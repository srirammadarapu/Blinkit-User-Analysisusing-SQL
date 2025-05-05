SELECT * FROM [BlinkIT Grocery Data];

UPDATE [BlinkIT Grocery Data]
SET Item_Fat_Content = 
    CASE 
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;
	SELECT DISTINCT(Item_Fat_Content) FROM [BlinkIT Grocery Data];

	SELECT CAST(SUM(Total_Sales)/100000.0 AS DECIMAL(10,2)) AS Toatal_Sales_Million
	FROM [BlinkIT Grocery Data];

SELECT CAST(AVG(Total_Sales) AS INT) AS Avg_Sales
FROM [BlinkIT Grocery Data];

SELECT COUNT(*) AS no_of_orders
FROM [BlinkIT Grocery Data];

SELECT CAST(AVG(Rating) AS INT) AS Avg_Rating
FROM [BlinkIT Grocery Data];

SELECT Item_Fat_Content , CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM [BlinkIT Grocery Data]
GROUP BY Item_Fat_Content;

SELECT Item_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM [BlinkIT Grocery Data]
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular
FROM 
(
    SELECT Outlet_Location_Type, [Low Fat], [Regular]
    FROM 
    (
        SELECT Outlet_Location_Type, Item_Fat_Content, 
               CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
        FROM [BlinkIT Grocery Data]
        GROUP BY Outlet_Location_Type, Item_Fat_Content
    ) AS SourceTable
    PIVOT 
    (
        SUM(Total_Sales) 
        FOR Item_Fat_Content IN ([Low Fat], [Regular])
    ) AS PivotTable
) AS FinalTable
ORDER BY Outlet_Location_Type;

SELECT Outlet_Establishment_Year, CAST(SUM(Total_sales) AS DECIMAL(10,2)) AS Total_Sales
FROM [BlinkIT Grocery Data]
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;

SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM [BlinkIT Grocery Data]
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

SELECT Outlet_Location_Type , CAST(SUM(Total_sales) AS DECIMAL(10,2)) AS Total_Sales
FROM [BlinkIT Grocery Data]
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

SELECT Outlet_Type, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM [BlinkIT Grocery Data]
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC
