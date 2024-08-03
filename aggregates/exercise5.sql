--List the total slots booked per facility in a given month

SELECT 
    b.facid AS facility_id,
    SUM(b.slots) AS total_slots
FROM 
    cd.bookings b
WHERE 
    b.starttime >= '2012-09-01' AND b.starttime < '2012-10-01'
GROUP BY 
    b.facid
ORDER BY 
    total_slots;

