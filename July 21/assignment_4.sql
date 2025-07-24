-- SECTION 1:
create database assignment4;
use assignment4;

create table movies(
movie_id int primary key,
title varchar(20),
genre varchar(20),
release_year int,
rental_rate decimal(5,2)
);

create table customers(
customer_id int primary key,
name varchar(20),
email varchar(20),
city varchar(20)
);

create table rentals(
rental_id int primary key,
customer_id int,
movie_id int,
rental_date date,
return_date date,
foreign key(customer_id) references customers(customer_id),
foreign key (movie_id) references movies(movie_id)
);

-- SECTION 2:
insert into movies values
(1, 'Inception', 'Sci-Fi', 2010, 100.00),
(2, 'The Dark Knight', 'Action', 2008, 90.00),
(3, 'Dune', 'Sci-Fi', 2021, 110.00),
(4, 'Soul', 'Animation', 2020, 80.00),
(5, 'Oppenheimer', 'Drama', 2023, 120.00);

insert into customers values
(1, 'Amit Sharma', 'amit@gmail.com', 'Delhi'),
(2, 'Neha Reddy', 'neha@gmail.com', 'Bangalore'),
(3, 'Ravi Mehta', 'ravi@gmail.com', 'Mumbai'),
(4, 'Sneha Das', 'sneha@gmail.com', 'Bangalore'),
(5, 'Ali Khan', 'ali@gmail.com', 'Chennai');

insert rentals value
(1, 1, 1, '2023-07-10', '2023-07-12'), 
(2, 1, 2, '2023-08-01', '2023-08-03'), 
(3, 2, 3, '2023-08-05', '2023-08-08'), 
(4, 3, 2, '2023-08-10', '2023-08-11'), 
(5, 4, 5, '2023-09-01', NULL),         
(6, 5, 4, '2023-09-03', '2023-09-05'), 
(7, 2, 1, '2023-09-07', '2023-09-08'), 
(8, 5, 3, '2023-09-10', '2023-09-13'); 

-- SECTION 3:
-- 1.
select m.title
from rentals r
join movies m on m.movie_id = r.movie_id
join customers c on c.customer_id = r.movie_id
where c.name = "Amit Sharma";

-- 2.
select * 
from customers
where city = "Bangalore";

-- 3.
select *
from movies
where release_year >2020;

-- 4.
select c.name, COUNT(r.rental_id) as rentals_count
from customers c
left join rentals r on c.customer_id = r.customer_id
group by c.name;

-- 5.
select m.title, COUNT(*) as rent_count
from rentals r
join movies m on r.movie_id = m.movie_id
group by m.title
order by rent_count DESC
limit 1;

-- 6.
select sum(m.rental_rate) as total 
from rentals r
join movies m on r.movie_id = m.movie_id;

-- 7.
select c.* 
from customers c 
left join rentals r on c.customer_id = r.customer_id
where r.rental_id is NULL;

-- 8.
select m.genre, sum(m.rental_rate) as total
from rentals r
join movies m on r.movie_id = m.movie_id
group by m.genre;

-- 9.
select c.name,sum(m.rental_rate) as amount
from rentals r
join customers c on r.customer_id = c.customer_id
join movies m on r.movie_id = m.movie_id
group by c.name
order by amount desc 
limit 1;

-- 10.
select m.title
from rentals r
join movies m on r.movie_id = m.movie_id
where r.return_date is null;