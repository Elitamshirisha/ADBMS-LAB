create database trigger1;
use trigger1;

create table person(
p_id varchar(30),
NAME VARCHAR(30),
ADDRESS VARCHAR(30),
CITY VARCHAR(30),
AGE varchar(30)
);


delimiter //
create trigger age_check before insert on person
for each row
if new.AGE < 18 then 
set new.AGE= 0;
end if;//

INSERT INTO person(p_id,NAME,ADDRESS,CITY,AGE)
VALUES
("1","Siri","Siddipet","Patiala",23),
("2","Raju","Tagore Nagar","India",14),
("3","Manu","Thigul","Landon",45),
("4","Laxmi","Hyd","Amritsar",34);

select*from person;