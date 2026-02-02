create  database db;
use db;
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing');


CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    age INT,
    salary INT,
    dept_id INT,
    joining_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO employees VALUES
(101, 'Amit', 28, 50000, 3, '2021-06-15'),
(102, 'Neha', 32, 65000, 2, '2020-03-10'),
(103, 'Rahul', 25, 40000, 3, '2022-01-20'),
(104, 'Sneha', 29, 55000, 4, '2021-11-05'),
(105, 'Karan', 35, 75000, 1, '2019-07-18'),
(106, 'Priya', 27, 48000, 2, '2022-09-12');



CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT,
    hours_worked INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO projects VALUES
(201, 'Payroll System', 101, 120),
(202, 'Budget Analysis', 102, 90),
(203, 'Website Revamp', 104, 150),
(204, 'Recruitment Drive', 105, 60),
(205, 'Data Migration', 103, 110);


select * from employees;

select emp_name , salary from employees;

select * from employees where salary > 50000;

select e.emp_id , e.emp_name,e.age,e.salary,e.joining_date,d.dept_name
from employees e join departments d 
on e.dept_id = d.dept_id
where d.dept_name = "IT";

select * from employees 
order by salary desc;

select count(*) from employees;

select round(avg(salary),2) from employees;

select min(salary) as minimun , max(salary) as maximun from employees;

select * from employees 
where emp_name like 'A%';

select * from employees 
where joining_date >  '2021-01-01';

select count(emp_id) , d.dept_name 
from employees e join  departments d  
on e.dept_id = d.dept_id 
group by e.dept_id;

select count(emp_id) , d.dept_name 
from employees e join  departments d  
on e.dept_id = d.dept_id 
group by e.dept_id
having count(emp_id) > 1;


