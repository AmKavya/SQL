-- Create database
CREATE DATABASE bookstore_db;
USE bookstore_db;
SET SQL_SAFE_UPDATES = 0;

-- Authors table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50)
);

-- Books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150),
    price DECIMAL(8,2),
    published_date DATE,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);


-- Customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE,
    loyalty_points INT
);

-- Orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Authors
INSERT INTO authors (name, country) VALUES
('Haruki Murakami', 'Japan'),
('George Orwell', 'UK'),
('Arundhati Roy', 'India'),
('Paulo Coelho', 'Brazil');

-- Books
INSERT INTO books (title, price, published_date, author_id) VALUES
('Kafka on the Shore', 450.75, '2002-09-12', 1),
('1984', 299.50, '1949-06-08', 2),
('The God of Small Things', 350.00, '1997-05-04', 3),
('The Alchemist', 400.00, '1988-04-14', 4);


-- Customers
INSERT INTO customers (full_name, email, join_date, loyalty_points) VALUES
('Alice Johnson', 'alice@example.com', '2021-03-15', 120),
('Bob Smith', 'bob@example.com', '2022-01-10', 50),
('Charlie Brown', 'charlie@example.com', '2020-07-20', NULL);

-- Orders
INSERT INTO orders (customer_id, book_id, order_date, quantity) VALUES
(1, 1, '2023-01-10', 1),
(2, 2, '2023-03-05', 2),
(3, 4, '2023-04-01', 1);

select*from authors;
select*from books;
select*from customers;
select*from orders;

-- - 1.    Show each author’s name in uppercase along with their country in lowercase.
select upper(name) as upper , lower(country) as lower from authors;

-- 2.    Display the first 7 characters of each book title.
select title, substr(title ,1,7) from books;

-- 3.    Find the length of each customer’s name.
select full_name,length(full_name) as len from customers;

-- 4.    Concatenate "Customer: " with each customer’s full_name.
select concat('customer :',' '  , full_name) as cust from customers;

-- 5.    Replace the word “The” with “A” in all book titles.
select*from books;
Select title , replace(title, 'The','A') as title2 from books ;

SELECT title AS original_title,
       CASE
           WHEN title LIKE 'The A%' OR title LIKE 'The E%' OR title LIKE 'The I%' OR title LIKE 'The O%' OR title LIKE 'The U%'
               THEN REPLACE(title, 'The ', 'An ')
           WHEN title LIKE 'The a%' OR title LIKE 'The e%' OR title LIKE 'The i%' OR title LIKE 'The o%' OR title LIKE 'The u%'
               THEN REPLACE(title, 'The ', 'An ')
           ELSE REPLACE(title, 'The ', 'A ')
       END AS updated_title
FROM books;


-- 6.    Remove leading and trailing spaces from the string ' My Bookstore '.
select length(' My Bookstore ') as before_trim, trim(' My Bookstore ') as cleanedstring,length(trim(' My Bookstore '))as after_trim;

-- 7.    Show each book title with its rounded price (no decimals).
select title ,round(price) from books;

-- 8.    Display each book title with its price ceiling and floor values.
select title , price, ceil(price) as ceil_price , floor(price) as floor_price from books;

-- 9.     Truncate book prices to 1 decimal place.
select title, truncate(price,1) as truncate_price from books;

-- 10.    Show each book’s price raised to the power of 2.
select title , round(power(price,2),2) from books;



-- 11. Show today’s date (CURDATE()) and system datetime (SYSDATE()).
select curdate();
select sysdate();


-- 12. Display each order date plus 15 days (using DATE_ADD).
select * from orders;
select order_date,date_add(order_date ,interval 15 day  ) as extra from orders;

-- 13. Find how many days each customer has been registered (using TIMESTAMPDIFF).
select * from customers;
SELECT join_date,TIMESTAMPDIFF(Day, join_date, CURDATE()) AS days_since_joining FROM customers;

-- 14. Extract the year and month from each order date.
select * from orders;
select order_date , extract( year  from order_date) as year , extract(month from order_date) as month from orders;
select order_date, year(order_date) as year , month(order_date) as month from orders;

-- 15. Format each book’s published date as DD-Month-YYYY.
select * from books;
select published_date, date_format(published_date, '%d-%m-%Y') as format_date from books;


-- 16. For each book, show the smaller value between its price and 350.
select title , price , least(price , 350 ) as least_price from books;
-- For each book, show the larger value between its price and 350.
select title , price , greatest(price , 350 ) as great_price from books;

-- 17.  Show all customers, replacing NULL loyalty points with 0 (use COALESCE).
select * from customers;
select * , coalesce(loyalty_points , 0) as replaced from customers;


-- 18. Compare each customer’s loyalty_points with 50. If equal, return NULL; otherwise, return the value.
SELECT *,
  CASE 
    WHEN loyalty_points = 50 THEN NULL
    ELSE loyalty_points
  END AS adjusted_loyalty_points
FROM customers;

SELECT *,
  COALESCE(NULLIF(loyalty_points, 50), NULL) AS adjusted_loyalty_points
FROM customers;


-- 19.  Rank all books by price (highest to lowest).
select * from books;
select * , rank() over(order by price desc) as ranking_price from books;

-- 20.  running sum of price for books
select * ,sum(price) over (order by price) as running_price from books;
