SELECT *
FROM credits c
JOIN titles t ON c.id = t.id;

SELECT
  COUNT(*) AS total,
  COUNT(imdb_score) AS with_imdb,
  COUNT(runtime) AS with_runtime,
  COUNT(release_year) AS with_year
FROM titles;

DELETE FROM titles
WHERE imdb_score IS NULL OR runtime IS NULL OR release_year IS NULL;

SELECT * FROM titles
WHERE imdb_score IS NOT NULL AND runtime IS NOT NULL AND release_year IS NOT NULL;

SELECT person_id, id, role, COUNT(*) AS occurrences
FROM credits
GROUP BY person_id, id, role
HAVING COUNT(*) > 1;

DELETE FROM credits
WHERE rowid NOT IN (
  SELECT MIN(rowid)
  FROM credits
  GROUP BY person_id, id, role
);

ALTER TABLE titles
DROP COLUMN description,
DROP COLUMN imdb_id,
DROP COLUMN tmdb_popularity,
DROP COLUMN seasons;

-- Top 10 Highest Rated Movies
SELECT title, imdb_score
FROM titles
WHERE type = 'MOVIE'
ORDER BY imdb_score DESC
LIMIT 10;

-- Most Popular Genre by Number of Titles
SELECT genres, COUNT(*) AS count
FROM titles
GROUP BY genres
ORDER BY count DESC;


-- Top Actors by Number of Movies/Shows
SELECT name, COUNT(*) AS appearances
FROM credits
WHERE role = 'ACTOR'
GROUP BY name
ORDER BY appearances DESC
LIMIT 10;


-- Most Productive Countries by Content Count
SELECT production_countries, COUNT(*) AS count
FROM titles
GROUP BY production_countries
ORDER BY count DESC;


-- Average IMDb Score by Genre
SELECT genres, ROUND(AVG(imdb_score), 2) AS avg_score
FROM titles
WHERE imdb_score IS NOT NULL
GROUP BY genres
ORDER BY avg_score DESC;

-- Director with Most High-Rated Shows
SELECT name, COUNT(*) AS high_rated_count
FROM credits c
JOIN titles t ON c.id = t.id
WHERE c.role = 'DIRECTOR' AND t.imdb_score >= 8
GROUP BY name
ORDER BY high_rated_count DESC
LIMIT 5;


-- Most Common Role Types (actor, director, etc.)
SELECT role, COUNT(*) AS total
FROM credits
GROUP BY role
ORDER BY total DESC;


-- IMDB vs TMDB Score Correlation Sample
SELECT title, imdb_score, tmdb_score
FROM titles
WHERE imdb_score IS NOT NULL AND tmdb_score IS NOT NULL
ORDER BY RANDOM()
LIMIT 20;

-- Top Series by Number of Seasons
SELECT title, seasons
FROM titles
WHERE type = 'SHOW'
ORDER BY seasons DESC
LIMIT 10;


-- Yearly Content Production Trend
SELECT release_year, COUNT(*) AS total_titles
FROM titles
GROUP BY release_year
ORDER BY release_year;


-- Actor with the Highest Average IMDb Score
SELECT c.name, ROUND(AVG(t.imdb_score), 2) AS avg_imdb
FROM credits c
JOIN titles t ON c.id = t.id
WHERE c.role = 'ACTOR' AND t.imdb_score IS NOT NULL
GROUP BY c.name
HAVING COUNT(*) >= 3
ORDER BY avg_imdb DESC
LIMIT 10;


-- Most Versatile Actor (Appeared in Most Genres)
SELECT c.name, COUNT(DISTINCT t.genres) AS genre_count
FROM credits c
JOIN titles t ON c.id = t.id
WHERE c.role = 'ACTOR'
GROUP BY c.name
ORDER BY genre_count DESC
LIMIT 10;



-- Most Common Genre Combinations
SELECT genres, COUNT(*) AS count
FROM titles
GROUP BY genres
ORDER BY count DESC
LIMIT 10;

-- Countries with Highest Rated Content
SELECT production_countries, ROUND(AVG(imdb_score), 2) AS avg_score
FROM titles
WHERE imdb_score IS NOT NULL
GROUP BY production_countries
ORDER BY avg_score DESC;


