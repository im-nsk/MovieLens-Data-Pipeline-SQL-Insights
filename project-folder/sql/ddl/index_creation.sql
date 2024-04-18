USE project_db;

CREATE INDEX IX_movies_title ON movieLens.movies(title);
CREATE INDEX IX_movies_genres ON movieLens.movies(genres);

CREATE INDEX IX_links_movieId ON movieLens.links (movieId);

CREATE INDEX IX_genome_tags_tag ON movieLens.genome_tags (tag);

CREATE INDEX IX_genome_scores_movieId ON movieLens.genome_scores (movieId);
CREATE INDEX IX_genome_scores_tagId ON movieLens.genome_scores (tagId);

CREATE INDEX IX_tags_userId ON movieLens.tags (userId);
CREATE INDEX IX_tags_movieId ON movieLens.tags (movieId);

CREATE INDEX IX_ratings_userId ON movieLens.rating (userId);
CREATE INDEX IX_ratings_movieId ON movieLens.rating (movieId);

