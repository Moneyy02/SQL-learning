-- set operator 
-- in joins we use key ccolumn but in set we need to have same coloumn

-- types of set operator
--1) union
--2) union all
--3) except 
--4) intersect

/* 
syntax :

   select 
   firstName
   lastName
   from customers

   union ---> set operator
   
   select 
   from employees
*/

-- RULES IN SET OPERATOR

/* rule 1 : SQL clauses
  * set operator can be used almost in all clauses 
     where | join | group by | having
  * order by is allowed only once at the end of query

  rule 2 : Number of columns
  * the number of columns in each query must be the same*/

select 
firstname,
lastname
from sales.Customers

union

select 
firstname,
lastname
from sales.Employees

/* rule 3 : data type
    data types of coloumns in each query must be compatible

	select 
customerID, -- breaking rule 3
lastname
from sales.Customers

union

select 
firstname,
lastname
from sales.Employees
*/

select
CustomerID,
LastName
from Sales.Customers

union

select
EmployeeID,
LastName
from sales.Employees

/*
  # rule 4 : order of columns
  the order of the columns in each query must be same

 select
 LastName  -- here breaking rules by mismatching the columns order
CustomerID,
from Sales.Customers

union

select
EmployeeID,
LastName
from sales.Employees


   # rule 5 : column aliases
   the column names in the result set are determined by the column names specified in the first query
   first query responsible for naming the columns in the output
*/

 
select
CustomerID as id,  -- first query controls column names
LastName
from Sales.Customers

union

select
EmployeeID,
LastName
from sales.Employees

/*  # rule 6 : correct columns
    - even if all rules are met are sql shows no errors, the result may be incorrect
	- incorrect column selection leads to inaccurate results.
	*/
	
select
FirstName,
LastName
from Sales.Customers

union

select
LastName, -- swapping firstname and lastname still gives rules but incorrect results
FirstName
from sales.Employees

/*
RULES :
#1 : order by can be used only once
#2 : same number of columns
#3 : matching data types
#4 : same order of columns
#5 : first query controls aliases
#6 : mapping correct columns
*/

-- union : return all distinct rows from both queries
-- removes duplicate rows from the result

 
-- task : combine the data from employees and customers into one table

select 
CustomerID,
FirstName,
LastName
from Sales.Customers

union

select 
EmployeeID,
FirstName,
LastName
from sales.Employees


-- UNION ALL
-- returns all rows from both queries, including duplicates.

-- UNION ALL VS UNION | UNION ALL IS GENERALLY FASTER THAN UNION
-- WHY? if you are confident there are no duplicates, use union all
-- use union all to find duplicates and quality issues
select 
CustomerID,
FirstName,
LastName
from Sales.Customers

union all

select 
EmployeeID,
FirstName,
LastName
from sales.Employees


-- EXCEPT : returns all distinct rows from the first query that are not found in the second query
 -- it is the only one where the order of queries affects the final result



 select 
CustomerID,
FirstName,
LastName
from Sales.Customers

except

select 
EmployeeID,
FirstName,
LastName
from sales.Employees

-- INTERSECT : returns only the rows that are common in both queries

 select 
CustomerID,
FirstName,
LastName
from Sales.Customers

intersect

select 
EmployeeID,
FirstName,
LastName
from sales.Employees


-- UNION USE CASES
/*  Combine information : combine similar information before analyzing the data
*/
-- task : orders are stored in seperate table(orders and orders archieve) now combine all orders into one report without duplicates

-- if we use * may be if we add new information or something the order of table might get changed
select -- ading source to identifies the data
'orders' as sourceTable,
[OrderID]
,[ProductID]
,[CustomerID]
,[SalesPersonID]
,[OrderDate]
,[ShipDate]
,[OrderStatus]
,[ShipAddress]
,[BillAddress]
,[Quantity]
,[Sales]
,[CreationTime]
from sales.Orders

union

select 
'ordersArchive' as sourceTable,
[OrderID]
,[ProductID]
,[CustomerID]
,[SalesPersonID]
,[OrderDate]
,[ShipDate]
,[OrderStatus]
,[ShipAddress]
,[BillAddress]
,[Quantity]
,[Sales]
,[CreationTime]
from sales.OrdersArchive
order by OrderID

-- except use cases (delta detection)
-- identifying the differences or changes(delta) between two batches of data
-- data completeness check : 