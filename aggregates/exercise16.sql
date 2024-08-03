--Produce a numbered list of members

SELECT ROW_NUMBER() OVER (
    ORDER BY joindate
),
firstname, surname
FROM cd.members

