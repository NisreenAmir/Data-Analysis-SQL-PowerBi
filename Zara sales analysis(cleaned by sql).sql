--Exploring all data structure and type--
select * from [dbo].[Zara_Sales_Analysis (2)]
--Search for dublicated data--
select product_id ,count(*) from [dbo].[Zara_Sales_Analysis (2)]
group by product_id having count(*) >1
--Removing dublicated--
delete from [dbo].[Zara_Sales_Analysis (2)] where Product_ID not in (select min(product_id) from
[dbo].[Zara_Sales_Analysis (2)] group by Product_ID)
--Sarching null values--
select * from [dbo].[Zara_Sales_Analysis (2)] where Product_ID is null or Product_Position is null or Promotion 
is null or Product_Category is null or Seasonal is null or Sales_Volume is null or brand is null or url is null 
or sku is null or name is null or description is null or price is null or currency is null or scraped_at is null
or terms is null or section is null;
--Replace null values with default values--
update [dbo].[Zara_Sales_Analysis (2)] set name='jackets', description = 'jackets' 
where name is null or description is null;
--Data Formating & Standarddization--
update  [dbo].[Zara_Sales_Analysis (2)] set Product_Position =lower(TRIM(Product_Position)), 
Product_Category=lower(TRIM(Product_Category)), brand=lower(TRIM(brand)),name=lower(TRIM(name)),
description=lower(TRIM(description)),currency=lower(TRIM(currency)),terms=lower(TRIM(terms)),
section=lower(TRIM(section));
--Data cleaning: search of nigative or illogical values--
select Product_ID,Sales_Volume,price from [dbo].[Zara_Sales_Analysis (2)]
where Product_ID<1 or Sales_Volume<1 or price<1;
--Descriptive statistics--
select STDEVP(price) as STD,MIN(price) as min, MAX(price) as max,AVG(price) as avg
from [dbo].[Zara_Sales_Analysis (2)];
select STDEVP(Sales_Volume) as STD,MIN(Sales_Volume) as min, MAX(Sales_Volume) as max,
AVG(Sales_Volume) as avg from [dbo].[Zara_Sales_Analysis (2)];
--exploring the reason of outlier--
select price,terms,count(price) from [dbo].[Zara_Sales_Analysis (2)] group by price,terms;
select terms,price,Sales_Volume,count(price) from [dbo].[Zara_Sales_Analysis (2)]
where price > 100 group by price,terms,Sales_Volume;
--expolring outliers--
with Q AS(select PERCENTILE_CONT(0.25)within group(order by price)over()as Q1,
PERCENTILE_CONT(0.5)within group(order by price)over()as Q2,
PERCENTILE_CONT(0.75)within group(order by price)over()as Q3
FROM [dbo].[Zara_Sales_Analysis (2)])
select DISTINCT(price) from  [dbo].[Zara_Sales_Analysis (2)] cross join Q
WHERE PRICE < Q.Q1-1.5*(Q.Q3-Q.Q1) OR
      PRICE > Q.Q3+1.5*(Q.Q3-Q.Q1);
select * from [dbo].[Zara_Sales_Analysis (2)] where price >= 299

with Q AS(select PERCENTILE_CONT(0.25)within group(order by Sales_volume)over()as Q1,
PERCENTILE_CONT(0.5)within group(order by Sales_volume)over()as Q2,
PERCENTILE_CONT(0.75)within group(order by Sales_volume)over()as Q3
FROM [dbo].[Zara_Sales_Analysis (2)])
select DISTINCT(Sales_volume) from  [dbo].[Zara_Sales_Analysis (2)] cross join Q
WHERE PRICE < Q.Q1-1.5*(Q.Q3-Q.Q1) OR
      PRICE > Q.Q3+1.5*(Q.Q3-Q.Q1);
--data extraction--
ALTER TABLE [dbo].[Zara_Sales_Analysis (2)] ADD Revenue DECIMAL(10,2);
UPDATE [dbo].[Zara_Sales_Analysis (2)] SET Revenue = (Sales_Volume * price);
ALTER TABLE [dbo].[Zara_Sales_Analysis (2)] ADD years smallint, months tinyint, days tinyint;
update [dbo].[Zara_Sales_Analysis (2)] set years= year(scraped_at), months=month(scraped_at),
days=day(scraped_at);
 ---the end of exploration,cleaning and extracting---

                             --BUSINESS QUESTIONS--
--Total Revenue/total sales_volume / total products--
select sum(Revenue) as total_revenue ,sum(sales_volume) as total_sales_volume,count(Product_ID)
from [dbo].[Zara_Sales_Analysis (2)]
--group section by revenue and %revenue--
select section,sum(revenue) as total_revenue,round(100*sum(revenue)/sum(sum(revenue))over(),2)
as pct_of_total
from [dbo].[Zara_Sales_Analysis (2)]
group by section order by total_revenue;
----group product_position by revenue and %revenue--
select Product_Position,sum(revenue) as total_revenue,round(100*sum(revenue)/sum(sum(revenue))
over(),2) as pct_of_total from [dbo].[Zara_Sales_Analysis (2)]
group by Product_Position order by total_revenue;
--group promotion by revenue and %revenue--
select Promotion,sum(revenue)as total_revenue,ROUND(100*sum(revenue)/sum(sum(revenue))over(),2)
as pct_of_total from [dbo].[Zara_Sales_Analysis (2)]
group by Promotion order by total_revenue;
--group seasonal by revenue and %revenue--
select Seasonal,sum(revenue)as total_revenue,ROUND(100*sum(revenue)/sum(sum(revenue))over(),2)
as pct_of_total from [dbo].[Zara_Sales_Analysis (2)]
group by Seasonal order by total_revenue;
--group terms by sales_volume--
select terms,sum(Sales_Volume)as total_sales,ROUND(100*sum(Sales_Volume)/sum(sum(Sales_Volume))
over(),2) as pct_of_total from [dbo].[Zara_Sales_Analysis (2)]
group by terms order by total_sales;
--group name by sales_volume:top 10 items of sales_volume--
select top 10 name,sum(Sales_Volume)as total_sales,ROUND(100*sum(Sales_Volume)/sum(sum(Sales_Volume))
over(),2) as pct_of_total from [dbo].[Zara_Sales_Analysis (2)]
group by name order by total_sales DESC;
--group name by revenue:top 10 items of revenue--
select top 10 name,sum(revenue)as total_revenue,
ROUND(100*sum(Revenue)/sum(sum(Revenue))over(),2) as pct_of_total_revenue 
from [dbo].[Zara_Sales_Analysis (2)]
group by name order by total_revenue DESC;

--the end of project--
