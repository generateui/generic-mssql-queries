use [Ruud]

DECLARE @sql NVARCHAR(MAX);
SET @sql = N'';

SELECT 
	@sql += 
		CASE 
			WHEN temporal_type = 2 THEN CAST('ALTER TABLE ' + QUOTENAME(s.NAME) + '.' + QUOTENAME(t.NAME) + ' SET (SYSTEM_VERSIONING = OFF);' + char(10) AS NVARCHAR(MAX))
		ELSE CAST(N'' AS NVARCHAR(MAX)) END
FROM   sys.tables t
       JOIN sys.schemas s
         ON t.[schema_id] = s.[schema_id]
WHERE  t.type = 'U'

SELECT @sql = @sql + CAST(N'
  ALTER TABLE ' + QUOTENAME(s.name) + N'.'
  + QUOTENAME(t.name) + N' DROP CONSTRAINT '
  + QUOTENAME(c.name) + ';' + char(10)  AS NVARCHAR(MAX))
FROM sys.objects AS c
INNER JOIN sys.tables AS t
ON c.parent_object_id = t.[object_id]
INNER JOIN sys.schemas AS s 
ON t.[schema_id] = s.[schema_id]
WHERE c.[type] IN ('D','C','F','PK','UQ')
ORDER BY c.[type];

SELECT 
	@sql += CAST('Drop table ' + QUOTENAME(s.NAME) + '.' + QUOTENAME(t.NAME) + ';' + char(10)  AS NVARCHAR(MAX))
FROM   sys.tables t
       JOIN sys.schemas s
         ON t.[schema_id] = s.[schema_id]
WHERE  t.type = 'U'

Exec Sp_executesql @sql