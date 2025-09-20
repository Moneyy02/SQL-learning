-- SQL functions 
-- why functions? what ?
-- to manipulate the data , to analyze the data, to clean the data,to transform the data

--     input value -> functions -> output values
-- function: a built in sql code that accepts an input value process it and returns an output value

-- types of function 
-- (1). Single row functions : for ex lower()
--(2). multi-row functions: for ex sum()

-- nested function : function used inside another function
-- for ex : len(lower(left('maria',2)))

-- SQL functions
--(1) single row function    : row level calculations
--(2)multi row functions     : aggregations

--(1) Single row functions : (manipulate & clean the data)
--   -> string fuctions
--   -> numeric functions
--   -> date & time functions
--   -> null functions

--(2) multi row functions :  ( prepare)
--   -> aggregate fuctions (basics)
--   -> window functions (advanced)


-- STRING FUNCTIONS
-- for manipulations : concat, upper, lower,trim, replace
-- for calculation : len
-- for string extraction : left,right, substring

--CONCAT
-- task : concatenate first name and country into one column

select
first_name,
country,
concat(first_name ,' ' ,country) as name_country
from customers

-- upper & lower


select
first_name,
country,
concat(first_name ,' ' ,country) as name_country,
lower(first_name) as low_name,
upper(first_name) as upper_name
from customers
 
 -- Trim | removes leading and trailing spaces
 -- task: find customers whose first name contains leading or trailing spaces

 select 
 first_name
  from customers
 where first_name != TRIM(first_name)
  
 -- length 
 select
 first_name,
 len(first_name) len_name,
 len(trim(first_name)) len_trim_name,
 len(first_name) - len(trim(first_name)) flag
 from customers
  where first_name != TRIM(first_name)

  -- replace 
  -- remove dashes (-) from a phone number

  select
  '123-456-7890' as phone,
  replace('123-456-7890', '-', '/') as clean_phone

  -- replace file extence from txt to csv
  select
  'report.txt' as old_filename,
  replace('report.txt', '.txt' , '.csv') as new_filename


  -- LENGTH
  -- calculate the length of each customer's first name
  select
  first_name,
  len(first_name) as length_name
  from customers

  --STRING EXTRACTION
  -- left & right
  
  -- left : extracts specific number of characters from the start
  -- right : extracts specific number of characters from the end 

  -- left(value, no of characters)
  -- right(value , no of characters)

  -- retrieve the first two characters of each first name
  select
  first_name,
  left(trim(first_name),2) as character_name
  from customers
  
  -- retrieve the last two characters of each first name
  select
  first_name,
  right(trim(first_name),2) as character_name
  from customers

  --SUBSTRING  : extract specific part at a specific position

-- task : retrieve a list of customers first names removing the first character
select 
first_name,
SUBSTRING(trim(first_name),2, len(first_name)) as sub_name
from customers



-- > NUMBER FUNCTIONS
-- round 
select 
3.516,
round(3.516,2) as round_2,
round(3.516,2) as round_1,
round(3.516,0) as round_0

-- absolute : convert a negative number to a positive number
select
-10,
abs(-10)


---> DATE & TIME FUNCTIONS

select
orderID,
orderDate,
shipDate,
CreationTime
from Sales.orders

-- getdate() : returns the current date and time at the moment when the query is executed.

select
orderID,
CreationTime,
'2025-08-20' hardcoded,
getdate() today
from Sales.orders

--> DATE & TIME FUNCTIONS
--> (1) part extraction : day, month, year, datepart, date name , date trunc , eomonth
--> (2) format & casting : format, convert , cast
--> (3) calculations : date add , date diff
--> (4) validation : isdate


-- PART EXTRACTION : day | month | year

select 
orderID,
creationtime,
year(creationtime) year,
month(creationtime) month,
day(creationtime) day
from sales.orders

-- datepart() return integer
--returns a specific part of a date as a number
-- syntax : datepart(part,date)
select 
orderID,
creationtime,
DATEPART(year, creationtime) year_dp,
DATEPART(QUARTER, creationtime) quarter_dp,
DATEPART(WEEK, creationtime) week_dp,
year(creationtime) year,
month(creationtime) month,
day(creationtime) day
from sales.orders

--datename() return string
-- returns the name of a specific part of a date
-- syntax : datename(part,date)

select 
orderID,
creationtime,
DATENAME(month, CreationTime) as month_dn,
DATENAME(WEEKDAY, CreationTime) as weekday_dn,
DATENAME(day, CreationTime) as day_dn,
DATENAME(year, CreationTime) as year_dn
from sales.orders


--- dateTrunc()
-- truncates the date to the specific part
-- syntax : datetrunc(part,date)
select 
orderID,
creationtime,
DATETRUNC(minute, creationtime) minute_dt,
DATETRUNC(day, creationtime) day_dt,
DATETRUNC(year, creationtime) year_dt
from sales.orders


-- example 
select 
DATETRUNC(month,creationtime) creation,
count(*) as orders
from sales.Orders
group by DATETRUNC(month,creationtime)


--EOMONTH()
-- return the last day of a month
-- syntax(date)
select 
orderid,
creationtime,
EOMONTH(creationtime) endofmonth,
cast(datetrunc(month, creationtime)as date) startofmonth
from sales.Orders


-- part extraction use cases 
-- data aggregations

-- how many orders were placed each year?
select 
year(orderdate),
count(*) NoOfOrders
from sales.orders
group by year(OrderDate)

-- how many orders were placed each month?
select 
datename(month,orderdate) as month_order,
count(*) NoOfOrders
from sales.orders
group by datename(month,orderdate)

--show all orders that were placed during the month of february
select
*
from sales.orders
where month(OrderDate) = 2