CREATE SCHEMA IF NOT EXISTS cd;

CREATE TABLE cd.members (
    memid SERIAL PRIMARY KEY,
    surname varchar(200) NOT NULL,
    firstname varchar(200) NOT NULL,
    address varchar(300) NOT NULL,
    zipcode integer NOT NULL,
    telephone varchar(20) NOT NULL,
    recommendedby integer NOT NULL,
    joindate timestamp without time zone NOT NULL   
);

CREATE TABLE cd.facilities (
    facid SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL,
    membercost numeric NOT NULL,
    guestcost numeric NOT NULL,
    initialoutlay numeric NOT NULL,
    monthlymaintenance numeric NOT NULL
);

CREATE TABLE cd.bookings (
    bookid SERIAL PRIMARY KEY,
    facid integer REFERENCES cd.facilities(facid) ON DELETE CASCADE,
    memid integer REFERENCES cd.members(memid) ON DELETE CASCADE,
    starttime timestamp without time zone NOT NULL,
    slots integer NOT NULL
);