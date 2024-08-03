--List the total slots booked per facility

SELECT 
    b.facid AS facility_id,
    SUM(b.slots) AS total_slots
FROM 
    cd.bookings b
GROUP BY 
    b.facid
ORDER BY 
    b.facid;

