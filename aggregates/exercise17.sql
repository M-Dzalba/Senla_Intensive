--Output the facility id that has the highest number of slots booked, again

WITH SlotCounts AS (
    SELECT 
        b.facid,
        SUM(b.slots) AS total_slots
    FROM 
        cd.bookings b
    GROUP BY 
        b.facid
),
MaxSlots AS (
    SELECT 
        MAX(total_slots) AS max_slots
    FROM 
        SlotCounts
)
SELECT 
    sc.facid,
    sc.total_slots
FROM 
    SlotCounts sc
JOIN 
    MaxSlots ms ON sc.total_slots = ms.max_slots
ORDER BY 
    sc.facid;

