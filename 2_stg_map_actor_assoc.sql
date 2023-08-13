USE movie_db

CREATE TABLE test_stg_actor (
	actor_id INT NOT NULL
	,actor NVARCHAR(155)
	,CONSTRAINT PK_actor_id PRIMARY KEY CLUSTERED (actor_id)
);


CREATE TABLE test_stg_actor_film_assoc (
	stg_actor_film_id INT NOT NULL IDENTITY(1,1)
	,actor_id INT NOT NULL
	,film_id INT NOT NULL
	,CONSTRAINT PK_stg_actor_film_assoc PRIMARY KEY CLUSTERED (stg_actor_film_id)
);
CREATE UNIQUE INDEX uidx_actor_id_film_id 
	ON test_stg_actor_film_assoc (actor_id, film_id)

--DROP TABLE test_map_actor
CREATE TABLE test_map_actor (
	actor_id INT NOT NULL IDENTITY(1,1)
	,actor NVARCHAR(255)
	,CONSTRAINT PK_test_map_actor PRIMARY KEY CLUSTERED (actor_id)
);




-- INSERT INTO test_map_actor 
SELECT DISTINCT Actor as actor
FROM 
(
SELECT trim(value)as Actor, Title, Year, Director
FROM (SELECT Actors, Title, Year, Director FROM land_movies) AS sub_query
CROSS APPLY string_split(sub_query.Actors,',')
) s
WHERE NOT EXISTS (SELECT 1 FROM test_map_actor m WHERE m.actor = s.Actor)


SELECT * FROM test_map_actor



--inserting into test_stg_actor_film_assoc
INSERT INTO test_stg_actor_film_assoc (actor_id, film_id)
SELECT ma.actor_id, mf.film_id
FROM
(
SELECT trim(value)as Actor, Title, Year, Director
FROM (SELECT Actors, Title, Year, Director FROM land_movies) AS sub_query
CROSS APPLY string_split(sub_query.Actors,',')
) s
INNER JOIN test_map_actor ma ON ma.actor = s.Actor
INNER JOIN map_film mf ON mf.director = s.Director
	and mf.film_year = s.Year	
	and mf.title = s.Title
WHERE NOT EXISTS (SELECT 1 FROM test_stg_actor_film_assoc sa WHERE sa.actor_id = ma.actor_id AND mf.film_id = sa.film_id)



select * from test_stg_actor_film_assoc



-- INSERT INTO test_stg_actor (actor_id, actor)
SELECT DISTINCT ma.actor_id, s.Actor as actor
FROM
(
SELECT trim(value)as Actor, Title, Year, Director
FROM (SELECT Actors, Title, Year, Director FROM land_movies) AS sub_query
CROSS APPLY string_split(sub_query.Actors,',')
) s
INNER JOIN test_map_actor ma ON ma.actor = s.Actor
WHERE NOT EXISTS (SELECT 1 FROM test_stg_actor sa WHERE sa.actor_id = ma.actor_id)


SELECT * FROM test_stg_actor
WHERE actor = 'Chris Pratt'


