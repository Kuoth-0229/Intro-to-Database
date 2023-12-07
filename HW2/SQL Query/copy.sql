-- this part should type in PSQL tool

\copy public.OxCGRT_nat_latest FROM 'C:/usr/local/pgsql/data/DB_HW2_Datas/OxCGRT_nat_latest.csv' WITH DELIMITER ',' CSV HEADER;
\copy public.country_and_continent_codes_list FROM 'C:/usr/local/pgsql/das-list-csv.csv' WITH DELIMITER ',' CSV HEADER;ta/DB_HW2_Datas/country-and-continent-code
