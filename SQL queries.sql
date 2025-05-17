Select * From marketing_and_product_performance limit 10; -- print everything in the table

ALTER TABLE marketing_and_product_performance
RENAME COLUMN `Profit Margin` TO Profit_Margin;

--  Basic Insights 
 
 -- 1. Count total number of campaigns
 SELECT COUNT(*) AS total_campaigns FROM marketing_and_product_performance;


 -- 2. Sum of all budgets 
 SELECT SUM(budget) AS total_budget 
 FROM marketing_and_product_performance;
 
 
 -- 3. Calculate the total number of clicks and conversions across all campaigns.
SELECT SUM(clicks) AS total_clicks, 
       SUM(conversions) AS total_conversions
FROM marketing_and_product_performance;
 
 
 -- 4. Calculate the total revenue generated from all campaigns 
 SELECT SUM(revenue_generated) AS total_revenue 
 FROM marketing_and_product_performance;
 
 
 -- 5. Average ROI across all campaigns 
 SELECT AVG(ROI) AS average_roi 
 FROM marketing_and_product_performance;
 
 
 -- 6. Average Conversition_rate across all campaigns
 SELECT AVG(Converstion_rate) AS average_Converstion_rate 
 FROM marketing_and_product_performance;
 
 
 -- 7. Average Profit_Margin across all campaigns
  SELECT AVG(Profit_Margin) AS average_Profit_Margin 
 FROM marketing_and_product_performance;
 
 
--  Top Performers 

-- 8. Get the top 10 campaigns by revenue
SELECT Campaign_ID, SUM(Revenue_Generated) AS Total_Revenue
FROM marketing_and_product_performance
GROUP BY Campaign_ID
ORDER BY Total_Revenue DESC
LIMIT 10;


-- 9. Get campaigns with the highest ROI
SELECT campaign_id, ROI 
FROM marketing_and_product_performance 
ORDER BY roi DESC LIMIT 5;


-- 10. Get the top 10 best-selling products by units sold
SELECT Product_ID, SUM(Conversions) AS Total_Units_Sold
FROM marketing_and_product_performance
GROUP BY Product_ID
ORDER BY Total_Units_Sold DESC
LIMIT 10;


-- 11. Get the top 10 products by revenue
SELECT Product_ID, SUM(Revenue_Generated) AS Total_Revenue
FROM marketing_and_product_performance
GROUP BY Product_ID
ORDER BY Total_Revenue DESC
LIMIT 10;


-- 12. Get the top 10 customers by total spending
SELECT "Customer_ID", SUM("Revenue_Generated") AS total_spending
FROM marketing_and_product_performance
GROUP BY "Customer_ID"
ORDER BY total_spending DESC
LIMIT 10;


-- 13. Get the top 10 flash sales by revenue.
SELECT Flash_Sale_ID AS "Flash Sale ID", Revenue_Generated AS "Revenue"
FROM marketing_and_product_performance
ORDER BY Revenue_Generated DESC
LIMIT 10;


-- 14. Get the top 10 bundles by units sold.
SELECT Bundle_ID, Units_Sold
FROM marketing_and_product_performance
ORDER BY Units_Sold DESC
LIMIT 10;


-- 15. Get the top 10 bundles by revenue.
SELECT Bundle_ID, Revenue_Generated
FROM marketing_and_product_performance
ORDER BY Revenue_Generated DESC 
LIMIT 10;


-- Categorization Examples 

-- 16. Categorize subscription length into short, mid, and long term 
SELECT 
    CASE 
        WHEN Subscription_Length BETWEEN 1 AND 5 THEN 'Short-term'
        WHEN Subscription_Length BETWEEN 6 AND 15 THEN 'Mid-term' 
        ELSE 'Long-term'
    END AS subscription_category,
    COUNT(*) AS num_products,
    AVG(Profit_Margin) AS avg_Profi_Margin,
    AVG(Converstion_rate) AS avg_Converstion_rate,
    SUM(Revenue_generated) AS total_revenue
FROM marketing_and_product_performance
GROUP BY subscription_category;


-- 17.Categorize discount level into low, moderate, and high
SELECT 
    CASE 
        WHEN Discount_Level BETWEEN 10 AND 25 THEN 'Low Discount'
        WHEN Discount_Level BETWEEN 26 AND 47 THEN 'Moderate Discount'
        ELSE 'High Discount'
    END AS discount_category,
    COUNT(*) AS num_products,
    AVG(Profit_Margin) AS avg_Profi_Margin,
    AVG(Converstion_rate) AS avg_Converstion_rate,
    SUM(Revenue_generated) AS total_revenue
FROM marketing_and_product_performance
GROUP BY Discount_category;


              
-- 18. Categorize conversion rate into low, medium, and high 
SELECT 
    CASE 
        WHEN Converstion_rate < 20 THEN 'Low Conversion'
        WHEN Conversition_rate BETWEEN 20 AND 50 THEN 'Medium Conversion'
        ELSE 'High Conversion'
    END AS Converstion_category,
    COUNT(*) AS num_campaigns,
    AVG(Profit_Margin) AS avg_Profi_Margin,
    SUM(Budget) AS total_budget,
    SUM(Revenue_generated) AS total_revenue
FROM marketing_and_product_performance
GROUP BY Converstion_category;


-- 19. Categorize profit margin into loss, low profit, and high profit 
SELECT 
	CASE 
        WHEN Profit_Margin < 0  THEN 'Loss'
        WHEN Profit_Margin BETWEEN  0 AND 0.5 THEN 'Low Profit'
        ELSE 'High Profit' 
    END AS Profit_category,
    COUNT(*) AS num_campaigns,
    SUM(Budget) AS total_Budget,
    AVG(Converstion_rate) AS avg_Converstion_rate,
    SUM(Revenue_generated) AS total_revenue
FROM marketing_and_product_performance
GROUP BY Profit_category;


-- 20. Get the most common keywords.
SELECT Common_Keywords,
	COUNT(Bundle_ID) AS "Number of times keyword is mentioned"
FROM marketing_and_product_performance
GROUP BY Common_Keywords
ORDER BY Common_Keywords DESC;


-- 21. Get the keywords with the Avrage conversion rate.
SELECT Common_Keywords, 
       AVG(Converstion_rate) AS avg_Converstion_rate
FROM marketing_and_product_performance
GROUP BY Common_Keywords
LIMIT 10;


-- 22. Analyze the impact of discount level on units sold, how tho? this needs to be a line graph
SELECT Discount_Level,
	COUNT(Units_Sold) AS "Number of offers with discount level"
FROM marketing_and_product_performance
GROUP BY Discount_Level
ORDER BY COUNT(Units_Sold) DESC 
LIMIT 10;


-- 23. Calculate the average subscription length per customer
SELECT Customer_ID , AVG(Subscription_Length)  AS avg_subscription_length
FROM marketing_and_product_performance
GROUP BY Customer_ID
ORDER BY avg_subscription_length DESC;


-- 24. Long subscriptions with high profit margin 
SELECT Campaign_ID,
	   Subscription_Length,
	   Profit_Margin
FROM marketing_and_product_performance 
WHERE Subscription_Length > 24 AND profit_margin > 0.5;


-- 25. High discount and high ROI campaigns 
SELECT  Campaign_ID,
	    ROI,
       Discount_Level
FROM marketing_and_product_performance 
WHERE discount_level > 50 AND roi > 3;


-- 26. Campaigns with high clicks but low conversion 
SELECT Campaign_ID, 
       Clicks,
	   Converstion_rate
FROM marketing_and_product_performance 
WHERE Clicks > 1000 AND Conversition_rate < 20;


-- 27.Total profit per customer 
SELECT Campaign_ID,
	   AVG(Profit_Margin) AS avg_profit 
FROM marketing_and_product_performance 
GROUP BY Campaign_ID 
ORDER BY avg_profit  DESC;