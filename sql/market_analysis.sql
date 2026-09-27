-- AutoScout24 Germany Marketplace Analytics
-- SQLite
-- Analytical population: country_code = 'DE' AND price >= 1000

DROP VIEW IF EXISTS german_listings;

CREATE VIEW german_listings AS
SELECT *
FROM autoscout24_listings
WHERE country_code = 'DE'
  AND price >= 1000;


-- 1. Core marketplace KPIs

SELECT
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS average_asking_price,
    MIN(price) AS minimum_asking_price,
    MAX(price) AS maximum_asking_price
FROM german_listings;


-- 2. Seller-type comparison

SELECT
    seller_type,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS average_asking_price,
    ROUND(AVG(mileage_km_raw), 0) AS average_mileage_km
FROM german_listings
GROUP BY seller_type
ORDER BY listings DESC;


-- 3. Fuel-category composition

SELECT
    fuel_category,
    COUNT(*) AS listings,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM german_listings),
        2
    ) AS listing_share_pct
FROM german_listings
GROUP BY fuel_category
ORDER BY listings DESC;


-- 4. Brand listing volume

SELECT
    make,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS average_asking_price
FROM german_listings
WHERE make IS NOT NULL
GROUP BY make
ORDER BY listings DESC
LIMIT 10;


-- 5. Model listing volume

SELECT
    make,
    model,
    COUNT(*) AS listings
FROM german_listings
WHERE make IS NOT NULL
  AND model IS NOT NULL
GROUP BY make, model
ORDER BY listings DESC
LIMIT 20;


-- 6. Mileage bands

SELECT
    CASE
        WHEN mileage_km_raw <= 10000 THEN '0–10K km'
        WHEN mileage_km_raw <= 50000 THEN '10K–50K km'
        WHEN mileage_km_raw <= 100000 THEN '50K–100K km'
        WHEN mileage_km_raw <= 150000 THEN '100K–150K km'
        WHEN mileage_km_raw > 150000 THEN '150K+ km'
        ELSE 'Unknown'
    END AS mileage_band,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS average_asking_price
FROM german_listings
GROUP BY mileage_band
ORDER BY
    CASE mileage_band
        WHEN '0–10K km' THEN 1
        WHEN '10K–50K km' THEN 2
        WHEN '50K–100K km' THEN 3
        WHEN '100K–150K km' THEN 4
        WHEN '150K+ km' THEN 5
        ELSE 99
    END;


-- 7. Seller mix by percentage

SELECT
    seller_type,
    COUNT(*) AS listings,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM german_listings),
        2
    ) AS share_pct
FROM german_listings
GROUP BY seller_type
ORDER BY listings DESC;


-- 8. High-price tail

SELECT
    COUNT(*) AS listings_above_1m
FROM german_listings
WHERE price > 1000000;
