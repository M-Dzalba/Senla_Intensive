--Retrieve the start times of members' bookings

SELECT b.starttime
FROM cd.bookings b
JOIN cd.members m ON b.memid = m.memid
WHERE m.firstname = 'David' AND m.surname = 'Farrell';
