CREATE TYPE ExamObj AS OBJECT (
  2   exam_year NUMBER,
  3  exam_city VARCHAR2(100)
  4  );
  5  /

Type created.

SQL> CREATE TYPE ExamTab AS TABLE OF ExamObj;
  2  /

Type created.

SQL> CREATE TYPE SkillObj AS OBJECT (
  2  skill_type VARCHAR2(100),
  3  exams ExamTab
  4  );
  5  /

Type created.

SQL> CREATE TYPE SkillTab AS TABLE OF SkillObj;
  2  /

Type created.

SQL> CREATE TYPE ChildObj AS OBJECT (
  2  child_name VARCHAR2(100),
  3  child_birthday DATE
  4  );
  5  /

Type created.

SQL> CREATE TYPE ChildTab AS TABLE OF ChildObj;
  2  /

Type created.

SQL> CREATE TABLE Emp (
  2  emp_id NUMBER PRIMARY KEY,
  3   ename VARCHAR2(100),
  4   children ChildTabType,
  5  skills SkillTab
  6  )
  7  NESTED TABLE children STORE AS ChildStoreTable,
  8  NESTED TABLE skills STORE AS SkillStoreTable
  9  (NESTED TABLE exams STORE AS ExamStoreTable);

Table created.

SQL> INSERT INTO Emp (emp_id, ename, children, skills) VALUES (
  2  1,
  3  'Siri',
  4  ChildTab(
  5   ChildObj('manu', TO_DATE('2002-04-05', 'YYYY-MM-DD')),
  6  ChildObj('laxmi', TO_DATE('1990-08-21', 'YYYY-MM-DD'))
  7  ),
  8  SkillTab(
  9  SkillObj('dancing', ExamTabType(ExamObjType(2022, 'Dayton'),
 10  ExamObjType(2019, 'San'))),
 11  SkillObjType('singing', ExamTabType(ExamObjType(2021, 'New York')))
 12  )
 13  );

1 row created.

SQL> INSERT INTO Emp (emp_id, ename, children, skills) VALUES (
  2  2,
  3  'manu',
  4  ChildTab(
  5   ChildObjType('laxmi', TO_DATE('2001-04-10', 'YYYY-MM-DD')),
  6  ),
  7  SkillTabType(
  8  SkillObjType('typing', ExamTabType(ExamObjType(2024, 'Dayton'),
  9  SkillObjType('design', ExamTabType(ExamObjType(2023, 'San')))
 10  )
 11  );


ERROR at line 6:
ORA-00936: missing expression


SQL> INSERT INTO Emp (emp_id, ename, children, skills) VALUES (
  2   2,
  3   'mounika',
  4  ChildTab(
  5  ChildObjType('GOUTHAM', TO_DATE('2003-11-25', 'YYYY-MM-DD'))
  6  ),
  7  SkillTab(
  8   SkillObj('typing', ExamTabType(ExamObj(2022, 'Dayton'))),
  9   SkillObj('management', ExamTabType(ExamObj(2021, 'San Francisco')))
 10  )
 11  );

1 row created.

SQL> INSERT INTO Emp (emp_id, ename, children, skills) VALUES (
  2  3,
  3   'babitha',
  4   ChildTab(
  5   ChildObj('Raju', TO_DATE('2001-12-20', 'YYYY-MM-DD'))
  6  ),
  7   SkillTab(
  8   SkillObj('dancing', ExamTab(ExamObj(2019, 'Dayton'))),
  9  SkillObj('design', ExamTab(ExamObj(2021, 'Los Angeles')))
 10  )
 11  );

1 row created.

SQL> INSERT INTO Emp (emp_id, ename, children, skills) VALUES (
  2  4,
  3  'shiva',
  4  ChildTab(
  5   ChildObj('Divya', TO_DATE('1998-10-01', 'YYYY-MM-DD'))
  6  ),
  7   SkillTab(
  8   SkillObj('management', ExamTab(ExamObj(2014, 'Boston')))
  9  )
 10  );

1 row created.

SQL> INSERT INTO Emp (emp_id, ename, children, skills) VALUES (
  2  5,
  3  'santhosh',
  4   ChildTab(
  5  ChildObj('sai', TO_DATE('2008-07-30', 'YYYY-MM-DD'))
  6  ),
  7   SkillTab()
  8  );

1 row created.

SQL> SELECT e.enameFROM Emp e,     TABLE(e.children) cWHERE c.child_birthday >= TO_DATE('2000-01-01', 'YYYY-MM-DD');
SELECT e.enameFROM Emp e,     TABLE(e.children) cWHERE c.child_birthday >= TO_DATE('2000-01-01', 'YYYY-MM-DD')
                       *
ERROR at line 1:
ORA-00923: FROM keyword not found where expected


SQL> SELECT e.ename
  2  FROM Emp e,
  3  TABLE(e.children) c
  4  WHERE c.child_birthday >= TO_DATE('2000-01-01', 'YYYY-MM-DD');

ENAME
--------------------------------------------------------------------------------
Siri
manu
mounika
babitha
santhosh


SQL> SELECT e.ename
  2  FROM Emp e,
  3   TABLE(e.skills) s,
  4   TABLE(s.exams) ex
  5  WHERE s.skill_type = 'typing' AND ex.exam_city = 'Dayton';

ENAME
--------------------------------------------------------------------------------
manu
GURU


SQL> SELECT DISTINCT s.skill_type
  2  FROM Emp e,
  3   TABLE(e.skills) s;

SKILL_TYPE
--------------------------------------------------------------------------------
dancing
singing
typing
design
management