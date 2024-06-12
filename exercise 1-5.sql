create database example;
use example;

create table instructor(
ID int primary key,
name varchar(30),
dept_name varchar(30),
salary int);

insert into instructor(ID,name,dept_name,salary)
value
(10101,"Srinivasan","Comp.Sci",65000),             
(12121,"Wu","Finance",90000),
(15151,"Mozart","Music",40000),
(22222,"Einstein","Physics",95000),
(32343,"El Said","History",60000),
(33456,"Gold","Physics",95000),
(45565,"Katz","Comp.Sci",75000),
(58583,"Califieri","History",62000),
(76543,"Singh","Finance",80000),
(76766,"Crick","Biology",72000),
(83821,"Brandt","Comp.Sci",92000),
(98345,"Kim","Elec.Eng",80000);



create table teaches(
ID int,
Course_id varchar(30),
sec_id int,
semester varchar(30),
year int);

insert into teaches(ID,Course_id,sec_id,semester,year)
values
(10101,"CS-101",1,"Fall",2017),
(10101,"CS-315",1,"Spring",2018),
(10101,"CS-347",1,"Fall",2017),
(12121,"FIN-201",1,"Spring",2018),
(15151,"MU-199",1,"Spring",2018),
(22222,"PHY-101",1,"Fall",2017),
(32343,"HIS-351",1,"Spring",2018),
(45565,"CS-101",1,"Spring",2018),
(45565,"CS-319",1,"Spring",2018),
(76766,"BIO-101",1,"Summer",2017),
(76766,"BIO-301",1,"Summer",2018),
(83821,"CS-190",1,"Spring",2017),
(83821,"CS-190",2,"Spring",2017),
(83321,"CS-319",2,"Spring",2018),
(98345,"EE-181",1,"Spring",2017);


select*from instructor;
select*from teaches;

insert into instructor value (10211,"Smith","Biology",66000);
delete from instructor where ID=10211;
select *from instructor where dept_name="History";
select*from instructor cross join teaches;
select *from instructor,teaches;
select name,course_id from instructor, teaches where instructor.ID = teaches.ID;
select*from instructor where name like "%dar%";
select name from instructor where salary between 90000 and 100000;


select * from instructor order by salary;
(select course_id from teaches where semester ="Fall" and year=2017) union (select course_id from teaches where semester ="Spring" and year=2018);
select course_id from teaches where (semester ="Fall" and year=2017) and (semester ="Spring" and year=2018);
select course_id from teaches where (semester ="Fall" and year=2017) and not (semester ="Spring" and year=2018);
insert into instructor value (10211,"Smith","Biology",66000);
insert into instructor value (10212,"Tom","Biology",NULL);
select * from instructor where salary is NULL;
select avg(salary) from instructor where dept_name="Comp.Sci";


select count(distinct ID) from teaches where semester = 'Spring' and year = 2018;
select count(*) from teaches;
select dept_name, avg(salary) as avg_salary from instructor group by dept_name;
select dept_name, avg(salary) as avg_salary from instructor group by dept_name having avg(salary) > 42000;
select distinct name from instructor where name not in ('Mozart', 'Einstein');
select name from instructor where salary > some (select salary from instructor where dept_name = 'Biology');
select name from instructor where salary > all (select max(salary) from instructor where dept_name = 'Biology');
select dept_name, avg_salary from (select dept_name, avg(salary) from instructor group by dept_name) as dept_avg(dept_name, avg_salary) where avg_salary > 42000;


SELECT dept_name FROM instructor GROUP BY dept_name HAVING SUM(salary) > (SELECT AVG(salary) FROM instructor);
SELECT instructor.Name, Teaches.course_id FROM instructor LEFT JOIN Teaches ON instructor.ID = Teaches.ID;
SELECT instructor.Name, Teaches.course_id FROM instructor LEFT JOIN Teaches ON instructor.ID = Teaches.ID;
create view faculty as select ID,name,dept_name from instructor;
select * from faculty;
CREATE USER manu@localhost IDENTIFIED BY 'manu12345';
SHOW GRANTS FOR manu@localhost;  
grant select on faculty to manu@localhost;


create view faculty as select ID,name,dept_name from instructor;
select * from faculty;
CREATE VIEW department_salary_totals AS SELECT dept_name, SUM(salary) AS TotalSalary FROM instructor GROUP BY dept_name;
select * from department_salary_totals;
create role 'student';
GRANT SELECT ON faculty TO student;
CREATE USER siri@localhost IDENTIFIED BY 'her123';
set default role all to siri@localhost;
revoke select on faculty from manu@localhost;
drop role 'student';
CREATE USER raju@localhost IDENTIFIED BY 'uppara12345';
SHOW GRANTS FOR raju@localhost;  
grant select on faculty to raju@localhost;