--Produce a list of costly bookings

SELECT 
    CASE 
        WHEN b.memid = 0 THEN 'GUEST GUEST' 
        ELSE CONCAT(m.firstname, ' ', m.surname) 
    END AS member, 
    f.name AS facility, 
    CASE
        WHEN b.memid = 0 THEN f.guestcost * b.slots
        ELSE f.membercost * b.slots
    END AS cost
FROM 
    cd.bookings b
LEFT JOIN 
    cd.members m ON b.memid = m.memid
JOIN 
    cd.facilities f ON b.facid = f.facid
WHERE 
    DATE(b.starttime) = '2012-09-14'
    AND (
        (b.memid = 0 AND f.guestcost * b.slots > 30) OR
        (b.memid != 0 AND f.membercost * b.slots > 30)
    )
ORDER BY 
    cost DESC;
