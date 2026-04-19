-- ================================================
-- Sales Data Analysis - SQL Queries
-- Author: Riyal Sai Kondakamarla
-- ================================================

-- 1. Total Sales and Profit by Region
SELECT 
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Avg_Sales
FROM superstore
GROUP BY Region
ORDER BY Total_Sales DESC;

-- 2. Top 5 Most Profitable Products
SELECT 
    Product_Name,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Product_Name
ORDER BY Total_Profit DESC
LIMIT 5;

-- 3. Sales by Category
SELECT 
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(Order_ID) AS Total_Orders
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

-- 4. Monthly Sales Trend
SELECT 
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    ROUND(SUM(Sales), 2) AS Monthly_Sales
FROM superstore
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

-- 5. Customers with Most Orders
SELECT 
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore
GROUP BY Customer_Name
ORDER BY Total_Orders DESC
LIMIT 10;

-- 6. Rank Regions by Sales using Window Function
SELECT 
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM superstore
GROUP BY Region;

-- 7. Find Orders with Above Average Sales
SELECT 
    Order_ID,
    Customer_Name,
    Sales
FROM superstore
WHERE Sales > (SELECT AVG(Sales) FROM superstore)
ORDER BY Sales DESC;

-- 8. Profit Margin by Sub-Category
SELECT 
    Sub_Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit)/SUM(Sales))*100, 2) AS Profit_Margin_Pct
FROM superstore
GROUP BY Sub_Category
ORDER BY Profit_Margin_Pct DESC;
