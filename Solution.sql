--  Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select 
max(length) as 'max_duration'
,min(length) as'min_duration'
from film
;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
select
round(avg(length)) as 'avg film duration in minutes'
-- ,floor(avg(length))
-- ,ceiling(avg(length))

from film;

-- You need to gain insights related to rental dates:
select
*
from rental;

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
select
datediff(now(), min(rental_date)) as 'days_operating'
from rental;

select max(return_date)- min(rental_date)  from rental;

select 
datediff(max(return_date),min(rental_date)) from rental;

select 
*,
dayname(rental_date),
monthname(rental_date),
month(rental_date),
weekday(rental_date),
date_format(rental_date,'%M' ),
date_format(rental_date,'%W' ),
case
when weekday(rental_date)<5 then 'Workday'
when weekday(rental_date)>=5 then 'Weekend'
from rental
;

-- SELECT 
--  *,
--  DAYNAME(rental_date),
--  monthname(rental_date),
--  MONTH(rental_date),
--  WEEKDAY(rental_date),
--  date_format(rental_date,'%M'),
--  date_format(rental_date,'%W'),
--  CASE 
-- 	WHEN  WEEKDAY(rental_date)<5 then 'Workday'
--     WHEN WEEKDAY(rental_date)>=5 then 'Weekend'
-- ELSE 
-- 	'Not a weekday at all'
-- END AS day_type
--  FROM rental
-- ;

SELECT
rental.*,
CASE
WHEN DAYOFWEEK(rental.rental_date) IN (1, 7) THEN 'weekend'
ELSE 'workday'
END AS day_type
FROM rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
select
title, ifnull(rental_duration, 'Not Available'), rental duration
from film
case where rental_duration is null then 'Not Available' else rental_duration end, 
if(rental_duration is null)
;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
select
concat(first_name, '', last_name),
left (email,3),
substring(email,1,3)
from customer;

-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
-- 1.2 The number of films for each rating.
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select count(*) from film;
select distinct rating from film;
select count(*) from film where rating='PG';
select count(*) from film where rating='G';
select rating, count(*) from film group by rating order by count(*) desc;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

select round(avg (length)) from film;

select 
	rating,
	round(avg(length))
from 
	film
group by rating
having floor (avg(length)/60)>=2
order by round(avg(length)) desc;


-- Bonus: determine which last names are not repeated in the table actor.

select  last_name from actor;
select  count(*) from actor where last_name = 'AKROYD';

select
last_name, count(*)
from actor
group by last_name
having count(*) = 1;