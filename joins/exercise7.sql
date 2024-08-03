--Produce a list of all members, along with their recommender, using no joins.

SELECT DISTINCT 
    CONCAT(m1.firstname, ' ', m1.surname) AS member,
    (SELECT CONCAT(m2.firstname, ' ', m2.surname)
     FROM cd.members m2
     WHERE m2.memid = m1.recommendedby) AS recommender
FROM 
    cd.members m1
ORDER BY 
    member;
