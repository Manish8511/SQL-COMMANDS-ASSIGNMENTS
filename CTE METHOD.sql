
select first_name ,last_name from customer where (select count(rental_id) from rental where rental.customer_id = customer.customer_id) = '30';
select first_name , last_name from customer where (select sum(amount) from payment p where p.customer_id = customer.customer_id) between 100 and 150;

select * from customer;
-- write a query generate a list of customer IDs along with the no of film rentals and the total paymenst. 

select c.first_name , c.last_name , tot_rental , tot_payment from customer c inner join ( select customer_id , count(*) as tot_rental, 
sum(amount) as tot_payment from payment group by customer_id ) a on c.customer_id = a.customer_id; 


select * from payment;
select avg(amount) from payment;

select customer_id, amount from payment where amount > (select avg(amount) from payment); 



select first_name, last_name, 
case 
when active = '1' then 'active' 
else 'inactive'
end actor_active
from customer ;  

select * from film;
select title, rental_duration, 
case 
when rental_duration = '5' then 'Pass'
else 'Fail' 
end  stage 
from film; 

select monthname(rental_date), rental_id from rental;
select sum(case when monthname(rental_date) = 'May' then 1 else 0 end ) as May,
sum(case when monthname(rental_date) = 'June' then 1 else 0 end ) as June,
 sum(case when monthname(rental_date) = 'July' then 1 else 0 end ) as July from rental; 
 
 select title, film_id,
 case ( select count(*) from inventory where inventory.film_id = film.film_id) 
 when 1 then 'out of stock' 
 when 2 then 'out of stock'
 when 3 then 'Available' 
 when 4 then 'Available' 
 else 'common' 
 end as avaiblity from film; 
 select * from film;
 select count( case when rating = 'PG' then 1 else 0 end) as PG, 
 count( case when rating = 'G' then 1 else 0 end) as G, 
 count( case when rating = 'NC-17' then 1 else 0 end) as NC17  from film;  
 
 select first_name, last_name from customer where (
select sum(amount) from payment where payment.customer_id = customer.customer_id) between 100 and 150;  

-- show even_number and herarchy  number 

--- Recursive Method CTE;


With recursive even_no (n) as (select 10 union all select n + 1 from even_no where n < 20) 
select * from even_no;


With recursive odd_no (n) as (select 10 union all select n + 3 from odd_noo where n < 20) 
select * from odd_no;


select * from actor_award;
with recursive actor_hararchy  as (
select actor_award_id, actor_id, first_name, last_name, 0 as level from actor_award where actor_id is null
union all select aa.actor_award_id, aa.actor_id, aa.first_name, aa.last_name, ah.level + 1 from actor_award as aa 
join actor_hararchy ah on aa.actor_id = ah.actor_id) 
select actor_award_id, actor_id, first_name, last_name, level from actor_hararchy;   
