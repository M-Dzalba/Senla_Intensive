--Combining results from multiple queries 

SELECT surname AS name
FROM cd.members
UNION
SELECT name AS name
FROM cd.facilities;
