    select
        name
    from sys.tables st
	where UPPER(name) != name
	COLLATE Latin1_General_CS_AS