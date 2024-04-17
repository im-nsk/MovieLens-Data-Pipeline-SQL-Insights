CREATE INDEX IX_movies_title ON movies(title);
CREATE INDEX IX_movies_genres ON movies(genres);

CREATE INDEX IX_links_movieId ON links (movieId);

CREATE INDEX IX_genome_tags_tag ON genome_tags (tag);

CREATE INDEX IX_genome_scores_movieId ON genome_scores (movieId);
CREATE INDEX IX_genome_scores_tagId ON genome_scores (tagId);

CREATE INDEX IX_tags_userId ON tags (userId);
CREATE INDEX IX_tags_movieId ON tags (movieId);

CREATE INDEX IX_ratings_userId ON ratings (userId);
CREATE INDEX IX_ratings_movieId ON ratings (movieId);

