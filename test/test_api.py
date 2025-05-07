# FastAPI のテスト用スクリプト
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_project_summary():
    response = client.get("/projects/summary")
    assert response.status_code == 200
    assert isinstance(response.json(), list)

def test_task_hierarchy():
    response = client.get("/tasks/dependency")
    assert response.status_code == 200
    assert isinstance(response.json(), list)

def test_search_tasks():
    response = client.get("/search/tasks", params={"keyword": "設計"})
    assert response.status_code == 200
    assert any("設計" in task["name"] for task in response.json())

def test_monthly_report():
    response = client.post("/reports/monthly")
    assert response.status_code == 200
    assert response.json()["status"] == "monthly report generated"