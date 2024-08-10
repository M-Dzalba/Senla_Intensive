--List facilities with more than 1000 slots booked

SELECT 
    b.facid AS facility_id,
    SUM(b.slots) AS total_slots
FROM 
    cd.bookings b
GROUP BY 
    b.facid
HAVING 
    SUM(b.slots) > 1000
ORDER BY 
    b.facid;

