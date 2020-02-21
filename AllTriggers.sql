SELECT  TAB.name as Table_Name, TRIG.name as Trigger_Name
FROM [sys].[triggers] as TRIG 
inner join sys.tables as TAB 
on TRIG.parent_id = TAB.object_id 