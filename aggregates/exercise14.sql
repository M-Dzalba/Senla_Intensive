--List each member's first booking after September 1st 2012

SELECT surname, firstname, memid, MIN(starttime) as starttime
FROM cd.bookings b
INNER JOIN cd.members m
USING (memid)
WHERE starttime >= '2012-09-01'
GROUP BY memid, surname, firstname
ORDER BY memid
