/*
=====================================
Create database and schemas
=====================================
Script purpose:
  This script creates a new database named 'Datawarehouse' after checking if it already exists.
  If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas within the database:
  'bronze','silver', and 'gold'.

Warning:
  Running this script will drop the entire 'Datawarehouse' database if it exists.
  All data in the database will be permanently deleted. Proceed with caution
  and ensure you havde proper backups before running this script.
  */

USE datawarehouse;
CREATE database bronze; 
CREATE database silver; 
CREATE database gold; 
