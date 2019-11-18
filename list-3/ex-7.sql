WITH RECURSIVE bc(n, k, val) AS (
    SELECT 0, 0, 1
    UNION ALL
    SELECT a.n + 1,
           a.k + 1,
           1
    FROM bc as a
    WHERE n < 15 AND k < 15
)
SELECT val
FROM bc
WHERE n = 5
  AND k = 5;


