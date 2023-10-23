/*
	problem b
    extract the total number of LEGO sets in each year from 1950 to 2017, 
    in descending order of total number of LEGO sets 
*/

SELECT 
	count(sets.set_num) as total_set_num, sets.year
FROM 
	sets
WHERE 
	sets.year <= 2017 AND
	sets.year >= 1950
GROUP BY
	sets.year
ORDER BY
	total_set_nu DESC