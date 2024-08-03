--Output the facility id that has the highest number of slots booked

SELECT 
    b.facid,
    SUM(b.slots) AS total_slots
FROM 
    cd.bookings b
GROUP BY 
    b.facid
ORDER BY 
    total_slots DESC
LIMIT 1;
