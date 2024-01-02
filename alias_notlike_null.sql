--Order by more closure
SELECT hiredate firstname, lastname
FROM HR.Employees
ORDER BY hiredate desc, lastname asc

--can order by alias
SELECT orderid, custid, YEAR(orderdate) as orderyear
FROM Sales.Orders
ORDER BY orderyear

--cannot filter by alias
SELECT orderid, custid, YEAR(orderdate) AS ordyear
FROM Sales.Orders
WHERE ordyear = '2016';

--here is how it works
SELECT orderid, custid, YEAR(orderdate) AS ordyear
FROM Sales.Orders
WHERE YEAR(orderdate) = '2016';

--  Step 2: Returning results including NULL
-- NULL handling examples
-- Show the presence of NULL in the region column
-- and ORDER BY sorting NULL together and first
SELECT custid, city, region, country
FROM Sales.Customers
ORDER BY region;

--###########
--NULLs

-- This query eliminates NULLs in region
SELECT custid, city, region, country
FROM Sales.Customers
WHERE region <> N'SP';
--WHERE region != N'SP';

-- This query also eliminates NULLs in region
SELECT custid, city, region, country
FROM Sales.Customers
WHERE region = N'SP';

-- Show how testing for NULL with an equality will
-- return an empty result set
-- might be misinterpreted as an absence of NULLs
-- tricky can be an interview question 
SELECT custid, city, region, country
FROM Sales.Customers
WHERE region = NULL;

-- use this instead
-- This query explicitly includes only NULLs
SELECT custid, city, region, country
FROM Sales.Customers
WHERE region IS NULL;

-- This query explicitly excludes NULLs
SELECT custid, city, region, country
FROM Sales.Customers
WHERE region IS NOT NULL;

--list region is SP with the NULLs
SELECT custid, city, region, country
FROM Sales.Customers
WHERE region = N'SP'
OR region IS NULL;


--#########################
--strings and dates

-- Simple WHERE clause
SELECT contactname, country
FROM Sales.Customers
WHERE country = N'Spain';


-- Use of OR to check for multiple search values
SELECT custid, companyname, country
FROM Sales.Customers
WHERE country = N'UK' OR country = N'Spain';


-- Use IN operator to evaluate from a list
SELECT custid, companyname, country
FROM Sales.Customers
WHERE country IN (N'UK',N'Spain');

-- Use NOT operator with IN to provide an exclusion list
SELECT custid, companyname, country
FROM Sales.Customers
WHERE country NOT IN (N'UK',N'Spain');

-- Filter by date
SELECT orderid, orderdate
FROM Sales.Orders
WHERE orderdate > '20070101';

-- Use logical operators to search within a range of dates
SELECT orderid, custid, orderdate
FROM Sales.Orders
WHERE orderdate > '20160301' AND orderdate < '20160321';
--WHERE orderdate > '20061231' AND orderdate < '20080101';


-- Step 10: Use WHERE to filter results
-- Use BETWEEN operator to search within a range of dates
SELECT orderid, custid, orderdate
FROM Sales.Orders
WHERE orderdate BETWEEN '20061231' AND '20080101';

--On a specific day. All Sales.Orders on 20140704
SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE orderdate >= '20140704'
AND orderdate < '20140705'; 


--#################################
--Like Not like

-- contactname-s, starting with [HC] H or C 
SELECT * 
FROM Sales.Customers 
WHERE contactname 
LIKE N'[HC]%'

--Cheryl or Sheryl
SELECT BusinessEntityID, FirstName, LastName   
FROM Person.Person   
WHERE FirstName LIKE '[CS]heryl'; 


-- ontactname-s, starting with [A-C] character between from A to C 
SELECT * 
FROM Sales.Customers 
WHERE contactname 
LIKE N'[A-C]%'

--contactnames NOT starting with A
--in some cases it may not work
select top 2 * 
FROM Sales.Customers 
WHERE contactname 
LIKE N'[^A]%'

-- 2. NOT starting with A
select top 2 * 
FROM Sales.Customers 
WHERE contactname 
NOT LIKE N'[A]%'

--any contactname where the 2. character matches "a". Undersore "_" means 1 character
select top 2 * 
FROM Sales.Customers 
WHERE contactname 
LIKE N'_a%'

--wildcard character can be searched by "ESCAPE"
LIKE N'10% off%' ESCAPE '%'