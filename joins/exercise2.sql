--Work out the start times of bookings for tennis courts

SELECT b.starttime, f.name
FROM cd.bookings b
JOIN cd.facilities f ON b.facid = f.facid
WHERE f.name LIKE 'Tennis Court%'
  AND DATE(b.starttime) = '2012-09-21'
ORDER BY b.starttime;

