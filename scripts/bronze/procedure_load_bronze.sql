/*
===============================================================================
Stored Procedure : Load Bronze Layer (Source --> Bronze)
===============================================================================
Script Purpose :
  This stored procedure loads data into the 'bronze' schema from external CSV files.
It performs the following actions :
 -- TRUNCATE the bronze tables before loading data.
 -- Uses the 'BULK INSERT' command to load data from CSV files to bronze tables.

Parameters :
  None.
This Stored Procedure does not accept any parameters or return any values.

Usage Example :
  EXEC bronze.load_bronze ;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
	DECLARE @start_time DATETIME , @end_time DATETIME, @batch_start_time DATETIME,  @end_batch_time DATETIME  ;

	BEGIN TRY 
		SET @batch_start_time = GETDATE()
		PRINT '========================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '========================================================';

		PRINT '--------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------------------------';
	 
		PRINT '>> Truncating Table : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info ;

		SET @start_time = GETDATE();
		PRINT 'Inserting Data Into : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info 
		FROM 'D:\Resume Project\SQL Learning With Barra\Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv' 
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration For Table bronze.crm_cust_info : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '------------------------------------------------------------';

		PRINT '>> Truncating Table : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info ;

		SET @start_time = GETDATE();
		PRINT 'Inserting Data Into : bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info 
		FROM 'D:\Resume Project\SQL Learning With Barra\Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration For Table bronze.crm_prd_info : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '------------------------------------------------------------';


		PRINT '>> Truncating Table : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details ;

		SET @start_time = GETDATE();
		PRINT 'Inserting Data Into : bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Resume Project\SQL Learning With Barra\Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration For Table bronze.crm_sales_details : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '------------------------------------------------------------';


		PRINT '--------------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '--------------------------------------------------------';
	
		PRINT '>> Truncating Table : bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12 ;

		SET @start_time = GETDATE();
		PRINT 'Inserting Data Into : bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Resume Project\SQL Learning With Barra\Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration For Table bronze.erp_cust_az12 : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '------------------------------------------------------------';


		PRINT '>> Truncating Table : bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		SET @start_time = GETDATE();
		PRINT 'Inserting Data Into : bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Resume Project\SQL Learning With Barra\Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration For Table bronze.erp_px_cat_g1v2 : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '------------------------------------------------------------';


		PRINT '>> Truncating Table : bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101 ;

		SET @start_time = GETDATE();
		PRINT 'Inserting Data Into : bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Resume Project\SQL Learning With Barra\Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration For Table bronze.erp_loc_a101 : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '------------------------------------------------------------';
		SET @end_batch_time = GETDATE();
		PRINT '======================================================='
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '- Total Load Duration : ' + CAST(DATEDIFF(SECOND, @batch_start_time, @end_batch_time) AS NVARCHAR);
		PRINT '======================================================='
	END TRY 

	BEGIN CATCH 

		PRINT '======================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message : ' + ERROR_MESSAGE();
		PRINT 'Error Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State : ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '======================================================';

	END CATCH 

END;
GO

-- EXECUTE Stored Procedure 
EXEC bronze.load_bronze;


