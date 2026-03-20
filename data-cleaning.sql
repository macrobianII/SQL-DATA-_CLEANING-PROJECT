
-- DATA CLEANING IN MYSQL 
SELECT * FROM layoffs ;

-- EDA PROCESS
-- REMOVING DUPLICATES 
-- STANDARDISE THE DATA 
    -- FINDING THE MISSING VALUES
-- POPULATE THE MISSING/NULL VALUES 
-- REMOVE ANY MISSING VALUES IF POSSIBLE 

-- STAGING - creating duplicate of the main dataset so incase of anything the main dataset or raw data remains untouched 
CREATE TABLE layoff_staging LIKE layoffs;
-- INSERTING DATA TO STAGED TABLE , DATA FROM THE RAW TABLE
INSERT INTO layoff_staging 
SELECT * FROM layoffs ;

-- CHECKING IF THE DATA IS INSERTED CORRECTLY 
SELECT * FROM layoff_staging;


-- Removing duplicate rows 
-- CHECK IF DUPLICATES EXIST BY USING THE ROW_NUMBER() FUNCTION 
WITH duplicate_cte AS (
SELECT * ,
ROW_NUMBER() OVER (PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) AS row_num 
FROM layoff_staging
)
SELECT * FROM duplicate_cte 
WHERE row_num > 1 ;

SELECT * FROM layoffs
WHERE company = 'Casper' ;


-- ADDING ROW_NUM TO BE ABLE TO DELETE DUPLICATES
CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int -- added to the staged table 2 to be able to delete it because cannot be deleted 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoff_staging2 ;

INSERT INTO layoff_staging2 -- inserting the second staging table the value of previous staged one 
SELECT * ,
ROW_NUMBER() OVER (PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) AS row_num 
FROM layoff_staging ;

SET SQL_SAFE_UPDATES = 0;
-- DELETING THE ROWS that are duplicates
DELETE
FROM layoff_staging2
WHERE row_num > 1;
-- checking the table if the duplicates are deleted 
SELECT * FROM layoff_staging2 ;


-- STANDARDISING DATA - FINDING ISSUES IN THE DATA AND FIXING IT 

SELECT DISTINCT company , TRIM(company)
FROM layoff_staging2;

UPDATE layoff_staging2
SET company = TRIM(company);


-- INDUSTRY 
SELECT DISTINCT industry FROM layoff_staging2 
ORDER BY 1;

SELECT *
FROM layoff_staging2 WHERE
industry  LIKE 'Crypto%' ;


UPDATE layoff_staging2 SET
industry = 'Crypto' WHERE 
industry LIKE 'Crypto%';

-- LOCATION 

SELECT DISTINCT location FROM layoff_staging2
ORDER BY 1;

-- COUNTRY 
SELECT DISTINCT country -- ,TRIM(TRAILING '.' FROM country) 
FROM layoff_staging2 
ORDER BY 1;

UPDATE layoff_staging2 SET 
country = 'United States'
-- TRIM(TRAILING '.' FROM country) 
WHERE country LIKE 'United States%';
-- UNITED STATES HAD DUPLICATE WITH A DOT

-- DATE CONVERSION FROM TEXT TO TIME SERIES 
SELECT `date` 
-- STR_TO_DATE(`date`, '%m/%d/%Y') AS 'date'
FROM layoff_staging2;

UPDATE layoff_staging2 SET
`date` = STR_TO_DATE(`date`, '%m/%d/%Y') WHERE 
industry LIKE `date`;
-- Changing the data type of date 
ALTER TABLE layoff_staging2 MODIFY COLUMN `date` DATE ;

SELECT * FROM layoff_staging2;

-- WORKING WITH NULL AND BLANK VALUES
 
 -- CHECKING ALL THE NULL VALUES 
SELECT *
 FROM layoff_staging2 
 WHERE total_laid_off IS NULL  
 OR percentage_laid_off IS NULL
 OR funds_raised_millions IS NULL
 OR stage IS NULL ;

-- CHECKING NULL AND EMPTY VALUES IN THE TABLES=INDUSTRY
SELECT * FROM layoff_staging2 
WHERE industry IS NULL OR industry = ''; 

SELECT * FROM layoff_staging2 
WHERE company = 'Airbnb';

-- In this case the missing value is populated with the data from the other related row i.e the company name is the same 
-- we perform a self join between tables to see the tables with null values and the values to populate them 

SELECT * FROM layoff_staging2 st1
JOIN layoff_staging2 st2 
ON st1.company = st2.company -- AND 
    --   st1.location = st2.location 
WHERE (st1.industry IS NULL OR st1.industry = '')
AND st2.industry IS NOT NULL ;
 
 -- set 'emmpty braces' to NULL values
 
 UPDATE layoff_staging2 
 SET industry = NULL WHERE industry ='';
 
 -- Populate 
 UPDATE layoff_staging2 st1 JOIN 
 layoff_staging2 st2 ON 
 st1.company = st2.company 
 SET st1.industry = st2.industry 
 WHERE (st1.industry IS NULL)
AND st2.industry IS NOT NULL;


-- DELETE THE ROW WHERE TOTAL AND PERCENTAGE LAID OFF ARE NULL

DELETE FROM layoff_staging2 
WHERE total_laid_off IS NULL AND percentage_laid_off;

-- Remove the column that we created 

ALTER TABLE layoff_staging2 DROP COLUMN row_num ;

SELECT * FROM layoff_staging2