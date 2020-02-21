SELECT date_of_birth 
FROM users
WHERE DATEPART(hh, date_of_birth) != 0