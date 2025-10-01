/*
===============================================================================
Quality Checks - Silver Layer
===============================================================================
Script Purpose:
    Automated data quality checks for the Silver Layer tables after ETL. 
    Ensures data consistency, accuracy, standardization, and proper relationships.
===============================================================================
*/

-- ====================================================================
-- 1. silver.crm_cust_info :-> Ensure customer data has no duplicates, nulls, 
--    or unwanted spaces, and standardized gender/marital status
-- ====================================================================
SELECT cst_id, COUNT(*) 
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

SELECT cst_key 
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

SELECT DISTINCT cst_marital_status 
FROM silver.crm_cust_info;

-- ====================================================================
-- 2. silver.crm_prd_info :-> Ensure product data has valid IDs, names, cost, 
--    standardized product lines, and correct date ranges
-- ====================================================================
SELECT prd_id, COUNT(*) 
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

SELECT prd_nm 
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

SELECT prd_cost 
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

SELECT DISTINCT prd_line 
FROM silver.crm_prd_info;

SELECT * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ====================================================================
-- 3. silver.crm_sales_details :-> Ensure sales data has valid dates and 
--    correct sales = quantity * price
-- ====================================================================
SELECT NULLIF(sls_due_dt, 0) AS sls_due_dt 
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
    OR LEN(sls_due_dt) != 8 
    OR sls_due_dt > 20500101 
    OR sls_due_dt < 19000101;

SELECT * 
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

SELECT DISTINCT sls_sales, sls_quantity, sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- ====================================================================
-- 4. silver.erp_cust_az12 :-> Ensure ERP customer data has valid birthdates 
--    and standardized gender
-- ====================================================================
SELECT DISTINCT bdate 
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' 
   OR bdate > GETDATE();

SELECT DISTINCT gen 
FROM silver.erp_cust_az12;

-- ====================================================================
-- 5. silver.erp_loc_a101 :-> Ensure location data has standardized country names
-- ====================================================================
SELECT DISTINCT cntry 
FROM silver.erp_loc_a101
ORDER BY cntry;

-- ====================================================================
-- 6. silver.erp_px_cat_g1v2 :-> Ensure product category data has no unwanted 
--    spaces and standardized maintenance values
-- ====================================================================
SELECT * 
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subct != TRIM(subct) 
   OR maintenance != TRIM(maintenance);

SELECT DISTINCT maintenance 
FROM silver.erp_px_cat_g1v2;
