/*
1. In the Transactions table, there is a Sort Code field which contains dashes. We need to remove these so just have a 6 digit string (hint)
2. Use the SWIFT Bank Code lookup table to bring in additional information about the SWIFT code and Check Digits of the receiving bank account (hint)
3. Add a field for the Country Code 
4. Create the IBAN as above 
5. Remove unnecessary fields 
6. Output the data
*/

SELECT REPLACE(SORT_CODE,'-','') AS SORT_CODE,
*
FROM PD2023_WK02_TRANSACTIONS AS t1
INNER JOIN PD2023_WK02_SWIFT_CODES AS t2
ON t1."BANK"=t2."BANK"  ;

WITH CTE AS(
SELECT REPLACE(SORT_CODE,'-','') AS SORT_CODES,
*
FROM PD2023_WK02_TRANSACTIONS AS t1
INNER JOIN PD2023_WK02_SWIFT_CODES AS t2
ON t1."BANK"=t2."BANK"  
)

SELECT 'GB' || CHECK_DIGITS || SWIFT_CODE || SORT_CODES || ACCOUNT_NUMBER AS "IBAN",
"TRANSACTION_ID"
FROM CTE;

/*Added a string of GB instead of adding a column as didn't have snowflake persmissons to alter table.*/