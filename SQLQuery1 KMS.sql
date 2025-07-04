Create Database KMS

Select * from [dbo].[KMS Sql Case Study (1)]

-----1. Which product category had the highest sales-------
SELECT TOP 1
    [Product_Category],
    SUM([Sales]) AS Total_Sales
FROM
   [dbo].[KMS Sql Case Study (1)]
GROUP BY
    [Product_Category]
ORDER BY
    Total_Sales DESC;

----------2. What are the Top 3 and Bottom 3 regions in terms of sales-----

---SQL Query for Top 3 Regions by Sales

SELECT TOP 3
    [Region],
    SUM([Sales]) AS Total_Sales
FROM
    [dbo].[KMS Sql Case Study (1)]
GROUP BY
    [Region]
ORDER BY
    Total_Sales DESC;

------SQL Query for Bottom 3 Regions by Sales

SELECT TOP 3
    [Region],
    SUM([Sales]) AS Total_Sales
FROM
    [dbo].[KMS Sql Case Study (1)]
GROUP BY
    [Region]
ORDER BY
    Total_Sales ASC;

------3. What were the total sales of appliances in Ontario----
SELECT 
    SUM([Sales]) AS Total_Appliance_Sales_Ontario
FROM 
    [dbo].[KMS Sql Case Study (1)]
WHERE 
    [Product_Sub_Category] = 'Appliances'
    AND [Province] = 'Ontario';

-------- 4. Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers--
SELECT TOP 10
    [Customer_Name],
    SUM([Sales]) AS Total_Sales,
    SUM([Profit]) AS Total_Profit,
    COUNT([Order_ID]) AS Total_Orders,
    AVG([Discount]) AS Avg_Discount,
    AVG([Shipping_Cost]) AS Avg_Shipping_Cost
FROM 
    [dbo].[KMS Sql Case Study (1)]
GROUP BY 
    [Customer_Name]
ORDER BY 
    Total_Sales ASC;

----Advice -- "Based on the analysis of the bottom 10 customers by sales, 
-----------------we observed that they place few orders and receive relatively high discounts. 
-----------------KMS should test lower discounts and focus on offering value-based promotions instead. 
------------------Additionally, optimizing shipping methods and offering incentives for bulk purchases could encourage more sales."----

------5. KMS incurred the most shipping cost using which shipping method---
SELECT TOP 1
    [Ship_Mode],
    SUM([Shipping_Cost]) AS Total_Shipping_Cost
FROM 
    [dbo].[KMS Sql Case Study (1)]
GROUP BY 
    [Ship_Mode]
ORDER BY 
    Total_Shipping_Cost DESC;

--------6. Who are the most valuable customers, and what products or services do they typically purchase--

---- a. Find the Most Valuable Customers by Total Sales

SELECT TOP 10
    [Customer_Name],
    SUM([Sales]) AS Total_Sales,
    SUM([Profit]) AS Total_Profit,
    COUNT([Order_ID]) AS Total_Orders
FROM 
   [dbo].[KMS Sql Case Study (1)]
GROUP BY 
    [Customer_Name]
ORDER BY 
    Total_Sales DESC;

---- b. Find Products Purchased by Those Top Customers
SELECT 
    K.[Customer_Name],
    K.[Product_Category],
    K.[Product_Sub_Category],
    SUM(K.[Sales]) AS Category_Sales
FROM 
    [dbo].[KMS Sql Case Study (1)] K
WHERE 
    K.[Customer_Name] IN (
        SELECT TOP 10 [Customer_Name]
        FROM [dbo].[KMS Sql Case Study (1)]
        GROUP BY [Customer_Name]
        ORDER BY SUM([Sales]) DESC
    )
GROUP BY 
    K.[Customer_Name],
    K.[Product_Category],
    K.[Product_Sub_Category]
ORDER BY 
    K.[Customer_Name], Category_Sales DESC;

-----Advice- “The top 10 customers primarily purchase Technology and Office Furniture products. 
--------------Focusing loyalty programs, early product releases, or 
----------------bundled discounts around these categories could strengthen customer retention and revenue.”----

------7. Which small business customer had the highest sales-----

SELECT TOP 1
    [Customer_Name],
    SUM([Sales]) AS Total_Sales
FROM 
    [dbo].[KMS Sql Case Study (1)]
WHERE 
    [Customer_Segment] = 'Small Business'
GROUP BY 
    [Customer_Name]
ORDER BY 
    Total_Sales DESC;


------8 . Which Corporate Customer placed the most number of orders in 2009 – 2012---

SELECT TOP 1
    [Customer_Name],
    COUNT(DISTINCT [Order_ID]) AS Total_Orders
FROM 
    [dbo].[KMS Sql Case Study (1)]
WHERE 
    [Customer_Segment] = 'Corporate'
    AND [Order_Date] BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY 
    [Customer_Name]
ORDER BY 
    Total_Orders DESC;

------9. Which consumer customer was the most profitable one---

SELECT TOP 1
    [Customer_Name],
    SUM([Profit]) AS Total_Profit
FROM 
    [dbo].[KMS Sql Case Study (1)]
WHERE 
    [Customer_Segment] = 'Consumer'
GROUP BY 
    [Customer_Name]
ORDER BY 
    Total_Profit DESC;

------10. Which customer returned items, and what segment do they belong to---

---non

----11. If the delivery truck is the most economical but the slowest shipping method and 
--------Express Air is the fastest but the most expensive one, do you think the company
----------appropriately spent shipping costs based on the Order Priority? Explain your answer

SELECT
    [Order_Priority],
    [Ship_Mode],
    COUNT(*) AS Num_Orders,
    SUM([Shipping_Cost]) AS Total_Shipping_Cost,
    AVG([Shipping_Cost]) AS Avg_Shipping_Cost
FROM 
    [dbo].[KMS Sql Case Study (1)]
GROUP BY 
    [Order_Priority], [Ship_Mode]
ORDER BY 
    [Order_Priority], Total_Shipping_Cost DESC;


-------Advice ---After analyzing the shipping methods used across different order priorities, 
----------------we noticed a mismatch: several low or medium-priority orders used Express Air (the most expensive option), 
-------------while some high or critical priority orders used Delivery Truck (the slowest method). 
-----------This indicates a lack of alignment between shipping method and order urgency, 
------------leading to unnecessary shipping costs and potential customer dissatisfaction. 
---------We recommend enforcing business rules that align shipping methods with order priority levels.

