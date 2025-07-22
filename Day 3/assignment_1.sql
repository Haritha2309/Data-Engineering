create database assignment1;
use  assignment1;

create table employees(
emp_id int primary key,
emp_name varchar(100),
department varchar(50),
salary int,
age int
);

create table departments(
dept_id int primary key,
dept_name varchar(50),
location varchar(50)
);

INSERT INTO employees VALUES
(101, 'Amit Sharma', 'Engineering', 60000, 30),
(102, 'Neha Reddy', 'Marketing', 45000, 28),
(103, 'Faizan Ali', 'Engineering', 58000, 32),
(104, 'Divya Mehta', 'HR', 40000, 29),
(105, 'Ravi Verma', 'Sales', 35000, 26);

INSERT INTO departments VALUES
(1, 'Engineering', 'Bangalore'),
(2, 'Marketing', 'Mumbai'),
(3, 'HR', 'Delhi'),
(4, 'Sales', 'Chennai');

-- SECTION A :
-- 1. 
select * from employees;

-- 2.
select emp_name,salary
from employees;

-- 3.
select * 
from employees
where salary > 40000;

-- 4.
select *
from employees
where age between 28 and 32;

-- 5. 
select * 
from employees
where department <>"HR";

-- 6. 
select * 
from employees
order by salary desc;

-- 7.
select count(*) as total
from employees;

-- 8.
select * 
from employees
where salary = (select max(salary) from employees);

-- SECTION B:
-- 1.
select e.emp_name,d.location
from employees e
inner join departments d on e.department = d.dept_name;

-- 2. 
select department,count(*) as no_of_emp
from employees
group by department;

-- 3.
select department,avg(salary) as avg_salary
from employees
group by department;

-- 4.
select d.dept_name
from departments d
left join employees e on e.department = d.dept_name
where e.emp_id is NULL;

-- 5. 
select department, sum(salary)as total_salary
from employees
group by department;

-- 6.
select department,avg (salary) as verage_salary 
from employees
group by department
having avg(salary) > 45000;

-- 7.
select emp_name,department
from employees
where salary > 50000
