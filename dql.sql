-- Create Database
CREATE DATABASE FinanceDB;
USE FinanceDB;

---------------------
-- 1. Customers Table
---------------------
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(50),
    dob DATE
);

INSERT INTO Customers VALUES
(1, 'Amit Sharma', 'amit@example.com', 'India', '1990-05-14'),
(2, 'Priya Mehta', 'priya@example.com', 'India', '1985-07-23'),
(3, 'John Smith', 'john@example.com', 'USA', '1979-09-12'),
(4, 'Linda Brown', 'linda@example.com', 'UK', '1992-03-05'),
(5, 'Chen Wei', 'chen@example.com', 'China', '1988-12-30');

---------------------
-- 2. Accounts Table
---------------------
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(12,2),
    opened_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Accounts VALUES
(101, 1, 'Savings', 150000.00, '2015-01-01'),
(102, 2, 'Checking', 35000.50, '2018-03-15'),
(103, 3, 'Savings', 220000.75, '2016-11-20'),
(104, 4, 'Credit', -5000.00, '2020-07-01'),
(105, 5, 'Checking', 78000.25, '2019-09-10');

------------------------
-- 3. Transactions Table
------------------------
CREATE TABLE Transactions (
    txn_id INT PRIMARY KEY,
    account_id INT,
    txn_date DATE,
    txn_type VARCHAR(10), -- 'Credit' or 'Debit'
    amount DECIMAL(12,2),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

INSERT INTO Transactions VALUES
(1001, 101, '2023-01-15', 'Credit', 5000.00),
(1002, 101, '2023-02-10', 'Debit', 2000.00),
(1003, 102, '2023-03-12', 'Credit', 10000.00),
(1004, 103, '2023-01-20', 'Debit', 15000.00),
(1005, 104, '2023-04-05', 'Debit', 2500.00),
(1006, 105, '2023-02-18', 'Credit', 20000.00),
(1007, 105, '2023-03-22', 'Debit', 5000.00);

---------------------
-- 4. Loans Table
---------------------
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(20),
    amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    start_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Loans VALUES
(201, 1, 'Home Loan', 5000000.00, 7.50, '2017-06-01'),
(202, 2, 'Car Loan', 800000.00, 9.00, '2020-09-15'),
(203, 3, 'Personal Loan', 300000.00, 12.00, '2022-01-10'),
(204, 5, 'Business Loan', 1500000.00, 10.50, '2021-11-01');

------------------------
-- 5. Investments Table
------------------------
CREATE TABLE Investments (
    invest_id INT PRIMARY KEY,
    customer_id INT,
    scheme VARCHAR(50),
    amount DECIMAL(12,2),
    start_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Investments VALUES
(301, 1, 'Mutual Fund', 200000.00, '2019-05-01'),
(302, 2, 'Stocks', 120000.00, '2021-02-12'),
(303, 3, 'Bonds', 50000.00, '2018-08-20'),
(304, 4, 'Mutual Fund', 75000.00, '2020-10-05'),
(305, 5, 'Stocks', 300000.00, '2022-07-15');


-- Excercises 
--  Get all accounts with balance between 50,000 and 2,00,000
select * from accounts where balance between 50000 and 200000;
select * from accounts where balance > 50000 and balance < 200000;
select account_type,balance from accounts where balance between 50000 and 200000;

-- Find loans taken between 2019 and 2021
select * from loans;

select * from loans where start_date between '2019-01-01' and '2021-12-31';
select * from loans where start_date > '2019-01-01' and start_date < '2021-12-31';

-- Find customers whose name starts with 'A'
select * from customers ;
select * from customers where name  like 'A%';


-- Get customers whose email ends with 'example.com'
select * from customers where email like '%example.com';


-- Customers with 'th' in their name
select * from customers where name like '%th%';

-- Get customers from India, USA, and UK
select * from customers where country in ('india','usa','uk');

-- Find transactions that are either 'Credit' or 'Debit' of 5000 or 10000
select*from transactions where (txn_type = 'credit' or txn_type = 'debit') and (amount=5000 or amount=10000) ;

-- Show customers who have no email (missing email address)
select*from customers where email is null;

-- Show investments where scheme is not mentioned
select*from investments where scheme is null ;

-- Show all customers with a registered email
select * from customers where email is not null; 

-- Find transactions where amount is recorded (not missing)
select * from transactions where amount is not null;

-- select * from transactions where amount is not null;
select * from transactions where amount is not null;


-- Get first 3 customers from the Customers table
select * from customers limit 3;

-- Skip first 2 customers and show next 3
select * from customers limit 3 offset 2;

-- Get distinct countries of customers
select distinct country from customers ;

-- Distinct account types available
select distinct account_type from accounts;

-- List customers by date of birth (oldest to youngest)
select * from customers  order by dob;

-- Accounts sorted by balance (highest first)
select * from accounts order by balance desc;

-- Count number of customers in each country
select country , count(*) from customers group by country; 
-- Count accounts by type
select count(distinct(account_type)) as account_type from accounts;

-- Find total balance per account_type
select account_type, sum(balance) from accounts group by account_type;

-- Average transaction amount per account
select*from transactions;
select account_id, avg(amount) from transactions group by account_id;

-- Top 3 customers with highest total investments
select * from investments order by amount desc limit 3;
select * from accounts  order by balance  desc limit 3;

-- Categorize accounts based on balance
select * ,
case 
     when balance < 0 then "minus"
     when balance between 0 and 100000 then "smaller"
     else "higher"
     end as Categories
from accounts;

-- Mark loans as "Small", "Medium","Large"
select *, 
case 
    when amount < 500000 then "Small" 
    when amount between 500000 and 2000000 then "Medium"
    else "Large"
end as Category
from loans ;

-- Sort accounts by increased balance after adding 5% interest
select * , balance* 1.05 as after_interest from accounts order by after_interest;




select*from Customers;
select*from Accounts;
select*from Loans;
select*from Transactions;
select*from Investments;


-- Get all customer names and their country.
select name , country from customers;
-- Show account IDs and balances of all accounts.
select account_id,balance from accounts;
-- List all transactions done after 2023-02-01.
select * from transactions where txn_date > '2023-02-02';
-- Display all loans greater than ₹1,000,000.
select * from loans where amount > 1000000;
-- Get the names of customers who are from India.
select name , country from customers where country = 'India';
-- Show details of accounts where balance is between 50,000 and 200,000.
select * from accounts where balance between 50000 and 200000;
-- Find customers whose name starts with ‘P’.
select * from customers where name like 'P%';
-- Get transactions where amount IN (5000, 10000, 20000).
select * from transactions where amount in ( 5000,10000,20000);
-- Show customers who have an email ending with ‘.com’.
select*from customers where email like '%.com';
-- List customers sorted by their date of birth (youngest first).
select * from customers order by dob desc;
-- Count number of customers in each country.
select country , count(*) from customers group by country ;
-- Find distinct account types available.
select distinct account_type from accounts;
-- Get the average balance of accounts.
select customer_id,avg(balance) from accounts group by customer_id;
select account_id,avg(balance) from accounts group by account_id;
-- Show total loan amount per customer.
select  customer_id , sum(amount) from loans group by customer_id;
-- Show top 3 customers with highest total investments.
select * from investments order by amount desc limit 3;


-- TEST
-- find the cumulative sum of loan amount
select amount , sum(amount) over (order by amount) as cumulative_total
from loans;

-- calculate loan amount with interest rate
select * from loans;
select *, (amount*interest_rate)   as total from loans;

-- Which scheme is having the highest investment amount?
select scheme, max(amount) from investments group by scheme limit 1;

-- Find the average invested amount per scheme?
select scheme , round(avg(amount)) from investments group by scheme;

-- Find the maximum and minimum transaction amount per transaction type.
select * from transactions;
select txn_type , max(amount) as max, min(amount) as min from transactions group by txn_type;

-- Rank transaction based on amount
select amount , rank() over (order by amount) from transactions;
 
-- Show the running total of transaction amount by transaction date
select txn_date , amount ,sum(amount)  over (order by txn_date)as total from transactions;

-- Get all customers with 's' in their name.
select * from customers where name like '%s%';

-- Get all customers who born after 1990
select * from customers where dob >'1990-12-31';

-- Get all customers who born between 1985 and 1990 
select * from customers where dob between '1985-01-01' and '1990-12-31';