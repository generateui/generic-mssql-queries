SELECT   t.Name, c.Name
FROM     
	(SELECT name, object_id, type FROM sys.objects) t
FULL OUTER JOIN 
	(SELECT name, object_id from sys.columns) c
ON t.object_id = c.object_id 
WHERE t.type = 'U' AND UPPER(c.Name) != c.Name
COLLATE Latin1_General_CS_AS