/*
===============================================================================
 Script Name   : Create Data Warehouse and Schemas
 Author        : Subham Adhikari
 Created On    : 2025-08-27

 Script Purpose:
   - Set up a fresh "DataWarehouse" database environment
   - Drop the existing "DataWarehouse" database if it already exists
   - Recreate the "DataWarehouse" database from scratch
   - Create base schemas (bronze, silver, gold) to organize tables/views
   - Provide a structured starting point for Data Warehouse projects

 Warning:
   - ⚠️ Running this script will DROP the existing "DataWarehouse" database.
   - All data inside the old "DataWarehouse" database will be permanently lost.
   - Recommended for development / testing environments only.
   - Always BACKUP your database before running in production.

 Notes:
   - The "master" database must be used before creating a new database.
   - "GO" is a batch separator in SQL Server Management Studio (SSMS).
   - Schemas act like folders to logically group database objects 
     (tables, views, stored procedures, etc.).
===============================================================================
*/




-- Create Database ( Data Warehouse )
-- first switch to master DB
/*
Why we switch to the master database before creating a new database ?

The master database keeps track of all databases on the SQL Server instance. 
When you create a new database, SQL Server needs to update the system metadata,
which is stored in master. So, your CREATE DATABASE command must be executed 
while you are connected to the master database, not inside another user database.
*/
USE master;
GO



-- CHECK THE EXISTENCE IF ALREADY THE DB EXISTS , THEN WHAT TO DO
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE ;
	DROP DATABASE DataWarehouse ;
END;
GO


-- Then create a new Database
CREATE DATABASE DataWarehouse;
GO


-- Then switch to the new Database you just created 
USE DataWarehouse;
GO



-- NOW we are going to build stuff inside the data warehouse
-- Let's start creating 'schemas' first ( bronze , silver , gold )
-- where you can find schema ?
--> 
/* Schemas are like folders or containers that help keep things organized.
   They act as a blueprint for the database and group related tables, views,
   and other objects together. */


CREATE SCHEMA bronze;
GO                          -- go is basically is a separator , it tells completely execute the first command then the next command .
CREATE SCHEMA silver;
GO 
CREATE SCHEMA gold;
