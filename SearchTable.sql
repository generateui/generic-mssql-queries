-- fields with certain name
use [permit-dev-amsterdam]
SELECT 
	table_name [Table Name]
FROM 
	information_schema.TABLES where table_name like '%target%'