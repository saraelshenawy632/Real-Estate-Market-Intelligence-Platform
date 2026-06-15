
create database DWH_Egypt_Business_Location_Intelligence_Platform
-- ============================================================
--  Real Estate & Market Intelligence — DWH Star Schema
--  Star Schema: 1 Fact Table + 6 Dimension Tables
-- ============================================================

-- ------------------------------------------------------------
-- DIMENSION TABLES
-- ------------------------------------------------------------

-- 1. DIM_LOCATION
CREATE TABLE DIM_LOCATION (
    location_key   INT           PRIMARY KEY,
    governorate    VARCHAR(100)  NOT NULL,
    city           VARCHAR(100)  NOT NULL,
    region         VARCHAR(100),
    latitude       DECIMAL(9,6),
    longitude      DECIMAL(9,6)
);

-- 2. DIM_PROPERTY_TYPE
CREATE TABLE DIM_PROPERTY_TYPE (
    property_type_key   INT          PRIMARY KEY,
    property_type       VARCHAR(50)  NOT NULL
    -- Values: Apartment, Shop, Clinic, Villa, Land, Office
);

-- 3. DIM_LISTING_TYPE
CREATE TABLE DIM_LISTING_TYPE (
    listing_type_key   INT          PRIMARY KEY,
    listing_type       VARCHAR(50)  NOT NULL
    -- Values: Rental, Sale, Commercial_Rent
);

-- 4. DIM_PRICE_PERIOD
CREATE TABLE DIM_PRICE_PERIOD (
    price_period_key   INT          PRIMARY KEY,
    price_period       VARCHAR(20)  NOT NULL
    -- Values: monthly, total
);

-- 5. DIM_BUSINESS_TYPE
CREATE TABLE DIM_BUSINESS_TYPE (
    business_type_key   INT          PRIMARY KEY,
    type_name           VARCHAR(100) NOT NULL
    -- Values: Developer, Agency, Broker, Individual
);

-- 6. DIM_DATE
CREATE TABLE DIM_DATE (
    date_key       INT          PRIMARY KEY,
    full_date      DATE         NOT NULL,
    day_num        TINYINT      NOT NULL,
    day_name       VARCHAR(10)  NOT NULL,
    week_num       TINYINT      NOT NULL,
    month_num      TINYINT      NOT NULL,
    month_name     VARCHAR(10)  NOT NULL,
    quarter_num    TINYINT      NOT NULL,
    year_num       SMALLINT     NOT NULL
);

-- ------------------------------------------------------------
-- FACT TABLE
-- ------------------------------------------------------------

CREATE TABLE FACT_MARKET_INTELLIGENCE (

    -- ── Foreign Keys ──────────────────────────────────────────
    location_key        INT  NOT NULL,
    property_type_key   INT  NOT NULL,
    listing_type_key    INT  NOT NULL,
    price_period_key    INT  NOT NULL,
    business_type_key   INT  NOT NULL,
    date_key            INT  NOT NULL,

    -- ── Real Estate Metrics ───────────────────────────────────
    listing_count       INT,
    avg_price_egp       DECIMAL(15,2),
    avg_price_per_sqm   DECIMAL(12,2),
    min_price_egp       DECIMAL(15,2),
    max_price_egp       DECIMAL(15,2),

    -- ── Demographics & Population ─────────────────────────────
    population_total    INT,
    population_male     INT,
    population_female   INT,
    youth_percentage    DECIMAL(5,2),
    avg_monthly_income  DECIMAL(12,2),

    -- ── Competitor Metrics ────────────────────────────────────
    competitor_count    INT,
    avg_rating          DECIMAL(3,2),
    reviews_count       INT,
    price_level_index   DECIMAL(5,2),

    -- ── Cost of Living ────────────────────────────────────────
    avg_cost_egp        DECIMAL(12,2),
    min_cost_egp        DECIMAL(12,2),
    max_cost_egp        DECIMAL(12,2),
    cost_index          DECIMAL(8,4),
    inflation_index     DECIMAL(8,4),

    -- ── Labor & Students ──────────────────────────────────────
    total_students      INT,
    total_labor_force   INT,
    total_employed      INT,
    unemployment_rate   DECIMAL(5,2),

    -- ── Composite Primary Key ─────────────────────────────────
    CONSTRAINT pk_fact PRIMARY KEY (
        location_key,
        property_type_key,
        listing_type_key,
        price_period_key,
        business_type_key,
        date_key
    ),

    -- ── Foreign Key Constraints ───────────────────────────────
    CONSTRAINT fk_fact_location
        FOREIGN KEY (location_key)      REFERENCES DIM_LOCATION(location_key),
    CONSTRAINT fk_fact_property_type
        FOREIGN KEY (property_type_key) REFERENCES DIM_PROPERTY_TYPE(property_type_key),
    CONSTRAINT fk_fact_listing_type
        FOREIGN KEY (listing_type_key)  REFERENCES DIM_LISTING_TYPE(listing_type_key),
    CONSTRAINT fk_fact_price_period
        FOREIGN KEY (price_period_key)  REFERENCES DIM_PRICE_PERIOD(price_period_key),
    CONSTRAINT fk_fact_business_type
        FOREIGN KEY (business_type_key) REFERENCES DIM_BUSINESS_TYPE(business_type_key),
    CONSTRAINT fk_fact_date
        FOREIGN KEY (date_key)          REFERENCES DIM_DATE(date_key)
);

-- ============================================================
--  Grain: One row per
--  Location × Property Type × Listing Type ×
--  Price Period × Business Type × Date
-- ============================================================