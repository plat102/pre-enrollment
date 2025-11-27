import json
import sqlite3
from datetime import datetime

DB_NAME = 'test.db'
EMPLOYEE_JSON = 'employees.json'

# ----- Connect db -----
# https://docs.python.org/3/library/sqlite3.html
con = sqlite3.connect(DB_NAME)
cur = con.cursor()

# ----- 1. Create table -----
# Create a table named "employees" in the Microsoft SQL (or any SQL) database
cur.execute("""
    CREATE TABLE IF NOT EXISTS employees (
        id INTEGER PRIMARY KEY,
        name TEXT,
        department TEXT,
        salary INTEGER,
        join_date DATE)
""")
con.commit()


# ----- 2. Exract data from json -----
def extract(file_path: str) -> list[dict]:
    with open(file_path, "r") as file:
        data = json.load(file)
    return data


# ----- 3. Transform data -----
def transform(data: list[dict]) -> list[dict]:
    for record in data:
        # Converting the "join_date" string to a date format
        record["join_date"] = datetime.strptime(record["join_date"], "%Y-%m-%d").date()

        # removing any unnecessary fields
        for key in record.keys() - {"id", "name", "department", "salary", "join_date"}:
            del record[key]

    return data


# ----- 4. Load data -----
def load(data: list[dict]):
    insert_sql = """
    INSERT OR REPLACE INTO employees (id, name, department, salary, join_date)
    VALUES (?, ?, ?, ?, ?)
    """
    
    try:
        for record in data:
            cur.execute(insert_sql, (
                record["id"],
                record["name"],
                record["department"],
                record["salary"],
                record["join_date"]
            ))
    except Exception as e:
        print(f"Error inserting record {record['id']}: {e}")

# ----- FULL PROCESS -----

data = extract(EMPLOYEE_JSON)
print(data)

transformed_data = transform(data)
print(transformed_data)

load(transformed_data)
con.commit()
con.close()
