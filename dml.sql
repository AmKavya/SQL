-- database creation n usage 
 create database demodb;
use demodb;

-- table creation
create table students (
stu_id  int primary key auto_increment,
name varchar(50) not null,
email varchar(50),
age int 
);

create table course (
course_id int primary key auto_increment,
c_name varchar(50) not null,
stuID int ,
foreign key(stuID) references students(stu_id)
);

insert into  students (name,email,age)
values 
("sijo" , "sijo@gmail.com", 21),
("okaka" , "okaka@gmail.com", 21),
("neesh" , "neesh@gmail.com", 22),
("chini" , "chini@gmail.com", 24),
("momo" , "momo@gmail.com", 23);

select * from students;


update students set age = 50 where stu_id = 5;

update students set name = "momo" where stu_id = 4;


set sql_safe_updates = 0;

update students set age = 40 where name = "momo";

update students set stu_id = 23 where name ="sijo";

delete from students where stu_id = 23;

CREATE TABLE Cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100)
);

CREATE TABLE Shelters (
    shelter_id INT PRIMARY KEY,
    shelter_name VARCHAR(100),
    city_id INT
);
-- Insert Cities
INSERT INTO Cities (city_id, city_name)
VALUES
(1, 'Mumbai'),
(2, 'Delhi'),
(3, 'Bangalore'),
(4, 'Hyderabad'),
(5, 'Chennai');

-- Insert Shelters
INSERT INTO Shelters (shelter_id, shelter_name, city_id)
VALUES
(101, 'Happy Paws Shelter', 1),
(102, 'Safe Haven Animal Shelter', 1),
(103, 'Delhi Stray Rescue', 2),
(104, 'Bangalore Pet Home', 3),
(105, 'Hyderabad Care Shelter', 4),
(106, 'Chennai Animal Welfare', 5);

update  cities 
set  city_id = 10 where  city_name ='Mumbai';

select * from shelters;
select *from cities;

ALTER TABLE Shelters
ADD CONSTRAINT fk_city
FOREIGN KEY (city_id)
REFERENCES Cities(city_id);


ALTER TABLE Shelters
DROP FOREIGN KEY fk_city;

-- Recreate with ON UPDATE CASCADE
ALTER TABLE Shelters
ADD CONSTRAINT fk_city
FOREIGN KEY (city_id) 
REFERENCES Cities(city_id)
ON UPDATE CASCADE;

UPDATE Cities
SET city_id = 13
WHERE city_id = 2;
drop table cities;
drop table shelters;

select count(*) from cities;

select substr('QWERTY', 2, 4 );
select round(678.90,-1); -- round to nearest ten 
select round (1234 , -4);

select dayname(now());
SELECT DATE_FORMAT(NOW(), '%a %d-%b-%Y %H:%i:%s');

SELECT WEEKDAY(NOW())+2;



CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    DeptID INT,
    Salary INT
);
INSERT INTO Employees (EmpID, Name, DeptID, Salary) VALUES
(100, 'Alice', 10, 50000),
(103, 'Bob', 20, 60000),
(116, 'Carol', 10, 55000),
(1107, 'Dave', 30, 70000),
(900,'Eve', 20, 65000),
(890, 'Frank', 10, 50000),
(188, 'Grace', 30, 72000),
(999, 'Heidi', 20, 60000);

select * from employees where name ='Carol';
CREATE INDEX idx_name ON Employees(Name);




