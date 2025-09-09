1. Define the following terms: data, database, relational database, and table.
Data - bu malumot so`z yoki sonlardan iborat bo`lgan.
Database - malumotlar bazasi unda malumotlar qayta ishlash uchun tabtibli saqlangan boladi
Relational database - malumotlar jadval korinishida saqlanadigan malumotlar bazasi
Table - malumotlar bazasidagi malumotlarni jadval korinishida ifodalash uchun foydalaniladi

2.List five key features of SQL Server.
- Ma’lumotlar xavfsizligi va shifrlash
- Yuqori ishonchlilik (High Availability)
- Kengayuvchanlik va tezkorlik
- Biznes tahlil (Business Intelligence)
- Ilg‘or tahlil (Advanced Analytics)

3. What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
- Windows autentifikatsiyasi (Windows Authentication) bu rejimda SQL Serverga Windows tizimidagi foydalanuvchi nomi va paroli bilan kiradi
windows tizimidagi nomni sql avtomatik tan oladi
- SQL Server autentifikatsiyasi (SQL Server Authentication) bu rejimda SQL Server ga alohida login va parol kiritish orqali kiradi

4. Create a new database in SSMS named SchoolDB.
create database SchoolDB
use schooldb

5. Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).
create table StudentsID (ID int primary key, name varchar(50), age int);
insert into studentsid values (1, 'Abdulazizov', 32),
(2, 'Fozilov', 30),
(3, 'Samatov', 28);
select * from StudentsID

6. Describe the differences between SQL Server, SSMS, and SQL
SQL Server bu — malumotlar bazasini boshqarish tizimi (DBMS). Malumotlarni saqlash,
boshqarish va ularga ishlov berish uchun moljallangan dastur.
SSMS bu — SQL Server Management Studio, yani SQL Serverni SQL Serverni boshqarish uchun interfeys.	
SQL Serverga ulanib, kod yozish, jadval yaratish, hisobot qilish va boshqalar.
SQL	bu — Structured Query Language, yani malumotlar bilan ishlash uchun sorov tili.
Malumotlarni yaratish, ozgartirish, ochirish va qidirish uchun ishlatiladi.

7. Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
DQL - Data Query Language	Malumotlarni bazadan olish uchun ishlatiladi (SELECT)
DML - Data Manipulation Language	Malumotlar bilan ishlash (INSERT, UPDATE, DELETE)
DDL - Data Definition Language	Jadval, ustun, bazani yaratish yoki ozgartirish (CREATE, ALTER, DROP)
DCL - Data Control Language	Foydalanuvchi huquqlarini boshqarish (GRANT, REVOKE)
TCL - Transaction Control Language	Malumotlar bazasida tranzaksiyalarni boshqarish (BEGIN TRANSACTION, COMMIT, ROLLBACK)
