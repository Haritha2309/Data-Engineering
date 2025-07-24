create database assign2;
use assign2;

create table destinations(
destination_id int primary key,
city varchar(20),
country varchar(20),
category varchar(20),
avg_cost_per_day int 
);

create table trips (
trip_id int primary key,
destination_id int,
traveller_name varchar(20),
start_date date,
end_date date,
budget int ,
foreign key (destination_id) references destinations(destination_id)
);

insert into destinations values
(1, 'Goa', 'India', 'Beach', 2500),
(2, 'Jaipur', 'India', 'Historical', 1800),
(3, 'Paris', 'France', 'Historical', 4500),
(4, 'Bali', 'Indonesia', 'Beach', 3000),
(5, 'Queenstown', 'New Zealand', 'Adventure', 5000),
(6, 'Zurich', 'Switzerland', 'Nature', 6000);

insert into trips values
(1, 1, 'Arjun', '2025-03-01', '2025-03-05', 12000),
(2, 2, 'Meera', '2025-04-10', '2025-04-15', 10000),
(3, 3, 'Alex', '2024-12-01', '2024-12-10', 50000),
(4, 4, 'Sophie', '2023-06-05', '2023-06-12', 21000),
(5, 5, 'John', '2022-11-20', '2022-11-28', 43000),
(6, 1, 'Meera', '2025-01-01', '2025-01-06', 14000),
(7, 6, 'Emma', '2025-05-12', '2025-05-20', 50000),
(8, 4, 'Arjun', '2025-02-10', '2025-02-14', 13000),
(9, 3, 'Rahul', '2024-09-01', '2024-09-03', 10000),
(10, 2, 'Sophie', '2023-08-01', '2023-08-05', 9000);

-- 1.
select * 
from destinations
where country = "India";

-- 2.
select * 
 from destinations
 where avg_cost_per_day < 3000;
 
 -- 3.
 select trip_id , datediff(end_date,start_date) +1 as duration
 from trips;
 
 -- 4.
 select * ,datediff(end_date,start_date) +1 as duration
 from trips
 where datediff(end_date,start_date) +1 >7;
 
 -- 5.
 select t.traveller_name , d.city,(datediff(end_date,start_date) +1 * d.avg_cost_per_day ) as total_cost
from trips t
join destinations d on t.destination_id = d.destination_id;
 
 -- 6.
 select d.country, count(*) as total_trips
 from trips t
 join destinations d on d.destination_id = t.destination_id
 group by d.country;
 
 -- 7.
 select d.country, avg(t.budget) as avg_budget
 from trips t
 join destinations d on d.destination_id = t.destination_id
 group by d.country ;
 
 -- 8.
 select traveller_name, count(*) as trip_count
 from trips 
 group by traveller_name
 order by trip_count desc
 limit 1;
 
 -- 9.
 select * 
 from destinations
 where destination_id not in ( select distinct destination_id from destinations);
 
 -- 10.
select t.*, d.city, t.budget / (DATEDIFF(t.end_date, t.start_date) + 1) as cost_per_day
from Trips t
join Destinations d on t.destination_id = d.destination_id
order by  cost_per_day desc
limit 1;

-- 11.
update trips t
join destinations d on d.destination_id = t.destination_id
set t.budget = t.budget + ( 3 * d.avg_cost_per_day)
where t.trip_id =1;

-- 12.
delete from trips 
where end_date < "2023-01-01";