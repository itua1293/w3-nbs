/* SUB QUERIES */
    /*Find the list of actors which starred in movies with 
    lengths higher or equal to the average length of all the movies*/
    /*average length of all the movies*/
    SELECT AVG(length) AS average FROM sakila.film;

    /*movies with lengths higher or equal to the average length of all the movies*/
    SELECT * 
    FROM sakila.film 
    WHERE length > (SELECT AVG(length) AS average FROM sakila.film)
        ORDER BY length DESC;


    /*list of actors which starred in movies with lengths higher 
    or equal to the average length of all the movies */

    USE sakila;
    SELECT 
        DISTINCT actor_id 
    FROM sakila.film_actor INNER JOIN 

        (SELECT 
            film_id 
        FROM sakila.film 
        WHERE length > (SELECT AVG(length) AS average FROM film)) AS selected_films_id
        
    ON sakila.film_actor.film_id = selected_films_id.film_id;


    /*Name of actors which starred in movies with lengths
    higher or equal to the average length of all the movies*/

    SELECT 
        first_name, 
        last_name
    FROM sakila.actor INNER JOIN 
        (
        SELECT DISTINCT actor_id 
        FROM sakila.film_actor
        INNER JOIN 
            (SELECT 
                film_id 
            FROM sakila.film 
            WHERE length > (SELECT AVG(length) AS average FROM film)
        ) AS selected_films_id

    ON sakila.film_actor.film_id = selected_films_id.film_id) AS selected_actors
    ON sakila.actor.actor_id = selected_actors.actor_id;


/* TEMPORARY TABLES */
    /* Now this new table can be used as a Temp -> ADVANCED TOPIC */
    CREATE TEMPORARY TABLE sakila.new_table
    SELECT 
        first_name, 
        last_name
    FROM sakila.actor INNER JOIN 
        (
        SELECT DISTINCT actor_id 
        FROM sakila.film_actor
        INNER JOIN 
            (SELECT 
                film_id 
            FROM sakila.film 
            WHERE length > (SELECT AVG(length) AS average FROM film)
        ) AS selected_films_id

    ON sakila.film_actor.film_id = selected_films_id.film_id) AS selected_actors
    ON sakila.actor.actor_id = selected_actors.actor_id;


    /* "new_table" has been created */
    /* Now we can use that table in other queries */
    SELECT *
    FROM sakila.new_table;