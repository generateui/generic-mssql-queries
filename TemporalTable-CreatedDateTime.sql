/** Select the dateCreated time and date last change time */
SELECT TOP (1000) t.[Id]
      ,t.[Name]
      ,t.[SysStartTime] as ChangedDateTime
      ,t.[SysEndTime],
	  t.[SysStartTime],
	  coalesce(
		(SELECT Min([SysStartTime]) 
		FROM [ruud-test].[dbo].[MSSQL_TemporalHistoryFor_565577053] h
		where h.Id=t.Id), 
		t.SysStartTime) as CreatedDateTime
  FROM [ruud-test].[dbo].[Table1] t

