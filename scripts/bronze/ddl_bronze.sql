/*
-- ===========================================================================
DDL Script : Create Bronze Tables 
-- ===========================================================================
Script Purpose : 
This script creates tables in the 'bronze', schema, dropping existing tables
if they already exist.
Run this scripts to re-drfine teh DDL structure of 'bronze' Tables.
-- ============================================================================
*/ 



-- Drop and recente the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN 
	ALTER DATABASE DataWarehouseSET SINGLE_USER WITH ROLLBACK IMMEDIATE ;
	DROP DATABASE DataWarehouse ;
END ;
GO


  
USE master ;
-- Create Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;

USE DataWarehouse ;

-- =============================================
-- Create Schema 
-- =============================================
-- Bronze Schema
CREATE SCHEMA bronze ;
GO
-- Silver Schema 
CREATE SCHEMA silver ;
GO
  
-- Gold Schema 
CREATE SCHEMA gold ;
GO 

-- ============================================================================================================================
-- Build Bronze Layer 
-- ============================================================================================================================

/*
	Before building the bronze layer 
	   Understand the Business Context & Owership 
	   1. Who owns the Data 
	   2. What Business Process it supports?
	   3. System & Data documentation
	   4. Data Model & Data Catalog

	   Architecture & tEchnology Stack
	   1. How is data stored.
	   (SQL Srver, Oracle, AWS, Azure,..)
	   2. What are the integration capabilities?
	   (API, Kafka,File Extract, Direct DB,....)

	   Extract & Load
	   1. Incremental vs Full Load ?
	   2. Data Scope & Historical needs ?
	   3. What is the expected size of the extracts?
	   4. Are they any data volume limitations ?
	   5. How to avoid impacting the source 
*/
-- ===================================================================
-- For CRM 
-- ===================================================================
  
-- Customer info Table 

-- Drop the table if exist and then create  new table
IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL 
	DROP TABLE  bronze.crm_cust_info ;
CREATE TABLE bronze.crm_cust_info (
	cst_id INT ,
	cst_key NVARCHAR(50) ,
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
) ;

-- Product Table 
IF OBJECT_ID ('bronze.crm_prd_info ', 'U') IS NOT NULL 
	DROP TABLE  bronze.crm_prd_info  ;
CREATE TABLE bronze.crm_prd_info
(
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(100),
    prd_cost DECIMAL(10,2),
    prd_line NVARCHAR(50),
    prd_start_dt NVARCHAR(20),
    prd_end_dt NVARCHAR(20)
);

-- Sales_Details 
CREATE TABLE bronze.crm_sales_details (
	sls_ordnum NVARCHAR(50), 
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT , 
	sls_order_dt INT ,
	sls_ship_dt INT, 
	sls_due_dt INT , 
	sls_sales INT , 
	sls_quantity INT , 
	sls_price INT 
) ;



-- ===================================================================
--  For ERP
-- ===================================================================

-- cust_az12
CREATE TABLE bronze.erp_cust_az12 (
	cid NVARCHAR(50), 
	bdate DATE ,
	gen NVARCHAR(50)
) ;

-- px_cat_g1v2
CREATE TABLE bronze.erp_px_cat_g1v2 (
	id			NVARCHAR(50),
	cat			NVARCHAR(50),
	subcat		NVARCHAR(50), 
	maintenance NVARCHAR(50)
) ;

-- loc_a101
CREATE TABLE bronze.erp_loc_a101 (
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
) ;


