--search for duplicates
--shows the duplicated mail addresses and the number of duplications
SELECT email, COUNT(*) AS mails
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

--or shows only duplicated mail address(es)
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;