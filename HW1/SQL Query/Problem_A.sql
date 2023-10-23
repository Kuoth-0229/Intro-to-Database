/*
    problem a
    extract the name of the set and name of the theme of all the LEGO sets published in 2017
*/

SELECT 
	sets.name as set_name, themes.name as theme_name
FROM 
	sets,themes
WHERE 
	sets.theme_id = themes.id AND
	sets.year = 2017