--Calculate the payback time for each facility

SELECT
  a.name,
  a.initialoutlay / (
    sum(b.slots *
	    CASE
	      WHEN b.memid=0 THEN a.guestcost
	      ELSE a.membercost
	    END) / 3.0 - a.monthlymaintenance
	) AS months
FROM
  cd.facilities AS a
INNER JOIN
  cd.bookings AS b
ON
  a.facid = b.facid
GROUP BY
  a.facid, a.name
ORDER BY
  a.name;
