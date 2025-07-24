create database assign3;
use assign3;

create table pets(
pet_id int primary key,
name varchar(50),
type varchar(20),
breed varchar(50),
age int,
owner_name varchar(20)
);

create table visits(
visit_id int primary key,
pet_id int,
visit_date date,
issue varchar(50),
fee decimal (8,2),
foreign key (pet_id) references pets (pet_id)
);

INSERT INTO Pets VALUES
(1, 'Buddy', 'Dog', 'Golden Retriever', 5, 'Ayesha'),
(2, 'Mittens', 'Cat', 'Persian', 3, 'Rahul'),
(3, 'Rocky', 'Dog', 'Bulldog', 6, 'Sneha'),
(4, 'Whiskers', 'Cat', 'Siamese', 2, 'John'),
(5, 'Coco', 'Parrot', 'Macaw', 4, 'Divya'),
(6, 'Shadow', 'Dog', 'Labrador', 8, 'Karan');

INSERT INTO Visits VALUES
(101, 1, '2024-01-15', 'Regular Checkup', 500.00),
(102, 2, '2024-02-10', 'Fever', 750.00),
(103, 3, '2024-03-01', 'Vaccination', 1200.00),
(104, 4, '2024-03-10', 'Injury', 1800.00),
(105, 5, '2024-04-05', 'Beak trimming', 300.00),
(106, 6, '2024-05-20', 'Dental Cleaning', 950.00),
(107, 1, '2024-06-10', 'Ear Infection', 600.00);

-- 1.
select * 
from pets 
where type = "Dog";

-- 2.
select * 
from visits
where fee>800;

-- 3.
select p.name, p.type,v.issue
from visits v
join pets p on p.pet_id = v.pet_id;

-- 4.
select p.name, count(v.visit_id) as visits
from visits v
join pets p on v.pet_id = p.pet_id 
group by p.name;

-- 5.
select sum(fee) as total
from visits;

-- 6.
select type, avg(age)as avg_age
from pets
group by type;

-- 7.
select * 
from visits 
where  month(visit_date) = 3;

-- 8.
select p.name , count(v.visit_id) as visits
from visits v
join pets p on p.pet_id = v.pet_id
group by p.name
having count(v.visit_id )>1 ;

-- 9.
select p.pet_id,p.name , sum(v.fee) as total_amt
from pets p
join visits v on v.pet_id = p.pet_id 
group by p.name,p.pet_id
order by sum(v.fee) desc 
limit 1;

-- 10.
select *
from pets 
where pet_id not in ( select distinct pet_id from visits);

-- 11.
update visits
set fee = 350
where visit_id = 105;

-- 12.
delete from visits
where visit_date<"2024-02-01";
