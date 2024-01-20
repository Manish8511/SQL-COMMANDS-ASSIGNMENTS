use mavenmovies;
select title , rental_duration from film where rental_duration between 6 and 10  and title like ("a_a%");

select first_name, last_update , actor_id from actor where actor_id  between 10 and 50 and first_name like ("a_e%");

select * from actor;

select first_name, last_update, actor_id , last_name from actor where last_name like ("__a%") and first_name like ("_e%");  


select concat(first_name , " - " ,  last_update) from actor; 

use mavenmovies;
select * from actor;
select * from film inner join film_actor on film.film_id = film_actor.film_id;
select city ,country from city join country on city.country_id = country.country_id where country.country = "india";
select * from actor;
select * from film_actor;
select * from film;
