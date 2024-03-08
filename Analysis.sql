USE sales;
-- *****Sales performance ******

-- What are the top-selling products?
SELECT 
	product_code , 
    COUNT(*) AS TimesSold
FROM transactions
GROUP BY product_code
ORDER BY TimesSold DESC;

-- Which markets are generating the most sales?
SELECT
	t.market_code ,
    m.markets_name , 
    COUNT(*) AS TimesSold
FROM transactions t 
JOIN markets m ON t.market_code = m.markets_code
GROUP BY market_code , markets_name 
ORDER BY TimesSold DESC;

-- What are the trends in sales over time?
SELECT 
  YEAR(order_date) AS SaleYear, 
  MONTH(order_date) AS SaleMonth,
  SUM(Sales_Amount) AS TotalSales
FROM Transactions
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY SaleYear, SaleMonth;

-- How does sales performance vary by customer type?
SELECT 
	c.customer_type,
    SUM(t.Sales_Amount) AS TotalSales
FROM customers  c
JOIN transactions t ON c.customer_code = t.customer_code
GROUP BY c.customer_type;


-- *****Customer analysis**** 

-- Who are the company's most valuable customers?
SELECT 
	c.custmer_name,
    SUM(t.Sales_Amount) AS TotalSales
FROM customers  c
JOIN transactions t ON c.customer_code = t.customer_code
GROUP BY c.custmer_name
ORDER BY TotalSales DESC;

-- What are the buying habits of different customer types?
SELECT 
   c.Customer_Type,
   COUNT(*) AS TotalTransactions,
   SUM(t.Sales_Amount) AS TotalSales,
   AVG(t.Sales_Amount) AS AverageTransactionAmount
FROM Customers c
JOIN Transactions t ON c.Customer_code = t.Customer_code
GROUP BY c.Customer_code, c.Customer_Type
ORDER BY c.Customer_Type;

-- **** Product analysis ****

-- Are there any products that are not selling well?
SELECT
	product_code , 
    COUNT(*) AS TimesSold
FROM transactions
GROUP BY product_code
HAVING TimesSold < 10
ORDER BY TimesSold ASC;

-- What is the profitability of different product lines
SELECT 
	p.Product_type , 
    SUM(t.sales_amount) as TotalAmmount
FROM products p 
JOIN transactions t  ON p.product_code = t.product_code
GROUP BY p.product_type
ORDER BY TotalAmmount DESC
