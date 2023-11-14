//Preppin Data 2023 - Week 01

/*
Input the data (help)
Split the Transaction Code to extract the letters at the start of the transaction code. These identify the bank who processes the transaction (help)
Rename the new field with the Bank code 'Bank'. 
Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values. 
Change the date to be the day of the week (help)
Different levels of detail are required in the outputs. You will need to sum up the values of the transactions in three ways (help):
1. Total Values of Transactions by each bank
2. Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
3. Total Values by Bank and Customer Code
Output each data file (help)
*/

//1. Regex Method

SELECT 
REGEXP_SUBSTR(TRANSACTION_CODE,'\\w*') AS Bank,
*
FROM pd2023_WK01;

//1. Alternative method

SELECT
LEFT(TRANSACTION_CODE,CHARINDEX('-',TRANSACTION_CODE)-1) AS "Bank",
CASE(ONLINE_OR_IN_PERSON)
WHEN 1 THEN 'Online'
WHEN 2 THEN 'In Person'
END AS "ONLINE_OR_IN_PERSON",
CASE (DAYNAME(TO_DATE(LEFT(TRANSACTION_DATE,10),'dd/mm/yyyy'))
WHEN 'Mon' THEN 'Monday'
WHEN 'Tue' THEN 'Tuesday'
WHEN 'Wed' THEN 'Wednesday'
WHEN 'Thu' THEN 'Thursday'
WHEN 'Fri' THEN 'Friday'
WHEN 'Sat' THEN 'Saturday'
WHEN 'Mon' THEN 'Sunday'
      END)
AS "WEEKDAY", 
*
FROM pd2023_WK01
;


//Output 1

SELECT
LEFT(TRANSACTION_CODE,CHARINDEX('-',TRANSACTION_CODE)-1) AS "Bank",
SUM("VALUE") AS "Value"
FROM PD2023_WK01
GROUP BY LEFT(TRANSACTION_CODE,CHARINDEX('-',TRANSACTION_CODE)-1);

//Output 2

WITH CTE AS (

SELECT
LEFT(TRANSACTION_CODE,CHARINDEX('-',TRANSACTION_CODE)-1) AS "Bank",
CASE(ONLINE_OR_IN_PERSON)
WHEN 1 THEN 'Online'
WHEN 2 THEN 'In Person'
END AS "ONLINE_OR_IN_PERSON",
DAYNAME(TO_DATE(LEFT(TRANSACTION_DATE,10),'dd/mm/yyyy')) AS TRANSACTION_DATE,
"VALUE"
FROM PD2023_WK01
  )
  
SELECT
"Bank",
"ONLINE_OR_IN_PERSON",
CASE("TRANSACTION_DATE")
WHEN 'Mon' THEN 'Monday'
WHEN 'Tue' THEN 'Tuesday'
WHEN 'Wed' THEN 'Wednesday'
WHEN 'Thu' THEN 'Thursday'
WHEN 'Fri' THEN 'Friday'
WHEN 'Sat' THEN 'Saturday'
ELSE 'Sunday'
END AS "TRANSACTION_DATE",
sum("VALUE")
FROM CTE
GROUP BY "Bank","ONLINE_OR_IN_PERSON",CASE("TRANSACTION_DATE")
WHEN 'Mon' THEN 'Monday'
WHEN 'Tue' THEN 'Tuesday'
WHEN 'Wed' THEN 'Wednesday'
WHEN 'Thu' THEN 'Thursday'
WHEN 'Fri' THEN 'Friday'
WHEN 'Sat' THEN 'Saturday'
ELSE 'Sunday'
END
;

//Output 3

SELECT
LEFT(TRANSACTION_CODE,CHARINDEX('-',TRANSACTION_CODE)-1) AS "Bank",
"CUSTOMER_CODE",
SUM("VALUE") AS "Value"
FROM PD2023_WK01
GROUP BY LEFT(TRANSACTION_CODE,CHARINDEX('-',TRANSACTION_CODE)-1),
"CUSTOMER_CODE";