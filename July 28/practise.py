import mysql.connector

conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Haritha@2309',
    database='sample_sql'
)

cursor = conn.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS employees(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    salary FLOAT
);
"""
cursor.execute(create_table_query)
print("Table 'employee' created successfully.")

insert_query = """
INSERT INTO employees(name,department,salary) VALUES
('RAHUL SHARMA','ENGINEERING',75000),
('NIKITHA', 'MARKETING',55000),
('ANIL KAPOOR', ' HR',50000);
"""

cursor.execute(insert_query)
conn.commit()
print("SIMPLE DATA INSERTED")

update_query = """
update employees set salary = 25000 where department = 'HR'"""
cursor.execute(update_query)
conn.commit()
print("DATA UPDATED")

select_query = "SELECT * FROM employees WHERE department = 'HR'"
cursor.execute(select_query)
rows = cursor.fetchall()
for row in rows:
    print(row)

delete_query = "DELETE FROM employees where id = 2"
cursor.execute(delete_query)
conn.commit()

print("FINAl TABLE")
select_query1 = "SELECT * FROM employees "
cursor.execute(select_query1)
rows = cursor.fetchall()
for row in rows:
    print(row)
cursor.close()
conn.close()