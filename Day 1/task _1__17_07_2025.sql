-- TASK 1 TABLE CREATION :
create table products(
product_id int primary key,
product_name varchar(100),
product_category varchar(100),
price decimal(8,2),
stock_quantity int,
added_date date
);
--TASK 2 :
insert into products
values (1, 'Laptop','electronics',500000.00,5,'2025-01-01'),
       (2,'headphones','electronics',2500,10,'2025-02-01'),
       (3,'table','furniture',10000,10,'2025-03-01'),
       (4,'bed','furniture',25000,8,'2025-04-01'),
       (5,'bedspread','cloth',700,9,'2025-05-01');
       
--TASK 3:
--1.
select * 
from products
--2.
select product_name, price
from products
--3. 
select product_name 
from products
where stock_quantity <10
--4. 
select product_name, price
from products 
where price between 500 and 2000
--5. 
select * 
from products 
where added_date > '2023-01-01'
--6. 
select product_name 
from products
where product_name like 's%'
--7. 
select product_name, product_category
from products
where product_category in('electronics','furniture')

--TASK 4:
--1.
update products 
set price = 1000 where price = 700
select * from products
--2. 
update products 
set stock_quantity = stock_quantity + 5
select * from products
--3.
delete from products 
where product_id = 4
select * from products
--4. 
delete from products 
where stock_quantity = 0
select * from products