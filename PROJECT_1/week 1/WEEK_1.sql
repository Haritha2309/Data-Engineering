-- 1.
create database course_enrollment;
use course_enrollment;

create table students(
student_id int primary key auto_increment,
student_name varchar(50),
student_email varchar(25),
student_college varchar(50)
);

create table courses(
course_id int primary key auto_increment,
title varchar(20),
description varchar(100),
faculty varchar(20)
);

create table enrollments(
enrollment_id int primary key auto_increment,
student_id int,
course_id int,
enrollment_date datetime default current_timestamp,
foreign key (student_id) references students(student_id),
foreign key (course_id) references courses ( course_id)
);

create table progress(
progress_id int primary key auto_increment,
enrollment_id int,
completed boolean default false,
module int,
foreign key (enrollment_id) references enrollments ( enrollment_id)
);
-- 2. 
insert into students(student_name,student_email,student_college) values
("AMIT","amit@gmail.com","KCT"),
("ROHIT","rohit@gmail.com","MCET"),
("LOKESH","lokesh@gmail.com","KPR"),
("RAMYA","ramya@gmail.com","SKET"),
("PRIYA","priya@gmail.com","MCET");

insert into courses(title,faculty,description) values
("FSD","website development","HARI"),
("EMBEDDED","hardware + software","KARPAGAM");

insert into enrollments(student_id,course_id) values
(1,1),
(2,2),
(3,1),
(4,2),
(5,1);
 
insert into progress(enrollment_id,module) values
(1,3),
(2,4),
(3,5),
(4,2),
(5,5);

select * from progress;

-- 3.
delimiter //
create procedure completion_percentage( in in_student_id int)
begin
declare total_modules int default 5;
declare completed_modules int default 0;
declare enroll_id int;
declare prog_id int;

select enrollment_id into enroll_id
from enrollments
where student_id = in_student_id;

select progress_id,module into prog_id,completed_modules
from progress
where enrollment_id = enroll_id
order by progress_id desc
limit 1;

if completed_modules = total_modules then
update progress
set completed = true
where progress_id = prog_id;
end if;

select concat(round((completed_modules/total_modules)*100),"%") as completion_percentage;
end//
delimiter ;

call completion_percentage(2)


