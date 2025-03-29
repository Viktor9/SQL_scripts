USE [Adatbazis]
GO

--find oldest row in table
--SELECT MIN(TS_CREATE) AS Oldest FROM [Tabla] WITH(NOLOCK)
--find newest row in table
--SELECT MAX(TS_CREATE) AS Oldest FROM [Tabla] WITH(NOLOCK)
--set how many days you want to delet from tabel
DECLARE @dayLimit DATE;
SET @dayLimit = (SELECT DATEADD (d , 30 , (SELECT MIN(TS_CREATE) FROM [Tabla]) ))
--SELECT @dayLimit AS DL

--set the limit here it is set to keep the last 30 days according to TS_create
DECLARE @new_minus_16 DATE
SET @new_minus_16 = (SELECT DATEADD (d , -30 , (SELECT MAX(TS_CREATE) FROM [Tabla]) ))
--SELECT @new_minus_16

--IF @dayLimit > @new_minus_16
IF @new_minus_16 < @dayLimit  
BEGIN
	--PRINT 'Elso sor'
	RETURN;
	--PRINT 'Masodik'
END

--UAT purge script ##########################
ELSE
BEGIN

	IF OBJECT_ID('tempdb.dbo.#IDS', 'U') IS NOT NULL
	DROP TABLE #IDS; 

	--DROP TABLE #IDS

	WHILE (
		--SELECT COUNT(*) FROM [Tabla] WITH(NOLOCK) WHERE CONVERT(DATE,TS_CREATE)<'20191110'
		SELECT COUNT(*) FROM [Tabla] WITH(NOLOCK) WHERE CONVERT(DATE,TS_CREATE)< @dayLimit
	) > 0

	BEGIN
	
		SELECT TOP 75000 FId, TS_CREATE INTO #IDS
		FROM [Tabla] WITH(NOLOCK)
		ORDER BY TS_CREATE ASC
		--SELECT * FROM [Tabla] WHERE FId IN (SELECT FId FROM #IDS)
		DELETE FROM [Tabla] WHERE FId IN (SELECT FId FROM #IDS)

		--DROP TABLE #IDS
		IF OBJECT_ID('tempdb.dbo.#IDS', 'U') IS NOT NULL
		DROP TABLE #IDS; 

	END

END
--SELECT * FROM #IDS

