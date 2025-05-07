from fastapi import FastAPI, Query
from app.db import get_db_connection
import psycopg2.extras

app = FastAPI()

@app.get("/projects/summary")
def get_project_summary():
    conn = get_db_connection()
    cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    with open("app/queries/project_summary.sql") as f:
        cur.execute(f.read())
    result = cur.fetchall()
    cur.close()
    conn.close()
    return result

@app.get("/tasks/dependency")
def get_task_hierarchy():
    conn = get_db_connection()
    cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    with open("app/queries/recursive_tasks.sql") as f:
        cur.execute(f.read())
    result = cur.fetchall()
    cur.close()
    conn.close()
    return result

@app.get("/search/tasks")
def search_tasks(keyword: str = Query(...)):
    conn = get_db_connection()
    cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cur.execute("""
        SELECT * FROM tasks
        WHERE name ILIKE %s
    """, (f"%{keyword}%",))
    result = cur.fetchall()
    cur.close()
    conn.close()
    return result

@app.post("/reports/monthly")
def run_monthly_report():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("CALL generate_monthly_report()")
    conn.commit()
    cur.close()
    conn.close()
    return {"status": "monthly report generated"}