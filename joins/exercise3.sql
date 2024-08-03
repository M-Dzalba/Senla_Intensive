--Produce a list of all members who have recommended another member

SELECT DISTINCT m.firstname, m.surname
FROM cd.members m
WHERE m.memid IN (SELECT DISTINCT recommendedby FROM cd.members WHERE recommendedby IS NOT NULL)
ORDER BY m.surname, m.firstname;

