USE project_db;
/*
Primary key constraint eligibilty: UNIQUE + NOT NULL
1. Check Primary key constraint
2. Remove the NUll Value
3. Remove Duplicacy
*/
--To check the constraint in the table
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='movies';

/* movieLens.movies Table */
--check the null constraint eligibilty
SELECT * FROM movieLens.movies
WHERE title IS NULL;

--If having null then deal by two way:
--1. Update the record
UPDATE movieLens.movies
SET title = 'Unknown'
WHERE title is NULL

--2. Delete the rows
DELETE FROM movieLens.movies
WHERE title is NULL

-- Now apply the Primary Key CONSTRAINT
ALTER TABLE movieLens.movies 
ADD CONSTRAINT pk_movie PRIMARY KEY (movieId);

/*movieLens.genome_scores Table*/
-- check the primary key if not there apply
--check the primary key constraint eligibilty
SELECT 
    (SELECT COUNT(*) FROM movieLens.genome_scores) AS total_rows,
    COUNT(DISTINCT CONCAT(movieId, '_', tagId)) AS unique_combinations
FROM 
    movieLens.genome_scores;

SELECT 
	COUNT(*) AS num_null_movieId
FROM 
	movieLens.genome_scores
WHERE 
	movieId IS NULL;

SELECT 
	COUNT(*) AS num_null_movieId
FROM 
	movieLens.genome_scores
WHERE 
	tagId IS NULL;

--now add the primary key
ALTER TABLE movieLens.genome_scores
ADD CONSTRAINT pk_genome_scores  PRIMARY KEY(movieId, tagId);

/* movieLens.genome_tags Table all good */

/* movieLens.links table */
-- check the primary key if not there apply
-- check the primary key constraint eligibilty

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

/* movieLens.rating Table */
-- check the primary key if not there apply
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


/* movieLens.tags Table */
-- check the primary key if not there apply
SELECT 
	userid,
	movieid,
	tag,
	count(*)
from movieLens.tags
group by userid, movieId, tag
having count(*)>1;

-- remove the duplicate
WITH duplicates_cte as(
select
	userId,
	movieId,
	tag,
	ROW_NUMBER()over(partition by userId, movieId, tag order by movieId) as rnk
from movieLens.tags)
delete from duplicates_cte
where rnk > 1;

-- check the null values
SELECT
	*
from movieLens.tags
where tag is NULL;

-- apply the null constraint
ALTER table movieLens.tags
ALTER COLUMN userId INT NOT NULL;

ALTER table movieLens.tags
ALTER COLUMN movieId INT NOT NULL;

-- Finally apply the primary key constraint
ALTER table movieLens.tags
ADD CONSTRAINT pk_tags PRIMARY KEY(userId, movieId, tag);


















	



















