--Count the number of recommendations each member makes.

SELECT 
    m.memid AS member_id,
    COUNT(r.memid) AS num_recommendations
FROM 
    cd.members m
LEFT JOIN 
    cd.members r ON m.memid = r.recommendedby
GROUP BY 
    m.memid
HAVING 
    COUNT(r.memid) > 0
ORDER BY 
    m.memid;
