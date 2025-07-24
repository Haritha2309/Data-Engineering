create database assign1;
use assign1;

create table exercises(
exercise_id int primary key,
exercise_name varchar(50),
category varchar(20),
calories_burn_per_minute int
);

create table workoutlog(
log_id int primary key,
exercise_id int ,
date date,
duration_min int,
mood varchar(20),
foreign key (exercise_id) references exercises(exercise_id)
);

insert into exercises values
(1, 'Running', 'Cardio', 10),
(2, 'Cycling', 'Cardio', 8),
(3, 'Yoga', 'Flexibility', 4),
(4, 'Weight Lifting', 'Strength', 6),
(5, 'Jump Rope', 'Cardio', 12);

insert into workoutlog values
(1, 1, '2025-03-05', 30, 'Energized'),
(2, 1, '2025-03-10', 45, 'Tired'),
(3, 2, '2025-03-12', 40, 'Normal'),
(4, 2, '2025-04-01', 35, 'Energized'),
(5, 3, '2025-03-07', 60, 'Normal'),
(6, 3, '2025-04-05', 45, 'Tired'),
(7, 4, '2025-03-15', 50, 'Normal'),
(8, 4, '2025-03-20', 55, 'Tired'),
(9, 5, '2025-03-22', 25, 'Energized'),
(10, 5, '2025-04-10', 30, 'Normal');

-- 1. 
select * 
from exercises
where category = "Cardio";

-- 2.
select * from workoutlog
where date between "2025-03-01" and "2025-03-31";

-- 3.
select w.log_id, w.duration_min * e.calories_burn_per_minute as total_calories
from workoutlog w
join exercises e on e.exercise_id = w.exercise_id;

-- 4.
select e.category, avg(w.duration_min)as average
from workoutlog w
join exercises e on e.exercise_id = w.exercise_id
group by e.category;

-- 5.
select e.exercise_name,w.date,w.duration_min,(e.calories_burn_per_minute * w.duration_min) as calories_burnt
from workoutlog w
join exercises e on w.exercise_id = e.exercise_id;

-- 6.
select w.date,sum(e.calories_burn_per_minute * w.duration_min) as calories_burnt
from workoutlog w
join exercises e on w.exercise_id = e.exercise_id
group by w.date
order by w.date;

-- 7.
select exercise_name ,calories_burnt
from (
select e.exercise_name,sum(e.calories_burn_per_minute * w.duration_min) as calories_burnt
from workoutlog w
join exercises e on w.exercise_id = e.exercise_id
group by e.exercise_name,e.exercise_id
) as calories
order by calories_burnt desc
limit 1;

-- 8.
select * from exercises
where exercise_id not in (select distinct exercise_id from workoutlog);

-- 9.
select * from workoutlog 
where mood = "Tired" and duration_min >30;

-- 10.
update workoutlog
set mood = "Fresh"
where log_id = 2;
select * from workoutlog where log_id =2;

-- 11.
update exercises
set calories_burn_per_minute = 11
where exercise_name = "Running";
select * from exercises where exercise_name = "Running";

-- 12.
delete from workoutlog
where month(date) = 2 and year(date) = 2024;