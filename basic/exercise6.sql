--Matching against multiple possible values

select facid, name, membercost,	guestcost, initialoutlay, monthlymaintenance
from cd.facilities
where facid in (1,5);
