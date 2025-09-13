-- combining the data

/* 
for combining two tables A and B
combine column wise we use join
combine row wise we use set operators

join types
minimum requirement - key column
(basic joins) 

1) inner join
2) full join
3) left join
4) right join

set types
minimum requirement - same column
1) union
2) union all
3) except (minus)
4) intersect
*/

-- no join : returns data from tables without combining them
/* syntax
select * from A;
select * from B;
*/
select * from customers;
select * from orders;

--inner join : return only matching rows from both tables
/* syntax
the order of tables doesn't matters
select * 
from A 
inner join B (default type : inner)
on <condition> a.key = b.key
*/

-- get all customers along with their orders but only for customers who have placed an order
select * 
from customers as c
inner join orders as o
on o.customer_id = c.id

-- column ambiguity : agar dono table mai samw naam ke column hai toh tablename.column krke define kro
select 
o.customer_id,
first_name,
order_id,
sales
from customers as c
inner join orders as o
on o.customer_id = c.id

-- left join : returns all rows from left and only matching from right
/* syntax
the order of tables matters
select * 
from A (left table)
left join B (right table)
on <condition> a.key = b.key
*/

-- get all customers along with their orders, including those without order
select * from customers;
select * from orders;

select 
c.id,
c.first_name,
o.order_id,
o.sales
from customers as c
left join orders as o
on c.id = o.customer_id

-- right join : returns all rows from right and only matching from right
/* syntax
the order of tables matters
select * 
from A 
right join B 
on <condition> a.key = b.key
*/

-- get all customers along with their orders, including orders without matching customers
select 
c.id,
c.first_name,
o.order_id,
o.sales
from orders as o
right join customers as c
on o.customer_id= c.id
 
select 
c.id,
c.first_name,
o.order_id,
o.sales
from customers as c
right join orders as o
on c.id = o.customer_id

-- full join : returns all rows from both tables
/*
the order of tables doesn't matter
syntax :
select * 
from A
full join B
on A.key = B.key*/

-- get all customers and all orders, even if there's no match
select * 
from customers as c
full join orders as o
on c.id=o.customer_id

-- (advanced join)
/*
1) left anti join - returns rows from left that has no match in right
order is important 
syntax :
select *
from A
left join B
on A.key = B.key
where B.key is null
*/

-- get all customers who haven't place any order
select * from customers;
select * from orders;

select 
c.id,
c.first_name,
o.order_id
from customers as c
left join orders as o
on c.id = o.customer_id
where o.customer_id is null

/*
1) left anti join - returns rows from right  that has no match in right
order is important 
syntax :
select *
from A
right join B
on A.key = B.key
where A.key is null
*/

-- get all orders without matching customers

select * 
from customers as c
right join orders as o
on c.id= o.customer_id
where c.id is null
-- using anti left join

select * 
from orders as o
left join customers as c
on c.id= o.customer_id
where c.id is null

/*
3) full anti join : returns only rows that dont match in either tools
the order of table doesnt matter
select *
from A
full join B
on A.key=B.key
where A.key is null
or
B.key is null
*/

-- find customers without order and orders without customers 
select *
from orders as o
full join customers as c
on c.id = o.customer_id
where c.id is null OR o.customer_id is null

-- get all customers along with their orders, but only for customers who have place an order
-- without using inner join
select * 
from customers as c
left join orders as o
on c.id = o.customer_id
where o.customer_id is not null

/* 4) cross join : combines every row from left with every row from right
all possible combinations -cartersian join-
order does not matter
select *
from A
cross join B*/

-- generate all possible combinations of customers and orders. */
select *
from customers 
cross join orders


--- joining multiple tables 3+ tables joins 
 /* task : using salesDB, retrieve a list of all orders , along with thr related customer, product
 ,and employee details. for each order, display:
 order id, customer's name, product name, sales,price sales person's name */

 -- exploring the table first
 select * from sales.customers;
 select * from sales.employees;
 select * from sales.orders;
 select * from sales.ordersArchive;
 select * from sales.products;



 select 
  o.orderID,
  o.sales,
  c.firstname as CustomerFirstName,
  c.lastname as CustomerLastName,
  p.product as productname,
  p.price,
  e.firstname as EmployeefirstName,
  e.lastname as EmployeeLastName
  from sales.orders as o
  left join sales.customers as c
  on o.customerID = c.customerID
  left join sales.products as p
  on o.productID = p.productID
  left join sales.employees as e
  on o.salespersonID = e.employeeID


