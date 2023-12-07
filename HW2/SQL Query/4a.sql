-- Dropping existing views if they exist
DROP VIEW IF EXISTS combined_view;
DROP VIEW IF EXISTS Located_In_View;
DROP VIEW IF EXISTS CountryCode_Index;
DROP VIEW IF EXISTS StringencyIndex;



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

-- Final SELECT statement using JOIN operations
SELECT
    S.Date,
    Continents.Continent_Name,
    S.Maximum AS Max_Stringency_Index, 
    MaxCountry.Country_Name AS Max_Country_Name,
    S.Minimum AS Min_Stringency_Index,
    MinCountry.Country_Name AS Min_Country_Name
FROM
    CountryCode_Index S
    LEFT JOIN Country MaxCountry
        ON S.Max_CountryCode = MaxCountry.Two_Letter_Country_Code
    LEFT JOIN Country MinCountry
        ON S.Min_CountryCode = MinCountry.Two_Letter_Country_Code
    JOIN Continents
        ON S.Continent_Code = Continents.Continent_Code
ORDER BY
    S.Date, Continents.Continent_Name;
