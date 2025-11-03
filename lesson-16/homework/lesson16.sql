1. Create a numbers table using a recursive query from 1 to 1000.

WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 1000
)
SELECT n
FROM numbers;

2. Write a query to find the total sales per employee using a derived table.(Sales, Employees)

SELECT 
    e.EmployeeID,
    e.EmployeeName,
    s.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        SUM(SaleAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS s
ON e.EmployeeID = s.EmployeeID;

3. Create a CTE to find the average salary of employees.(Employees)

WITH AvgSalaryCTE AS (
    SELECT 
        AVG(Salary) AS AverageSalary
    FROM Employees
)
SELECT 
    AverageSalary
FROM AvgSalaryCTE;

4. Write a query using a derived table to find the highest sales for each product.(Sales, Products)

SELECT 
    p.ProductID,
    p.ProductName,
    s.MaxSale
FROM Products p
JOIN (
    SELECT 
        ProductID,
        MAX(SaleAmount) AS MaxSale
    FROM Sales
    GROUP BY ProductID
) AS s
ON p.ProductID = s.ProductID;

5. Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.

WITH RECURSIVE Doubles AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n * 2
    FROM Doubles
    WHERE n * 2 < 1000000
)
SELECT n
FROM Doubles;

6. Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)

WITH SalesCountCTE AS (
    SELECT 
        EmployeeID,
        COUNT(*) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
)
SELECT 
    e.EmployeeName,
    s.TotalSales
FROM Employees e
JOIN SalesCountCTE s
    ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales > 5;

7. Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)

WITH ProductSalesCTE AS (
    SELECT 
        ProductID,
        SUM(SaleAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT 
    p.ProductID,
    p.ProductName,
    c.TotalSales
FROM Products p
JOIN ProductSalesCTE c
    ON p.ProductID = c.ProductID
WHERE c.TotalSales > 500;

8. Create a CTE to find employees with salaries above the average salary.(Employees)

WITH AvgSalaryCTE AS (
    SELECT 
        AVG(Salary) AS AverageSalary
    FROM Employees
)
SELECT 
    e.EmployeeID,
    e.EmployeeName,
    e.Department,
    e.Salary
FROM Employees e
CROSS JOIN AvgSalaryCTE a
WHERE e.Salary > a.AverageSalary;

9. Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)

SELECT 
    e.EmployeeID,
    e.EmployeeName,
    s.TotalOrders
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        COUNT(*) AS TotalOrders
    FROM Sales
    GROUP BY EmployeeID
) AS s
    ON e.EmployeeID = s.EmployeeID
ORDER BY s.TotalOrders DESC
LIMIT 5;

10. Write a query using a derived table to find the sales per product category.(Sales, Products)

SELECT 
    p.Category,
    s.TotalSales
FROM (
    SELECT 
        ProductID,
        SUM(SaleAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
) AS s
JOIN Products p
    ON p.ProductID = s.ProductID
GROUP BY p.Category;

11. Write a script to return the factorial of each value next to it.(Numbers1)

WITH RECURSIVE FactorialCTE AS (
       SELECT 
        Number,
        1 AS Factorial,
        1 AS Counter
    FROM Numbers1

    UNION ALL
	SELECT
        f.Number,
        f.Factorial * (f.Counter + 1) AS Factorial,
        f.Counter + 1 AS Counter
    FROM FactorialCTE f
    WHERE f.Counter + 1 <= f.Number
)
    Number,
    MAX(Factorial) AS Factorial
FROM FactorialCTE
GROUP BY Number
ORDER BY Number;

12. This script uses recursion to split a string into rows of substrings for each character in the string.(Example)

WITH RECURSIVE SplitChars AS (
      SELECT
        Text,
        1 AS Position,
        SUBSTRING(Text, 1, 1) AS Character
    FROM Example

    UNION ALL
    SELECT
        s.Text,
        s.Position + 1 AS Position,
        SUBSTRING(s.Text, s.Position + 1, 1) AS Character
    FROM SplitChars s
    WHERE s.Position < LENGTH(s.Text)
)
SELECT
    Text,
    Character,
    Position
FROM SplitChars
ORDER BY Text, Position;

13. Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)

WITH MonthlySales AS (
    SELECT
        DATE_TRUNC('month', SaleDate) AS SaleMonth,
        SUM(SaleAmount) AS TotalSales
    FROM Sales
    GROUP BY DATE_TRUNC('month', SaleDate)
)
SELECT
    SaleMonth,
    TotalSales,
    TotalSales - LAG(TotalSales) OVER (ORDER BY SaleMonth) AS SalesDifference
FROM MonthlySales
ORDER BY SaleMonth;

14. Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)

SELECT 
    e.EmployeeID,
    e.EmployeeName,
    s.Quarter,
    s.QuarterlySales
FROM Employees e
JOIN (
       SELECT 
        EmployeeID,
        CONCAT(EXTRACT(YEAR FROM SaleDate), '-Q', EXTRACT(QUARTER FROM SaleDate)) AS Quarter,
        SUM(SaleAmount) AS QuarterlySales
    FROM Sales
    GROUP BY EmployeeID, EXTRACT(YEAR FROM SaleDate), EXTRACT(QUARTER FROM SaleDate)
) AS s
    ON e.EmployeeID = s.EmployeeID
WHERE s.QuarterlySales > 45000
ORDER BY e.EmployeeID, s.Quarter;

15. This script uses recursion to calculate Fibonacci numbers

WITH RECURSIVE FibonacciCTE AS (
        SELECT 0 AS n, 0 AS Fibonacci
    UNION ALL
    SELECT 1 AS n, 1 AS Fibonacci

    UNION ALL
        SELECT n + 1, 
           (SELECT Fibonacci FROM FibonacciCTE f2 WHERE f2.n = f.n - 1) 
         + (SELECT Fibonacci FROM FibonacciCTE f3 WHERE f3.n = f.n - 2)
    FROM FibonacciCTE f
    WHERE n < 20
)
SELECT n, Fibonacci
FROM FibonacciCTE
ORDER BY n;

16. Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)

SELECT Text
FROM FindSameCharacters
WHERE LENGTH(Text) > 1
  AND Text = REPEAT(SUBSTRING(Text, 1, 1), LENGTH(Text));

17. Create a numbers table that shows all numbers 1 through n and their order gradually increasing
by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)


18. Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)

SELECT 
    e.EmployeeID,
    e.EmployeeName,
    s.TotalSales
FROM Employees e
JOIN (
       SELECT 
        EmployeeID,
        SUM(SaleAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
       GROUP BY EmployeeID
) AS s
    ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales = (
       SELECT MAX(TotalSales)
    FROM (
        SELECT SUM(SaleAmount) AS TotalSales
        FROM Sales
        WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY EmployeeID
    ) AS maxSales
)
ORDER BY e.EmployeeID;

19. Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, 
remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
