-- 1. Ans
-- address, 
select * from address;
select first_name, last_name, email, c.city  from customer inner join address on address.address_id = customer.address_id 
inner join city as c on c.city_id = address.city_id;
 ---- 2. And 
 select * from film;
 select title, description, release_year, max(rental_duration) from film group by film_id;
 ------ 3. Ans 
 select * from customer;
 select c.first_name, rental_date, title from customer as c left join rental as r on c.customer_id = r.customer_id 
 left join inventory as i on r.inventory_id = i.inventory_id left join film as f on i.film_id = f.film_id; 
 
 --- 4. Ans 
 select * from film_actor;
 select * from film;
 select f.title, count(actor_id) from film as f left join film_actor as 
  fa on fa.film_id = f.film_id group by f.title;
  
  ---- 5. Ans 
  select * from rental;
  select c.first_name, c.last_name, c.email, r.rental_date, r.return_date, f.title from customer as c 
  join rental as r on r.customer_id = c.customer_id join inventory as i on i.inventory_id = r.inventory_id
  join film as f on i.film_id = f.film_id; 
  
  -- 6. Ans 
  select * from customer;
  select title, film_id from film where film_id IN (select film_id from inventory where store_id 
  IN (select store_id from customer  where email like '%.org'));
  
  SELECT title
FROM film
WHERE film_id IN (
SELECT film_id
FROM inventory
WHERE store_id IN (
SELECT store_id
FROM customer
WHERE email LIKE '%.org'
)
); 


-- 7. Ans 
select * from rental;
Select c.first_name, c.last_name, count(r.rental_id) as total_rantal from customer as c 
left join rental as r on c.customer_id =r.customer_id group by c.customer_id
order by total_rantal desc;

----- 8. Ans 
select * from payment;
select first_name, last_name from customer where customer_id IN(select customer_id from rental group by customer_id
HAVING COUNT(rental_id) > (
SELECT AVG(rental_count)
FROM (
SELECT COUNT(rental_id) AS rental_count
FROM rental
GROUP BY customer_id
) AS avg_rentals
)
);

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
SELECT customer_id
FROM rental
GROUP BY customer_id
HAVING COUNT(rental_id) > (
SELECT AVG(rental_count)
FROM (
SELECT COUNT(rental_id) AS rental_count
FROM rental
GROUP BY customer_id
) AS avg_rentals
)
);

-- 9. Ans 
select * from address;

SELECT c1.first_name, c1.last_name, c1.email, c2.first_name 
AS other_first_name,
c2.last_name AS other_last_name
FROM customer c1
JOIN address as a1 ON c1.address_id = a1.address_id
JOIN address as a2 ON a1.city = a2.city AND a1.address_id = a2.address_id
JOIN customer c2 ON a2.address_id = c2.address_id;

-- 10. 
select * from film;
SELECT title, rental_rate
FROM film f
WHERE rental_rate > (
SELECT AVG(rental_rate)
FROM film join film_category on f.film_id = film_category.film_id
WHERE category_id = film_category.category_id
); 


-- 11. Ans 
select title, description, length from film where rental_rate >
(select avg(rental_rate) from film where release_year = film.release_year) order by length asc; 

-- 12. Ans 
SELECT first_name, last_name, email
FROM customer
WHERE customer_id IN (
SELECT DISTINCT c.customer_id
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Documentary'
);

-- 13. Ans  
SELECT title, rental_rate,
rental_rate - (SELECT AVG(rental_rate) FROM film) AS rate_difference
FROM film;

-- 14. Ans. 
SELECT title, film_id 
FROM film
WHERE film_id NOT IN (
SELECT DISTINCT film_id
FROM inventory
WHERE film_id IS NOT NULL
);


-- 15. Ans.
select avg(rental_rate) from film; 
select title, rental_rate from film where rental_rate > 
(select avg(rental_rate) from film where release_year = film.release_year) 
and film_id IN (select fc.film_id from film_category as fc join category as c 
on fc.category_id = c.category_id 
where c.name = 'Sci-Fi');

-- 16. Ans 
SELECT customer_id, COUNT(rental_id) AS film_count
FROM rental
GROUP BY customer_id
HAVING COUNT(rental_id) >= 5; 