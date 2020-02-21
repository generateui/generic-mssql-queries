select * 
from information_schema.routines 
where routine_type = 'PROCEDURE' and routine_name like '%address%'
