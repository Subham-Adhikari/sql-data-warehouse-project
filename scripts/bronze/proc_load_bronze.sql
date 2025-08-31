/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/





-- developing the sql load scripts ,
-- open files in notepad to see the delimeters
-- ALSO ADD PRINT AT THE LAST WHEN ALL ARE DONE
-- ALSO handle the error (try.....catch)
-- HERE WE USED DATETIME ALWAYS , BUT USE DATETIME2 WHEN YOU CREATE FROM STARTING AGAIN.

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

    DECLARE @start_time DATETIME , @end_time DATETIME , 
            @batch_start_time DATETIME , @batch_end_time DATETIME

    BEGIN TRY
        
        SET @batch_start_time  = GETDATE() ;

        PRINT '<======================>' ;
        PRINT 'Loading the bronze layer' ;
        PRINT '<======================>' ;

        -- ===============================================
        -- STEP 1: Truncate the target table
        -- Clear all existing data to prepare for a fresh bulk load
        -- ===============================================

        PRINT '<-------------------->' ;
        PRINT 'Loading the crm tables'   ;
        PRINT '<-------------------->' ;


        SET @start_time = GETDATE() ;

        PRINT '>> Truncating the table bronze.crm_cust_info' ;

        TRUNCATE TABLE bronze.crm_cust_info;

        -- ===============================================
        -- STEP 2: Bulk insert data from CSV file into SQL Server
        -- ===============================================

        PRINT '>> Inserting the data into table bronze.crm_cust_info' ;

        BULK INSERT bronze.crm_cust_info
        FROM 'D:\a_my_all_sql_commands_sql_files\aa_sql_Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,            
            -- Skip the header row in CSV (first row contains column names)
            FIELDTERMINATOR = ',',    
            -- Columns are separated by commas
            -- always check this in notepad before doing bulk insert
            TABLOCK                  
            -- Lock the entire table during bulk insert to improve performance
            -- TABLOCK reduces logging overhead and speeds up large data loads
        );

        SET @end_time = GETDATE() ;
        PRINT 'Load duration : ' + CAST (DATEDIFF(SECOND , @start_time , @end_time) 
               AS NVARCHAR) + 'seconds' ;
        PRINT '>> ---------' ;

        -- ===============================================
        -- STEP 3: Verify the data
        -- Always check a few rows to ensure data matches the source CSV
        -- ===============================================
        --SELECT * 
        --FROM bronze.crm_cust_info;



        -- now do the same for every table you create ,

        SET @start_time = GETDATE() ;

        PRINT '>> Truncating the table bronze.crm_prd_info' ;

        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Inserting the data into table bronze.crm_prd_info' ;

        BULK INSERT bronze.crm_prd_info
        FROM 'D:\a_my_all_sql_commands_sql_files\aa_sql_Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',    
            TABLOCK                  
        );

        SET @end_time = GETDATE() ;
        PRINT 'Load duration : ' + CAST (DATEDIFF(SECOND , @start_time , @end_time) 
               AS NVARCHAR) + 'seconds' ;
        PRINT '>> ---------' ;
        --SELECT * 
        --FROM bronze.crm_prd_info;





        SET @start_time = GETDATE() ;

        PRINT '>> Truncating the table bronze.crm_sales_details' ;

        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting the data into table bronze.crm_sales_details' ;

        BULK INSERT bronze.crm_sales_details
        FROM 'D:\a_my_all_sql_commands_sql_files\aa_sql_Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',    
            TABLOCK                  
        );

        SET @end_time = GETDATE() ;
        PRINT 'Load duration : ' + CAST (DATEDIFF(SECOND , @start_time , @end_time) 
               AS NVARCHAR) + 'seconds' ;
        PRINT '>> ---------' ;
        --SELECT * 
        --FROM bronze.crm_sales_details
        --ORDER BY sls_ord_num 






        PRINT '<-------------------->' ;
        PRINT 'Loading the erp tables'   ;
        PRINT '<-------------------->' ;


        SET @start_time = GETDATE() ;

        PRINT '>> Truncating the table bronze.erp_cust_az12' ;

        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> Inserting the data into table bronze.erp_cust_az12' ;

        BULK INSERT bronze.erp_cust_az12
        FROM 'D:\a_my_all_sql_commands_sql_files\aa_sql_Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            TABLOCK                  
        );

        SET @end_time = GETDATE() ;
        PRINT 'Load duration : ' + CAST (DATEDIFF(SECOND , @start_time , @end_time) 
               AS NVARCHAR) + 'seconds' ;
        PRINT '>> ---------' ;
        --SELECT * 
        --FROM bronze.erp_cust_az12



        SET @start_time = GETDATE() ;

        PRINT '>> Truncating the table bronze.erp_loc_a101' ;

        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> Inserting the data into table bronze.erp_loc_a101' ;

        BULK INSERT bronze.erp_loc_a101
        FROM 'D:\a_my_all_sql_commands_sql_files\aa_sql_Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            TABLOCK                  
        );

        SET @end_time = GETDATE() ;
        PRINT 'Load duration : ' + CAST (DATEDIFF(SECOND , @start_time , @end_time) 
               AS NVARCHAR) + 'seconds' ;
        PRINT '>> ---------' ;
        --SELECT * 
        --FROM bronze.erp_loc_a101





        SET @start_time = GETDATE() ;

        PRINT '>> Truncating the table bronze.erp_px_cat_g1v2' ;

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> Inserting the data into table bronze.erp_px_cat_g1v2' ;

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'D:\a_my_all_sql_commands_sql_files\aa_sql_Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            TABLOCK                  
        );

        SET @end_time = GETDATE() ;
        PRINT 'Load duration : ' + CAST (DATEDIFF(SECOND , @start_time , @end_time) 
               AS NVARCHAR) + 'seconds' ;
        PRINT '>> ---------' ;
        --SELECT *
        --FROM bronze.erp_px_cat_g1v2



        SET @batch_end_time  = GETDATE() ;
        PRINT '===========================' ;
        PRINT 'Loading bronze layer is completed' ;
        PRINT 'Total load duration : ' +  
               CAST(DATEDIFF(SECOND ,@batch_start_time, @batch_end_time) AS NVARCHAR) +
               ' seconds' ;
        PRINT '===========================' ;



    END TRY

    BEGIN CATCH
        
        PRINT '<------------------------------------------>' ;
        PRINT 'Error occured while loading the bronze layer' ;
        PRINT 'Error message ' + ERROR_MESSAGE() ;
        PRINT 'Error message ' + CAST (ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error message ' + CAST (ERROR_STATE() AS NVARCHAR);
        PRINT '<------------------------------------------>' ;


    END CATCH


END


-- TRY THE LOAD PROCEDURE YOU CREATED 
EXEC bronze.load_bronze
