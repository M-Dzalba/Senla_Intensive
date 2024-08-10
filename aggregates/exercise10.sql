--Find facilities with a total revenue less than 1000

SELECT 
    f.name AS facility_name,
    SUM(
        CASE
            WHEN b.memid = 0 THEN f.guestcost * b.slots
            ELSE f.membercost * b.slots
        END
    ) AS revenue
FROM 
    cd.bookings b
JOIN 
    cd.facilities f ON b.facid = f.facid
GROUP BY 
    f.name
HAVING 
    SUM(
        CASE
            WHEN b.memid = 0 THEN f.guestcost * b.slots
            ELSE f.membercost * b.slots
        END
    ) < 1000
ORDER BY 
    revenue;

