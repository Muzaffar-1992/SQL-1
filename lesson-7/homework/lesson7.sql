create database lesson7
1. Write a query to find the minimum (MIN) price of a product in the Products table.

SELECT MIN(price) AS MinPrice
FROM Products;

2. Write a query to find the maximum (MAX) Salary from the Employees table.

SELECT MAX(Salary) AS MaxSalary
FROM Employees;

3. Write a query to count the number of rows in the Customers table.

SELECT COUNT(*) AS TotalCustomers
FROM Customers;

4. Write a query to count the number of unique product categories from the Products table.

SELECT COUNT(DISTINCT Category) AS UniqueCategories
FROM Products;

5. Write a query to find the total sales amount for the product with id 7 in the Sales table.

SELECT SUM(SalesAmount) AS TotalSales
FROM Sales
WHERE ProductID = 7;

SELECT SUM(Quantity * Price) AS TotalSales
FROM Sales
WHERE ProductID = 7;

6. Write a query to calculate the average age of employees in the Employees table.

SELECT AVG(Age) AS O‘rtachaYosh
FROM Employees;

SELECT AVG(YEAR(CURDATE()) - YEAR(BirthDate)) AS O‘rtachaYosh
FROM Employees;

7. Write a query to count the number of employees in each department.

SELECT DepartmentID, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;


SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

8. Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.

SELECT 
    Category,
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

9. Write a query to calculate the total sales per Customer in the Sales table.

SELECT 
    CustomerID,
    SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

10. Write a query to filter departments having more than 5 employees from the Employees table.DeptID is enough, if you dont have DeptName

SELECT 
    DeptID,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DeptID
HAVING COUNT(*) > 5;

SELECT 
    DeptID,
    DeptName,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DeptID, DeptName
HAVING COUNT(*) > 5;

11. Write a query to calculate the total sales and average sales for each product category from the Sales table.

SELECT 
    P.Category,
    SUM(S.SalesAmount) AS TotalSales,
    AVG(S.SalesAmount) AS AverageSales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.Category;

12. Write a query to count the number of employees from the Department HR.

SELECT COUNT(*) AS EmployeeCount
FROM Employees
WHERE DeptName = 'HR';

13. Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you dont have DeptName).

SELECT 
    DeptID,
    MAX(Salary) AS HighestSalary,
    MIN(Salary) AS LowestSalary
FROM Employees
GROUP BY DeptID;

14. Write a query to calculate the average salary per Department.(DeptID is enough, if you dont have DeptName).

SELECT 
    DeptID,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DeptID;

15. Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you dont have DeptName).

SELECT 
    DeptID,
    AVG(Salary) AS AvgSalary,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DeptID;

16. Write a query to filter product categories with an average price greater than 400.

SELECT 
    Category,
    AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

17. Write a query that calculates the total sales for each year in the Sales table.

SELECT 
    YEAR(SaleDate) AS SaleYear,
    SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate)
ORDER BY SaleYear;

18. Write a query to show the list of customers who placed at least 3 orders.

SELECT 
    CustomerID,
    COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

19. Write a query to filter out Departments with average salary expenses greater than 60000.(DeptID is enough, if you dont have DeptName).

SELECT 
    DeptID,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DeptID
HAVING AVG(Salary) > 60000;

20. Write a query that shows the average price for each product category, and then filter categories with an average price greater than 150.

SELECT 
    Category,
    AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

21. Write a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.

SELECT 
    CustomerID,
    SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SalesAmount) > 1500;

22. Write a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.

SELECT 
    DeptID,
    SUM(Salary) AS TotalSalary,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DeptID
HAVING AVG(Salary) > 65000;

23. Write a query to find total amount for the orders which weights more than $50 for each customer along with their least purchases.
(least amount might be lower than 50, use tsql2012.sales.orders table,freight col, ask ur assistant to give the TSQL2012 database).

SELECT 
    O.custid,
    SUM(CASE WHEN O.freight > 50 THEN O.freight ELSE 0 END)        AS TotalFreightOver50,
    MIN(O.freight)                                                 AS LeastFreight
FROM Sales.Orders AS O
GROUP BY O.custid
HAVING SUM(CASE WHEN O.freight > 50 THEN O.freight ELSE 0 END) > 0;

25. Write a query that calculates the total sales and counts unique products sold in each month of each year, 
and then filter the months with at least 2 products sold.(Orders)

SELECT
    YEAR(OrderDate) AS SaleYear,
    MONTH(OrderDate) AS SaleMonth,
    SUM(OrderQty * UnitPrice) AS TotalSales,
    COUNT(DISTINCT ProductID) AS UniqueProductsSold
FROM Sales.Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2
ORDER BY SaleYear, SaleMonth;

26. Write a query to find the MIN and MAX order quantity per Year. From orders table.

SELECT
    YEAR(OrderDate) AS OrderYear,
    MIN(OrderQty) AS MinOrderQty,
    MAX(OrderQty) AS MaxOrderQty
FROM Sales.Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
