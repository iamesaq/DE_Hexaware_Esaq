drop database if exists sqlrefresher;
create database sqlrefresher;
use sqlrefresher;

-- create table
drop table if exists students;
create table students(id int primary key, name varchar(50), age int, grade varchar(10), marks int, admission_date date);

-- storing data
insert into students values (1, 'john', 18, 'a', 85, '2023-06-15');
insert into students values (2, 'alice', 19, 'b', 75, '2023-06-20');
insert into students values (3, 'bob', 18, 'a', 90, '2023-06-25');

-- updating data
update students set marks = 88 where id = 1;

-- deleting data
delete from students where id = 2;

-- retrieving data
select * from students;
select name, age from students;

-- retrieving selected rows using where (filtering)
select * from students where age = 18;
select * from students where grade in ('a', 'b');

-- filter data with IN, DISTINCT, AND, OR, BETWEEN, IN , LIKE
select distinct grade from students;
select * from students where age = 18 and grade = 'a';
select * from students where age = 18 or marks > 80;
select * from students where age between 18 and 20;
select * from students where name like 'j%';

-- table aliases
select s.name as student_name, s.age as student_age from students s;

-- using string func
select upper(name) from students;
select lower(name) from students;
select concat(name, ' - grade ', grade) as details from students;
select length(name) from students;
select substr(name, 1, 3) from students;

-- using date func
select year(admission_date), month(admission_date) from students;
select now(), curdate(), curtime();

-- using math func
select round(marks/10, 2) from students;
select abs(marks - 90) from students;
select user(), database(), version();

-- summary
select count(*) from students;
select avg(marks), max(marks), min(marks), sum(marks) from students;

-- grouping and aggregate 
select grade, avg(marks) from students group by grade;
select grade, count(*) from students group by grade;
select grade, count(*) from students group by grade having count(*) > 1;
select * from students where marks > (select avg(marks) from students);
select grade, avg(marks) from students group by grade order by avg(marks) desc;

-- joins 
drop table if exists courses;
create table courses(student_id int, course_name varchar(50));

insert into courses values (1, 'math'), (1, 'science'), (3, 'english');

-- inner join
select s.name, c.course_name from students s inner join courses c on s.id = c.student_id;

-- left join
select s.name, c.course_name from students s left join courses c on s.id = c.student_id;

-- right join
select s.name, c.course_name from students s right join courses c on s.id = c.student_id;

-- full outer join
select s.name, c.course_name from students s left join courses c on s.id = c.student_id union select s.name, c.course_name from students s right join courses c on s.id = c.student_id;

-- cross join
select s.name, c.course_name from students s cross join courses c;

-- join with group by and aggregate func
select s.grade, avg(marks) from students s join courses c on s.id = c.student_id group by s.grade;

-- subqueries
select * from students where exists (select * from courses where students.id = courses.student_id);
select * from students where marks > all (select marks from students where grade = 'b');
select * from students where marks = any (select marks from students where grade = 'a');
select * from students where marks > (select avg(marks) from students where grade = 'b');
select * from students s where marks > (select avg(marks) from students where grade = s.grade);
