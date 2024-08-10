--Produce a list of all members, along with their recommender

SELECT m1.firstname AS memfname,
	   m1.surname AS memsname,
	   r.firstname AS recfname,
       r.surname AS recsname       
FROM cd.members m1
LEFT JOIN cd.members r ON m1.recommendedby = r.memid
ORDER BY m1.surname, m1.firstname;
