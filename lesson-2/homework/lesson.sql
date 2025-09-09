Lesson 2: DDL and DML Commands

1. Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
Create database lesson2
use lesson2
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

2. Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).

insert into Employees values (1, 'Tojiyev', 500000.00);
insert into Employees values (2, 'Tojiyev Bahrom', 600000.00),
(1, 'Nabiyev Mavlon', 700000.00);
select*from Employees

3. Update the Salary of an employee to 7000 where EmpID = 1.

update Employees
set Salary=7000.00
where EmpID=1

4. Delete a record from the Employees table where EmpID = 2.

delete from Employees
where EmpID=2

5. Give a brief definition for difference between DELETE, TRUNCATE, and DROP.

Delete jadvaldagi muayyan malumotlarni o`chiradi where buyrugi bilan birga ishlatiladi
Truncate jadvaldagi barcha malumotlarni o`chiradi
drop butun jadvalni to`liq ochiradi

6. Modify the Name column in the Employees table to VARCHAR(100).

	ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

7. Add a new column Department (VARCHAR(50)) to the Employees table.

Alter table employees ADD Department VARCHAR(50)

8. Change the data type of the Salary column to FLOAT.

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

9. Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

10. Remove all records from the Employees table without deleting its structure.

Truncate table employees

Intermediate-Level Tasks (6)

11. Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).

insert into Departments values (1, 'Iqtisod'),
(2, 'buxgalteriya'),
(3, 'Kadr'),
(4, 'Texnolog'),
(5, 'Oshpaz');

select* from Departments

12. Update the Department of all employees where Salary > 5000 to 'Management'.

update Employees
set Department = 'management'
where salary>5000.00;

13. Write a query that removes all employees but keeps the table structure intact.

delete from Employees;

14. Drop the Department column from the Employees table.

ALTER TABLE Employees
DROP COLUMN Department;

15. Rename the Employees table to StaffMembers using SQL commands.

ALTER TABLE Employees
RENAME TO StaffMembers;
EXEC sp_rename 'Employees', 'StaffMembers';

16. Write a query to completely remove the Departments table from the database.

DROP TABLE Departments;

Advanced-Level Tasks (9)

17. Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)

create table Products (ProductID int Primary Key, ProductName VARCHAR(10), Category VARCHAR(15), Price DECIMAL, madein nvarchar (10));

18. Add a CHECK constraint to ensure Price is always greater than 0.
ALTER TABLE Products
ADD CONSTRAINT chk_price_positive CHECK (Price > 0);

19. Modify the table to add a StockQuantity column with a DEFAULT value of 50.

Alter table products add StockQuantity int DEFAULT(50);

20. Rename Category to ProductCategory

EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

select*from Products

21. Insert 5 records into the Products table using standard INSERT INTO queries.

insert into Products values (1, 'olma', 'meva', 2000, 'Uzbekistan', 100),
(2, 'o`rik', 'meva', 3000, 'Uzbekistan', 200),
(3, 'Behi', 'meva', 4000, 'Uzbekistan', 300),
(4, 'olcha', 'meva', 5000, 'Uzbekistan', 400),
(5, 'banan', 'meva', 6000, 'india', 600);

22. Use SELECT INTO to create a backup table called Products_Backup containing all Products data.

SELECT *
INTO Products_Backup
FROM Products;

23. Rename the Products table to Inventory.

EXEC sp_rename 'Products', 'Inventory';

24. Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.

ALTER TABLE Inventory
DROP CONSTRAINT chk_price_positive;
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

25. Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.

SQL Serverda mavjud jadvalga IDENTITY ustunini to‘g‘ridan-to‘g‘ri qo‘shish imkonsiz.
