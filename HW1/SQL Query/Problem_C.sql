/*  
    problem c
    extract the name of the most popular theme, 
    defined by the number of sets in the themes.
*/ 
WITH 
	themes_sets (name,num_set)
AS (
	select themes.name, count(sets.name)
	from themes,sets
	where themes.id = sets.theme_id
	group by themes.name
)
	
SELECT
	 name,num_set as max_set
FROM
	themes_sets
WHERE
	num_set = (select max(num_set)
			   from themes_sets);