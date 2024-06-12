show databases;
create database salesman;
use salesman;

create table salesman(
salesman_id int primary key,
name varchar(30),
city varchar(30),
comission float
);
insert into salesman (salesman_id,name,city,comission)
values
(5001,"James Hoog","New York",0.15),
(5002,"Nail Knite","Paris",0.13),
(5005,"Pit Alex","London",0.11),
(5006,"MC Lyon","Paris",0.14),
(5003,"Lauson Hen",null,0.12),
(5007,"Paul Adam","Rome",0.13);


create table customer1(
customer_id int,
customer_name varchar(30),
city varchar(30),
grade int,
salesman_id int,
primary key (customer_id),
foreign key (salesman_id) references salesman (salesman_id)
);
insert into customer1(customer_id,customer_name,city,grade,salesman_id)
values
(3002,"Nick Rimando","New York",100,5001),
(3005,"Graham Zusi","California",200,5002),
(3001,"Brad Guzan","London",null,null),
(3004,"Fabian Johns","Paris",300,5006),
(3007,"Brad Davis","New York",200,5001),
(3009,"Geoff Camero","Berlin",100,null),
(3008,"Julian Green","London",300,5002),
(3003,"Jozy Altidor","Mancow",200,5007);

create table order1(
order_no int,
purch_no float,
order_date date,
customer_id int,
salesman_id int
);
insert into order1(order_no,purch_no,order_date,customer_id,salesman_id)
values
(70001,150.5,"2016-10-05",3005,5002),
(70009,270.5,"2016-09-10",3001,null),
(70002,65.5,"2016-10-05",3002,5001),
(70004,110.5,"2016-08-17",3009,null),
(7007,948.5,"2016-09-10",3005,5002),
(70005,2400.6,"2016-07-27",3007,5001),
(70008,5760,"2016-09-10",3002,5001),
(70010,19830.43,"2016-10-10",3004,5006),
(70003,2480,"2016-10-10",3009,null);





select*from salesman;
select *from customer1;
select*from order1;

--query 1-5
select name,comission from salesman;
select distinct salesman_id from order1;
select name,city from salesman where city="paris";
select * from customer1 where grade=200;
select order_no,order_date,purch_no from order1 where salesman_id=5001;

select order_no from order1 where order_date = "2016-10-05" and salesman_id = 5002;
select*from order1 where salesman_id like 5001;
select customer_name from customer1 where city = "New York" and grade = 100;

alter table order1 add amount int;
alter table order1 modify column order_no int primary key;
select*from order1;
alter table order1
rename column amount to money;
alter table order1
drop column money;
update order1 set order_date = "2016-10-05" where order_no =70001;







