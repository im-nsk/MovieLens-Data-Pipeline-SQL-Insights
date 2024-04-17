ALTER TABLE movies
ADD CONSTRAINT FK_movies_genreId FOREIGN KEY (genreId) REFERENCES genres(genreId);

ALTER TABLE links
ADD CONSTRAINT FK_links_imdbId FOREIGN KEY (imdbId) REFERENCES imdb(imdbId);

ALTER TABLE genome_scores
ADD CONSTRAINT FK_genome_scores_tagId FOREIGN KEY (tagId) REFERENCES genome_tags(tagId);

ALTER TABLE tags
ADD CONSTRAINT FK_tags_userId FOREIGN KEY (userId) REFERENCES users(userId);

ALTER TABLE ratings
ADD CONSTRAINT FK_ratings_userId FOREIGN KEY (userId) REFERENCES users(userId);
