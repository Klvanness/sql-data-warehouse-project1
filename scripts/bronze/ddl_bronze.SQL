/*
=================================================================================================================================
DDL Script: Create Bronze Tables
=================================================================================================================================
Script Purpose:
  -This script creates tables in the 'bronze' schema, dropping existing bronze tables if they already exisit.
  -Run this script to re-define the DDL structure of 'bronze' Tables.
  -Store this as loading bronze procedure.
Parameters:
	None.
	This stored procedure does not accept any parameters or return any values.
Usage example:
	Call bronze.load_bronze();
=================================================================================================================================
/*

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
