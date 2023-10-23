/*  
    problem f
    find out the name of the colors that are most used in the LEGO parts, 
    for each theme, and list the top 1 for each theme 
    (please provide the name of the theme, too).
*/ 
 WITH color_theme_quantity AS (
    SELECT
        themes.name AS theme_name,
        colors.name AS color_name,
        quantity
    FROM
        colors, inventory_parts, inventories, sets, themes, parts
    WHERE
        parts.part_num = inventory_parts.part_num AND
        colors.id = inventory_parts.color_id AND
        inventory_parts.inventory_id = inventories.id AND
        sets.set_num = inventories.set_num AND
        sets.theme_id = themes.id
)
, color_theme_max_quantity AS (
    SELECT
        theme_name,
        color_name,
        SUM(quantity) AS sum_quantity
    FROM
        color_theme_quantity
    GROUP BY
        theme_name, color_name
)
, RankedColors AS (
    SELECT
        theme_name,
        color_name,
        sum_quantity,
        RANK() OVER (PARTITION BY theme_name ORDER BY sum_quantity DESC) AS rank
    FROM
        color_theme_max_quantity
)
SELECT
    theme_name,
    color_name,
    sum_quantity
FROM
    RankedColors
WHERE
    rank = 1;