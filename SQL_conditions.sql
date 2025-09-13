/*find the average score for each country
considering only customers with a score not equal to 0
and return only those countries with an average score greater than 430
*/
select 
country,
avg(score) as avg_score
from customers
where score != 0
group by country
having avg(score)>430

-- return unique list of all countries
select distinct country from customers

--- retrieve only 3 customers
select top 3 *
from customers

--retrieve the top 3 customers with the hightest scores
select top 3 *
from customers
order by score desc

/*
                     FILTERING DATA
where operator 
1) comparision operator 
=,<>  =! , > ,< ,>=,<=

2) logical operator
AND - all conditions must be true
OR - atleast one conditions must be true
NOT - excluded matching rows

3).range operator
Between - check use (but instead of using this use >= or <= clearly shows that both boundaries are included  x(AND)y

4)membership operator 
IN - check if a value exists in list
NOT	IN - check if a value not exists in list

5) search operator
like - search for a pattern in a text 
'm%' , %hlo%,

*/
select * from customers
where country = 'germany' or country ='usa'

select *
from customers
where country not in ('germany','USA')

-- find all customers whose first name start with 'M'
select *
from customers
where first_name like 'm%'

-- find all customers whose first name ends with 'n'
select * 
from customers
where first_name like '%n'

-- find all customers whose first name has 'r' in the 3rd position
select *
from customers
where first_name like '__r%'

