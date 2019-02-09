use sakila;
select first_name,last_name from actor;
select upper(concat(first_name, ' ', last_name)) 'Actor Name'  from actor;
select actor_id, first_name,last_name from actor where first_name = "Joe";
select actor_id, first_name,last_name from actor where last_name like "%GEN%";
select actor_id, first_name,last_name from actor where last_name like "%LI%" order  by last_name, first_name;
select country_id, country from country where country in ("Afghanistan", "Bangladesh", "China");
alter table actor add column description BLOB after last_name;
alter table actor drop column description ; 
select last_name, count(*) '# of actors' from actor group by last_name;
select last_name, count(*) as count_of_actors from actor group by last_name having count_of_actors >=2;
select * from actor where first_name = 'GROUCHO' and last_name='WILLIAMS';
update  actor set first_name = 'HARPO' where first_name = 'GROUCHO' and last_name='WILLIAMS';
select * from actor where first_name = 'HARPO';
SET SQL_SAFE_UPDATES = 0;
update actor set first_name = 'GROUCHO'  where first_name = 'HARPO' ;
SET SQL_SAFE_UPDATES = 1;
SHOW CREATE TABLE address;

select s.first_name,
	s.last_name,
    a.address,
    a.address2 from staff as s 
    join address as a on 
    s.address_id = a.address_id;

select s.staff_id, 
	sum(p.amount) 
    from staff as s 
    join payment as p on
    s.staff_id = p.staff_id
    where p.payment_date >= '2005-08-01'
    group by staff_id;

select f.title, 
	count(fa.actor_id) as total_actors 
    from film as f 
    join film_actor as fa 
    on f.film_id = fa.film_id 
    group by f.title;

select f.title, 
	count(i.inventory_id) as total_copies 
    from film as f 
    join inventory as i
    on f.film_id = i.film_id
    where f.title = 'Hunchback Impossible';
 
 #Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:
 select c.first_name, c.last_name, sum(p.amount)
	from customer as c
    join payment as p
    on c.customer_id = p.customer_id
    group by c.first_name, c.last_name
    order by c.last_name;
    
#7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
select f.title from film as f
	join language as l
    on f.language_id =  l.language_id
    where ( f.title like 'K%' or f.title like 'Q%') and
    l.name = 'English';

#7b. Use subqueries to display all actors who appear in the film Alone Trip.
select first_name,last_name from actor where actor_id in (
	select actor_id from film_actor where film_id in (
		select film_id from film where title = 'Alone Trip'));

#You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

select first_name,last_name,email from customer as c
	join address as a on c.address_id = a.address_id  
    join city as ci on ci.city_id = a.city_id
    join country as co on co.country_id = ci.country_id
    where co.country = "Canada";
    
#7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select title from film where rating = 'PG' ;

#7e. Display the most frequently rented movies in descending order.
select count(r.inventory_id) as rental_count, f.title
	from rental as r join inventory as i on r.inventory_id = i.inventory_id
    join film as f on f.film_id = i.film_id
    group by f.title
    order by rental_count desc;
    

#7f. Write a query to display how much business, in dollars, each store brought in.
select sum(p.amount), s.store_id
	from payment as p join rental as r on p.rental_id = r.rental_id
    join staff as st on r.staff_id = st.staff_id
    join store as s on s.store_id = st.store_id
    group by s.store_id;

#7g. Write a query to display for each store its store ID, city, and country.
select s.store_id, c.city, cn.country
	from store as s join address as a on s.address_id = a.address_id
    join city as c on a.city_id = c.city_id
    join country as cn on cn.country_id = c.country_id
    ;

#7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select c.name, sum(p.amount)
	from category as c join film_category as fc on c.category_id = fc.category_id
    join film as f on fc.film_id = f.film_id 
    join inventory as i on f.film_id = i.film_id
    join rental as r on i.inventory_id = r.inventory_id
    join payment as p on r.rental_id = p.rental_id 
    group by c.name;

#8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't' solved 7h, you can substitute another query to create a view.
create view top_genre as 
	select c.name
	from category as c join film_category as fc on c.category_id = fc.category_id
    join film as f on fc.film_id = f.film_id 
    join inventory as i on f.film_id = i.film_id
    join rental as r on i.inventory_id = r.inventory_id
    join payment as p on r.rental_id = p.rental_id 
    group by c.name
    order by sum(p.amount) desc limit 5;
     
#8b. How would you display the view that you created in 8a?
select * from top_genre ;

#8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
drop view top_genre ;





    

	
  
 

