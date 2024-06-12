create database internal1;
use internal1;

-- 1
create table employee1(
Emp_no varchar(30) primary key,
E_name varchar(30),
E_address varchar(30),
E_ph_no varchar(30),
Dept_no varchar(30),
Dept_name varchar(30),
Job_id char(30),
Salary int
);

select*from employee1;
-- 2
alter table employee1 add column HIREDATE date;
-- 3
alter table employee1 modify column Job_id varchar(30);
-- 4
alter table employee1 rename column Emp_no to E_no;
-- 5
alter table employee1;
-- 6
insert into employee1(E_no,E_name,E_address,E_ph_no,Dept_no,Dept_name,Job_id,Salary,HIREDATE)
values
("E1","manu","1-25-01","8688705484","CS101","Computer Sceience",111,50000,"1981-05-01");
insert into employee1(E_no,E_name,E_address,E_ph_no,Dept_no,Dept_name,Job_id,Salary,HIREDATE)
values
("E2","siri","1-36-02","6188705234","CS101","Computer Sceience",123,60000,"1981-10-03"),
("E3","babitha","1-45-03","7288705456","MA112","Mathematics",141,45000,"1981-10-17"),
("E4","raju","1-07-04","8988705123","BIO121","Biology",211,30000,"1980-01-19"),
("E5","sajitha","1-218-05","9888705678","STAT105","Statistics",241,40000,"2024-05-01");
-- 7
select* from employee1;
-- 8
update employee1 set Salary=Salary=Salary*0.25 where Dept_name = "Mathematics";
-- 9
select Dept_name,Salary from employee1;
-- 10
select E_name from employee1 where Dept_name = "Clerk" or "Analyst";
-- 11
select* from employee1 where HIREDATE in ("1981-05-01","1981-10-03","1981-10-17","1980-01-19");
-- 12
select E_name from employee1 where Dept_no = 10 or Dept_name= 20;
-- 13
select* from employee1 where E_name like "s%";
-- 14
savepoint employee1;
-- 15
rollback;
-- 16
commit;
-- 17
create table sailors(
S_id varchar(30) primary key,
S_name varchar(30),
rating varchar(30),
age int
);

create table boats(
b_id varchar(30) primary key,
b_name varchar(30),
colour varchar(30)
);

create table reserves(
S_id varchar(30) primary key,
b_id varchar(30),
day date
);

insert into sailors(S_id,S_name,rating,age)
values
("1","manu","10",22),
("2","siri","10",18),
("3","babitha","8",25),
("4","laxmi","9",32);
select* from sailors;

insert into boats(b_id,b_name,colour)
values
("101","raju","black"),
("102","sajitha","blue"),
("103","thapaswini","red"),
("104","sai","pink");
select* from boats;

insert into reserves(S_id,b_id,day)
values
("1","101","2024-05-23"),
("2","101","2024-05-23"),
("3","102","2024-05-23"),
("4","104","2024-05-23");
select* from reserves;

-- 18
select* from sailors where S_id in(select S_id from reserves where b_id=101);

-- 19
select S_name as sailors_name from sailors s join reserves r on s.S_id = r.S_id;