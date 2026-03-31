select * from `workspace`.`default`.`bright_coffee_shop` limit 100;

--Check all Colunms
select*
FROM `WORKSPACE`.`DEFAULT`.`BRIGHT_COFFEE_SHOP`;

--Distinct Product Categories: which product categories do we have in the data
Select DISTINCT PRODUCT_CATEGORY,      
From `WORKSPACE`.`DEFAULT`.`BRIGHT_COFFEE_SHOP`;

--Check Product types available: which product types does the data have?
Select DISTINCT PRODUCT_TYPE, 
From `WORKSPACE`.`DEFAULT`.`BRIGHT_COFFEE_SHOP`;

---Store locations
Select DISTINCT STORE_LOCATION
From `WORKSPACE`.`DEFAULT`.`BRIGHT_COFFEE_SHOP`;

--- Shop operational dates: Shop has been operational for 6 months
Select Min(TRANSACTION_DATE) As Start_Date,
       Max (TRANSACTION_DATE) As End_Date
FROM `WORKSPACE`.`DEFAULT`.`BRIGHT_COFFEE_SHOP`;

--- Shop opeing time and closing time
Select Min(TRANSACTION_TIME) As Opening_Time,
       Max (TRANSACTION_TIME) As Closing_Time
FROM `WORKSPACE`.`DEFAULT`.`BRIGHT_COFFEE_SHOP`;

---Check Number of `transactions
Select Count(DISTINCT TRANSACTION_ID) As Number_of_Transactions
FROM `WORKSPACE`.`DEFAULT`.`BRIGHT_COFFEE_SHOP`;

--check if there are nulls in the data
Select *
FROM `WORKSPACE`.`DEFAULT`.`BRIGHT_COFFEE_SHOP`
Where (coloum) is null 
Or coloum is Null

-----------------------------------------------------------------------
---Consolidated Query
---Classify transaction date into months and days 

Select TRANSACTION_DATE,
       DAYNAME(TRANSACTION_DATE) AS DAY_NAME,
       CASE
            WHEN DAY_NAME IN ('Sat','Sun') THEN 'Weekend'
            ELSE 'Weekday'
       END AS Day_Classification,
       MONTHNAME(TRANSACTION_DATE)AS MONTH_NAME,
       MONTH(TRANSACTION_DATE)AS MONTH_NUMBER,
       DAYOFMONTH(TRANSACTION_DATE) AS DAY_OF_MONTH,
 ----Transaction time: Time buckets into Morning, Midday, and Afternoo, else Evening and also Extract Hour of day     
     TRANSACTION_TIME,
     CASE
         WHEN TRANSACTION_TIME BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
         WHEN TRANSACTION_TIME BETWEEN '12:00:00' AND '15:59:59' THEN 'Midday'
         WHEN TRANSACTION_TIME BETWEEN '16:00:00' AND '19:59:59' THEN 'Afternoon'
         ELSE 'Evening'
         END AS Time_Classification,
      HOUR(TRANSACTION_TIME)As Hour_of_Day,

----Categorical data
     STORE_LOCATION,
     PRODUCT_CATEGORY,
     PRODUCT_TYPE,
     PRODUCT_DETAIL,

--- Quantitative data
    TRANSACTION_ID,
    STORE_ID,
    TRANSACTION_QTY,
    UNIT_PRICE,
    TRANSACTION_QTY* UNIT_PRICE AS Revenue,
    CASE
        WHEN Revenue BETWEEN 0 AND 120 THEN 'LOW_SPEND'
        WHEN Revenue BETWEEN 121 AND 240 THEN 'MID_SPEND'
        WHEN Revenue >240 THEN 'HIGH_SPEND'
    END AS SPEND_CATEGORY
From `WORKSPACE`.`DEFAULT`.`BRIGHT_COFFEE_SHOP`;
