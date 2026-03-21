

select * from retail_sales;

select * from retail_sales
limit 5;

select count(*) from retail_sales 

--Check Null Values

select * from retail_sales
where transactions_id is null;

select * from retail_sales
where
      transactions_id is null
      OR
	  sale_date is null
	  OR
	  sale_time is null
	  OR
	  customer_id is null
	  OR
	  gender is null
	  OR 
	  age is null
	  OR
	  category is null
	  OR 
	  quantiy is null
	  OR 
	  price_per_unit is null
	  OR 
	  cogs is null
	  OR
	  total_sale is null;

--Data Cleaning

DELETE FROM retail_sales
where
      transactions_id is null
      OR
	  sale_date is null
	  OR
	  sale_time is null
	  OR
	  customer_id is null
	  OR
	  gender is null
	  OR 
	  age is null
	  OR
	  category is null
	  OR 
	  quantiy is null
	  OR 
	  price_per_unit is null
	  OR 
	  cogs is null
	  OR
	  total_sale is null;

--Data Exploration

--How many sales we have?

SELECT COUNT(*) as total_sale from retail_sales 

--How many unique customers we have?

SELECT COUNT(Distinct customer_id) as total_customer_id from retail_sales

SELECT DISTINCT category FROM retail_sales

--Data analysis and Business Key problems & answers

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales
where sale_date = '2022-11-05'

--Q.2 Write a SQL query to retrieve all transactions where the category is "Clothing" and the quantity sold 
--is more than 4 in the month of Nov-2022

SELECT * from retail_sales
where category = 'Clothing' and quantiy >= 4 and TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'

--Q.3 write a SQL query to calculate the total sales (total_sale) for each category

SELECT category ,SUM(total_sale) as total_sale 
from retail_sales 
group by category

 --Q.4 Write a SQL query to find average age of customer who purchased items from the 'Beauty' category 

SELECT AVG(age) as Avg_age from retail_sales 
where category = 'Beauty'
 
-- OR(fro round figure age)

SELECT Round(AVG(age),2) as Avg_age from retail_sales 
where category = 'Beauty'

--Q.5 Write a SQL Query to find all transactions where the total sale is grater than 1000.

SELECT * from retail_sales
where total_sale>1000

--Q.6 Write a SQL Query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT gender,category , COUNT(*) as total_transactions
from retail_sales
group by gender,category
order by 2

--Q.7 Write a SQL query to calculate the average sale for month. find out the best selling month in each year 

SELECT 
     EXTRACT(YEAR FROM sale_date) as year ,
     EXTRACT(MONTH FROM sale_date) as month,
     AVG(total_sale) avg_total_sale 
from retail_sales
group by year, month
order by year ,month DESC

--OR
SELECT year, month avg_sale 
from
(	 
SELECT 
     EXTRACT(YEAR FROM sale_date) as year ,
     EXTRACT(MONTH FROM sale_date) as month,
     AVG(total_sale) avg_total_sale, 
	 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
from retail_sales
group by year, month
)as t1
WHERE rank = 1
--order by year ,month DESC

--Q.8 Write a SQL Query to find the top 5 customers based on the highest total_sale
SELECT 
    customer_id , 
	sum(total_sale) as total_sales 
FROM retail_sales
group by customer_id
order by total_sales DESC
LIMIT 5

--Q.9 Write SQL Query to find the number of unique customers who purchased items from each category.

SELECT category,count(DISTINCT customer_id) as cnt_unique_cs
from retail_sales
group by category 

--Q.10 Write SQL Query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12& 17 ,Evening>17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
	    WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
FROM retail_sales
)
SELECT
     shift,
     count(*) as total_orders
FROM hourly_sale
group by shift

--End of Project 



		