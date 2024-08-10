--List the total slots booked per facility per month, part 2

SELECT 
    b.facid,
    EXTRACT(MONTH FROM b.starttime) AS month,
    SUM(b.slots) AS total_slots
FROM 
    cd.bookings b
WHERE 
    EXTRACT(YEAR FROM b.starttime) = 2012
GROUP BY 
    ROLLUP (b.facid, EXTRACT(MONTH FROM b.starttime))
ORDER BY 
    b.facid,
    month;

