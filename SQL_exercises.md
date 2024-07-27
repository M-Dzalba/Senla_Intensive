**SQL exercises**

Tables definition:

```sql
CREATE TABLE cd.members (
    memid integer NOT NULL,
    surname varchar(200) NOT NULL,
    firstname varchar(200) NOT NULL,
    address varchar(300) NOT NULL,
    zipcode integer NOT NULL,
    telephone varchar(20) NOT NULL,
    recommendedby integer,
    joindate timestamp without time zone NOT NULL
);

CREATE TABLE cd.bookings (
    bookid integer NOT NULL,
    facid integer NOT NULL,
    memid integer NOT NULL,
    starttime timestamp without time zone NOT NULL,
    slots integer NOT NULL
);

CREATE TABLE cd.facilities (
    facid integer NOT NULL,
    name varchar(100) NOT NULL,
    membercost numeric NOT NULL,
    guestcost numeric NOT NULL,
    initialoutlay numeric NOT NULL,
    monthlymaintenance numeric NOT NULL
);
```

**BASIC**

![basic](https://github.com/user-attachments/assets/704b0887-8e5f-4f79-9c86-57b43b5e561e)

**_Retrieve everything from a table_**
How can you retrieve all the information from the cd.facilities table? [to the task statement](https://www.pgexercises.com/questions/basic/selectall.html)

```sql
SELECT * FROM cd.facilities;
```

**_Retrieve specific columns from a table_**
You want to print out a list of all of the facilities and their cost to members. How would you retrieve a list of only facility names and costs? [to the task statement](https://www.pgexercises.com/questions/basic/selectspecific.html)

```sql
SELECT name, membercost
FROM cd.facilities;
```

**_Control which rows are retrieved_**
How can you produce a list of facilities that charge a fee to members? [to the task statement](https://www.pgexercises.com/questions/basic/where.html)

```sql
SELECT facid, name, membercost, guestcost, initialoutlay, monthlymaintenance	
FROM cd.facilities
WHERE membercost > 0;
```

**_Control which rows are retrieved - part 2_**
How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintenance cost? Return the facid, facility name, member cost, and monthly maintenance of the facilities in question. 
 [to the task statement](https://www.pgexercises.com/questions/basic/where2.html)

```sql
select facid, name, membercost, monthlymaintenance
from cd.facilities
where monthlymaintenance > (membercost*50) and membercost != 0 ;
```

**_Basic string searches_**
How can you produce a list of all facilities with the word 'Tennis' in their name?  [to the task statement](https://www.pgexercises.com/questions/basic/where3.html)

```sql
select facid, name,	membercost, guestcost,	initialoutlay, monthlymaintenance
from cd.facilities
where name like '%Tennis%';
```

**_Matching against multiple possible values_**
How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator. [to the task statement](https://www.pgexercises.com/questions/basic/where4.html)

```sql
select facid, name,	membercost,	guestcost, initialoutlay,	monthlymaintenance
from cd.facilities
where facid in (1,5);
```

**_Classify results into buckets_**
How can you produce a list of facilities, with each labelled as 'cheap' or 'expensive' depending on if their monthly maintenance cost is more than $100? Return the name and monthly maintenance of the facilities in question. [to the task statement](https://www.pgexercises.com/questions/basic/classify.html)

```sql
SELECT name, 
       CASE
           WHEN monthlymaintenance > 100 THEN 'expensive'
           ELSE 'cheap'
       END AS cost
FROM cd.facilities;
```

**_Working with dates_**
How can you produce a list of members who joined after the start of September 2012? Return the memid, surname, firstname, and joindate of the members in question. [to the task statement](https://www.pgexercises.com/questions/basic/classify.html)

```sql
SELECT memid, surname, firstname, joindate
FROM cd.members
WHERE joindate > '2012-09-01';
```

**_Removing duplicates, and ordering results_**
How can you produce an ordered list of the first 10 surnames in the members table? The list must not contain duplicates. [to the task statement](https://www.pgexercises.com/questions/basic/unique.html)

```sql
SELECT DISTINCT surname
FROM cd.members
ORDER BY surname
LIMIT 10;
```

**_Combining results from multiple queries_**
You, for some reason, want a combined list of all surnames and all facility names. Yes, this is a contrived example :-). Produce that list! [to the task statement](https://www.pgexercises.com/questions/basic/union.html)

```sql
SELECT surname AS name
FROM cd.members
UNION
SELECT name AS name
FROM cd.facilities;
```

**_Simple aggregation_**
You'd like to get the signup date of your last member. How can you retrieve this information?  [to the task statement](https://www.pgexercises.com/questions/basic/agg.html)

```sql
SELECT joindate
FROM cd.members
ORDER BY joindate DESC
LIMIT 1;
```

**_More aggregation_**
You'd like to get the first and last name of the last member(s) who signed up - not just the date. How can you do that?
[to the task statement](https://www.pgexercises.com/questions/basic/agg2.html)

```sql
SELECT firstname, surname, joindate
FROM cd.members
WHERE joindate = (
    SELECT MAX(joindate)
    FROM cd.members
);
```
---
**JOINS**

![joins](https://github.com/user-attachments/assets/01b8710e-d4b8-44e2-a8ef-b266236f9cae)

**_Retrieve the start times of members' bookings_**
How can you produce a list of the start times for bookings by members named 'David Farrell'? [to the task statement](https://www.pgexercises.com/questions/joins/simplejoin.html)

```sql
SELECT b.starttime
FROM cd.bookings b
JOIN cd.members m ON b.memid = m.memid
WHERE m.firstname = 'David' AND m.surname = 'Farrell';
```

**_Work out the start times of bookings for tennis courts_**
How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility name pairings, ordered by the time. [to the task statement](https://www.pgexercises.com/questions/joins/simplejoin2.html)

```sql
SELECT b.starttime, f.name
FROM cd.bookings b
JOIN cd.facilities f ON b.facid = f.facid
WHERE f.name LIKE 'Tennis Court%'
  AND DATE(b.starttime) = '2012-09-21'
ORDER BY b.starttime;
```

**_Produce a list of all members who have recommended another member_**
How can you output a list of all members who have recommended another member? Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname). [to the task statement](https://www.pgexercises.com/questions/joins/self.html)

```sql
SELECT DISTINCT m.firstname, m.surname
FROM cd.members m
WHERE m.memid IN (SELECT DISTINCT recommendedby FROM cd.members WHERE recommendedby IS NOT NULL)
ORDER BY m.surname, m.firstname;
```

**_Produce a list of all members, along with their recommender_**
How can you output a list of all members, including the individual who recommended them (if any)? Ensure that results are ordered by (surname, firstname). [to the task statement](https://www.pgexercises.com/questions/joins/self2.html)

```sql
SELECT m1.firstname AS memfname,
	   m1.surname AS memsname,
	   r.firstname AS recfname,
       r.surname AS recsname       
FROM cd.members m1
LEFT JOIN cd.members r ON m1.recommendedby = r.memid
ORDER BY m1.surname, m1.firstname;
```

**_Produce a list of all members who have used a tennis court_**
How can you produce a list of all members who have used a tennis court? Include in your output the name of the court, and the name of the member formatted as a single column. Ensure no duplicate data, and order by the member name followed by the facility name.  [to the task statement](https://www.pgexercises.com/questions/joins/threejoin.html)

```sql
SELECT DISTINCT 
       CONCAT(m.firstname, ' ', m.surname) AS member_name, 
       f.name AS court_name
FROM cd.bookings b
JOIN cd.members m ON b.memid = m.memid
JOIN cd.facilities f ON b.facid = f.facid
WHERE f.name LIKE 'Tennis Court%'
ORDER BY member_name, court_name;
```

**_Produce a list of costly bookings_**
How can you produce a list of bookings on the day of 2012-09-14 which will cost the member (or guest) more than $30? Remember that guests have different costs to members (the listed costs are per half-hour 'slot'), and the guest user is always ID 0. Include in your output the name of the facility, the name of the member formatted as a single column, and the cost. Order by descending cost, and do not use any subqueries.  [to the task statement](https://www.pgexercises.com/questions/joins/threejoin2.html)

```sql
SELECT 
    CASE 
        WHEN b.memid = 0 THEN 'GUEST GUEST' 
        ELSE CONCAT(m.firstname, ' ', m.surname) 
    END AS member, 
    f.name AS facility, 
    CASE
        WHEN b.memid = 0 THEN f.guestcost * b.slots
        ELSE f.membercost * b.slots
    END AS cost
FROM 
    cd.bookings b
LEFT JOIN 
    cd.members m ON b.memid = m.memid
JOIN 
    cd.facilities f ON b.facid = f.facid
WHERE 
    DATE(b.starttime) = '2012-09-14'
    AND (
        (b.memid = 0 AND f.guestcost * b.slots > 30) OR
        (b.memid != 0 AND f.membercost * b.slots > 30)
    )
ORDER BY 
    cost DESC;
```

**_Produce a list of all members, along with their recommender, using no joins._**
How can you output a list of all members, including the individual who recommended them (if any), without using any joins? Ensure that there are no duplicates in the list, and that each firstname + surname pairing is formatted as a column and ordered.
[to the task statement](https://www.pgexercises.com/questions/joins/sub.html)

```sql
SELECT DISTINCT 
    CONCAT(m1.firstname, ' ', m1.surname) AS member,
    (SELECT CONCAT(m2.firstname, ' ', m2.surname)
     FROM cd.members m2
     WHERE m2.memid = m1.recommendedby) AS recommender
FROM 
    cd.members m1
ORDER BY 
    member;
```

**_Produce a list of costly bookings, using a subquery_**
The [Produce a list of costly bookings](https://www.pgexercises.com/questions/joins/threejoin2.html) exercise contained some messy logic: we had to calculate the booking cost in both the WHERE clause and the CASE statement. Try to simplify this calculation using subqueries. For reference, the question was:
How can you produce a list of bookings on the day of 2012-09-14 which will cost the member (or guest) more than $30? Remember that guests have different costs to members (the listed costs are per half-hour 'slot'), and the guest user is always ID 0. Include in your output the name of the facility, the name of the member formatted as a single column, and the cost. Order by descending cost. [to the task statement](https://www.pgexercises.com/questions/joins/tjsub.html)

```sql
SELECT 
    COALESCE(CONCAT(m.firstname, ' ', m.surname), 'GUEST GUEST') AS member,
	bc.facility_name AS facility,    
    bc.cost
FROM 
    (SELECT 
        b.facid,
        b.memid,
        f.name AS facility_name,
        CASE
            WHEN b.memid = 0 THEN f.guestcost * b.slots
            ELSE f.membercost * b.slots
        END AS cost
    FROM 
        cd.bookings b
    JOIN 
        cd.facilities f ON b.facid = f.facid
    WHERE 
        DATE(b.starttime) = '2012-09-14'
    ) AS bc
LEFT JOIN 
    cd.members m ON bc.memid = m.memid
WHERE 
    bc.cost > 30
ORDER BY 
    bc.cost DESC;
```

---

**AGGREGATES**

![Aggregation](https://github.com/user-attachments/assets/d29dc172-04f0-4e3f-8f1d-0a68a205f05b)

**_Count the number of facilities_**
For our first foray into aggregates, we're going to stick to something simple. We want to know how many facilities exist - simply produce a total count. [to the task statement](https://www.pgexercises.com/questions/aggregates/count.html)

```sql
SELECT COUNT(*) AS total_facilities
FROM cd.facilities;
```

**_Count the number of expensive facilities_**
Produce a count of the number of facilities that have a cost to guests of 10 or more. [to the task statement](https://www.pgexercises.com/questions/aggregates/count2.html)

```sql
SELECT COUNT(*) AS count
FROM cd.facilities
WHERE guestcost >= 10;
```

**_Count the number of recommendations each member makes._**
Produce a count of the number of recommendations each member has made. Order by member ID. [to the task statement](https://www.pgexercises.com/questions/aggregates/count3.html)

```sql
SELECT 
    m.memid AS member_id,
    COUNT(r.memid) AS num_recommendations
FROM 
    cd.members m
LEFT JOIN 
    cd.members r ON m.memid = r.recommendedby
GROUP BY 
    m.memid
HAVING 
    COUNT(r.memid) > 0
ORDER BY 
    m.memid;
```

**_List the total slots booked per facility_**
Produce a list of the total number of slots booked per facility. For now, just produce an output table consisting of facility id and slots, sorted by facility id. [to the task statement](https://www.pgexercises.com/questions/aggregates/fachours.html)

```sql
SELECT 
    b.facid AS facility_id,
    SUM(b.slots) AS total_slots
FROM 
    cd.bookings b
GROUP BY 
    b.facid
ORDER BY 
    b.facid;
```

**_List the total slots booked per facility in a given month_**
Produce a list of the total number of slots booked per facility in the month of September 2012. Produce an output table consisting of facility id and slots, sorted by the number of slots. [to the task statement](https://www.pgexercises.com/questions/aggregates/fachoursbymonth.html)

```sql
SELECT 
    b.facid AS facility_id,
    SUM(b.slots) AS total_slots
FROM 
    cd.bookings b
WHERE 
    b.starttime >= '2012-09-01' AND b.starttime < '2012-10-01'
GROUP BY 
    b.facid
ORDER BY 
    total_slots;
```

**_List the total slots booked per facility per month_**
Produce a list of the total number of slots booked per facility per month in the year of 2012. Produce an output table consisting of facility id and slots, sorted by the id and month. [to the task statement](https://www.pgexercises.com/questions/aggregates/fachoursbymonth2.html)

```sql
SELECT 
    b.facid AS facility_id,
    EXTRACT(MONTH FROM b.starttime) AS month,    
    SUM(b.slots) AS total_slots
FROM 
    cd.bookings b
WHERE 
    EXTRACT(YEAR FROM b.starttime) = 2012
GROUP BY 
    b.facid,
    EXTRACT(MONTH FROM b.starttime),
    EXTRACT(YEAR FROM b.starttime)
ORDER BY 
    b.facid,
    month;
```

**_Find the count of members who have made at least one booking_**
Find the total number of members (including guests) who have made at least one booking. [to the task statement](https://www.pgexercises.com/questions/aggregates/members1.html)

```sql
SELECT 
    COUNT(DISTINCT b.memid) AS total_members
FROM 
    cd.bookings b
WHERE 
    b.memid IS NOT NULL;
```

**_List facilities with more than 1000 slots booked_**
Produce a list of facilities with more than 1000 slots booked. Produce an output table consisting of facility id and slots, sorted by facility id. [to the task statement](https://www.pgexercises.com/questions/aggregates/fachours1a.html)

```sql
SELECT 
    b.facid AS facility_id,
    SUM(b.slots) AS total_slots
FROM 
    cd.bookings b
GROUP BY 
    b.facid
HAVING 
    SUM(b.slots) > 1000
ORDER BY 
    b.facid;
```

**_Find the total revenue of each facility_**
Produce a list of facilities along with their total revenue. The output table should consist of facility name and revenue, sorted by revenue. Remember that there's a different cost for guests and members! [to the task statement](https://www.pgexercises.com/questions/aggregates/facrev.html)

```sql
SELECT 
    f.name AS facility_name,
    SUM(
        CASE
            WHEN b.memid = 0 THEN f.guestcost * b.slots
            ELSE f.membercost * b.slots
        END
    ) AS revenue
FROM 
    cd.bookings b
JOIN 
    cd.facilities f ON b.facid = f.facid
GROUP BY 
    f.name
ORDER BY 
    revenue;
```

**_Find facilities with a total revenue less than 1000_**
Produce a list of facilities with a total revenue less than 1000. Produce an output table consisting of facility name and revenue, sorted by revenue. Remember that there's a different cost for guests and members! [to the task statement](https://www.pgexercises.com/questions/aggregates/facrev.html)

```sql
SELECT 
    f.name AS facility_name,
    SUM(
        CASE
            WHEN b.memid = 0 THEN f.guestcost * b.slots
            ELSE f.membercost * b.slots
        END
    ) AS revenue
FROM 
    cd.bookings b
JOIN 
    cd.facilities f ON b.facid = f.facid
GROUP BY 
    f.name
HAVING 
    SUM(
        CASE
            WHEN b.memid = 0 THEN f.guestcost * b.slots
            ELSE f.membercost * b.slots
        END
    ) < 1000
ORDER BY 
    revenue;
```

**_Output the facility id that has the highest number of slots booked_**
Output the facility id that has the highest number of slots booked. For bonus points, try a version without a LIMIT clause. This version will probably look messy! [to the task statement](https://www.pgexercises.com/questions/aggregates/fachours2.html)

```sql
SELECT 
    b.facid,
    SUM(b.slots) AS total_slots
FROM 
    cd.bookings b
GROUP BY 
    b.facid
ORDER BY 
    total_slots DESC
LIMIT 1;
```

**_List the total slots booked per facility per month, part 2_**
Produce a list of the total number of slots booked per facility per month in the year of 2012. In this version, include output rows containing totals for all months per facility, and a total for all months for all facilities. The output table should consist of facility id, month and slots, sorted by the id and month. When calculating the aggregated values for all months and all facids, return null values in the month and facid columns. [to the task statement](https://www.pgexercises.com/questions/aggregates/fachoursbymonth3.html)

```sql
SELECT 
    b.facid,
    EXTRACT(MONTH FROM b.starttime) AS month,
    SUM(b.slots) AS total_slots
FROM 
    cd.bookings b
WHERE 
    EXTRACT(YEAR FROM b.starttime) = 2012
GROUP BY 
    ROLLUP (b.facid, EXTRACT(MONTH FROM b.starttime))
ORDER BY 
    b.facid,
    month;
```

**_List the total hours booked per named facility_**
Produce a list of the total number of hours booked per facility, remembering that a slot lasts half an hour. The output table should consist of the facility id, name, and hours booked, sorted by facility id. Try formatting the hours to two decimal places.
[to the task statement](https://www.pgexercises.com/questions/aggregates/fachours3.html)

```sql
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
```

**_List each member's first booking after September 1st 2012_**
Produce a list of each member name, id, and their first booking after September 1st 2012. Order by member ID.
[to the task statement](https://www.pgexercises.com/questions/aggregates/nbooking.html)

```sql
SELECT surname, firstname, memid, MIN(starttime) as starttime
FROM cd.bookings b
INNER JOIN cd.members m
USING (memid)
WHERE starttime >= '2012-09-01'
GROUP BY memid, surname, firstname
ORDER BY memid
```

**_Produce a list of member names, with each row containing the total member count_**
Produce a list of member names, with each row containing the total member count. Order by join date, and include guest members. [to the task statement](https://www.pgexercises.com/questions/aggregates/countmembers.html)

```sql
SELECT COUNT(*) OVER(), firstname, surname
FROM cd.members
ORDER BY joindate
```

**_Produce a numbered list of members_**
Produce a monotonically increasing numbered list of members (including guests), ordered by their date of joining. Remember that member IDs are not guaranteed to be sequential. [to the task statement](https://www.pgexercises.com/questions/aggregates/nummembers.html)

```sql
SELECT ROW_NUMBER() OVER (
    ORDER BY joindate
),
firstname, surname
FROM cd.members
```

**_Output the facility id that has the highest number of slots booked, again_**
Output the facility id that has the highest number of slots booked. Ensure that in the event of a tie, all tieing results get output.
[to the task statement](https://www.pgexercises.com/questions/aggregates/fachours4.html)

```sql
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
```

**_Rank members by (rounded) hours used_**
Produce a list of members (including guests), along with the number of hours they've booked in facilities, rounded to the nearest ten hours. Rank them by this rounded figure, producing output of first name, surname, rounded hours, rank. Sort by rank, surname, and first name. [to the task statement](https://www.pgexercises.com/questions/aggregates/rankmembers.html)

```sql
SELECT firstname, surname, round(SUM(slots * 0.5), -1) AS hours,
RANK() OVER (
    ORDER BY round(SUM(slots * 0.5), -1) DESC
) AS rank
FROM cd.members m
INNER JOIN cd.bookings b
USING (memid)
GROUP BY memid
ORDER BY rank, surname, firstname
```

**_Find the top three revenue generating facilities_**
Produce a list of the top three revenue generating facilities (including ties). Output facility name and rank, sorted by rank and facility name. [to the task statement](https://www.pgexercises.com/questions/aggregates/facrev3.html)

```sql
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
```

**_Classify facilities by value_**
Classify facilities into equally sized groups of high, average, and low based on their revenue. Order by classification and facility name. [to the task statement](https://www.pgexercises.com/questions/aggregates/classify.html)

```sql
WITH facility_rank_by_revenue AS (
SELECT name, 
NTILE(3) OVER (
    ORDER BY SUM(
        CASE WHEN memid = 1
        THEN guestcost * slots
        ELSE membercost * slots
        END
    ) DESC
) AS revenue
FROM cd.facilities f
INNER JOIN cd.bookings b
USING (facid)
GROUP BY name
ORDER BY revenue, name
)

SELECT name,
    (CASE
    WHEN revenue = 1 THEN 'high'
    WHEN revenue = 2 THEN 'average'
    ELSE 'low'
    END) AS revenue
FROM facility_rank_by_revenue
```

**_Calculate the payback time for each facility_**
Based on the 3 complete months of data so far, calculate the amount of time each facility will take to repay its cost of ownership. Remember to take into account ongoing monthly maintenance. Output facility name and payback time in months, order by facility name. Don't worry about differences in month lengths, we're only looking for a rough value here!
[to the task statement](https://www.pgexercises.com/questions/aggregates/payback.html)

```sql
SELECT
  a.name,
  a.initialoutlay / (
    sum(b.slots *
	    CASE
	      WHEN b.memid=0 THEN a.guestcost
	      ELSE a.membercost
	    END) / 3.0 - a.monthlymaintenance
	) AS months
FROM
  cd.facilities AS a
INNER JOIN
  cd.bookings AS b
ON
  a.facid = b.facid
GROUP BY
  a.facid, a.name
ORDER BY
  a.name;
```

**_Calculate a rolling average of total revenue_**
For each day in August 2012, calculate a rolling average of total revenue over the previous 15 days. Output should contain date and revenue columns, sorted by the date. Remember to account for the possibility of a day having zero revenue. This one's a bit tough, so don't be afraid to check out the hint! [to the task statement](https://www.pgexercises.com/questions/aggregates/payback.html)

```sql
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
```

---

**RECUSIVE**

![Recursive](https://github.com/user-attachments/assets/3783e9e4-e2c1-4432-964e-2ea4f5962407)

**_Find the upward recommendation chain for member ID 27_**
Find the upward recommendation chain for member ID 27: that is, the member who recommended them, and the member who recommended that member, and so on. Return member ID, first name, and surname. Order by descending member id.
[to the task statement](https://www.pgexercises.com/questions/recursive/getupward.html)

```sql
WITH RECURSIVE recommenders(recommender) AS (
        SELECT recommendedby AS recommender
        FROM cd.members
        WHERE memid = 27
    UNION ALL
        SELECT m.recommendedby AS recommender
        FROM recommenders r, cd.members m
        WHERE r.recommender = m.memid
)
SELECT recommender, firstname, surname
FROM recommenders r
INNER JOIN cd.members m
ON r.recommender = m.memid
ORDER BY recommender DESC 
```

**_Find the downward recommendation chain for member ID 1_**
Find the downward recommendation chain for member ID 1: that is, the members they recommended, the members those members recommended, and so on. Return member ID and name, and order by ascending member id.
[to the task statement](https://www.pgexercises.com/questions/recursive/getdownward.html)

```sql
WITH RECURSIVE chain(i) AS (
  SELECT 1
  UNION ALL
  SELECT
    m.memid
  FROM 
    cd.members as m, chain as c
  WHERE 
    m.recommendedby=c.i
)
SELECT
  a.memid, a.firstname, a.surname
FROM
  cd.members as a 
INNER JOIN
  chain as b
ON
  a.memid=b.i
WHERE
  a.memid<>1
ORDER BY
  a.memid;
```

**_Produce a CTE that can return the upward recommendation chain for any member_**
Produce a CTE that can return the upward recommendation chain for any member. You should be able to select recommender from recommenders where member=x. Demonstrate it by getting the chains for members 12 and 22. Results table should have member and recommender, ordered by member ascending, recommender descending.
[to the task statement](https://www.pgexercises.com/questions/recursive/getupwardall.html)

```sql
WITH RECURSIVE recommenders(memid, recommender) AS (
        SELECT memid, recommendedby AS recommender
        FROM cd.members
    UNION ALL
        SELECT r.memid, recommendedby
        FROM recommenders r, cd.members m
        WHERE r.recommender = m.memid
)
SELECT r.memid, recommender, firstname, surname
FROM recommenders r
INNER JOIN cd.members m
ON r.recommender = m.memid
WHERE r.memid IN (12, 22)
ORDER BY r.memid ASC, r.recommender DESC
```