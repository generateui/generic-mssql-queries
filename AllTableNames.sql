SELECT 
    distinct(t.NAME) AS TableName
FROM 
    sys.tables t
INNER JOIN 
    sys.partitions p ON t.object_id = p.OBJECT_ID
WHERE t.NAME NOT LIKE '%History%'
ORDER BY 
    t.Name