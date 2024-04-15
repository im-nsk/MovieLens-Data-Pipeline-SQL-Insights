use project_db;

select * from movielens.movies
where title like '?%' or genres like '?%';

DELETE FROM movielens.movies
where title like '?%' or genres like '?%';

select top 5 * from movielens.rating
-- need to change timestamp into readble format;

UPDATE movieLens.rating
SET timestamp = DATEADD(SECOND, CAST(timestamp AS FLOAT), '1970-01-01')
WHERE ISNUMERIC(timestamp) = 1;

ALTER TABLE movieLens.rating
ALTER COLUMN timestamp DATE;


select * from movielens.tags
where tag like '?%';

DELETE FROM movielens.tags
where tag like '?%';
