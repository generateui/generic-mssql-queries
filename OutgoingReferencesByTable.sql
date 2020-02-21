use [permit-prod-amsterdam]

declare @table_name varchar(50);
set @table_name = 'PermitType';

--outgoing
select 
    pk_tab.name as [pk_table],
	tab.name as [fk_table],
    col.name as [fk_column]
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
where pk_tab.schema_id is not null and pk_tab.name= @table_name

