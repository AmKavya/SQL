--  Step 1: Create Database
CREATE DATABASE college;
USE college;

-- Step 2: Create Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    dept_id INT
);

-- Step 3: Create Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    student_id INT   -- enrolled student
);

-- Step 4: Create Departments Table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Step 5: Insert Departments
INSERT INTO departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'History');

-- Step 6: Insert Students
INSERT INTO students VALUES
(1, 'Alice', 1),   -- CS
(2, 'Bob', 2),     -- Math
(3, 'Charlie', 1), -- CS
(4, 'David', NULL);-- No dept

-- Step 7: Insert Courses
INSERT INTO courses VALUES
(101, 'Math', 1),     -- Alice enrolled
(102, 'Science', 2),  -- Bob enrolled
(103, 'History', NULL), -- No student enrolled
(104, 'English', 5);    -- Invalid student_id

select * from courses ;
select * from departments ;
select * from students ;

-- inner join : it will return only data where student n courses r available(common data)(null be ignored)

select s.student_name,c.course_name 
from students s 
inner join  courses c 
on s.student_id = c.student_id;

select s.student_name,c.course_name 
from students s 
left join  courses c 
on s.student_id = c.student_id;

select s.student_name,c.course_name 
from students s 
right join  courses c 
on s.student_id = c.student_id;

select s.student_name,c.course_name 
from students s 
left join  courses c 
on s.student_id = c.student_id 
union 
select s.student_name,c.course_name 
from students s 
right join  courses c 
on s.student_id = c.student_id;


-- cross join : cartesian product
select * from students 
cross join courses;

select * from courses 
cross join students;


-- natural join : kind of inner join , but we do no need to pass the common column , it will auto detect it
select student_name,dept_name 
from students 
natural join departments;

select student_name,course_name 
from students 
natural join  courses;

-- self join : employee ; id , name, manage_id 

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT
);

INSERT INTO employee VALUES
(1, 'Alice', 4),   
(2, 'Bob', 3),     
(3, 'Charlie', 1), 
(4, 'David', NULL);


select e.emp_id as employee_id, e.emp_name as employee_name , m.emp_name as manager_name
from employee e 
join  employee m 
on e.manager_id = m.emp_id;


-- R1 table (Students)
CREATE TABLE R1 (
    StudentID INT,
    Name VARCHAR(50),
    Age INT,
    Class VARCHAR(10),
    City VARCHAR(50)
);

INSERT INTO R1 (StudentID, Name, Age, Class, City) VALUES
(1, 'Alice', 15, '9', 'NY'),
(2, 'Bob', 16, '10', 'LA'),
(3, 'Charlie', 15, '9', 'SF'),
(4, 'David', 16, '10', 'NY'),
(5, 'Eve', 15, '9', 'LA'),
(6, 'Frank', 16, '10', 'SF'),
(7, 'Grace', 15, '9', 'NY'),
(8, 'Hannah', 16, '10', 'LA'),
(9, 'Ivy', 15, '9', 'SF'),
(10, 'Jack', 17, '11', 'NY');

-- R2 table (Courses) → empty table
CREATE TABLE R2 (
    CourseID INT,
    CourseName VARCHAR(50),
    Credits INT,
    Teacher VARCHAR(50),
    Room VARCHAR(10),
    Schedule VARCHAR(20),
    Semester VARCHAR(10)
);

select * from R1 cross join  R2;