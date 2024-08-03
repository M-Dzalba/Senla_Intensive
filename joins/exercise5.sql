--Produce a list of all members who have used a tennis court

SELECT DISTINCT 
       CONCAT(m.firstname, ' ', m.surname) AS member_name, 
       f.name AS court_name
FROM cd.bookings b
JOIN cd.members m ON b.memid = m.memid
JOIN cd.facilities f ON b.facid = f.facid
WHERE f.name LIKE 'Tennis Court%'
ORDER BY member_name, court_name;
