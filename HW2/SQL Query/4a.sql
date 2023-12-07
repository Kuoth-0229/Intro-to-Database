-- Dropping existing views if they exist
DROP VIEW IF EXISTS Combined_View;
DROP VIEW IF EXISTS CountryCode_Index;
DROP VIEW IF EXISTS Located_In_View;
DROP VIEW IF EXISTS stringencyindex;


-- Creating StringencyIndex view
CREATE VIEW StringencyIndex AS
    SELECT
        Date,
        Continent_Code,
        MAX(StringencyIndex_Average_ForDisplay) AS Maximum,
        MIN(StringencyIndex_Average_ForDisplay) AS Minimum
    FROM
        Indices NATURAL JOIN Located_In
    WHERE 
        Date IN (20200401, 20210401, 20220401, 20221201)
    GROUP BY
        Date, Continent_Code;

-- Creating CountryCode_Index view
CREATE VIEW CountryCode_Index AS
    SELECT 
        S.Date,
        S.Continent_Code,
        S.Maximum,
        MaxLocated_In.Two_Letter_Country_Code AS Max_CountryCode,
        S.Minimum,
        MinLocated_In.Two_Letter_Country_Code AS Min_CountryCode
    FROM
        StringencyIndex S
        LEFT JOIN (Indices NATURAL JOIN Located_In) AS MaxLocated_In
            ON (S.Maximum = MaxLocated_In.StringencyIndex_Average_ForDisplay 
                AND S.Date = MaxLocated_In.Date
                AND S.Continent_Code = MaxLocated_In.Continent_Code)
        LEFT JOIN (Indices NATURAL JOIN Located_In) AS MinLocated_In
            ON (S.Minimum = MinLocated_In.StringencyIndex_Average_ForDisplay 
                AND S.Date = MinLocated_In.Date
                AND S.Continent_Code = MinLocated_In.Continent_Code);

-- Creating Located_In_View
CREATE VIEW Located_In_View AS
    SELECT
        Country.Two_Letter_Country_Code,
        Country.Country_Name,
        Continents.Continent_Code,
        Continents.Continent_Name
    FROM
        Country NATURAL JOIN Located_In NATURAL JOIN Continents;

-- Creating Combined_View
CREATE VIEW Combined_View AS
    SELECT
        CCI.Date,
        CCI.Continent_Code,
        MaxCountry.Continent_Name AS Max_Continent_Name,
        CCI.Maximum AS Max_Stringency_Index,
        MaxCountry.Country_Name AS Max_Country_Name,
        CCI.Minimum AS Min_Stringency_Index,
        MinCountry.Continent_Name AS Min_Continent_Name,
        MinCountry.Country_Name AS Min_Country_Name
    FROM
        CountryCode_Index CCI
        LEFT JOIN Located_In_View MaxCountry
            ON (CCI.Max_CountryCode = MaxCountry.Two_Letter_Country_Code AND CCI.Continent_Code = MaxCountry.Continent_Code)
        LEFT JOIN Located_In_View MinCountry
            ON (CCI.Min_CountryCode = MinCountry.Two_Letter_Country_Code AND CCI.Continent_Code = MinCountry.Continent_Code);

-- Example SELECT statement using the Combined_View
SELECT * FROM Combined_View;
