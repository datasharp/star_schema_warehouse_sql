USE movie_db

CREATE TABLE stg_genre (
	genre_id INT NOT NULL
	,genre NVARCHAR(155)
);
ALTER TABLE stg_genre
ADD CONSTRAINT PK_stg_genre PRIMARY KEY CLUSTERED (genre_id)

CREATE TABLE stg_genre_film_assoc (
	stg_genre_film_id INT NOT NULL IDENTITY(1,1)
	,genre_id INT NOT NULL
	,film_id INT NOT NULL
	,CONSTRAINT PK_stg_genre_film_id PRIMARY KEY CLUSTERED (stg_genre_film_id)
);
CREATE UNIQUE INDEX uidx_stg_genre_film_assoc
	ON stg_genre_film_assoc (genre_id, film_id)

	
CREATE TABLE map_genre (
	genre_id INT NOT NULL IDENTITY(1,1)
	,genre NVARCHAR(155)
	,CONSTRAINT PK_map_genre PRIMARY KEY CLUSTERED (genre_id)
);

-- Step 1: Populate map_genre table

INSERT INTO map_genre (genre)
SELECT DISTINCT Genre as genre FROM
(
SELECT trim(value)as Genre, Title, Year, Director
FROM (SELECT Genre, Title, Year, Director FROM land_movies) AS sub_query
CROSS APPLY string_split(sub_query.Genre,',') 
) s
WHERE NOT EXISTS (SELECT 1 FROM map_genre mg WHERE mg.genre = s.Genre)

-- SELECT * FROM map_genre

-- TRUNCATE TABLE stg_genre_film_assoc

-- Step 2: Populating stg_genre_film_assoc
INSERT INTO stg_genre_film_assoc (film_id, genre_id)
SELECT mf.film_id, mg.genre_id
FROM
(
SELECT trim(value)as Genre, Title, Year, Director
FROM (SELECT Genre, Title, Year, Director FROM land_movies) AS sub_query
CROSS APPLY string_split(sub_query.Genre,',') 
) s
INNER JOIN map_genre mg ON mg.genre = s.Genre
INNER JOIN map_film mf ON mf.director = s.Director
	and mf.film_year = s.Year
	and mf.title = s.Title 
WHERE NOT EXISTS (SELECT 1 FROM stg_genre_film_assoc sg WHERE sg.film_id = mf.film_id and sg.genre_id = mg.genre_id)

-- Step 3: Populating stg_genre table
INSERT INTO stg_genre (genre_id, genre)
SELECT DISTINCT mg.genre_id, s.Genre as genre
FROM
(
SELECT trim(value)as Genre, Title, Year, Director
FROM (SELECT Genre, Title, Year, Director FROM land_movies) AS sub_query
CROSS APPLY string_split(sub_query.Genre,',') 
) s
INNER JOIN map_genre mg ON mg.genre = s.Genre
WHERE NOT EXISTS (SELECT 1 FROM stg_genre sg WHERE sg.genre_id = mg.genre_id)

SELECT * FROM stg_genre
