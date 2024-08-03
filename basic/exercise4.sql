--Control which rows are retrieved - part 2

select facid, name, membercost, monthlymaintenance
from cd.facilities
where monthlymaintenance > (membercost*50) and membercost != 0 ;
