--Control which rows are retrieved

SELECT facid, name, membercost, guestcost, initialoutlay, monthlymaintenance	
FROM cd.facilities
WHERE membercost > 0;
