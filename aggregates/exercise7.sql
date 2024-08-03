--Find the count of members who have made at least one booking

SELECT 
    COUNT(DISTINCT b.memid) AS total_members
FROM 
    cd.bookings b
WHERE 
    b.memid IS NOT NULL;

