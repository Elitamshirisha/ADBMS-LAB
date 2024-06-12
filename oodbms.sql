-- query 1
CREATE TYPE addr_ty AS OBJECT
  2  (street    varchar2(60),
  3  city       varchar2(30),
  4  state      char(2),
  5  zip        varchar(9));
  6  /

Type created.

SQL> CREATE TYPE person_ty AS OBJECT
  2     (name   varchar2(25),
  3     address  addr_ty);
  4  /

Type created.

SQL> CREATE TYPE emp_ty AS OBJECT
  2     (empt_id        varchar2(9),
  3     person  person_ty);
  4
  5  /

Type created.

-- query 2
SQL> CREATE TABLE EMP_OO
  2     (full_emp emp_ty);

-- query 3
-- insert
insert into EMP_OO values( emp_ty('100', person_ty('raju', addr_ty('100 st','Patiala','up','605001'))));
insert into EMP_OO values( emp_ty('101', person_ty('siri', addr_ty('101 st','sire','Blore','105001'))));


-- query 4
-- select
select * from emp_oo;

FULL_EMP(EMPT_ID, PERSON(NAME, ADDRESS(STREET, CITY, STATE, ZIP)))
--------------------------------------------------------------------------------
EMP_TY('100', PERSON_TY('Raju', ADDR_TY('1000 st', 'Patiala', 'up', '605001')))
EMP_TY('101', PERSON_TY('siri', ADDR_TY('1001 st', 'sire', 'AP', '105001')))

select e.full_emp.empt_id ID,e.full_emp.person.name NAME, e.full_emp.person.address.city CITY from emp_oo e;

ID        NAME                      CITY
--------- ------------------------- ------------------------------
100       Raju                       Patiala
101       siri                       sire


-- query 5
-- update
update emp_oo e set e.full_emp.person.name = 'Raju' where e.full_emp.empt_id = '1000';


-- query 6
-- create new obj with member function
create or replace type newemp_ty as object (firstname varchar2(25),
lastname Varchar2(25), birthdate Date, member function age (birthdate in date) return number);


-- query 7
create or replace type body newemp_ty as 
	member function age(birthdate in date) return number is 
	begin
		return round(sysdate - birthdate);
	end;
end;


-- query 8
create table new_emp_oo (employee newemp_ty);

-- query 9
insert into new_emp_oo values(newemp_ty('raju', 'lal','1976-12-12'));

-- query 10 how to call a member function
select e.employee.firstname, e.employee.age, e.employee.age(e.employee.birthdate) from new_emp_oo e;

-- query 11 creation of object table 
create table new_emp1 of emp_ty;


-- query 12 
insert into new_emp1 values('102',person_ty('rajitha',addr_ty('100 TU', 'Pta','PB', '147002'))));

-- query 13
select * from new_emp1;

PERSON_TY('rajitha', ADDR_TY('100 TU', 'Pta', 'PB', '147002'))


-- query 14 references
select ref(p) from new_emp1 p;

REF(P)
--------------------------------------------------------------------------------
0000280209E44C561C843C4E90B9AB35A22AD3E8FBAFAB0D508DDF493C87F3A6F19DC6804F0041DC
C90000

-- query 15 implementing the concept of fk
create type new_dept_oo as object (deptno number(3),dname varchar(10));

-- query 16
create table dept_table of new_dept_oo;

-- query 17
insert into dept_table values (10,'comp');
insert into dept_table values (20,'chem');
insert into dept_table values (30,'math');


-- query 18
create table emp_test_fk(empno number(3), name varchar2(10), dept ref new_dept_oo);

-- query 19
set desc depth 2
desc emp_test_fk

 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 EMPNO                                              NUMBER(3)
 NAME                                               VARCHAR2(10)
 DEPT                                               REF OF NEW_DEPT_OO
 DEPTNO                                             NUMBER(3)
 DNAME                                              VARCHAR2(10)


-- query 20
insert into emp_test_fk select 100, 'raj', ref(p) from dept_table p where deptno =10;
insert into emp_test_fk select 101, 'sam', ref(p) from dept_table p where deptno = 20;

-- query 21 accessing values
select empno, name, deref(e.dept) from emp_test_fk e;
     EMPNO NAME
---------- ----------
DEREF(E.DEPT)(DEPTNO, DNAME)
--------------------------------------------------------------------------------
       100 raj
NEW_DEPT_OO(10, 'comp')

       101 sam
NEW_DEPT_OO(20, 'chem')

select empno, name, deref(e.dept), deref(e.dept).deptno DEPTNO,deref(e.dept).dname DNAME from emp_test_fk e;
     EMPNO NAME
---------- ----------
DEREF(E.DEPT)(DEPTNO, DNAME)
--------------------------------------------------------------------------------
    DEPTNO DNAME
---------- ----------
       100 raju
NEW_DEPT_OO(10, 'comp') 10 comp

       101 siri
NEW_DEPT_OO(20, 'chem') 20 chem

     EMPNO NAME
---------- ----------
DEREF(E.DEPT)(DEPTNO, DNAME)
--------------------------------------------------------------------------------
    DEPTNO DNAME
---------- ----------

-- query 22
 create table emp_table_fk (employee emp_ty, dept ref new_dept_oo);

set desc depth 2

-- query 23
insert into emp_table_fk values (emp_ty('100', person_ty('ram', addr_ty('100 st','Patiala','up','605001'))), (select ref(p) from dept_table p where deptno = 10));

-- query 24
select * from em_table_fk;
EMPLOYEE(EMPT_ID, PERSON(NAME, ADDRESS(STREET, CITY, STATE, ZIP)))
--------------------------------------------------------------------------------
DEPT
--------------------------------------------------------------------------------
EMP_TY('100', PERSON_TY('raju', ADDR_TY('100 st', 'Patiala', 'up', '605001')))
00002202088ECB5F5DB94A44CD901A1BACD0D508D64D9EE4FAD8EF4404B2D19B5A449B8463

select e.employee.empt_id ID, e.employee.person.name NAME, deref(e.dept), deref(e.dept).deptno DEPTNO,deref(e.dept).dname DNAME from emp_table_fk e;

ID        NAME
--------- -------------------------
DEREF(E.DEPT)(DEPTNO, DNAME)
--------------------------------------------------------------------------------
    DEPTNO DNAME
---------- ----------
100       raju
NEW_DEPT_OO(10, 'comp')
        10 comp