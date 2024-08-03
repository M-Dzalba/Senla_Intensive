--Rank members by (rounded) hours used

SELECT firstname, surname, round(SUM(slots * 0.5), -1) AS hours,
RANK() OVER (
    ORDER BY round(SUM(slots * 0.5), -1) DESC
) AS rank
FROM cd.members m
INNER JOIN cd.bookings b
USING (memid)
GROUP BY memid
ORDER BY rank, surname, firstname

