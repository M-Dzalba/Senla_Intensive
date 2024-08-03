--Find the top three revenue generating facilities

WITH FacilityRevenue AS (
    SELECT 
        f.name AS facility_name,
        COALESCE(SUM(CASE 
            WHEN b.memid = 0 THEN f.guestcost * b.slots  
            ELSE f.membercost * b.slots                
        END), 0) AS total_revenue
    FROM 
        cd.bookings b
    JOIN 
        cd.facilities f ON b.facid = f.facid
    GROUP BY 
        f.name
),
RankedFacilities AS (
    SELECT 
        facility_name,
        total_revenue,
        RANK() OVER (ORDER BY total_revenue DESC) AS rank
    FROM 
        FacilityRevenue
)
SELECT 
    facility_name,
    rank
FROM 
    RankedFacilities
WHERE 
    rank <= 3
ORDER BY 
    rank, facility_name;
