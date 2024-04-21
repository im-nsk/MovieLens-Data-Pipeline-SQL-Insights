USE project_db;
/*Join Tables: You can join the tables to combine relevant information. For example, joining the "movies" table with the "ratings" table on the "movieId" column can give you ratings for each movie. Similarly, joining "movies" with "tags" can give you user-generated tags for each movie.
*/
--1. Calculate Average Ratings: With the joined table of movies and ratings, we can calculate the average rating for each movie. 
SELECT 
	title,
	round(avg(rating),1) as rating
FROM movielens.movies INNER JOIN  movielens.rating on movies.movieId = rating.movieId
GROUP BY title
order by rating DESC;


--2. Count Number of Ratings: We can count the number of ratings each movie has received. 

SELECT
	title,
	sum(rating) as rating_count
FROM movieLens.movies INNER JOIN movieLens.rating ON movies.movieId = movies.movieId
GROUP BY movies.title
ORDER BY rating_count;

--3. List Most Common Tags: After joining the movies table with the tags table, we can list the most common tags associated with movies. 
select t.tag, count(*) as tag_count 
from movielens.tags t
INNER JOIN movieLens.movies m ON t.movieId = m.movieId
GROUP BY t.tag
ORDER BY tag_count DESC;


-- 4. Explore Genre-Rating Relationship: We can analyze the relationship between movie genres and ratings by joining the movies table with the ratings table and grouping by genres.

SELECT m.genres, ROUND(AVG(r.rating), 2) AS avg_rating
FROM movieLens.movies m
INNER JOIN movielens.rating r ON m.movieId = r.movieId
GROUP BY m.genres
ORDER BY avg_rating DESC;
/*
Aggregation: Calculate statistics such as average ratings, count of ratings, or average relevance of tags for each movie.*/
--1 Average Relevance of Tags for Each Movie:
SELECT m.movieId, m.title, ROUND(AVG(gs.relevance),3) AS avg_tag_relevance
FROM movieLens.movies m 
INNER JOIN movieLens.genome_scores as gs ON m.movieId = gs.movieId
GROUP BY m.movieId, m.title;

/*Exploratory Data Analysis (EDA): Explore the data distribution, identify trends, and understand the characteristics of movies, ratings, tags, etc.*/



-- 1. Distribution of Genres:

SELECT genres, COUNT(*) AS genre_count
FROM movielens.movies
GROUP BY genres
ORDER BY genre_count DESC;

-- 2. Trend of movie Over Time
SELECT 
     m.title,
    AVG(rating) AS avg_rating,
	YEAR(timestamp) as yearly_rating
FROM 
    movieLens.rating r
INNER JOIN movieLens.movies m ON m.movieId = r.movieId
GROUP BY 
	m.title,YEAR(timestamp)
ORDER BY 
    avg_rating desc, yearly_rating ;

-- 3. Number of Movies per Year 

SELECT 
    title,
    SUBSTRING(title, CHARINDEX('(', title) + 1, LEN(title) - CHARINDEX('(', title) - 1) AS extracted_year
FROM 
    movieLens.movies;


/*Genre Analysis: Analyze the distribution of genres among movies. You can count the occurrences of each genre and visualize them.*/

-- 1. Count Occurrences of Each Genre:
--Visualize the Distribution of Genres:You can use Power BI

/*Collaborative Filtering: Use collaborative filtering techniques to recommend movies based on user ratings.*/
-- collaborative filtering to recommend movies based on user ratings:

/*Content-Based Filtering: Analyze movie tags and genres to recommend similar movies based on content.*/
-- content-based filtering using movie tags and genres:


/*Dimensionality Reduction: Use techniques like Principal Component Analysis (PCA) on the genome scores to reduce dimensionality and find latent features.*/


/*Data Visualization: Visualize insights using Power BI or any other data visualization tool. Create charts, graphs, and dashboards to represent the findings effectively.*

Machine Learning Models: Build predictive models for movie ratings or user preferences using techniques like regression, classification, or clustering.
--coming soon