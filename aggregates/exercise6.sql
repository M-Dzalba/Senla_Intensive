--List the total slots booked per facility per month

SELECT 
    b.facid AS facility_id,
    EXTRACT(MONTH FROM b.starttime) AS month,    
    SUM(b.slots) AS total_slots
FROM 
    cd.bookings b
WHERE 
    EXTRACT(YEAR FROM b.starttime) = 2012
GROUP BY 
    b.facid,
    EXTRACT(MONTH FROM b.starttime),
    EXTRACT(YEAR FROM b.starttime)
ORDER BY 
    b.facid,
    month;
