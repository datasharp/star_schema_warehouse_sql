USE movie_db

-- creating stg_actor
CREATE TABLE stg_actor (
	actor_id INT NOT NULL 
	,actor NVARCHAR(155)
);
alter table stg_actor ADD CONSTRAINT PK_stg_actor PRIMARY KEY CLUSTERED (actor_id)

-- creating actor_film accociative table 
CREATE TABLE stg_actor_film_assoc (
	stg_actor_film_id INT NOT NULL IDENTITY(1,1) 
	,actor_id INT NOT NULL
	,film_id INT NOT NULL
	,CONSTRAINT PK_stg_actor_film PRIMARY KEY CLUSTERED (stg_actor_film_id)
);
CREATE UNIQUE INDEX uidx_actor_id_film_id
	ON stg_actor_film_assoc (actor_id, film_id); 

-- creating map actor table
CREATE TABLE map_actor(
	actor_id INT NOT NULL IDENTITY(1,1)
	,actor NVARCHAR(155)
	CONSTRAINT PK_map_actor PRIMARY KEY CLUSTERED (actor_id)
);


INSERT INTO map_actor
SELECT DISTINCT Actor
FROM (SELECT trim(value)as Actor, Title, Year, Director
	FROM (
		SELECT Actors, Title, Year, Director FROM land_movies 
			) AS sub_query
	CROSS APPLY string_split(sub_query.Actors,',') as actors_split) as v
WHERE NOT EXISTS (SELECT 1 FROM map_actor m WHERE m.actor = v.Actor)


SELECT * FROM map_actor


INSERT INTO stg_actor_film_assoc (actor_id, film_id)
SELECT DISTINCT ma.actor_id, mf.film_id 
FROM ( 
	SELECT trim(value)as Actor, Title, Year, Director
	FROM (
		SELECT Actors, Title, Year, Director FROM land_movies 
			) AS sub_query
	CROSS APPLY string_split(sub_query.Actors,',') as actors_split) as t
INNER JOIN map_actor as ma on ma.actor = t.Actor
INNER JOIN map_film as mf on mf.Title  =  t.Title
	AND mf.film_year = t.Year
	AND mf.director = t.Director
WHERE NOT EXISTS (SELECT 1 FROM stg_actor_film_assoc as a WHERE ma.actor_id = a.actor_id AND mf.film_id = a.film_id)

SELECT * FROM  stg_actor_film_assoc

INSERT INTO stg_actor
SELECT DISTINCT
m.actor_id
,v.Actor
FROM (SELECT trim(value)as Actor, Title, Year, Director
	FROM (
		SELECT Actors, Title, Year, Director FROM land_movies 
			) AS sub_query
	CROSS APPLY string_split(sub_query.Actors,',') as actors_split) AS v
INNER JOIN map_actor AS m ON m.actor = v.Actor
WHERE NOT EXISTS (SELECT 1 FROM stg_actor AS s WHERE s.actor_id = m.actor_id);


SELECT * FROM stg_actor --1985 rows

SELECT * FROM stg_actor
WHERE actor = 'Chris Pratt' --1 row! -- actor_id = 1370