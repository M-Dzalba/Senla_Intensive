--Produce a list of member names, with each row containing the total member count

SELECT COUNT(*) OVER(), firstname, surname
FROM cd.members
ORDER BY joindate

