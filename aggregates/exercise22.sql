--Calculate a rolling average of total revenue

WITH daily_revenue AS (
    SELECT DISTINCT starttime::date as date,
    SUM(
        CASE
        WHEN memid = 0 THEN guestcost * slots
        ELSE membercost * slots
        END
    ) AS revenue
    FROM cd.bookings b
    INNER JOIN cd.facilities f
    USING (facid)
    GROUP BY date
    ORDER BY date
), avg_daily_revenue AS (
    SELECT date,
    AVG(revenue) OVER (
        ROWS BETWEEN 14 PRECEDING AND CURRENT ROW
    ) AS revenue    
    FROM daily_revenue
)
SELECT * FROM avg_daily_revenue
WHERE date BETWEEN '2012-08-01' AND '2012-08-31'

