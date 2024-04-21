-- Loading the data fix the error

-- 1. Data size can be greater than column data size
-- 2. Primary key constraint


ALTER TABLE movieLens.genome_tags
ALTER COLUMN tag VARCHAR(200);


--Remove the primary key then load data
--find the primary key constraint
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='genome_scores';

--remove the primary key
ALTER TABLE movieLens.genome_scores
DROP CONSTRAINT PK__genome_s__42EB374EEBBD4870;
