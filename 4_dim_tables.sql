USE movie_db


CREATE TABLE dim_movie (
	film_id INT NOT NULL
	,title NVARCHAR(255)
	,description NVARCHAR(450)
	,CONSTRAINT PK_dim_movie PRIMARY KEY CLUSTERED (film_id)
);

SELECT * FROM dim_movie


-- Insert into dim movie
INSERT INTO dim_movie
SELECT mf.film_id, mf.title, mf.director FROM stg_film sf
INNER JOIN map_film mf ON mf.film_id = sf.film_id
WHERE NOT EXISTS (SELECT 1 FROM dim_movie dm WHERE dm.film_id = mf.film_id)


SELECT * FROM dim_movie

--

CREATE TABLE dim_actor_movie_assoc (
	dim_actor_movie_assoc_id INT NOT NULL 
	,actor_id INT NOT NULL
	,film_id INT NOT NULL
	,CONSTRAINT PK_dim_actor_movie_assoc PRIMARY KEY CLUSTERED (dim_actor_movie_assoc_id)
);
CREATE UNIQUE INDEX uidx_dim_actor_movie_assoc
	ON dim_actor_movie_assoc (actor_id, film_id)

-- Insert into dim movie
INSERT INTO dim_actor_movie_assoc (dim_actor_movie_assoc_id ,actor_id, film_id)
SELECT stg_actor_film_id, actor_id, film_id FROM stg_actor_film_assoc s
WHERE NOT EXISTS (SELECT 1 FROM dim_actor_movie_assoc da WHERE da.actor_id = s.actor_id AND da.film_id = s.film_id)

--

SELECT * FROM stg_actor_film_assoc;

SELECT * FROM dim_actor_movie_assoc;

--

CREATE TABLE dim_actor (
	actor_id INT NOT NULL
	,actor NVARCHAR(155)
	,CONSTRAINT PK_dim_actor PRIMARY KEY CLUSTERED (actor_id)
);

INSERT INTO dim_actor (actor_id, actor)
SELECT s.actor_id, s.actor FROM stg_actor s
WHERE NOT EXISTS (SELECT 1 FROM dim_actor d WHERE d.actor_id = s.actor_id)



SELECT * FROM dim_actor 

--


CREATE TABLE dim_genre_movie_assoc (
	dim_genre_movie_assoc_id INT NOT NULL 
	,genre_id INT NOT NULL
	,film_id INT NOT NULL
	,CONSTRAINT PK_dim_genre_movie_assoc PRIMARY KEY CLUSTERED (dim_genre_movie_assoc_id)
);
CREATE UNIQUE INDEX uidx_dim_genre_movie_assoc
	ON dim_genre_movie_assoc (genre_id, film_id)


INSERT INTO dim_genre_movie_assoc (film_id, genre_id, dim_genre_movie_assoc_id)
SELECT s.film_id, s.genre_id, s.stg_genre_film_id
FROM stg_genre_film_assoc s
WHERE NOT EXISTS (SELECT 1 FROM dim_genre_movie_assoc d WHERE d.genre_id = s.genre_id and d.film_id = s.film_id)




SELECT * FROM dim_genre_movie_assoc




-- Creating dim director table and dim date table

-- creating dim_director
CREATE TABLE dim_director (
	director_id INT NOT NULL 
	,director NVARCHAR(255)
);
alter table dim_director ADD CONSTRAINT PK_dim_director PRIMARY KEY CLUSTERED (director_id)



-- creating map director table
CREATE TABLE map_director(
	director_id INT NOT NULL IDENTITY(1,1)
	,director NVARCHAR(155)
	CONSTRAINT PK_map_director PRIMARY KEY CLUSTERED (director_id)
);



--TRUNCATE TABLE map_director

INSERT INTO map_director (director)
SELECT DISTINCT sf.director 
FROM stg_film sf
INNER JOIN map_film mf on mf.film_id = sf.film_id     
WHERE NOT EXISTS (SELECT 1 FROM map_director md WHERE md.director = sf.director)
-- 644 rows

SELECT * FROM map_director



INSERT INTO dim_director
SELECT DISTINCT md.director_id, sf.director
FROM stg_film sf
INNER JOIN map_director md ON md.director = sf.director
WHERE NOT EXISTS (SELECT 1 FROM dim_director dd WHERE md.director = sf.director)


SELECT * FROM dim_director


------


CREATE TABLE dim_year (
	date_id INT NOT NULL 
	,year INT NOT NULL
);

CREATE TABLE map_year (
	year_id INT NOT NULL IDENTITY(1,1)
	,year INT NOT NULL
	,CONSTRAINT year_year PRIMARY KEY CLUSTERED (year_id)
);




INSERT INTO map_year (year)
SELECT DISTINCT sf.film_year 
FROM stg_film sf
INNER JOIN map_film mf on mf.film_id = sf.film_id     
WHERE NOT EXISTS (SELECT 1 FROM map_year md WHERE md.year = sf.film_year)
-- 11 rows

SELECT * FROM map_year


INSERT INTO dim_year
SELECT DISTINCT md.year_id, sf.film_year
FROM stg_film sf
INNER JOIN map_year md ON md.year = sf.film_year
WHERE NOT EXISTS (SELECT 1 FROM dim_year dd WHERE md.year = sf.film_year)


SELECT * FROM dim_year

SELECT * FROM dim_movie

---
SELECT * FROM stg_film



-- Creating fact_film


CREATE TABLE fact_film (
	runtime_minutes FLOAT 
	,rating FLOAT
	,revenue_millions FLOAT
	,votes INT
	,metascore INT
	,film_id INT NOT NULL
	,director_id INT NOT NULL
	,year_id INT NOT NULL
);
	

INSERT INTO fact_film 
SELECT s.runtime_minutes, s.rating, s.revenue_millions, s.votes, s.metascore,mf.film_id, md.director_id, my.year_id
FROM stg_film as s
INNER JOIN map_director md ON md.director = s.director
INNER JOIN map_year my ON my.year = s.film_year
INNER JOIN map_film mf ON mf.film_id = s.film_id
WHERE NOT EXISTS (SELECT 1 FROM fact_film f WHERE f.film_id = mf.film_id and md.director_id = f.director_id and my.year_id = f.year_id)