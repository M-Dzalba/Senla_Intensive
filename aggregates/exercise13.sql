--List the total hours booked per named facility

SELECT
    f.facid,
    f.name AS facility_name,
    ROUND(SUM(b.slots) * 0.5, 2) AS hours_booked
FROM
    cd.bookings b
JOIN
    cd.facilities f ON b.facid = f.facid
GROUP BY
    f.facid, f.name
ORDER BY
    f.facid;

