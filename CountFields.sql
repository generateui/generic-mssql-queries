-- fields with certain name

use [permit-acc-amsterdam]
SELECT 
	count(column_name)
FROM 
	information_schema.columns where column_name not like '%id%'