-- ============================================================
--  Real Estate & Market Intelligence — EERD Tables
--  All tables EXCEPT those marked "suggested by AI"
--  (LISTING_TYPE_LOOKUP was suggested by AI → excluded)
-- ============================================================

-- ------------------------------------------------------------
-- 1. LOCATION
-- ------------------------------------------------------------
CREATE TABLE LOCATION (
    Location_ID   INT           PRIMARY KEY,
    Governorate   VARCHAR(100)  NOT NULL,
    City          VARCHAR(100)  NOT NULL,
    Region        VARCHAR(100),
    Latitude      DECIMAL(9,6),
    Longitude     DECIMAL(9,6)
);

-- ------------------------------------------------------------
-- 2. DEMOGRAPHICS
-- ------------------------------------------------------------
CREATE TABLE DEMOGRAPHICS (
    Location_ID        INT            PRIMARY KEY,
    Population_Total   INT,
    Population_Male    INT,
    Population_Female  INT,
    Youth_Percentage   DECIMAL(5,2),
    Avg_Monthly_Income DECIMAL(12,2),
    CONSTRAINT fk_demo_location
        FOREIGN KEY (Location_ID) REFERENCES LOCATION(Location_ID)
);

-- ------------------------------------------------------------
-- 3. UNIVERSITY_STUDENTS
-- ------------------------------------------------------------
CREATE TABLE UNIVERSITY_STUDENTS (
    Uni_Student_ID   INT          PRIMARY KEY,
    Location_ID      INT          NOT NULL,
    University       VARCHAR(200) NOT NULL,
    University_Type  VARCHAR(50),
    Num_Male         INT,
    Num_Female       INT,
    Total_Students   INT,
    CONSTRAINT fk_uni_location
        FOREIGN KEY (Location_ID) REFERENCES LOCATION(Location_ID)
);

-- ------------------------------------------------------------
-- 4. LABOR_FORCE
-- ------------------------------------------------------------
CREATE TABLE LABOR_FORCE (
    Labor_ID         INT  PRIMARY KEY,
    Location_ID      INT  NOT NULL,
    Num_Male         INT,
    Num_Female       INT,
    Total_Labor_Force INT,
    CONSTRAINT fk_labor_location
        FOREIGN KEY (Location_ID) REFERENCES LOCATION(Location_ID)
);

-- ------------------------------------------------------------
-- 5. EMPLOYMENT_BY_INDUSTRY
-- ------------------------------------------------------------
CREATE TABLE EMPLOYMENT_BY_INDUSTRY (
    Employment_ID  INT          PRIMARY KEY,
    Location_ID    INT          NOT NULL,
    Industry       VARCHAR(150) NOT NULL,
    Num_Male       INT,
    Num_Female     INT,
    Total_Employed INT,
    CONSTRAINT fk_emp_location
        FOREIGN KEY (Location_ID) REFERENCES LOCATION(Location_ID)
);

-- ------------------------------------------------------------
-- 6. PROPERTY_TYPE_LOOKUP
-- ------------------------------------------------------------
CREATE TABLE PROPERTY_TYPE_LOOKUP (
    Property_Type  VARCHAR(50)  PRIMARY KEY
    -- Values: Apartment, Shop, Clinic, Villa, Land, Office
);

-- ------------------------------------------------------------
-- 7. PROPERTY
-- ------------------------------------------------------------
CREATE TABLE PROPERTY (
    Property_ID    INT            PRIMARY KEY,
    Location_ID    INT            NOT NULL,
    Property_Type  VARCHAR(50)    NOT NULL,
    Size_sqm       DECIMAL(10,2),
    Latitude       DECIMAL(9,6),
    Longitude      DECIMAL(9,6),
    CONSTRAINT fk_prop_location
        FOREIGN KEY (Location_ID)   REFERENCES LOCATION(Location_ID),
    CONSTRAINT fk_prop_type
        FOREIGN KEY (Property_Type) REFERENCES PROPERTY_TYPE_LOOKUP(Property_Type)
);

-- ------------------------------------------------------------
-- 8. PRICE_PERIOD_LOOKUP
-- ------------------------------------------------------------
CREATE TABLE PRICE_PERIOD_LOOKUP (
    Price_Period  VARCHAR(20)  PRIMARY KEY
    -- Values: monthly, total
);

-- ------------------------------------------------------------
-- 9. LISTING
-- ------------------------------------------------------------
CREATE TABLE LISTING (
    Listing_ID     INT            PRIMARY KEY,
    Property_ID    INT            NOT NULL,
    Listing_Type   VARCHAR(50)    NOT NULL,
    Price_EGP      DECIMAL(15,2),
    Price_Per_Sqm  DECIMAL(12,2),
    Price_Period   VARCHAR(20),
    Title          VARCHAR(255),
    Date_Listed    DATE,
    CONSTRAINT fk_listing_property
        FOREIGN KEY (Property_ID)  REFERENCES PROPERTY(Property_ID),
    CONSTRAINT fk_listing_period
        FOREIGN KEY (Price_Period) REFERENCES PRICE_PERIOD_LOOKUP(Price_Period)
);

-- ------------------------------------------------------------
-- 10. COSTOFLIVING
-- ------------------------------------------------------------
CREATE TABLE COSTOFLIVING (
    Cost_ID       INT            PRIMARY KEY,
    Location_ID   INT            NOT NULL,
    Category      VARCHAR(100),
    Item          VARCHAR(200),
    Avg_Price_EGP DECIMAL(12,2),
    Min_Price_EGP DECIMAL(12,2),
    Max_Price_EGP DECIMAL(12,2),
    CONSTRAINT fk_cost_location
        FOREIGN KEY (Location_ID) REFERENCES LOCATION(Location_ID)
);

-- ------------------------------------------------------------
-- 11. BUSINESSTYPE
-- ------------------------------------------------------------
CREATE TABLE BUSINESSTYPE (
    BusinessType_ID  INT          PRIMARY KEY,
    Type_Name        VARCHAR(100) NOT NULL
);

-- ------------------------------------------------------------
-- 12. COMPETITOR
-- ------------------------------------------------------------
CREATE TABLE COMPETITOR (
    Competitor_ID    INT            PRIMARY KEY,
    Location_ID      INT            NOT NULL,
    Business_Name    VARCHAR(200)   NOT NULL,
    BusinessType_ID  INT,
    Category         VARCHAR(100),
    Rating           DECIMAL(3,2),
    Reviews_Count    INT,
    Price_Level      VARCHAR(20),
    CONSTRAINT fk_comp_location
        FOREIGN KEY (Location_ID)     REFERENCES LOCATION(Location_ID),
    CONSTRAINT fk_comp_bustype
        FOREIGN KEY (BusinessType_ID) REFERENCES BUSINESSTYPE(BusinessType_ID)
);