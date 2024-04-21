
USE project_db;
-- Data Cleaning
-- Date Format
-- Naming Format

select * from movielens.movies
where title like '?%' or genres like '?%';

DELETE FROM movielens.movies
where title like '?%' or genres like '?%';

-- Standarized the Naming format
UPDATE movielens.movies
SET title = CASE 
                WHEN PATINDEX('%[a-zA-Z]%', title) > 1 
                THEN SUBSTRING(title, PATINDEX('%[a-zA-Z]%', title), LEN(title)) 
                ELSE title 
            END

UPDATE  movielens.movies
SET title = UPPER(LEFT(title, 1)) + LOWER(SUBSTRING(title, 2, LEN(title)))


-- format the timestamp column data into readable date
UPDATE movieLens.tags
set timestamp = DATEADD(second, CAST(timestamp as BIGINT), '1970-01-01');
select top 5 * from movieLens.tags;

ALTER TABLE movieLens.tags
ALTER COLUMN timestamp DATE;
select top 5 * from movielens.tags;

UPDATE movielens.tags
set tag = 'unknown tag'
where tag like '??%';

select * from movielens.tags
where tag like '?%';

DELETE FROM movielens.tags
where tag like '?%';

SELECT
	userid,
	movieid,
	tag
from movieLens.tags
where tag like '??%';

select top 5 * from movielens.rating
-- To change timestamp into readble format;
UPDATE movieLens.rating
SET timestamp = DATEADD(SECOND, CAST(timestamp AS FLOAT), '1970-01-01')
WHERE ISNUMERIC(timestamp) = 1;

ALTER TABLE movieLens.rating
ALTER COLUMN timestamp DATE;