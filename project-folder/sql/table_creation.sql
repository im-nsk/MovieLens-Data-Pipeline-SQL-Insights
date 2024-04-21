
-- CREATE DATABASE project_db;
USE project_db;
-- CREATE SCHEMA movieLens;

/*create database and schema only one time*/

CREATE TABLE movieLens.movies(
movieId INT PRIMARY KEY,
title VARCHAR(200) NOT NULL,
genres VARCHAR(100) NOT NULL);

CREATE TABLE movieLens.links(
movieId INT ,
imdbId INT,
tmdbId INT);

CREATE TABLE movieLens.genome_tags(
tagId INT PRIMARY KEY,
tag VARCHAR(25) NOT NULL);

CREATE TABLE movieLens.genome_scores(
movieId INT PRIMARY KEY,
tagId INT NOT NULL,
relevance DECIMAL(5,2));

CREATE TABLE movieLens.tags(
userId INT ,
movieId INT,
tag VARCHAR(200),
timestamp VARCHAR(20));

CREATE TABLE movieLens.rating(
userId INT PRIMARY KEY,
movieId INT,
rating DECIMAL(3,2),
timestamp VARCHAR(20));


/* If required */
-- DROP TABLE IF EXISTS movielens.movies;
-- DROP TABLE IF EXISTS links;
-- DROP TABLE IF EXISTS genome_tags;
-- DROP TABLE IF EXISTS genome_scores;
-- DROP TABLE IF EXISTS tags;
-- DROP TABLE IF EXISTS rating;

-- Display the tables in the schema:
SELECT name as table_name
FROM sys.tables
WHERE schema_name(schema_id) = 'movieLens'
ORDER BY name;







