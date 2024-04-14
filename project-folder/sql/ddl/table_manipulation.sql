USE project_db;
/*
1. Datatype Format, typeCast it
2. Check constraint
*/
--To find the primary key constraint
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='tags';



--movieLens.movies
select
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH
from information_schema.columns 
where table_name = 'movies'
--apply the constraint 
--check the null constraint eligibilty
SELECT * FROM movieLens.movies
WHERE title IS NULL;

--If having then deal by two way:
--1. Update the record
UPDATE movieLens.movies
SET title = 'Unknown'
WHERE title is NULL

--2. Delete the rows
DELETE FROM movieLens.movies
WHERE title is NULL

-- NOW APPLY THE CONSTRAINT
ALTER TABLE movieLens.movies 
ALTER COLUMN title varchar(500) NOT NULL;

-- create index:
-- Index on movieId column
CREATE INDEX idx_movies_movieId ON movieLens.movies(movieId);

-- movieLens.genome_scores
select
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH
from information_schema.columns 
where table_name = 'genome_scores'

--CREATE INDEX idx_movie_tag ON movieLens.genome_scores(movieId, tagId);

--apply the constraint 
--check the primary key constraint eligibilty
SELECT 
    (SELECT COUNT(*) FROM movieLens.genome_scores) AS total_rows,
    COUNT(DISTINCT CONCAT(movieId, '_', tagId)) AS unique_combinations
FROM 
    movieLens.genome_scores;

SELECT COUNT(*) AS num_null_movieId
FROM movieLens.genome_scores
WHERE movieId IS NULL;
SELECT COUNT(*) AS num_null_movieId
FROM movieLens.genome_scores
WHERE tagId IS NULL;

--now add the primary key
ALTER TABLE movieLens.genome_scores
ADD CONSTRAINT pk_genome_scores  PRIMARY KEY(movieId, tagId);

-- movieLens.genome_tags all good

-- movieLens.links
SELECT
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH
FROM information_schema.columns 
WHERE table_name = 'links'

--apply the constraint 
--check the primary key constraint eligibilty

-- check the duplicacy:
SELECT 
    (SELECT COUNT(*) FROM movieLens.links) AS total_rows,
    COUNT(DISTINCT CONCAT(movieId, '_', imdbId, '_', tmdbId)) AS unique_combinations
FROM 
    movieLens.links;

-- or

SELECT 
	movieId, 
	imdbId, 
	tmdbId, 
	COUNT(*) AS num_duplicates
FROM movieLens.links
GROUP BY movieId, imdbId, tmdbId
HAVING COUNT(*) > 1;

-- or

WITH duplicates_cte AS (
    SELECT 
        movieId, 
        imdbId, 
        tmdbId, 
        ROW_NUMBER() OVER (PARTITION BY imdbId, tmdbId ORDER BY movieId) AS rn
    FROM 
        movieLens.links
)
SELECT
	* 
FROM duplicates_cte
WHERE rn>1;


-- delete the duplicate records
WITH duplicates_cte AS (
   SELECT 
		movieId, 
		imdbId, 
		tmdbId, 
		ROW_NUMBER() OVER (PARTITION BY imdbId, tmdbId ORDER BY movieId) AS rn
    FROM 
        movieLens.links
)
DELETE FROM 
    duplicates_cte
WHERE 
    rn > 1;

-- check null value

SELECT 
	* 
FROM 
	movieLens.links
WHERE tmdbId IS NULL;

-- Apply the primary key constraint
ALTER TABLE movieLens.links
ALTER COLUMN movieId INT NOT NULL;

ALTER TABLE movieLens.links
ALTER COLUMN imdbId INT NOT NULL;

ALTER TABLE movieLens.links
ALTER COLUMN tmdbId INT NOT NULL;


ALTER TABLE movieLens.links
ADD CONSTRAINT pk_links PRIMARY KEY(movieId, imdbId, tmdbId);

-- movieLens.rating
SELECT
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH
FROM information_schema.columns 
WHERE table_name = 'rating'

-- check the duplicacy
SELECT userId, movieId, COUNT(*) AS num_duplicates
FROM movieLens.rating
GROUP BY userId, movieId
HAVING COUNT(*) > 1;

-- check null
select * from 
movielens.rating
where movieId is NULL;

-- apply primary key
ALTER TABLE movielens.rating
ALTER COLUMN userId INT NOT NULL;

ALTER TABLE movielens.rating
ALTER COLUMN movieId INT NOT NULL;

ALTER TABLE movielens.rating
ADD CONSTRAINT pk_ratings PRIMARY KEY (userId, movieId);


-- movieLens.tags
SELECT
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH
FROM information_schema.columns 
WHERE table_name = 'tags'

-- formatting column datatype: in sqlserver altering the column, only one column in one command
ALTER TABLE movieLens.tags
ALTER COLUMN userId INT;

ALTER TABLE movieLens.tags
ALTER COLUMN movieId INT;

UPDATE movieLens.tags
set timestamp = DATEADD(second, CAST(timestamp as BIGINT), '1970-01-01');
ALTER TABLE movieLens.tags
ALTER COLUMN timestamp DATE;

select top 5 * from movielens.tags 
-- Assuming the timestamp value is stored in a column named 'timestamp_column' in a table named 'your_table_name'
SELECT DATEADD(second, 1439472355, '1970-01-01') AS readable_timestamp;

UPDATE movielens.tags
set tag = 'unknown tag'
where tag like '??%';


SELECT 
	userid,
	movieid,
	tag,
	count(*)
from movieLens.tags
group by userid, movieId, tag
having count(*)>1;

SELECT
	userid,
	movieid,
	tag
from movieLens.tags
where tag like '??%';

WITH duplicates_cte as(
select
	userId,
	movieId,
	tag,
	ROW_NUMBER()over(partition by userId, movieId, tag order by movieId) as rnk
from movieLens.tags)
delete from duplicates_cte
where rnk > 1;

SELECT
	*
from movieLens.tags
where tag is NULL;

--set column as null;
ALTER table movieLens.tags
ALTER COLUMN userId INT NOT NULL;

ALTER table movieLens.tags
ALTER COLUMN movieId INT NOT NULL;

ALTER table movieLens.tags
ALTER COLUMN tag varchar(200) NOT NULL;

ALTER table movieLens.tags
ADD CONSTRAINT pk_tags PRIMARY KEY(userId, movieId, tag);

-- with this DATA cleaning completed














	



















