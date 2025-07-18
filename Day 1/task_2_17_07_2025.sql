create table departments(
dept_id int primary key,
dept_name varchar(100)
);
insert into departments values
(1,'Human Resources'),
(2,'Engineering'),
(3,'Marketing');

create table employees(
emp_id int primary key,
emp_name varchar(100),
dept_id int ,
salary int,
foreign key (dept_id) references departments(dept_id)
);

insert into employees values
(101,'Amit Sharma',1,30000),
(102,'Neha Reddy',2,45000),
(103,'Faizan Ali',2,48000),
(104,'Divya Mehta',3,35000),
(105,'Ravi Verma',null,28000);

-- 1. 
select e.emp_name, d.dept_name
from employees e
left join departments d on d.dept_id = e.dept_id;

-- 2.
select e.emp_name
from employees e
left join departments d on d.dept_id = e.dept_id
where d.dept_name is null;

-- 3. 
select d.dept_name ,count(e.emp_id) as total
from departments d
left join employees e on e.dept_id = d.dept_id
group by d. dept_name;

-- 4.
select d.dept_name , count(e.emp_id) as total
from departments d
left join employees e on e.dept_id = d.dept_id
group by d.dept_name
having count(e.emp_id) = 0;

-- 5.
select e.emp_name,d.dept_name,e.salary
from employees e
join departments d on d.dept_id = e.dept_id
where e.salary > 40000;
