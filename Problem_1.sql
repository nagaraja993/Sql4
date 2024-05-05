# Write your MySQL query statement below
WITH CTE AS (
    SELECT employee_id, experience, salary, SUM(salary) 
    OVER(PARTITION BY experience ORDER BY salary, employee_id) AS 'rsum'
    FROM Candidates
),
ACTE AS (
    SELECT 70000 - IFNULL(max(rsum), 0) AS remaining FROM CTE WHERE
    experience = 'Senior' and rsum <= 70000
)
SELECT 'Senior' AS experience, count(employee_id) AS 'accepted_candidates'
FROM CTE WHERE experience = 'Senior' AND rsum <= 70000
UNION
SELECT 'Junior' AS experience, count(employee_id) AS 'accepted_candidates'
FROM CTE WHERE experience = 'Junior' AND rsum <= (SELECT remaining FROM ACTE);