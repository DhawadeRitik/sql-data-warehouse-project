
/*
============================================================================================================================
Create Database and Schemas
============================================================================================================================
Script Purpose :
  This script creates a new database names 'DataWarehouse' after checking if it already exists.
  If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
  within the database: 'bronze', 'silver', and 'gold'.

WARNING :
  Running this script will drop the entire 'Datawarehouse' database if it exists.
A;l data in the database will be permanently deleted. Proceed with caution
and ensure you have proper backups before running this script.
*/ 


USE master ;

-- Drop and recente the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN 
	ALTER DATABASE DataWarehouseSET SINGLE_USER WITH ROLLBACK IMMEDIATE ;
	DROP DATABASE DataWarehouse ;
END ;
GO

-- Create Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

-- Use Database DataWarehouse 
USE DataWarehouse ;

-- Create Schema 
-- Bronze Schema 
CREATE SCHEMA bronze ;
GO
-- Silver Schema 
CREATE SCHEMA silver ;
GO
-- Gold Schema 
CREATE SCHEMA gold ;
GO 
