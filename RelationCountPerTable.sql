select outgoing.[table], incoming.count as [incoming_count], outgoing.count as [outgoing_count] from 

	(select t.name as [table],
		count(t.name) as count
	from sys.tables t
		inner join sys.columns col on col.object_id = t.object_id
		left outer join sys.foreign_key_columns fk_cols on fk_cols.parent_object_id = t.object_id and fk_cols.parent_column_id = col.column_id
		left outer join sys.foreign_keys fk on fk.object_id = fk_cols.constraint_object_id
		left outer join sys.tables pk_tab on pk_tab.object_id = fk_cols.referenced_object_id
		left outer join sys.columns pk_col on pk_col.column_id = fk_cols.referenced_column_id and pk_col.object_id = fk_cols.referenced_object_id
	where fk.object_id is not null
	group by t.name) as outgoing

join 

	(select pk_tab.name as [table], count(pk_tab.name) as count
	from sys.tables tab
		inner join sys.columns col 
			on col.object_id = tab.object_id
		left outer join sys.foreign_key_columns fk_cols
			on fk_cols.parent_object_id = tab.object_id
			and fk_cols.parent_column_id = col.column_id
		left outer join sys.foreign_keys fk
			on fk.object_id = fk_cols.constraint_object_id
		left outer join sys.tables pk_tab
			on pk_tab.object_id = fk_cols.referenced_object_id
		left outer join sys.columns pk_col
			on pk_col.column_id = fk_cols.referenced_column_id
			and pk_col.object_id = fk_cols.referenced_object_id
	where pk_tab.schema_id is not null
	GROUP BY pk_tab.name) incoming

ON outgoing.[table] = incoming.[table]
ORDER BY incoming_count DESC, outgoing_count DESC