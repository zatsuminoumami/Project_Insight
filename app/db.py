import psycopg2
import os

def get_db_connection():
    return psycopg2.connect(
        dbname=os.getenv("POSTGRES_DB", "project_insight"),
        user=os.getenv("POSTGRES_USER", "postgres"),
        password=os.getenv("POSTGRES_PASSWORD", "password"),
        host=os.getenv("POSTGRES_HOST", "db"),
        port=os.getenv("POSTGRES_PORT", "5432")
    )