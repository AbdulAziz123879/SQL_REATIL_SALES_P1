create database sql_project_p1

use sql_project_p1
-- Sql retail sales Analysis

--create table 
create table retail_sales (
   transactions_id int PRIMARY KEY ,
   sale_date DATE,
   sale_time TIME,
   customer_id int ,
   gender VARCHAR(10),
   age INT,
   category VARCHAR(15),
   quantiy int,
   price_per_unit FLOAT,
   cogs	FLOAT,
   total_sale FLOAT
);

SELECT COUNT(DISTINCT(customer_id)) as total_customer FROM retail_sales


SELECT *
      from retail_sales
   where category='clothing'
   and 
     sale_date between '2022-01-01' and '2022-12-31'
   and quantiy>=4


select category,
        sum(total_sale) as net_sale,
        count(*) as total_orders
        from retail_sales
        GROUP BY 1


select  
      round(avg(age),2) as ave_age from retail_sales
      where category='beauty'


select * from retail_sales
where total_sale>1000


select 
      category,gender,
      count(*) total_transation 
      from retail_sales
      GROUP BY category,gender
      ORDER BY 1

select year,month,avg_sale from
(
select 
   year(sale_date) as year,
   month(sale_date) as month,
   round(avg(total_sale),3) as avg_sale,
   rank() over(PARTITION BY year(sale_date)  
   ORDER BY round(avg(total_sale),3) DESC) as Rnk
from retail_sales
GROUP BY 1,2) as t1
where Rnk=1



select 
      customer_id,
      sum(total_sale) as total_sales
from retail_sales
GROUP BY 1
ORDER BY 2 DESC
limit 5


select
      category,
      count(DISTINCT(customer_id)) as unique_customer
   
from retail_sales
GROUP BY 1






WITH hourley_sales
as(
SELECT *,
      CASE 
         when hour(sale_time)<12  THEN 'Morning'
         when  hour(sale_time) BETWEEN 12 and 17 then 'Afternoon'
         else 'Night'
         end as shift
from retail_sales

)
select shift,
      count(*) as total_orders
 from hourley_sales
 group by 1