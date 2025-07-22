create database inventory_management;
use inventory_management;

create table products(
product_id int primary key,
name varchar(20),
reorder_level int,
price decimal(6,2)
);

create table warehouse(
warehouse_id int primary key,
name varchar(20),
location varchar(50)
);

create table suppliers(
supplier_id int primary key,
name varchar(50),
ph_number varchar(20)
);

create table stock_movements(
movement_id int primary key,
product_id int,
supplier_id int,
warehouse_id int,
quantity int not null,
movement_type ENUM('IN','OUT'),
movement_date date,
foreign key (product_id) references products(product_id),
foreign key (supplier_id) references suppliers(supplier_id),
foreign key (warehouse_id) references warehouse(warehouse_id)
);

insert into products (product_id, name, reorder_level, price) values
(1, 'Mouse', 100, 299.99),
(2, 'Keyboard', 5, 499.50),
(3, 'Monitor', 3, 7999.00),
(4, 'USB Cable', 15, 149.00);

insert into warehouse (warehouse_id, name, location) values
(1, 'Main Warehouse', 'Chennai'),
(2, 'North Zone', 'Delhi'),
(3, 'South Zone', 'Bangalore');

insert into suppliers (supplier_id, name, ph_number) values
(1, 'ABC Electronics', '9876543210'),
(2, 'Gadget Traders', '9123456780'),
(3, 'Tech Supplies Inc.', '9012345678');

insert into stock_movements (movement_id, product_id, supplier_id, warehouse_id, quantity, movement_type, movement_date) values
(1, 1, 1, 1, 50, 'IN', '2025-07-01'),
(2, 1, NULL, 1, 10, 'OUT', '2025-07-02'),
(3, 2, 2, 1, 30, 'IN', '2025-07-03'),
(4, 2, NULL, 2, 5, 'OUT', '2025-07-04'),
(5, 3, 3, 3, 20, 'IN', '2025-07-05'),
(6, 4, 1, 1, 40, 'IN', '2025-07-06'),
(7, 4, NULL, 1, 10, 'OUT', '2025-07-07'),
(8, 1, NULL, 2, 15, 'OUT', '2025-07-08');

update stock_movements
set quantity = 8
where movement_id = 2;

delete from stock_movements
where movement_id = 8

delimiter //
create procedure needed_reorder()
begin
select p.product_id,p.name,ifnull(sum(
case
when sm.movement_type = 'IN' then sm.quantity
when sm.movement_type = 'OUT' then -sm.quantity
else 0
end
),0) as current_stock
from products p
left join stock_movements sm on sm.product_id = p.product_id
group by p.product_id,p.name,p.reorder_level
having current_stock <p.reorder_level;
end //
delimiter ;
drop procedure if exists needed_reorder;
call needed_reorder()

