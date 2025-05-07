-- DBスキーマとトリガー、プロシージャ
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    department TEXT
);

CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    start_date DATE,
    end_date DATE
);

CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    name TEXT NOT NULL,
    assigned_to INT REFERENCES employees(id),
    estimated_hours INT,
    status TEXT CHECK (status IN ('todo', 'in_progress', 'done')),
    parent_task_id INT REFERENCES tasks(id),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE task_history (
    id SERIAL PRIMARY KEY,
    task_id INT,
    status TEXT,
    updated_at TIMESTAMP
);

-- トリガー：タスクの状態変更を履歴に記録
CREATE OR REPLACE FUNCTION log_task_update() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO task_history(task_id, status, updated_at)
    VALUES (NEW.id, NEW.status, now());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER task_update_trigger
AFTER UPDATE ON tasks
FOR EACH ROW
WHEN (OLD.status IS DISTINCT FROM NEW.status)
EXECUTE PROCEDURE log_task_update();

-- ストアドプロシージャ：月次レポート生成用
CREATE OR REPLACE PROCEDURE generate_monthly_report()
LANGUAGE SQL
AS $$
    INSERT INTO reports (project_id, report_month, total_tasks, completed_tasks)
    SELECT
        project_id,
        date_trunc('month', CURRENT_DATE)::DATE,
        COUNT(*),
        COUNT(*) FILTER (WHERE status = 'done')
    FROM tasks
    GROUP BY project_id;
$$;

CREATE TABLE reports (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    report_month DATE,
    total_tasks INT,
    completed_tasks INT
);