-- ddl (cant rollback)
create database DR315;
SELECT DATABASE();
USE DR315;

create table student(
stuID int primary key,
stu_name varchar(100) not null,
gender enum('male','female'),
age int not null,
department varchar(50) not null
);

CREATE TABLE PRODUCTS
(
PRODUCTID int PRIMARY KEY,
PRODUCTNAME VARCHAR(500)  NOT NULL,
PRODUCTDESC TEXT NOT NULL,
PRODUCTPRICE NUMERIC(10,2),
PRODUCTIMAGE LONGBLOB,
MANUFACTUREDATE DATE,
PRODUCTQTY NUMERIC(5),
CREATEDDATE TIMESTAMP,
MODIFIEDDATE TIMESTAMP
);

desc products;


use dr315;

-- to show all of indexes of table 
show indexes from products;

create index  ind1 on products(productName);

alter table products
add productcolor enum('red','green','blue','white');

alter table products 
drop column productcolor;


alter table products
add productcolor enum('red','green','blue','white') 
after productDesc;

alter table products 
add seller_name varchar(100)
first;

alter table products 
modify column productprice numeric(12,2);

alter table products 
rename column productprice to productP;

rename table products to pro;

desc pro;

drop table student;

-- to show script
show create table products; 

-- table level constraints
create table cust1(
cust_id int , 
cust_name varchar(100) not null,
cust_email varchar(200),
cust_gender enum('m','f'),
constraint cust_id_pk primary key (cust_id),
constraint cust_mail_uk unique key (cust_email)
);

-- after table creation level const
alter table cust1
add constraint name_uk unique key (cust_name);

-- DML(can rollback) 
insert into pro 
values('sijo',123,'mouse','slim flat' ,'white' , 1200, null , '2025-12-09',10,current_timestamp ,current_timestamp);

select * from pro;

insert into pro (productID, productName , productDesc)
values (2,'monitor','black');

show variables like '%secure%';


-- insert into images 
insert into pro 
values('sijo',567,'mouse','slim flat' ,'white' , 1200, load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/wallpaper.jpg') 
, '2025-12-09',10,current_timestamp ,current_timestamp);
 
--  storing anything database
 select productImage into dumpfile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/red.jpg' from pro where productID=567;

show tables;
alter table student 
drop age;

alter table student add age int ;
select*from student;
alter table student add column divison varchar(50) first;
alter table student add column class int after divison;

select sysdate();

select now();
select getdata();

