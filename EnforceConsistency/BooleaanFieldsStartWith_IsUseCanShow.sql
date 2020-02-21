--check if boolean fields use the IS_, USE_, CAN_ or SHOW_ naming pattern
SELECT 
	table_name [Table Name], 
	column_name [Column Name]
FROM 
	information_schema.columns where data_type = 'BIT'
	AND column_name not like 'IS_%' --general
	AND column_name not like 'USE_%' --
	AND column_name not like 'CAN_%'
	AND column_name not like 'SHOW_%' -- settings
