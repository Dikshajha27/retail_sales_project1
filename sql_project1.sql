-- SQL Retail Sales Analysis - P1
create database sql_project1;

-- create table 
DROP TABLE IF EXISTS retail_sales;
create Table retail_sales
           (
			transactions_id	INT PRIMARY KEY,
            sale_date DATE,	
            sale_time TIME,
            customer_id	INT,
            gender  VARCHAR(15),
            age	INT,
            category VARCHAR(15),	
            quantiy	INT,
            price_per_unit	FLOAT,
            cogs	FLOAT,
            total_sale FLOAT
            );
            
select * from retail_sales;

select count(*) from retail_sales;

-- checking null if any
-- DATA CLEANING
select * from retail_sales
where transactions_id is null; 

select * from retail_sales
where sale_date is null;

select * from retail_sales
where sale_time is null;

select * from retail_sales
  where 
    transactions_id is null
    or
    sale_date is null
    or
     sale_time is null
     or
      customer_id is null
      or
       gender is null
       or
        age is null
        or
         category is null
         or
          quantiy is null
          or
           price_per_unit is null
           or
            cogs is null
            or
             total_sale is null;
             
-- delete if any null values
Delete from retail_sales
  where 
    transactions_id is null
    or
    sale_date is null
    or
     sale_time is null
     or
      customer_id is null
      or
       gender is null
       or
        age is null
        or
         category is null
         or
          quantiy is null
          or
           price_per_unit is null
           or
            cogs is null
            or
             total_sale is null;
 
 -- DATA EXPLORATION
 -- q1. how many sales we have?
 select * from retail_sales;
 select count(total_sale) from retail_sales;

-- how many unique customer we have
select count(distinct(customer_id)) from retail_sales;

-- how many unique category we have
select distinct(category) from retail_sales;

-- Data Analysis and Business problem
-- My Analysis and Findings 
-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select * from retail_sales where sale_date = '2022-11-05';

-- Q2. Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity 
-- sold is more than 10 in the month of Nov-2022
SELECT * 
FROM retail_sales 
WHERE category = 'clothing' 
AND sale_date BETWEEN DATE '2022-11-01' AND DATE '2022-11-30' 
AND quantiy >= 4;

-- Q3.write a sql query to calculate the total sales (total_sales) for each category
select category,
sum(total_sale) as total_sales ,
count(*) as total_orders
from retail_sales
group by category;

-- Q4. write a sql query to find the average age of customers who purchased items from the 'Beauty' category
select 
round(avg(age),2) as average_age
from 
retail_sales
where category = 'Beauty'; 

-- Q5. Write a sql query to find all transaction where the total-sale is greater than 1000.
select  *
from retail_sales
where total_sale > 1000; 

-- Q6. write a sql query to find the total number of transaction(transaction_id ) made by each gender in each category
select 
category,
gender,
count(*) as total_transaction
from retail_sales
group by 
category,gender
order by category desc;

-- Q7. Write a sql query to calculate the average sales for each month. find out best selling month in each year
SELECT * FROM (
    SELECT 
        ROUND(AVG(total_sale), 2) AS avg_sale,
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS ranking
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE ranking = 1;

    
-- Q8. write a sql query to find the top 5 customers based on the highest total sales
select customer_id,
sum(total_sale) as total_sale
from retail_sales
group by customer_id
order by total_sale desc
limit 5;

 -- Q9. write a sql query to find the number of unique customers who purchased items from each category
 select category,
count(distinct(customer_id))as unique_customer
 from retail_sales
 group by category;

-- Q10. write a sql query to create each shift and number of orders (example morning <= 12, afternoon between 12 and 17 ,evening > 17)
select * ,
   case 
    when hour(sale_time) <12 then 'morning'
    when hour(sale_time) between 12 and 17 then 'afternoon'
    else 'evening'
end as shift
from retail_sales;

-- from cte
with hourly_sale
AS
(
select * ,
   case 
    when hour(sale_time) <12 then 'morning'
    when hour(sale_time) between 12 and 17 then 'afternoon'
    else 'evening'
end as shift
from retail_sales
)
select
shift,
count(*) as total_orders
from hourly_sale
group by shift;

 





