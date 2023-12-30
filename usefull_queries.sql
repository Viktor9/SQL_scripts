--Usefull SQL-s

--How many extracts by extract id created 
--##############
SELECT top 10 extractId, min(ts_create) as TS_CREATE, count(1) as CountBooking
FROM [TABLE_NAME] with(nolock)
GROUP BY ExtractID 
ORDER BY extractID DESC

--OR the SAME

SELECT top 10 extractid, count(extractId) as CountBooking, min(ts_create) as TS_CREATE
FROM [TABLE_NAME] with(nolock)
GROUP BY ExtractID 
ORDER BY extractID DESC
--###########

--Daily extract number
SELECT count(ExtractID) as ExtractocAdottNapon
FROM [TABLE_NAME] WITH (nolock)
WHERE ExtractTypeID = 1234
AND TS_CREATE >= '2023-01-31' AND TS_CREATE < '2023-02-01'


--last extract with 40

declare @DataVariable int;
--set variable
SET @DataVariable = (
  SELECT ExtractID
  FROM [TableName]
  WHERE  
	--last extract with STATUS 40
	ExtractID = (
	SELECT max(ExtractID) FROM [TableName] WITH (NOLOCK) 
	WHERE [ExtractTypeID] = 1234
	and STATUS = 40
	)	);
--print result
SELECT @DataVariable as ExtracID_with_Status_40 ;
--update 40 extract to 200
UPDATE [TableName]
SET STATUS = 200
WHERE ExtractID in (@DataVariable)
AND ExtractTypeID = 1234

--last extract with 40 END


--date CAST
SELECT TOP 1000 *
FROM [Table_name]
WHERE CONVERT(DATE,TS_CREATE)='20231220'
ORDER BY 1 DESC
