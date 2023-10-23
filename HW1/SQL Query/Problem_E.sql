/*  
    problem e
    find out the name of the colors that are most used in the unique LEGO parts, and list the top 10.
*/ 

WITH color_used (name, num)
AS (
    SELECT colors.name, COUNT(DISTINCT inventory_parts.part_num) AS num
    FROM colors, inventory_parts
    WHERE colors.id = inventory_parts.color_id
    GROUP BY colors.name
)
SELECT 
    name AS color_name, num AS used_num
FROM 
    color_used
ORDER BY 
    color_used.num DESC
LIMIT 10;