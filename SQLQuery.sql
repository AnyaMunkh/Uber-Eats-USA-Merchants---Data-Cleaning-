 -- Fetching only the state name from the full_address column and adding that colum to the table.
    -- So that i can make the map visualization for each state.   
SELECT 
    full_address,
    SUBSTRING(full_address, CHARINDEX(',', full_address, CHARINDEX(',', full_address) + 1) + 1, 
    CHARINDEX(',', full_address, CHARINDEX(',', full_address, CHARINDEX(',', full_address) + 1) + 1) - CHARINDEX(',', full_address, 
    CHARINDEX(',', full_address) + 1) - 1) AS state_Name 
FROM [Restaurants].[dbo].[US_Merchant - sheet1]

Alter Table [Restaurants].[dbo].[US_Merchant - sheet1]
ADD state_name nvarchar(50)
UPDATE [Restaurants].[dbo].[US_Merchant - sheet1]
SET state_name = TRIM(SUBSTRING(full_address, CHARINDEX(',', full_address, CHARINDEX(',', full_address) + 1) + 1, 
CHARINDEX(',', full_address, CHARINDEX(',', full_address, CHARINDEX(',', full_address) + 1) + 1) - CHARINDEX(',', full_address, 
CHARINDEX(',', full_address) + 1) - 1))

   --Fetching only the first or word or phrase from the category column, so it can be narrowed down for better analysis.
   SELECT category, 
    CASE WHEN CHARINDEX(',', category) > 0 THEN SUBSTRING(category, 1, CHARINDEX(',', category) - 1) 
    ELSE category 
    END as new_category
FROM [Restaurants].[dbo].[US_Merchant - sheet1]

Alter Table [Restaurants].[dbo].[US_Merchant - sheet1]
ADD new_category nvarchar(50)
UPDATE [Restaurants].[dbo].[US_Merchant - sheet1]
SET new_category = CASE WHEN CHARINDEX(',', category) > 0 THEN SUBSTRING(category, 1, CHARINDEX(',', category) - 1) 
ELSE category 
END

-- -- Fetching the city name from the full_address column. So that i can make an visualization only for a specific city. 
SELECT full_address, SUBSTRING(full_address, CHARINDEX(',', full_address) + 2, CHARINDEX(',', full_address, 
CHARINDEX(',', full_address) + 1) - CHARINDEX(',', full_address) - 2) AS city_name
FROM [Restaurants].[dbo].[US_Merchant - sheet1]

Alter Table [Restaurants].[dbo].[US_Merchant - sheet1]
ADD city_name nvarchar(50)
UPDATE [Restaurants].[dbo].[US_Merchant - sheet1]
SET city_name = SUBSTRING(full_address, CHARINDEX(',', full_address) + 2, CHARINDEX(',', full_address, 
CHARINDEX(',', full_address) + 1) - CHARINDEX(',', full_address) - 2)



-- Getting a table for a top 10 francises visualization. 
  Select top(10) restaurant_name, Count(restaurant_name) as Total_Stores, Round(AVG(rate_avg),2) as average_rate
   FROM [Restaurants].[dbo].[US_Merchant - sheet1]
   GROUP BY restaurant_name
   Order BY Total_Stores DESC

