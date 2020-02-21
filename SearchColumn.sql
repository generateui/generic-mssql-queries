-- fields with certain name
SELECT 
	table_name [Table Name], 
	column_name [Column Name]
FROM 
	information_schema.columns where column_name like '%target%'