create database customer;
create table customer(
CNO varchar(30) primary key,
NAME VARCHAR(30),
ADDRESS VARCHAR(30),
CITY VARCHAR(30)
);
INSERT INTO customer(CNO,NAME,ADDRESS,CITY)
VALUES
("C1","Rahat","Thapar Nagar","Patiala"),
("C2","Rhuhi","Tagore Nagar","Jalandhar"),
("C3","Chatan","Dharamapura","Qadian"),
("C4","Pooja","GNDU","Amritsar");

create table customer_loan(
CNO varchar(30),
LNO varchar(30),
AMOUNT INT
);
INSERT INTO customer_loan(CNO,LNO,AMOUNT)
VALUES
("C1","L1","10000"),
("C2","L1","10000"),
("C3","L2","15000"),
("C3","L3","25000"),
("C4","L4","35000");





use customer;
select *from customer;
select *from customer_loan;
