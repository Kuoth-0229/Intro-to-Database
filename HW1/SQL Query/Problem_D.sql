/*  
    problem d
    extract the average number of parts in a set for each theme, 
    with the name of the theme and the average number of parts per set. 
    In ascending order of average number of parts in a set
*/ 
WITH 
	themes_avg (name,part)
AS (
	select themes.name, avg(sets.num_parts)
	from themes,sets
	where themes.id = sets.theme_id
	group by themes.name
)
	
SELECT
	 name,part as avg_part
FROM
	themes_avg
ORDER BY 
	part ASC