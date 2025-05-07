# Project Insight

## 概要

社内プロジェクトを管理するための分析・表示アプリ。SQL技術を続々利用した複雑な問いを解決するための構成です。

## インストール手順

### 必要環境
- Docker
- docker-compose

### 実行手順
```bash
# イメージを作成
$ docker-compose build

# 起動
$ docker-compose up

# APIエンドポイントにアクセス
http://localhost:8000/projects/summary
http://localhost:8000/tasks/dependency
http://localhost:8000/search/tasks?keyword=テスト
http://localhost:8000/reports/monthly
```

## 使用SQL技術
- 複雑JOIN
- 再帰CTE
- ウィンドウ関数
- トリガー
- ストアドプロシージャ
- LIKE検索
- 集縮関数

## 文書構成
- `app/queries/*.sql`に出力要項を集約
- `init_schema.sql`でDBスキーマ生成
- `main.py`でFastAPIエンドポイント提供

## 注意
- 計算ロジックやデータを数量処理するのでPostgreSQLを使用