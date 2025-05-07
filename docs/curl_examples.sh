#!/bin/bash

# プロジェクトサマリー
curl -X GET http://localhost:8000/projects/summary | jq

# タスク依存構造
curl -X GET http://localhost:8000/tasks/dependency | jq

# タスク検索
curl -X GET "http://localhost:8000/search/tasks?keyword=設計" | jq

# 月次レポート作成
curl -X POST http://localhost:8000/reports/monthly | jq