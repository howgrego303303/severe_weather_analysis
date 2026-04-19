-- ================================================
-- Severe Weather Analysis
-- Author: Gregory Howell
-- Date: April 2026
-- ================================================

-- DATA CLEANING OVERVIEW:
-- The NOAA Storm Events database stores property and crop damage
-- as text strings rather than numeric values.
-- Examples: "10.00K" = $10,000 | "2.50M" = $2,500,000 | "1.00B" = $1,000,000,000
-- This script adds two new numeric columns to enable proper
-- mathematical analysis of damage values.

-- ================================================
-- STEP 1: Add clean numeric column for property damage
-- ================================================

ALTER TABLE severe_weather
ADD COLUMN damage_property_usd REAL;

-- Convert text damage values to numeric USD amounts
-- Handles K (thousands), M (millions), and B (billions)
UPDATE severe_weather
SET damage_property_usd =
    CASE
        WHEN UPPER(TRIM(damage_property)) LIKE '%K'
            THEN CAST(REPLACE(UPPER(TRIM(damage_property)), 'K', '') AS REAL) * 1000
        WHEN UPPER(TRIM(damage_property)) LIKE '%M'
            THEN CAST(REPLACE(UPPER(TRIM(damage_property)), 'M', '') AS REAL) * 1000000
        WHEN UPPER(TRIM(damage_property)) LIKE '%B'
            THEN CAST(REPLACE(UPPER(TRIM(damage_property)), 'B', '') AS REAL) * 1000000000
        ELSE 0
    END;

-- ================================================
-- STEP 2: Add clean numeric column for crop damage
-- ================================================

ALTER TABLE severe_weather
ADD COLUMN damage_crops_usd REAL;

-- Convert text crop damage values to numeric USD amounts
UPDATE severe_weather
SET damage_crops_usd =
    CASE
        WHEN UPPER(TRIM(damage_crops)) LIKE '%K'
            THEN CAST(REPLACE(UPPER(TRIM(damage_crops)), 'K', '') AS REAL) * 1000
        WHEN UPPER(TRIM(damage_crops)) LIKE '%M'
            THEN CAST(REPLACE(UPPER(TRIM(damage_crops)), 'M', '') AS REAL) * 1000000
        WHEN UPPER(TRIM(damage_crops)) LIKE '%B'
            THEN CAST(REPLACE(UPPER(TRIM(damage_crops)), 'B', '') AS REAL) * 1000000000
        ELSE 0
    END;

-- ================================================
-- STEP 3: Verify cleaning worked correctly
-- ================================================

-- Spot check: original text value alongside new numeric value
-- 250.00K should show as 250000.0
-- 1.50M should show as 1500000.0
SELECT
    damage_property,
    damage_property_usd,
    damage_crops,
    damage_crops_usd
FROM severe_weather
WHERE damage_property_usd > 0
LIMIT 20;

-- ================================================
-- CLEANING NOTES:
-- UPPER() and TRIM() used to handle inconsistent casing
-- and whitespace in raw NOAA data
-- NULL and '0' values default to 0 in the numeric columns
-- Original text columns preserved for reference
-- SQLite REAL type used instead of NUMERIC for compatibility
-- ================================================
