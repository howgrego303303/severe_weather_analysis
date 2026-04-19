-- ================================================
-- Severe Weather Analysis
-- Author: Gregory Howell
-- Date: April 2026
-- ================================================

-- TABLE CREATION NOTE:
-- The severe_weather table was created automatically by importing
-- CSV files through DataGrip's CSV import wizard connected to SQLite.
-- The schema below reflects the resulting table structure and is
-- documented here for reference and reproducibility.

-- To recreate this table manually in PostgreSQL or another
-- database engine, run the CREATE TABLE statement below
-- followed by the data cleaning script (02_data_cleaning.sql)

-- DATA SOURCE:
-- NOAA National Centers for Environmental Information (NCEI)
-- Storm Events Database - Details Files (2000-2025)
-- https://www.ncei.noaa.gov/pub/data/swdi/stormevents/csvfiles/

-- IMPORT PROCESS:
-- 1. Downloaded individual yearly CSV files from NOAA
-- 2. Connected SQLite database in DataGrip
-- 3. Imported each CSV file using DataGrip's CSV import wizard
-- 4. Appended each year to the same severe_weather table
-- 5. Total records imported: approximately 150,000+ rows
-- 6. Years covered: 2000-2025

CREATE TABLE severe_weather (
    begin_yearmonth     INT,
    begin_day           INT,
    begin_time          VARCHAR(10),
    end_yearmonth       INT,
    end_day             INT,
    end_time            VARCHAR(10),
    episode_id          BIGINT,
    event_id            BIGINT PRIMARY KEY,
    state               VARCHAR(50),
    state_fips          INT,
    year                INT,
    month_name          VARCHAR(20),
    event_type          VARCHAR(100),
    cz_type             CHAR(1),
    cz_fips             INT,
    cz_name             VARCHAR(100),
    wfo                 VARCHAR(10),
    cz_timezone         VARCHAR(20),
    injuries_direct     INT,
    injuries_indirect   INT,
    deaths_direct       INT,
    deaths_indirect     INT,
    damage_property     VARCHAR(20),
    damage_crops        VARCHAR(20),
    source              VARCHAR(100),
    magnitude           NUMERIC(8,2),
    magnitude_type      VARCHAR(10),
    flood_cause         VARCHAR(100),
    category            VARCHAR(20),
    tor_f_scale         VARCHAR(10),
    tor_length          NUMERIC(8,2),
    tor_width           INT,
    tor_other_wfo       VARCHAR(10),
    tor_other_cz_state  VARCHAR(5),
    tor_other_cz_fips   INT,
    tor_other_cz_name   VARCHAR(100),
    begin_range         NUMERIC(8,2),
    begin_azimuth       VARCHAR(5),
    begin_location      VARCHAR(100),
    end_range           NUMERIC(8,2),
    end_azimuth         VARCHAR(5),
    end_location        VARCHAR(100),
    begin_lat           NUMERIC(9,4),
    begin_lon           NUMERIC(9,4),
    end_lat             NUMERIC(9,4),
    end_lon             NUMERIC(9,4),
    episode_narrative   TEXT,
    event_narrative     TEXT,
    data_source         VARCHAR(20)
);
