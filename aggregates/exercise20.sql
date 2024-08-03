--Classify facilities by value

WITH facility_rank_by_revenue AS (
SELECT name, 
NTILE(3) OVER (
    ORDER BY SUM(
        CASE WHEN memid = 1
        THEN guestcost * slots
        ELSE membercost * slots
        END
    ) DESC
) AS revenue
FROM cd.facilities f
INNER JOIN cd.bookings b
USING (facid)
GROUP BY name
ORDER BY revenue, name
)
SELECT name,
    (CASE
    WHEN revenue = 1 THEN 'high'
    WHEN revenue = 2 THEN 'average'
    ELSE 'low'
    END) AS revenue
FROM facility_rank_by_revenue
