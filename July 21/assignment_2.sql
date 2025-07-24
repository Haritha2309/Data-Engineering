create database assignment2;
use assignment2;

create table students(
student_id int primary key,
name varchar(100),
age int,
gender varchar(10),
department_id int,
foreign key (department_id) references departments(department_id)
);

create table departments (
department_id int primary key,
department_name varchar(100),
head_of_department varchar(100)
);

create table courses(
course_id int primary key,
course_name varchar(100),
department_id int,
credit_hours int,
foreign key(department_id) references departments(department_id)
);

INSERT INTO students VALUES
(1, 'Amit Sharma', 20, 'Male', 1),
(2, 'Neha Reddy', 22, 'Female', 2),
(3, 'Faizan Ali', 21, 'Male', 1),
(4, 'Divya Mehta', 23, 'Female', 3),
(5, 'Ravi Verma', 22, 'Male', 2);

INSERT INTO departments VALUES
(1, 'Computer Science', 'Dr. Rao'),
(2, 'Electronics', 'Dr. Iyer'),
(3, 'Mechanical', 'Dr. Khan');

INSERT INTO courses VALUES
(101, 'Data Structures', 1, 4),
(102, 'Circuits', 2, 3),
(103, 'Thermodynamics', 3, 4),
(104, 'Algorithms', 1, 3),
(105, 'Microcontrollers', 2, 2);

-- SECTION A:
-- 1.
select name,age,gender
from students;

-- 2.
select * 
from students
where gender = "Female";

-- 3.
select c.course_name
from courses c
join departments d on c.department_id = d.department_id
where d.department_name = "Electronics";

-- 4.
select department_name,head_of_department
from departments
where department_id = 1;

-- 5.
select *
from students
where age>21;

-- SECTION B:
-- 6.
select s.name,d.department_name
from students s 
join departments d on d.department_id = s.department_id;

-- 7.
select d.department_name,count(s.student_id)
from departments d
join students s on s.department_id = d.department_id
group by d.department_id;

-- 8.
select avg(s.age)as avg_age,d.department_name
from departments d
join students s on s.department_id = d.department_id
group by d.department_id;

-- 9.
select c.course_name,d.department_name
from courses c
join departments d on d.department_id = c.department_id;

-- 10.
select d.department_name 
from departments d 
left join students s on d.department_id = s.department_id
where s.student_id is null;

-- 11
select d.department_name,count(c.course_id) as total
from departments d
join courses c on c.department_id = d.department_id
group by d.department_id
order by total desc
limit 1;

-- SECTION C:
-- 12.
select name
from students 
where age >(select avg(age) from students);

-- 13.
select d.department_name,c.course_name,c.credit_hours
from departments d
join courses c on c.department_id = d.department_id
where c.credit_hours > 3;

-- 14.
select s.name
from students s
where s.department_id = (select department_id
from courses group by department_id
order by count(course_id) 
limit 1
);

-- 15.
select s.name, d.head_of_department
from students s
join departments d on s.department_id = d.department_id
where d.head_of_department like "%Dr.%";

-- 16.
select * 
from students
where age = (select max(age)
 from students
 where age < (select max(age) from students));
 
-- 17. 
 select c.course_name
 from courses c
 join departments d on d.department_id = c.department_id
 where c.department_id in (
 select department_id 
 from students
 group by department_id 
 having count(*) > 2
 );