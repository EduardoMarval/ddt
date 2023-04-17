-- Crear una base de datos llamada películas.
CREATE DATABASE peliculas;


-- Create table for movies
CREATE TABLE movie (
id INT PRIMARY KEY,
title VARCHAR(255),
release_year INT,
director VARCHAR(255)
);


-- Create table for actors
CREATE TABLE actor (
id SERIAL PRIMARY KEY,
actor_name VARCHAR(255),
movie_id INT REFERENCES movie(id)
);



-- Cargar ambos archivos a su tabla correspondiente y aplicar el truncado de estas.

TRUNCATE table movie,actor;

\COPY movie(id,title,release_year,director) FROM 'assets/docs/peliculas.csv' DELIMITER ',' CSV HEADER;

\COPY actor(movie_id,actor_name) FROM 'assets/docs/reparto.csv' DELIMITER ',' CSV HEADER;


-- Obtener el ID de la película “Titanic”.

SELECT id FROM movie WHERE title = 'Titanic';


-- Listar a todos los actores que aparecen en la película "Titanic".

SELECT actor_name FROM actor WHERE movie_id = (SELECT movie_id FROM movie WHERE title = 'Titanic');


-- Consultar en cuántas películas del top 100 participa Harrison Ford.

SELECT COUNT(*) 
FROM (
SELECT DISTINCT movie_id
FROM actor
WHERE actor_name = 'Harrison Ford'
AND movie_id IN (
SELECT movie_id
FROM movie
LIMIT 100
)
) AS top_movies;


--  Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de
-- manera ascendente.

SELECT title, release_year
FROM movie
WHERE release_year BETWEEN 1990 AND 1999
ORDER BY title ASC;


-- Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser
-- nombrado para la consulta como “longitud_titulo”.

SELECT title, LENGTH(title) AS longitud_titulo
FROM movie;


--Consultar cual es la longitud más grande entre todos los títulos de las películas.

SELECT title, LENGTH(title) AS longitud_titulo
FROM movie
ORDER BY longitud_titulo desc
limit 1;


