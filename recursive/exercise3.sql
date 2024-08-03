--Produce a CTE that can return the upward recommendation chain for any member

WITH RECURSIVE recommenders(memid, recommender) AS (
        SELECT memid, recommendedby AS recommender
        FROM cd.members
    UNION ALL
        SELECT r.memid, recommendedby
        FROM recommenders r, cd.members m
        WHERE r.recommender = m.memid
)
SELECT r.memid, recommender, firstname, surname
FROM recommenders r
INNER JOIN cd.members m
ON r.recommender = m.memid
WHERE r.memid IN (12, 22)
ORDER BY r.memid ASC, r.recommender DESC
