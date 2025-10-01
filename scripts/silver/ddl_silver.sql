/*===========================================================
  Learning Practice: Data Warehouse - Silver Layer DDL
  Source     : Class/Learning material (from teacher , YT :-> DATA WITH BARAA)
  Purpose    : Practice script for creating the Silver Layer tables 
               required for CRM and ERP systems.
               Each table is created in the "silver" schema 
               with consistent naming conventions and includes 
               a metadata column (dwh_create_date).

  Important  : My Bronze Layer DDL script is in another file. 
               Before building this Silver Layer, 
               you must first execute the Bronze Layer 
               creation script successfully.

  Note       : This script is part of my learning journey 
               and not an original project.

  Student    : Subham Adhikari
  Date       : [2025-10-01]
===========================================================*/



------------------------------------------------------------
-- 1. CRM CUSTOMER INFORMATION TABLE
------------------------------------------------------------
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;
GO

CREATE TABLE silver.crm_cust_info (
    cst_id             INT,
    cst_key            NVARCHAR(50),
    cst_firstname      NVARCHAR(50),
    cst_lastname       NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr           NVARCHAR(50),
    cst_create_date    DATE,
    -- Metadata column for data warehouse tracking
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO


------------------------------------------------------------
-- 2. CRM PRODUCT INFORMATION TABLE
------------------------------------------------------------
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
GO

CREATE TABLE silver.crm_prd_info (
    prd_id          INT,
    cat_id          NVARCHAR(50),
    prd_key         NVARCHAR(50),
    prd_nm          NVARCHAR(50),
    prd_cost        INT,
    prd_line        NVARCHAR(50),
    prd_start_dt    DATE,
    prd_end_dt      DATE,
    -- Metadata column for data warehouse tracking
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO


------------------------------------------------------------
-- 3. CRM SALES DETAILS TABLE
------------------------------------------------------------
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
GO

CREATE TABLE silver.crm_sales_details (
    sls_ord_num     NVARCHAR(50),
    sls_prd_key     NVARCHAR(50),
    sls_cust_id     INT,
    sls_order_dt    DATE,
    sls_ship_dt     DATE,
    sls_due_dt      DATE,
    sls_sales       INT,
    sls_quantity    INT,
    sls_price       INT,
    -- Metadata column for data warehouse tracking
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO


------------------------------------------------------------
-- 4. ERP CUSTOMER MASTER (AZ12) TABLE
------------------------------------------------------------
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az12;
GO

CREATE TABLE silver.erp_cust_az12 (
    cid             NVARCHAR(50),
    bdate           DATE,
    gen             NVARCHAR(50),
    -- Metadata column for data warehouse tracking
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO


------------------------------------------------------------
-- 5. ERP LOCATION MASTER (A101) TABLE
------------------------------------------------------------
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;
GO

CREATE TABLE silver.erp_loc_a101 (
    cid             NVARCHAR(50),
    cntry           NVARCHAR(50),
    -- Metadata column for data warehouse tracking
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO


------------------------------------------------------------
-- 6. ERP PRODUCT CATEGORY (G1V2) TABLE
------------------------------------------------------------
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;
GO

CREATE TABLE silver.erp_px_cat_g1v2 (
    id              NVARCHAR(50),
    cat             NVARCHAR(50),
    subct           NVARCHAR(50),
    maintenance     NVARCHAR(50),
    -- Metadata column for data warehouse tracking
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
