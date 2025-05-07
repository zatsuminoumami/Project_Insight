-- プロジェクトごとのタスク集計と分析
WITH task_stats AS (
    SELECT
        p.id AS project_id,
        p.name AS project_name,
        COUNT(t.id) AS total_tasks,
        COUNT(*) FILTER (WHERE t.status = 'done') AS completed_tasks,
        AVG(t.estimated_hours) AS avg_estimated_hours,
        MAX(t.updated_at) OVER (PARTITION BY p.id) AS last_update
    FROM projects p
    LEFT JOIN tasks t ON p.id = t.project_id
    GROUP BY p.id
)
SELECT * FROM task_stats ORDER BY last_update DESC;