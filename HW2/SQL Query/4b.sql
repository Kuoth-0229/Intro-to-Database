-- Creating Located_In_View
CREATE VIEW Located_In_View AS
    SELECT
        Country.Two_Letter_Country_Code,
        Country.Country_Name,
        Continents.Continent_Code,
        Continents.Continent_Name
    FROM
        Country NATURAL JOIN Located_In NATURAL JOIN Continents;

WITH Old_MovingAverage_Country AS(
		SELECT
			Date,
			Two_Letter_Country_Code,
			ConfirmedCases,
			(ConfirmedCases - LAG(ConfirmedCases, 7) OVER (
				PARTITION BY 
                    Two_Letter_Country_Code 
				ORDER BY 
                    Date 
			) ) / 7 AS Moving_Average
		FROM 
            Statistic
	),
    MovingAverage_Country AS(
        SELECT
            Date,
			Two_Letter_Country_Code,
			COALESCE(NULLIF(Moving_Average, 0), 0.1) AS Moving_Average
        FROM 
            Old_MovingAverage_Country
    ),
	OverStringencyIndices AS(
		SELECT
			I.Date,
			I.Two_Letter_Country_Code,
            C.Continent_Code,
			I.StringencyIndex_Average_ForDisplay / M.Moving_Average AS OverStringencyIndex
		FROM
			Indices AS I
			NATURAL JOIN MovingAverage_Country AS M
            NATURAL JOIN Country_Continent AS C
	),
	MaxMin_OverStringencyIndices(Date, Continent_Code, Maximum, Minimum) AS(
	SELECT
		Date,
        Continent_Code,
		MAX(OverStringencyIndex),
		Min(OverStringencyIndex)
	FROM
		OverStringencyIndices
	WHERE 
		Date IN (20200401, 20210401, 20220401, 20221201)
	GROUP BY
		Date, Continent_Code
	),
	CountryCode_Index AS(
	SELECT 
		O.Date,
        O.Continent_Code,
		O.Maximum,
		O.Minimum,
		MaxCountryCode.Two_Letter_Country_Code AS Max_CountryCode,
		MinCountryCode.Two_Letter_Country_Code As Min_CountryCode
	FROM
		MaxMin_OverStringencyIndices AS O
		LEFT JOIN OverStringencyIndices AS MaxCountryCode 
			ON (O.Maximum = MaxCountryCode.OverStringencyIndex 
                AND O.Continent_Code = MaxCountryCode.Continent_Code
                AND O.Date = MaxCountryCode.Date)
		LEFT JOIN OverStringencyIndices AS MinCountryCode 
			ON (O.Minimum = MinCountryCode.OverStringencyIndex 
                AND O.Continent_Code = MinCountryCode.Continent_Code
                AND O.Date = MinCountryCode.Date)

	)
	
SELECT
    S.Date,
    MaxCountryName.Continent_Name,
    S.Maximum AS Max_Stringency_Index, 
    MaxCountryName.Country_Name AS Max_Country_Name,
    S.Minimum AS Min_Stringency_Index,
    MinCountryName.Country_Name AS Min_Country_Name
FROM
    CountryCode_Index S
    LEFT JOIN Located_In_View MaxCountryName
        ON S.Max_CountryCode = MaxCountryName.Two_Letter_Country_Code
        AND S.Continent_Code = MaxCountryName.Continent_Code
    LEFT JOIN Located_In_View MinCountryName
        ON S.Min_CountryCode = MinCountryName.Two_Letter_Country_Code
        AND S.Continent_Code = MinCountryName.Continent_Code
ORDER BY
    S.Date, MaxCountryName.Continent_Name;
