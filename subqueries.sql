
use financedb;

select max(amount) from investments ;
select* from investments where amount = (select max(amount) from investments );



-- find investments which has above avg amount 
select * from investments;
select avg(amount) from investments;
select * from investments where amount > (select avg(amount) from investments);



-- Create database
CREATE DATABASE shop;
USE shop;

-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    city VARCHAR(50)
);

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Customers
INSERT INTO customers (name, city) VALUES
('Alice', 'Mumbai'),
('Bob', 'Delhi'),
('Charlie', 'Bangalore'),
('David', 'Mumbai'),
('Eva', 'Chennai');

-- Products
INSERT INTO products (product_name, price) VALUES
('Laptop', 60000),
('Phone', 30000),
('Headphones', 2000),
('Keyboard', 1500),
('Monitor', 12000);

-- Orders
INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES
(1, 1, 1, '2025-09-01'), -- Alice buys Laptop
(2, 2, 2, '2025-09-02'), -- Bob buys 2 Phones
(3, 3, 3, '2025-09-03'), -- Charlie buys 3 Headphones
(1, 4, 1, '2025-09-04'), -- Alice buys Keyboard
(4, 5, 1, '2025-09-05'); -- David buys Monitor

-- types of subqueries 
-- single line / scalar : will return 1 value i.e min,max , avg
-- 1. find the product with highest price 
select * from products where price = (select max(price) from products);

-- multi line : a) row subquery , returns a single row but  multiple cols
-- 2. get the product having max price 
select product_name , price  from products where (product_name , price) = 
(select product_name , price where price = (select max(price) from products));
 
 select product_name , price  from products where  price = (select max(price) from products); 
 -- would give out similar output tho if where condition has 2 cols the subquery whould require having 2 cols as well

--  column subquery : having multiple cols n rows 
--  3. find the customers who brought products above 20,000
 select * from customers where customer_id in 
 (select customer_id from orders where product_id in (select  product_id from products where price >20000 ));


-- corelated : excetues row by row (would return only one row)
-- 4. frind the customers who brought more than 1 type of product 
select * from customers c where 1 < (select count(distinct( product_id)) from orders o where c.customer_id=o.customer_id);

-- 5.  find the  highest product price from the products table 
 select price  from products where  price = (select max(price) from products); 

-- 6.  find the customer name who placed the earliest order 
select * from customers where customer_id = 
(select customer_id from orders where order_date = (select max(order_date) from orders ));

-- 7.  get the product name and price of the expensive product 
select product_name , price  from products where price = (select max(price) from products);

-- 8.  find the product name and price of the cheapest product 
select product_name , price  from products where (product_name , price) = 
(select product_name , price where price = (select min(price) from products));

-- 9. find customers who have placed an order 
select * from customers where customer_id in (select customer_id from orders);
select * from customers where customer_id not in (select customer_id from orders);

-- 10. find products that have never been ordered
select * from orders;
select * from products where product_id not in (select product_id from orders);

-- 11.list all customer names who are from the same city as alice 
select * from customers where city = (select city from customers where name = 'Alice');

-- 12. find customers who have orderd more than 1 distinct product 
select * from customers c where 1 < (select count(distinct( product_id)) from orders o where c.customer_id=o.customer_id);

-- 13. show all orders with customer names and product names 
SELECT o.order_id,c.name,p.product_name
FROM orders o
inner join  customers c ON o.customer_id = c.customer_id
inner join  products p ON o.product_id = p.product_id;

-- 14. find total amount (quantity * price) of each order along with customer name 
select  o.order_id, c.name ,  p.product_name ,(o.quantity * p.price) as total_amount 
from orders o 
inner join products p on o.product_id = p.product_id 
inner join customers c on o.customer_id = c.customer_id;

-- 15. list all customers who have order laptop ( show customer name + product)
select c.name , p.product_name  
from orders o 
inner join products p on p.product_id = o.product_id 
inner join customers c on c.customer_id = o.customer_id 
where p.product_name ='Laptop';

-- 16. show all customers with their orders (if any). customer without order should appear
select  o.order_id, c.name ,  p.product_name 
from orders o 
right  join products p on o.product_id = p.product_id 
right join customers c on o.customer_id = c.customer_id;

-- 16. show all products with their orders (if any). products without order should appear
select  o.order_id, c.name ,  p.product_name 
from orders o 
right  join products p on o.product_id = p.product_id 
right join customers c on o.customer_id = c.customer_id;
