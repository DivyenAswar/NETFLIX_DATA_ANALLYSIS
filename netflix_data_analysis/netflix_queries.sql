-- netflix project 

Create table netflix(
show_id Varchar(10),
type Varchar(10),	
title Varchar(150),
director Varchar(220),	
casts	varchar(1000),
country varchar(150),
date_added varchar(50),
release_year int,
rating	varchar(10),
duration varchar(15),	
listed_in	varchar(105),
description varchar(250)
);


-- Total content count
SELECT COUNT(*) AS total_content FROM netflix;

-- Content types
SELECT DISTINCT type FROM netflix;

-- Unique directors
SELECT COUNT(DISTINCT director) AS unique_directors FROM netflix;

-- Unique countries
SELECT COUNT(DISTINCT country) AS unique_countries FROM netflix;





-- Business problems --


--  count the numbers of movies vs tv show 

select type,
count(*) as total_count
from netflix 
group by type;




--  list all movie released in spesific year (e.g. 2020)

select * from netflix 
where type='Movie' and release_year ='2020';




--  Identify the longest movie

SELECT 
    title,
    duration
FROM netflix
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC
LIMIT 1;





-- content added in last 5 years 

select * from netflix 
where to_date(date_added,'month dd,yyyy') >= current_date - interval '5 years' ;



-- content by director S. Shankar

select * from netflix 
where director like '%S. Shankar%' ;




-- tv show with more than 5 seasons 

SELECT *
FROM netflix
WHERE type = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::INT > 5;


-- content count by diffrent genre 

SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))) AS genre,
    COUNT(*) AS total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC;




---top 5 years witg highest release in india 

select release_year , count(*) as total_releases
from netflix 
where country ilike '%india%'
group by release_year
order by total_releases desc
limit 5 ;

select * from netflix limit 5 ;



-- all documentry movies 

select * from netflix 
where listed_in ILIKE '%Documentaries%';





--- movies without director 

select title from netflix 
where director is null  or director ='';





--- movies in salmam khan act IN LAST 10 YEARS 

select title from netflix 
where casts ILIKE '%Salman Khan%'
and release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10 ;





--- TOP 10 actors in indian movies 

SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))) AS actor,
    COUNT(*) AS total_content
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;





-- categorize content as Good or Bad based on description

SELECT 
    CASE 
        WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' 
        THEN 'Bad' 
		ELSE 'Good'
   	 END AS category,
    COUNT(*) AS content_count
FROM netflix
GROUP BY category;

