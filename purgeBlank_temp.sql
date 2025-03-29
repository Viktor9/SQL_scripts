USE [DataBase]
GO
--purge script limit 2023-07-01
-- ennel frissebb napokat ne toroljon
DECLARE @dayLimitBI DATE;
SET @dayLimitBI = '2023-07-01'
--SET @dayLimitBI = '2021-06-14'
SELECT @dayLimitBI AS BI_daylimit


DECLARE @minDate DATE
SET @minDate = (
SELECT MIN(TS_CREATE) as legregebi
FROM [DataBase].[Tablicsku] WITH (NOLOCK))

SELECT @minDate AS mindate


DECLARE @FPiDlimit BIGINT
SET @FPiDlimit = (
SELECT MAX(Needed_ID) 
FROM [DataBase].[Tablicsku]
WHERE CONVERT(date,TS_CREATE) = @minDate 
)
SELECT @FPiDlimit AS BI_id

IF @dayLimitBI <= @minDate   
BEGIN
	
	RETURN;

END

--BI purge script ##########################
ELSE
BEGIN

	DELETE FROM [DataBase].[Tablicsku]
	WHERE [Needed_ID] <= @FPiDlimit

END