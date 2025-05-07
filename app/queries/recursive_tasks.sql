-- タスク依存関係（再帰CTE）
WITH RECURSIVE task_tree AS (
    SELECT id, name, parent_task_id, 1 AS level
    FROM tasks
    WHERE parent_task_id IS NULL

    UNION ALL

    SELECT t.id, t.name, t.parent_task_id, tt.level + 1
    FROM tasks t
    INNER JOIN task_tree tt ON t.parent_task_id = tt.id
)
SELECT * FROM task_tree ORDER BY level, id;