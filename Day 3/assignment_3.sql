create database assignment3;
use assignment3;

-- PART 1:
create table books(
book_id int primary key,
title varchar(50),
author varchar(20),
genre varchar(20),
price decimal (8,2)
);

create table customers(
customer_id int primary key,
name varchar(20),
email varchar(20),
city varchar(20)
);

create table orders(
order_id int primary key,
customer_id int,
book_id int,
order_date date,
quantity int,
foreign key (customer_id) references customers(customer_id),
foreign key (book_id) references books(book_id)
);

-- PART 2:

insert into books values
(1, 'The Alchemist', 'Paulo Coelho', 'Fiction', 550.00),
(2, 'Clean Code', 'Robert Martin', 'Programming', 850.00),
(3, 'Atomic Habits', 'James Clear', 'Self-help', 500.00),
(4, 'Deep Work', 'Cal Newport', 'Productivity', 600.00),
(5, 'Unordered Book', 'Unknown Author', 'Mystery', 400.00); 

insert into customers values
(1, 'Ravi Kumar', 'ravi@gmail.com', 'Hyderabad'),
(2, 'Meena Sharma', 'meena@gmail.com', 'Chennai'),
(3, 'Ali Khan', 'ali@gmail.com', 'Hyderabad'),
(4, 'Sneha Reddy', 'sneha@gmail.com', 'Delhi'),
(5, 'Arjun Das', 'arjun@gmail.com', 'Mumbai');

insert into orders values
(1, 1, 1, '2023-02-15', 2),  
(2, 2, 2, '2023-03-10', 1),  
(3, 3, 3, '2023-04-05', 3),  
(4, 1, 4, '2023-05-01', 1),  
(5, 4, 1, '2023-02-25', 1),  
(6, 5, 3, '2023-01-05', 2),  
(7, 3, 2, '2023-06-15', 1);  

-- PART 3:
-- 1.
select * 
from books
where price >500;

-- 2.
select * 
from customers 
where city = "Hyderabad";

-- 3. 
select * 
from orders 
where order_date > "2023-01-01";

-- 4.
select c.name,b.title
from orders o
join customers c on c.customer_id = o.customer_id
join books b on b.book_id = o.book_id;

-- 5.
select b.genre, sum(o.quantity) as total
from orders o
join books b on b.book_id = o.book_id
group by b.genre;

-- 6.
select b.title, SUM(b.price * o.quantity) as total_sales
from orders o
join books b on o.book_id = b.book_id
group by b.title;

-- 7. 
select c.name, COUNT(*) as total_orders
from orders o
join customers c on o.customer_id = c.customer_id
group by c.name
order by total_orders desc
limit 1;

-- 8.
select genre, avg(price) as avg_price
from books
group by genre;

-- 9.
select * 
from books
where book_id not in(select  book_id from orders);

-- 10.
select c.name, sum(b.price * o.quantity) as total_spent
from orders o
join books b on o.book_id = b.book_id
join customers c on o.customer_id = c.customer_id
group by c.name
order by total_spent desc
limit 1;
