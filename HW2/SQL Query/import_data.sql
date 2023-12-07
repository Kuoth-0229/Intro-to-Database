
INSERT INTO
	country_and_continent_codes_list
VALUES
	('Europe', 'EU', 'Kosovo, Republic of', 'KS', 'RKS', 383);

INSERT INTO 
    public.Country
SELECT DISTINCT
    Two_Letter_Country_Code,
    Three_Letter_Country_Code, 
    Country_Name,
    Country_Number 
FROM 
    country_and_continent_codes_list;

UPDATE 
	Country
SET 
	Country_Name = OxCGRT_nat_latest.CountryName
FROM
	OxCGRT_nat_latest
WHERE
    OxCGRT_nat_latest.CountryCode = Country.Three_Letter_Country_Code;

INSERT INTO 
    public.Continents
SELECT DISTINCT
    Continent_Code,
    Continent_Name
FROM 
    country_and_continent_codes_list;

INSERT INTO 
    public.located_in
SELECT DISTINCT
    Two_Letter_Country_Code,
    Continent_Code
FROM 
    country_and_continent_codes_list;


INSERT INTO 
    public.Containment_and_closure_policy
SELECT DISTINCT
    Two_Letter_Country_Code,
    Date_,
    C1M,
    C2M,
    C3M,
    C4M,
    C5M,
    C6M,
    C7M,
    C8EV,
    C1M_Flag,
    C2M_Flag,
    C3M_Flag,
    C4M_Flag,
    C5M_Flag,
    C6M_Flag,
    C7M_Flag
FROM 
    OxCGRT_nat_latest JOIN Country ON
        OxCGRT_nat_latest.CountryCode = Country.Three_Letter_Country_Code;
INSERT INTO 
    public.Economic_policy
SELECT DISTINCT
    Two_Letter_Country_Code,
    Date_,
    E1,
    E2,
    E3,
    E4,
    E1_Flag
FROM 
    OxCGRT_nat_latest JOIN Country ON
        OxCGRT_nat_latest.CountryCode = Country.Three_Letter_Country_Code;
INSERT INTO 
    public.Health_system_policy
SELECT DISTINCT
    Two_Letter_Country_Code,
    Date_,
    H1,
    H2,
    H3,
    H4,
    H5,
    H6M,
    H7,
    H8M,
    H1_Flag,
    H6M_Flag
FROM 
    OxCGRT_nat_latest JOIN Country ON
        OxCGRT_nat_latest.CountryCode = Country.Three_Letter_Country_Code;
INSERT INTO 
    public.Vaccine_policy
SELECT DISTINCT
    Two_Letter_Country_Code,
    Date_,
    V1,
    V2A,
    V2B,
    V2C,
    V2D,
    V2E,
    V2F,
    V2G,
    V3,
    V4
FROM 
    OxCGRT_nat_latest JOIN Country ON
        OxCGRT_nat_latest.CountryCode = Country.Three_Letter_Country_Code;

INSERT INTO
    public.Statistic
SELECT DISTINCT
    Two_Letter_Country_Code,
    Date_,
    PopulationVaccinated,
    ConfirmedCases,
    ConfirmedDeaths
FROM
    OxCGRT_nat_latest JOIN Country ON
        OxCGRT_nat_latest.CountryCode = Country.Three_Letter_Country_Code;

INSERT INTO
    public.Indices
SELECT DISTINCT
    Two_Letter_Country_Code,
    Date_,
	StringencyIndex_Average_ForDisplay,
    GovernmentResponseIndex_Average_ForDisplay,
    ContainmentHealthIndex_Average_ForDisplay,
    EconomicSupportIndex_ForDisplay
FROM
    OxCGRT_nat_latest JOIN Country ON
        OxCGRT_nat_latest.CountryCode = Country.Three_Letter_Country_Code;