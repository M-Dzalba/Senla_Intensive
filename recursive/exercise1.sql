--Find the upward recommendation chain for member ID 27

WITH RECURSIVE recommenders(recommender) AS (
        SELECT recommendedby AS recommender
        FROM cd.members
        WHERE memid = 27
    UNION ALL
        SELECT m.recommendedby AS recommender
        FROM recommenders r, cd.members m
        WHERE r.recommender = m.memid
)
SELECT recommender, firstname, surname
FROM recommenders r
INNER JOIN cd.members m
ON r.recommender = m.memid
ORDER BY recommender DESC 
