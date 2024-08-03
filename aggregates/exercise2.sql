--Count the number of expensive facilities

SELECT COUNT(*) AS count
FROM cd.facilities
WHERE guestcost >= 10;

