/*
=================================================================================================================================
DDL Script: Create Bronze Tables
=================================================================================================================================
Script Purpose:
  This script creates tables in the 'bronze' schema, dropping existing bronze tables if they already exisit.
  Run this script to re-define the DDL structure of 'bronze' Tables
=================================================================================================================================
/*

DROP DATABASE IF EXISTS bronze;
CREATE database bronze; 
DROP DATABASE IF EXISTS silver;
CREATE database IF NOT EXISTS silver; 
DROP DATABASE IF EXISTS gold;
CREATE database IF NOT EXISTS gold; 

DELIMITER $$
DROP PROCEDURE IF EXISTS bronze.load_bronze $$
CREATE PROCEDURE bronze.load_bronze()
BEGIN
	DECLARE start_time DATETIME;
    DECLARE end_time DATETIME;
    DECLARE batch_start_time DATETIME;
    DECLARE batch_end_time DATETIME;
    
		SELECT '====================' AS message;
		SELECT 'Create Bronze Table' AS message;
		SELECT '====================' AS message;

		DROP TABLE IF EXISTS bronze.crm_cust_info;
		CREATE table bronze.crm_cust_info(
		cst_id INT,
		cst_key NVARCHAR(50),
		cst_firstname NVARCHAR(50),
		cst_lastname NVARCHAR(50),
		cst_marital_status NVARCHAR(50),
		cst_gndr NVARCHAR(50),
		cst_create_date DATE
		);

		DROP TABLE IF EXISTS bronze.crm_prd_info;
		CREATE table bronze.crm_prd_info(
		prd_id INT,
		prd_key NVARCHAR(50),
		prd_nm NVARCHAR(50),
		prd_cost INT,
		prd_line NVARCHAR(50),
		prd_start_dt DATE,
		prd_end_dt DATE
		);

		DROP TABLE IF EXISTS bronze.crm_sales_details;
		CREATE table bronze.crm_sales_details(
		sls_ord_num VARCHAR(50),
		sls_prd_key NVARCHAR(50),
		sls_cust_id INT,
		sls_order_dt INT,
		sls_ship_dt INT,
		sls_due_dt INT,
		sls_sales INT,
		sls_quantity INT,
		sls_price INT
		);

		DROP TABLE IF EXISTS bronze.erp_cust_az12;
		CREATE table bronze.erp_cust_az12(
		CID VARCHAR(50),
		BDATE DATE,
		GEN VARCHAR(50)
		);

		DROP TABLE IF EXISTS bronze.erp_loc_a101;
		CREATE table bronze.erp_loc_a101(
		CID VARCHAR(50),
		CNTRY VARCHAR(50)
		);

		DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;
		CREATE table bronze.erp_px_cat_g1v2(
		ID VARCHAR(50),
		CAT VARCHAR(50),
		SUBCAT VARCHAR(50),
		MAINTENANCE VARCHAR(50)
		);

END $$
DELIMITER ;

Call bronze.load_bronze();

SELECT '------------------' AS message;
SELECT 'Loading CRM Tables' AS message;
SELECT '------------------' AS message;

SELECT '>>Inserting Table:bronze.crm_cust_info' AS message;
SET @start_time = NOW();
set @batch_start_time=now();
LOAD DATA LOCAL INFILE '/Users/chensang/Downloads/sql-data-warehouse-project-2/datasets/source_crm/cust_info.csv'
INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS message;
SELECT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'AS message;

SELECT '>>Inserting Table:bronze.crm_prd_info' AS message;
SET @start_time = NOW();
LOAD DATA LOCAL INFILE '/Users/chensang/Downloads/sql-data-warehouse-project-2/datasets/source_crm/prd_info.csv'
INTO TABLE bronze.crm_prd_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('>>Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time),' seconds') AS message;



SELECT '>>Inserting Table:bronze.crm_sales_details' AS message;
SET @start_time=NOW();
LOAD DATA LOCAL INFILE '/Users/chensang/Downloads/sql-data-warehouse-project-2/datasets/source_crm/sales_details.csv'
INTO TABLE bronze.crm_sales_details
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time=NOW();
SELECT CONCAT('>>Load Duration: ',TIMESTAMPDIFF(Second,@start_time,@end_time),' seconds') AS message;

SELECT '------------------' AS message;
SELECT 'Loading ERP Tables' AS message;
SELECT '------------------' AS message;

SELECT '>>Inserting Table:bronze.erp_cust_az12' AS message;
SET @start_time=NOW();
LOAD DATA LOCAL INFILE '/Users/chensang/Downloads/sql-data-warehouse-project-2/datasets/source_erp/cust_az12.csv'
INTO TABLE bronze.erp_cust_az12
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time=NOW();
SELECT concat('>>Load Duration: ',timestampdiff(second,@start_time,@end_time), ' seconds')AS message;

SELECT '>>Inserting Table:bronze.erp_loc_a101' AS message;
SET @start_time=now();
LOAD DATA LOCAL INFILE '/Users/chensang/Downloads/sql-data-warehouse-project-2/datasets/source_erp/loc_a101.csv'
INTO TABLE bronze.erp_loc_a101
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
set @end_time=now();
select concat('>>Load Duration: ',timestampdiff(second,@start_time,@end_time) , ' seconds')as message;

SELECT '>>Inserting Table:bronze.erp_px_cat_g1v2' AS message;
set @start_time=now();
LOAD DATA LOCAL INFILE '/Users/chensang/Downloads/sql-data-warehouse-project-2/datasets/source_erp/px_cat_g1v2.csv'
INTO TABLE bronze.erp_px_cat_g1v2
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
set @end_time=now();
set @batch_end_time=now();
select concat('>>Load Duration: ',timestampdiff(second,@start_time,@end_time),' seconds')as message;
select concat(' - Total Load Duration: ',timestampdiff(second,@batch_start_time,@batch_end_time) , ' seconds')as message;

