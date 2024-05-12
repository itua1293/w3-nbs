/* INTRO */

	SELECT  * 
	FROM sakila.film;

	/* my first sql query select all columns and only first 20 rows */
	SELECT  * 
	FROM sakila.film 
	LIMIT 20; 

	/*select only some columns */

	SELECT 
	title , 
	description , 
	rating 
	FROM sakila.film; 


/* BASIC READ QUERIES */
	/*select the distinct values in a particular column */

	SELECT DISTINCT rental_duration
	FROM sakila.film; 


	/*... or multiple */

	SELECT DISTINCT rental_duration, language_id
	FROM sakila.film; 

	/*Check the longest films */

	SELECT title, rental_rate, length
	FROM sakila.film
	ORDER BY length DESC;

	/*Check the longest films, tiebreak by most expensive rental */

	SELECT title, rental_rate, length
	FROM sakila.film
	ORDER BY length DESC, rental_rate DESC;


	/* Aliasing */
	SELECT title, rental_rate AS cost, length
	FROM sakila.film;

	/* Computations */
	SELECT title, rental_rate/length AS price_per_min
	FROM sakila.film
	ORDER BY price_per_min ASC

	/*String Computations */

	SELECT CONCAT(title,', rating:',rating) AS descriptor
	FROM sakila.film;

	/* perform a query with a condition */

	SELECT * 
	FROM sakila.film
	WHERE sakila.film.rental_duration = 6;

	/* plus some variations */ 

	WHERE sakila.film.rental_duration > 6;
	WHERE sakila.film.rental_duration >= 6;
	WHERE sakila.film.rental_duration <> 6;
	WHERE sakila.film.rental_duration in (3,4,5,6);

	WHERE sakila.film.special_features = 'Deleted Scenes';
	WHERE sakila.film.special_features LIKE '%Deleted Scenes%';
	WHERE sakila.film.special_features NOT LIKE '%Deleted Scenes%';

	/* Sample aggregations */

	SELECT COUNT(*),MAX(rental_duration),AVG(replacement_cost),AVG(rental_duration)
	FROM sakila.film


	/* Aggregations with group by */
	SELECT rating, COUNT(rating), AVG(rental_rate) 
	FROM sakila.film
	GROUP BY rating;


	SELECT rating, rental_duration, COUNT(rating), AVG(rental_rate) 
	FROM sakila.film
	GROUP BY rating, rental_duration;

	/* JOIN */
	/* bringing tables together -> join them -> one step inner join*/ 
	/* What is the language of a film?*/
	SELECT 
		sakila.film.film_id,
	    sakila.film.title,
	    sakila.language.name
	FROM sakila.film INNER JOIN sakila.language
		ON sakila.film.language_id = sakila.language.language_id;

	/* bringing tables together -> join them -> 2 step inner join*/ 
	SELECT * FROM sakila.actor;
	SELECT * FROM sakila.film_actor;
	SELECT * FROM sakila.film;

	/* many 2 many relations are well handled by a "bridge" table */
	SELECT 
		sakila.film.title,
		sakila.actor.first_name AS Fname, 
		sakila.actor.last_name AS Lname, 
	    sakila.film_actor.film_id
	    
	FROM sakila.actor INNER JOIN sakila.film_actor
		ON sakila.actor.actor_id = sakila.film_actor.actor_id
			INNER JOIN sakila.film
				ON sakila.film.film_id = sakila.film_actor.film_id;



