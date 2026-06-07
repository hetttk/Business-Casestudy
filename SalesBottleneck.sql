-- Query 1: Monthly Sales Trend

SELECT
MONTH(STR_TO_DATE(Date,'%Y-%m-%d')) AS Month,
SUM(TotalAmount) AS TotalSales
FROM RegionalSales2025
GROUP BY MONTH(STR_TO_DATE(Date,'%Y-%m-%d'))
ORDER BY Month;

-- Query 2: Cancellation and Return Percentage by Region

SELECT Region,

ROUND(
100 * SUM(CASE WHEN OrderStatus='Cancelled' THEN 1 ELSE 0 END)
/ COUNT(*),2
) AS CancellationPercentage,

ROUND(
100 * SUM(CASE WHEN OrderStatus='Returned' THEN 1 ELSE 0 END)
/ COUNT(*),2
) AS ReturnPercentage

FROM RegionalSales2025
GROUP BY Region;

-- Query 3: Regions with Highest Revenue Loss

SELECT Region,
SUM(TotalAmount) AS RevenueLoss
FROM RegionalSales2025
WHERE OrderStatus IN ('Cancelled','Returned')
GROUP BY Region
ORDER BY RevenueLoss DESC;

-- Query 4: Average Order Value by Category

SELECT Category,
AVG(TotalAmount) AS AverageOrderValue
FROM RegionalSales2025
GROUP BY Category;

-- Query 5: Top 5 Sales Agents

SELECT SalesAgent,
SUM(TotalAmount) AS TotalRevenue
FROM RegionalSales2025
WHERE OrderStatus='Completed'
GROUP BY SalesAgent
ORDER BY TotalRevenue DESC
LIMIT 5;

-- Query 6: Category Contribution to Total Sales

SELECT Category,
SUM(TotalAmount) AS TotalSales,

ROUND(
100 * SUM(TotalAmount) /
(SELECT SUM(TotalAmount)
FROM RegionalSales2025),2
) AS ContributionPercent

FROM RegionalSales2025
GROUP BY Category;

-- Query 7: Customers with More Than 3 Returns

SELECT CustomerID,
COUNT() AS ReturnCount
FROM RegionalSales2025
WHERE OrderStatus='Returned'
GROUP BY CustomerID
HAVING COUNT() > 3;

