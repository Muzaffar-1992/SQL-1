create database lesson14

1. Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)

SELECT
    LTRIM(RTRIM(SUBSTRING(Name, 1, CHARINDEX(',', Name) - 1))) AS Name,
    LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS Surname
FROM TestMultipleColumns;

2. Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)

SELECT *
FROM TestPercent
WHERE StringColumn LIKE '%[%]%' ;

3. Split a string based on dot(.).(Splitter)

SELECT value AS Part
FROM Splitter
CROSS APPLY STRING_SPLIT(StringColumn, '.');

4. Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)

SELECT *
FROM testDots
WHERE (LEN(Vals) - LEN(REPLACE(Vals, '.', ''))) > 2;

5. Write a SQL query to count the spaces present in the string.(CountSpaces)

SELECT 
    (LEN(StringColumn) - LEN(REPLACE(StringColumn, ' ', ''))) AS SpaceCount
FROM CountSpaces;

6. Write a SQL query that finds out employees who earn more than their managers.(Employee)

SELECT e.EmployeeID, e.Name, e.Salary, m.Name AS ManagerName, m.Salary AS ManagerSalary
FROM Employee e
JOIN Employee m ON e.ManagerID = m.EmployeeID
WHERE e.Salary > m.Salary;

7. Find the employees who have been with the company for more than 10 years, but less than 15 years.
Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service
(calculated as the number of years between the current date and the hire date).(Employees)

SELECT 
    EmployeeID,
    FirstName,
    LastName,
    HireDate,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 10
  AND DATEDIFF(YEAR, HireDate, GETDATE()) < 15;

8. write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)

SELECT Id, Date, Temperature
FROM (
    SELECT 
        Id,
        Date,
        Temperature,
        LAG(Temperature) OVER (ORDER BY Date) AS PrevTemperature
    FROM weather
) AS t
WHERE Temperature > PrevTemperature;

9. Write an SQL query that reports the first login date for each player.(Activity)

SELECT 
    PlayerID,
    MIN(LoginDate) AS FirstLoginDate
FROM Activity
GROUP BY PlayerID;

10. Your task is to return the third item from that list.(fruits)

SELECT *
FROM fruits
ORDER BY Id
LIMIT 1 OFFSET 2;

11. Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
If the employee has worked for less than 1 year → 'New Hire'
If the employee has worked for 1 to 5 years → 'Junior'
If the employee has worked for 5 to 10 years → 'Mid-Level'
If the employee has worked for 10 to 20 years → 'Senior'
If the employee has worked for more than 20 years → 'Veteran'(Employees)

SELECT 
    EmployeeID,
    FirstName,
    LastName,
    HireDate,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfService,
    CASE 
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 10 AND 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees;

12. Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)

SELECT 
    CASE 
        WHEN PATINDEX('[0-9]%', Vals) = 1 THEN
            CAST(SUBSTRING(Vals, 1, PATINDEX('%[^0-9]%', Vals + 'X') - 1) AS INT)
        ELSE NULL
    END AS LeadingInteger
FROM GetIntegers;

13. In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)

WITH SplitVals AS (
    SELECT value AS part
    FROM MultipleVals
    CROSS APPLY STRING_SPLIT(Vals, ',')
)
SELECT 
    CASE 
        WHEN LEN(part) >= 2 THEN 
            SUBSTRING(part, 2, 1) + SUBSTRING(part, 1, 1) + SUBSTRING(part, 3, LEN(part)-2)
        ELSE part
    END AS SwappedPart
FROM SplitVals;

14. Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)

DECLARE @str VARCHAR(100) = 'sdgfhsdgfhs@121313131';

WITH CharCTE AS (
    SELECT 1 AS Pos, SUBSTRING(@str, 1, 1) AS Char
    UNION ALL
    SELECT Pos + 1, SUBSTRING(@str, Pos + 1, 1)
    FROM CharCTE
    WHERE Pos + 1 <= LEN(@str)
)
SELECT *
INTO CharTable
FROM CharCTE
OPTION (MAXRECURSION 0);

15. Write a SQL query that reports the device that is first logged in for each player.(Activity)
WITH FirstLogin AS (
    SELECT 
        PlayerID,
        Device,
        LoginDate,
        ROW_NUMBER() OVER (PARTITION BY PlayerID ORDER BY LoginDate) AS rn
    FROM Activity
)
