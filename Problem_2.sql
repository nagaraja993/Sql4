# Write your MySQL query statement below
WITH CTE AS (SELECT home_team_id AS r1, away_team_id AS r2, home_team_goals AS t1, away_team_goals AS t2
FROM Matches
UNION ALL
SELECT away_team_id AS r1, home_team_id AS r2, away_team_goals AS t1, home_team_goals AS t2
FROM Matches)

SELECT T.team_name, count(r1) AS 'matches_played', SUM(
    CASE
        WHEN t1 > t2 THEN 3
        WHEN t1 = t2 THEN 1
        ELSE 0
    END) AS points, 
SUM(t1) AS 'goal_for', SUM(t2) AS 'goal_against',
SUM(t1) - SUM(t2) AS goal_diff
FROM CTE C LEFT JOIN Teams T ON C.r1 = T.team_id
LEFT JOIN Teams T2 ON C.r2 = T2.team_id
GROUP BY r1
ORDER BY points DESC, goal_diff DESC, team_name;