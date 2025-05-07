-- 初期データ投入用
INSERT INTO employees (name, department) VALUES
('山田 太郎', '開発部'),
('佐藤 花子', '企画部'),
('鈴木 次郎', '開発部');

INSERT INTO projects (name, start_date, end_date) VALUES
('新製品開発', '2025-04-01', '2025-09-30'),
('内部管理ツール改善', '2025-05-01', '2025-12-31');

INSERT INTO tasks (project_id, name, assigned_to, estimated_hours, status, parent_task_id) VALUES
(1, '要件定義', 1, 20, 'done', NULL),
(1, '設計', 1, 30, 'in_progress', 1),
(1, '実装', 1, 50, 'todo', 2),
(2, '調査', 2, 10, 'done', NULL),
(2, '設計検討', 3, 15, 'in_progress', 4);