use project_db;
--Links Table:
--Verify Data Consistency
select m.movieId, l.movieId
from movieLens.movies m RIGHT JOIN movieLens.links l on m.movieId = l.movieId
where m.movieId is NULL;
--Correct Data: 
DELETE FROM movieLens.links
where movieId NOT IN(select movieId from movieLens.movies);
-- Add Foreign Key Constraint: 
ALTER TABLE movielens.links
ADD CONSTRAINT FK_links_movieId FOREIGN KEY (movieId) REFERENCES movielens.movies(movieId);

--Genome Scores Table:
--Verify Data Consistency
select m.movieId, gm.movieId
from movieLens.movies m RIGHT JOIN movieLens.genome_scores gm on m.movieId = gm.movieId
where m.movieId is NULL;
-- Add Foreign Key Constraint: 
ALTER TABLE movielens.genome_scores
ADD CONSTRAINT FK_genome_scores_movieId FOREIGN KEY (movieId) REFERENCES movielens.movies(movieId);

--Verify Data Consistency
select gt.tagId, gm.tagId
from movieLens.genome_tags gt RIGHT JOIN movieLens.genome_scores gm on gt.tagId = gm.tagId
where gt.tagId is NULL;
-- Add Foreign Key Constraint: 
ALTER TABLE movieLens.genome_scores
ADD CONSTRAINT FK_genome_scores_tagId FOREIGN KEY (tagId) REFERENCES movieLens.genome_tags(tagId);

--Tags Table:
--Verify Data Consistency
select m.movieId, t.movieId
from movieLens.movies m RIGHT JOIN movieLens.tags t on m.movieId = t.movieId
where m.movieId is NULL;
-- Correct Data:
DELETE FROM movieLens.tags
where movieId NOT IN(select movieId from movieLens.movies);
-- Add Foreign Key Constraint: 
ALTER TABLE movieLens.tags
ADD CONSTRAINT FK_tags_movieId FOREIGN KEY (movieId) REFERENCES movieLens.movies(movieId);

--Ratings Table:
select m.movieId, r.movieId
from movieLens.rating r LEFT JOIN movieLens.movies m on r.movieId = m.movieId
where m.movieId IS NULL;
--Correct data
DELETE FROM movieLens.rating
WHERE movieId NOT IN (SELECT movieId FROM movieLens.movies);
-- Add Foreign Key Constraint:
ALTER TABLE movieLens.rating
ADD CONSTRAINT FK_ratings_movieId FOREIGN KEY (movieId) REFERENCES movieLens.movies(movieId);

