/*
=======================================




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

