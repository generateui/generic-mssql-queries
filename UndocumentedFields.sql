select
	st.name [Table],
	count(st.name)
	--sc.name [Column],
	--sep.value [Description]
from sys.tables st
inner join sys.columns sc on st.object_id = sc.object_id
left join sys.extended_properties sep on st.object_id = sep.major_id
									 and sc.column_id = sep.minor_id
									 and sep.name = 'MS_Description'
WHERE sep.value is null AND CHARINDEX(N'ID', sc.name) = 0
GROUP BY st.name
ORDER BY count(st.name) DESC
