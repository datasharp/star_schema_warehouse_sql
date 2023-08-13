SELECT * FROM land_movies

------ creating staging tables
--DROP TABLE stg_film

-- staging film table
CREATE TABLE stg_film (
	film_id INT NOT NULL PRIMARY KEY,
	title NVARCHAR(255),
	description NVARCHAR(MAX),
	director NVARCHAR(155),
	film_year INT,
	runtime_minutes INT,
	rating FLOAT,
	votes INT,
	revenue_millions FLOAT,
	metascore INT
);

--alter table stg_film drop CONSTRAINT PK__stg_film__349764A9C0EDD59D
--alter table stg_film ADD CONSTRAINT PK_stg_film PRIMARY KEY CLUSTERED (film_id)


SELECT * FROM stg_film

-- mapping table film (surrogate key lookup table)
CREATE TABLE map_film(
	film_id INT NOT NULL IDENTITY(1,1),
	title NVARCHAR(255),
	film_year INT,
	director NVARCHAR(155),
	CONSTRAINT PK_map_film PRIMARY KEY CLUSTERED (film_id)
);

CREATE UNIQUE INDEX uidx_title_film_year_director   
ON map_film (title, film_year, director);  


-- Insert into map
INSERT INTO map_film (title, director, film_year)
SELECT Title, Director, Year
FROM land_movies l
WHERE NOT EXISTS (SELECT 1 FROM map_film m WHERE m.title = l.Title and m.director = l.Director and m.film_year = l.Year)



---------------------

INSERT INTO stg_film
SELECT  
m.film_id
,l.[Title]
,l.[Description]
,l.[Director]
,l.Year
,l.[Runtime_Minutes]
,l.[Rating]
,l.[Votes]
,l.[Revenue_Millions]
,l.[Metascore]
FROM [land_movies] AS l
INNER JOIN map_film AS m ON m.title = l.Title 
and m.director = l.Director 
and m.film_year = l.Year
WHERE NOT EXISTS (SELECT 1 FROM stg_film AS s WHERE s.film_id = m.film_id)

----------

