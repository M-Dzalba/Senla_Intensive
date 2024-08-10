--Basic string searches

select facid, name, membercost, guestcost, initialoutlay, monthlymaintenance
from cd.facilities
where name like '%Tennis%';
