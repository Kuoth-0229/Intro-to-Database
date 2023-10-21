
COPY public.colors(id,name,rgb,is_trans)
FROM 'C:/Program Files/PostgreSQL/16/bin/DB_HW1_Datas/colors.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.themes(id,name,parent_id)
FROM 'C:/Program Files/PostgreSQL/16/bin/DB_HW1_Datas/themes.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.sets(set_num,name,year,theme_id,num_parts)
FROM 'C:/Program Files/PostgreSQL/16/bin/DB_HW1_Datas/sets.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.inventories(id, version, set_num)
FROM 'C:/Program Files/PostgreSQL/16/bin/DB_HW1_Datas/inventories.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.inventory_sets(inventory_id,set_num,quantity)
FROM 'C:/Program Files/PostgreSQL/16/bin/DB_HW1_Datas/inventory_sets.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.part_categories(id,name)
FROM 'C:/Program Files/PostgreSQL/16/bin/DB_HW1_Datas/part_categories.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.parts(part_num,name,part_cat_id)
FROM 'C:/Program Files/PostgreSQL/16/bin/DB_HW1_Datas/parts.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.inventory_parts(inventory_id,part_num,color_id,quantity,is_spare)
FROM 'C:/Program Files/PostgreSQL/16/bin/DB_HW1_Datas/inventory_parts.csv'
DELIMITER ',' 
CSV HEADER;
