import mysql.connector

conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='manu@sql1',
    database='example'
)

cursor = conn.cursor()


# 1
insert_query = """
INSERT INTO instructor (ID, name, dept_name, salary) VALUES
('10211', 'Smith', 'Biology', 66000)
"""
cursor.execute(insert_query)

# 2
tuple_to_delete = ('10211', 'Smith', 'Biology', 66000)

delete_query = "DELETE FROM instructor WHERE ID = %s AND name = %s AND dept_name = %s AND salary = %s"
cursor.execute(delete_query, tuple_to_delete)

# 3
dept_name = 'History'

select_query = "SELECT * FROM instructor WHERE dept_name = %s"
cursor.execute(select_query, (dept_name,))

results = cursor.fetchall()

for row in results:
    print(row)
    
# 4
cartesian_query = """
SELECT * FROM instructor, teaches
"""

cursor.execute(cartesian_query)

results = cursor.fetchall()

for row in results:
    print(row)
   
# 5 
query = """
SELECT DISTINCT instructor.name, teaches.course_id
FROM instructor
JOIN teaches ON instructor.ID = teaches.ID
"""

# Execute the query
cursor.execute(query)

# Fetch the results
results = cursor.fetchall()

# Print the results
for row in results:
    print(row)
    
# 6
query = """
SELECT name
FROM instructor
WHERE name LIKE '%dar%'
"""

cursor.execute(query)

results = cursor.fetchall()

for row in results:
    print(row[0])
    
# 7
query = """
SELECT name
FROM instructor
WHERE salary BETWEEN 90000 AND 100000
"""

cursor.execute(query)

results = cursor.fetchall()

for row in results:
    print(row[0])
    
conn.commit()

cursor.close()
conn.close()