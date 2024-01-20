
-- WINDOW FUNCTION
Select * from film;

select title, film_id, rating, rental_duration, avg(rental_duration) over(), 
avg(rental_duration) over (partition by rating)
from film;
-- rank, dense_rank, row_number 
select title, film_id, rating, rental_duration,  
row_number () over (partition by rating order by rental_duration)
from film; 

-- CTE METHOD in window function. 
with rented as (
select title, film_id, rating, rental_duration,  
rank() over (partition by rating order by rental_duration) as ratings from film)
select rating, count(distinct ratings) from rented group by rating;
