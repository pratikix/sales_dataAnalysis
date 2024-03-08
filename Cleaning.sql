-- In this data base there are some transactions in USD so we Need to first convert them into INR in order to make Dashboard
UPDATE transactions 
SET sales_amount = sales_amount*82
WHERE currency = 'USD\r' AND currency = 'USD';

UPDATE transactions 
SET sales_amount = sales_amount*82
WHERE currency = 'USD';

-- Later I found out that the currency are looking same but after checking distinct currency 
-- I found out in some rows there is \r hidden keyword in it which will create a huge problem later
UPDATE transactions 
SET currency = 'INR'
WHERE currency = 'USD\r' OR currency = 'USD' OR currency = 'INR\r';

WITH cte AS(
SELECT * , RANK() OVER(PARTITION BY product_code,customer_code,market_code ,order_date,sales_qty, sales_amount , currency ORDER BY product_code ) AS RN 
FROM transactions )

SELECT * FROM cte WHERE Rn>1 -- This Funtion will check it there is any duplicate values of not
