Lesson 3: Importing and Exporting Data
create database lesson3

1. Define and explain the purpose of BULK INSERT in SQL Server.
BULK INSERT — bu SQL Serverda malumotlarni tashqi fayldan (odatda .txt, .csv, yoki boshqa matnli fayllardan) jadvalga
tez va samarali yuklash uchun ishlatiladigan buyruqdir

2. List four file formats that can be imported into SQL Server.

Quyida SQL Server ga import qilish mumkin bo‘lgan to‘rtta fayl formatlari keltirilgan (o‘zbek tilida):

1. CSV (vergul bilan ajratilgan qiymatlar) fayli
Jadval korinishidagi malumotlarni saqlash uchun eng keng tarqalgan format.
Har bir ustun vergul bilan ajratiladi.
Misol: malumotlar.csv

2. TXT (oddiy matn) fayli
Har xil ajratkichlar (masalan: tab, |, nuqta-vergul) bilan yozilgan oddiy matn fayli.
Misol: malumotlar.txt

3. XLS / XLSX (Microsoft Excel fayllari)
Excel fayllaridagi malumotlar SQL Serverga import qilinishi mumkin.
Buning uchun SQL Server Import Wizard yoki OPENROWSET funksiyasi ishlatiladi.
Misol: hisobot.xlsx

4. XML (Kengaytiriladigan Belgilash Tili) fayli
Tuzilishi murakkab bolgan, iyerarxik (daraxtsimon) malumotlar uchun ishlatiladi.
SQL Server XML formatdagi fayllarni maxsus funksiyalar orqali o‘qiy oladi.
Misol: mahsulotlar.xml

3. Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).

create table Products (productid int primary key, productname varchar(50), price decimal (10,2))

4. Insert three records into the Products table using INSERT INTO.

insert into products values (1, 'apple', 5000.00),
(2, 'patato', 6000.00),
(3, 'melon', 7000.00);

5. Explain the difference between NULL and NOT NULL.
NULL — bu qiymat mavjud emas degani. Ya’ni, ustun bo‘sh yoki noma’lum bo‘lsa, u NULL qiymatga ega bo‘ladi.
NOT NULL — bu ustunga albatta qiymat kiritilishi kerak degani.
Agar siz bu ustunga hech narsa kiritmasangiz — xatolik yuz beradi.

6. Add a UNIQUE constraint to the ProductName column in the Products table.
Alter table products add constraint uq_productname unique (productname);

7. Write a comment in a SQL query explaining its purpose.
SQL query — bu SQL (Structured Query Language) tilida yozilgan so‘rov yoki buyruq bo‘lib, 
u ma’lumotlar bazasidan ma’lumotlarni olish, qo‘shish, o‘zgartirish yoki o‘chirish uchun ishlatiladi

8. Add CategoryID column to the Products table.
alter table products add CategoryID nvarchar(50) 

9. Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.

create table Categories (categoryid int primary key, categoryname nvarchar(10) unique);

10. Explain the purpose of the IDENTITY column in SQL Server.
IDENTITY — bu SQL Serverda ustun yaratishda ishlatiladigan maxsus xususiyat bo‘lib, 
u avtomatik ravishda raqamli qiymatlarni ketma-ket generatsiya qiladi.

11. Use BULK INSERT to import data from a text file into the Products table.
BULK INSERT Products
FROM 'C:\data\products.txt'
WITH (FIELDTERMINATOR = ',',  -- ustunlar orasidagi ajratuvchi
    ROWTERMINATOR = '\n',   -- qator oxirini belgilovchi
    FIRSTROW = 1            -- qayerdan boshlash kerak (agar sarlavha bo‘lsa 2 bo‘lishi mumkin));

12. Create a FOREIGN KEY in the Products table that references the Categories table.
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID);


13. Explain the differences between PRIMARY KEY and UNIQUE KEY.
PRIMARY KEY bir jadvalda faqat bitta bo'lishi mumkin, NULL qiymatlarni qabul qilmaydi va jadvaldagi har bir satrni noyob tarzda identifikatsiya qilish uchun ishlatiladi, o'z navbatida, bir nechta bo'lishi mumkin bo'lgan UNIQUE KEY esa NULL qiymatlarga ruxsat berishi va ustundagi qiymatlarning takrorlanishini oldini olish uchun ishlatiladi. 
PRIMARY KEY (Asosiy kalit)
Bitta bo'lishi mumkin: Bir jadvalda faqat bitta PRIMARY KEY bo'lishi mumkin. 
NULL qiymatlarga ruxsat bermaydi: NULL qiymatlarni qabul qilmaydi. 
Noyob identifikator: Jadvaldagi har bir satrni noyob tarzda identifikatsiya qilish uchun ishlatiladi. 
Indeks: Avtomatik ravishda qat'iy indeks yaratadi (ko'pincha klasterlangan indeks), bu esa qidiruv tezligini oshiradi. 
UNIQUE KEY (Noyob kalit)
Ko'p bo'lishi mumkin: Bir jadvalda bir nechta UNIQUE KEY bo'lishi mumkin. 
NULL qiymatlarga ruxsat beradi: NULL qiymatlarga ruxsat beradi, lekin ko'pincha faqat bitta NULL qiymatga ruxsat beriladi. 
Takrorlanmaslikni ta'minlaydi: Ustunlardagi qiymatlarning takrorlanmasligini ta'minlaydi. 
Indeks: Odatda klasterlanmagan indeksni yaratadi. 

14. Add a CHECK constraint to the Products table ensuring Price > 0
ALTER TABLE Products
ADD CONSTRAINT chk_price_positive CHECK (Price > 0);

15. Modify the Products table to add a column Stock (INT, NOT NULL).

select*from products

16. Use the ISNULL function to replace NULL values in Price column with a 0.
UPDATE Products
SET Price = 0
WHERE Price IS NULL;

17. Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
FOREIGN KEY bu – bir jadvaldagi ustun (yoki ustunlar guruhi) boshqa jadvaldagi PRIMARY KEY (yoki UNIQUE) ustuniga bog‘langanligini bildiradi.

Bu cheklov quyidagilarni ta’minlaydi:
Yordamchi jadvalga (child table) faqat asosiy jadvalda (parent table) mavjud bo‘lgan qiymatlar kiritilishi mumkin.
Ma’lumotlar bazasidagi bog‘liq yozuvlar noto‘g‘ri kiritilmasligini kafolatlaydi.

18. Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
IF OBJECT_ID('Customers', 'U') IS NOT NULL
    DROP TABLE Customers;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Email NVARCHAR(100),
    CHECK (Age >= 18)
);
19. Create a table with an IDENTITY column starting at 100 and incrementing by 10.
CREATE TABLE Customers (
    CustomerID INT IDENTITY(100, 10) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Age INT CHECK (Age >= 18),
    Email NVARCHAR(100)
);

20. Write a query to create a composite PRIMARY KEY in a new table OrderDetails.

CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID)
);

21. Explain the use of COALESCE and ISNULL functions for handling NULL values.
ISNULL(expression, replacement_value)
Bu funksiya agar expression NULL bo‘lsa, uning o‘rniga replacement_value ni qaytaradi. Agar expression NULL bo‘lmasa, o‘sha qiymatni qaytaradi.
COALESCE(expression1, expression2, ..., expressionN)
Berilgan ifodalardan birinchi NULL bo‘lmagan qiymatni qaytaradi. Agar barcha ifodalar NULL bo‘lsa, NULL qaytaradi.

22. Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE,
    Position NVARCHAR(50),
    HireDate DATE
);

23. Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

