--Find the downward recommendation chain for member ID 1

WITH RECURSIVE chain(i) AS (
  SELECT 1
  UNION ALL
  SELECT
    m.memid
  FROM 
    cd.members as m, chain as c
  WHERE 
    m.recommendedby=c.i
)
SELECT
  a.memid, a.firstname, a.surname
FROM
  cd.members as a 
INNER JOIN
  chain as b
ON
  a.memid=b.i
WHERE
  a.memid<>1
ORDER BY
  a.memid;

