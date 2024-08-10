--Produce a list of costly bookings, using a subquery

SELECT 
    COALESCE(CONCAT(m.firstname, ' ', m.surname), 'GUEST GUEST') AS member,
	bc.facility_name AS facility,    
    bc.cost
FROM 
    (SELECT 
        b.facid,
        b.memid,
        f.name AS facility_name,
        CASE
            WHEN b.memid = 0 THEN f.guestcost * b.slots
            ELSE f.membercost * b.slots
        END AS cost
    FROM 
        cd.bookings b
    JOIN 
        cd.facilities f ON b.facid = f.facid
    WHERE 
        DATE(b.starttime) = '2012-09-14'
    ) AS bc
LEFT JOIN 
    cd.members m ON bc.memid = m.memid
WHERE 
    bc.cost > 30
ORDER BY 
    bc.cost DESC;

