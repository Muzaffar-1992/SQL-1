create database lesson13

1. You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.

SELECT emp_id || '-' || first_name || ' ' || last_name AS full_info
FROM employees;

2. Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'

UPDATE employees
SET phone_number = REPLACE(phone_number, '124', '999')
WHERE phone_number LIKE '%124%';

3. Display the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. 
Give each column an appropriate label. Sort the results by the employees first names.(Employees)

SELECT 
    first_name AS "First Name",
    LENGTH(first_name) AS "Name Length"
FROM employees
WHERE first_name LIKE 'A%' 
   OR first_name LIKE 'J%' 
   OR first_name LIKE 'M%'
ORDER BY first_name;

4. Write an SQL query to find the total salary for each manager ID.(Employees table)

SELECT 
    manager_id AS "Manager ID",
    SUM(salary) AS "Total Salary"
FROM employees
GROUP BY manager_id
ORDER BY manager_id;

5. Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table

SELECT
    year,
    GREATEST(Max1, Max2, Max3) AS Highest_Value
FROM TestMax;

6. Find me odd numbered movies and description is not boring.(cinema)

SELECT *
FROM cinema
WHERE MOD(movie_number, 2) = 1   -- movie_number yoki id odd bo‘lsa
  AND description NOT LIKE '%boring%';

 7. You have to sort data based on the Id but Id with 0 should always be the last row. 
  Now the question is can you do that with a single order by column.(SingleOrder)

  SELECT *
FROM SingleOrder
ORDER BY 
    CASE WHEN Id = 0 THEN 1 ELSE 0 END,

8. Write an SQL query to select the first non-null value from a set of columns. 
If the first column is null, move to the next, and so on. If all columns are null, return null.(person)

SELECT 
    COALESCE(column1, column2, column3, column4) AS first_non_null
FROM person;

9. Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)

SELECT
    LEFT(FullName, CHARINDEX(' ', FullName) - 1) AS Firstname,
    SUBSTRING(
        FullName,
        CHARINDEX(' ', FullName) + 1,
        LEN(FullName) - CHARINDEX(' ', FullName) - CHARINDEX(' ', REVERSE(FullName))
    ) AS Middlename,
    RIGHT(FullName, CHARINDEX(' ', REVERSE(FullName)) - 1) AS Lastname
FROM Students;

10. For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)

SELECT *
FROM Orders
WHERE state = 'Texas'
  AND customer_id IN (
      SELECT DISTINCT customer_id
      FROM Orders
      WHERE state = 'California');

11. Write an SQL statement that can group concatenate the following values.(DMLTable)

12. Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.

SELECT *
FROM employees
WHERE (LENGTH(first_name || last_name) 
       - LENGTH(REPLACE(LOWER(first_name || last_name), 'a', ''))) >= 3;

13. The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)

SELECT 
    department_id,
    COUNT(*) AS total_employees,
    ROUND(
        100.0 * SUM(CASE WHEN SYSDATE - hire_date > 3*365 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS percent_over_3_years
FROM employees
GROUP BY department_id
ORDER BY department_id;

14. Write an SQL query that replaces each row with the sum of its value and the previous rows value. (Students table)

SELECT
    student_id,
    value,
    SUM(value) OVER (ORDER BY student_id) AS running_total
FROM Students
ORDER BY student_id;

15. Given the following dataset, find the students that share the same birthday.(Student Table)

SELECT birth_date, COUNT(*) AS num_students
FROM Student
GROUP BY birth_date
HAVING COUNT(*) > 1;

16. You have a table with two players (Player A and Player B) and their scores. If a pair of players have multiple entries, 
aggregate their scores into a single row for each unique pair of players. 
Write an SQL query to calculate the total score for each unique player pair(PlayerScores)

SELECT 
    CASE WHEN player_a < player_b THEN player_a ELSE player_b END AS player1,
    CASE WHEN player_a < player_b THEN player_b ELSE player_a END AS player2,
    SUM(score) AS total_score
FROM PlayerScores
GROUP BY 
    CASE WHEN player_a < player_b THEN player_a ELSE player_b END,
    CASE WHEN player_a < player_b THEN player_b ELSE player_a END
ORDER BY player1, player2;

17. Write an SQL query that separates the uppercase letters, lowercase letters, numbers, 
and other characters from the given string 'tf56sd#%OqH' into separate columns.


