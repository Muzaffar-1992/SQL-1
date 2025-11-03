1. You must provide a report of all distributors and their sales by region. If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. Assume there is at least one sale for each region
SQL Setup:

DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);
Input:

|Region       |Distributor    | Sales |
|-------------|---------------|--------
|North        |ACE            |   10  |
|South        |ACE            |   67  |
|East         |ACE            |   54  |
|North        |Direct Parts   |   8   |
|South        |Direct Parts   |   7   |
|West         |Direct Parts   |   12  |
|North        |ACME           |   65  |
|South        |ACME           |   9   |
|East         |ACME           |   1   |
|West         |ACME           |   7   |

WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
)
SELECT 
    r.Region,
    d.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM Regions r
CROSS JOIN Distributors d
LEFT JOIN #RegionSales rs
    ON r.Region = rs.Region
   AND d.Distributor = rs.Distributor
ORDER BY r.Region, d.Distributor;

2. Find managers with at least five direct reports
SQL Setup:

CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);
Input:

| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |

SELECT 
    m.id,
    m.name,
    COUNT(e.id) AS DirectReports
FROM Employee m
JOIN Employee e
    ON m.id = e.managerId
GROUP BY m.id, m.name
HAVING COUNT(e.id) >= 5;

3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
SQL Setup:

CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

SELECT 
    p.product_name,
    SUM(o.unit) AS total_units
FROM Products p
JOIN Orders o 
    ON p.product_id = o.product_id
WHERE 
    o.order_date >= '2020-02-01'
    AND o.order_date < '2020-03-01'
GROUP BY 
    p.product_name
HAVING 
    SUM(o.unit) >= 100;

4. Write an SQL statement that returns the vendor from which each customer has placed the most orders
SQL Setup:

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

WITH VendorOrderCounts AS (
    SELECT 
        CustomerID,
        Vendor,
        COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY CustomerID, Vendor
),
RankedVendors AS (
    SELECT 
        CustomerID,
        Vendor,
        OrderCount,
        RANK() OVER (PARTITION BY CustomerID ORDER BY OrderCount DESC) AS rnk
    FROM VendorOrderCounts
)
SELECT 
    CustomerID,
    Vendor,
    OrderCount
FROM RankedVendors
WHERE rnk = 1;

5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'
Example Input:

DECLARE @Check_Prime INT = 91;

6. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.
SQL Setup:

CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

WITH SignalSummary AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS SignalCount
    FROM Device
    GROUP BY Device_id, Locations
),
RankedSignals AS (
    SELECT 
        Device_id,
        Locations,
        SignalCount,
        RANK() OVER (PARTITION BY Device_id ORDER BY SignalCount DESC) AS rnk
    FROM SignalSummary
)
SELECT 
    s.Device_id,
    COUNT(DISTINCT s.Locations) AS Num_Locations,
    MAX(CASE WHEN rnk = 1 THEN Locations END) AS Most_Signal_Location,
    SUM(s.SignalCount) AS Total_Signals
FROM RankedSignals s
GROUP BY s.Device_id;

7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output
SQL Setup:

CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

SELECT 
    e.EmpID,
    e.EmpName,
    e.Salary
FROM Employee e
WHERE e.Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);

8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.
Winning Numbers:

|Number|
--------
|  25  |
|  45  |
|  78  |

Tickets:

| Ticket ID | Number |
|-----------|--------|
| A23423    | 25     |
| A23423    | 45     |
| A23423    | 78     |
| B35643    | 25     |
| B35643    | 45     |
| B35643    | 98     |
| C98787    | 67     |
| C98787    | 86     |
| C98787    | 91     |

CREATE TABLE Numbers (
    Number INT
);

INSERT INTO Numbers (Number)
VALUES
(25),
(45),
(78);


CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);

INSERT INTO Tickets (TicketID, Number)
VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);
WITH TicketMatch AS (
    SELECT 
        t.TicketID,
        COUNT(DISTINCT t.Number) AS TotalNumbers,
        COUNT(DISTINCT n.Number) AS MatchingNumbers
    FROM Tickets t
    LEFT JOIN Numbers n
        ON t.Number = n.Number
    GROUP BY t.TicketID
),
TicketPrize AS (
    SELECT 
        TicketID,
        CASE 
            WHEN MatchingNumbers = (SELECT COUNT(*) FROM Numbers) THEN 100
            WHEN MatchingNumbers > 0 THEN 10
            ELSE 0
        END AS Prize
    FROM TicketMatch
)
SELECT 
    SUM(Prize) AS Total_Winnings
FROM TicketPrize;

9. The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.
Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.
SQL Setup:

CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

WITH UserPlatformSummary AS (
    SELECT 
        Spend_date,
        User_id,
        SUM(CASE WHEN Platform = 'Mobile' THEN Amount ELSE 0 END) AS MobileSpend,
        SUM(CASE WHEN Platform = 'Desktop' THEN Amount ELSE 0 END) AS DesktopSpend
    FROM Spending
    GROUP BY Spend_date, User_id
),
UserCategory AS (
    SELECT 
        Spend_date,
        CASE 
            WHEN MobileSpend > 0 AND DesktopSpend > 0 THEN 'Both'
            WHEN MobileSpend > 0 THEN 'Mobile'
            WHEN DesktopSpend > 0 THEN 'Desktop'
        END AS PlatformType,
        (MobileSpend + DesktopSpend) AS TotalAmount
    FROM UserPlatformSummary
)
SELECT 
    Spend_date,
    PlatformType,
    COUNT(DISTINCT User_id) AS TotalUsers,
    SUM(TotalAmount) AS TotalAmount
FROM UserCategory
GROUP BY Spend_date, PlatformType
ORDER BY Spend_date, PlatformType;
