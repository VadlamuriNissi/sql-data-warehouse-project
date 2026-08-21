/* 
==================================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===================================================================================================
Script Purpose:
This stored procedure loads data into the 'bronze' schema from external CSV files.
It performs the following actions:
 -Truncates the bronze tables before loading data.
 -Uses the BULK INSERT command to load data from csv Files to bronze tables.

Parameters:
   None.
  This stored procedure does not accept any parameters or return any values.
Usage Example:
 EXEC bronze.load_bronze;
=======================================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze as
BEGIN 
 DECLARE @start_time datetime,@end_time datetime,@batchstart_time datetime,@batchend_time datetime;
BEGIN TRY
       set @batchstart_time = getdate();
       print '===============================';
       print 'loading bronze layer ';
       print '===============================';

       print'--------------------------------';
       print 'loading crm tables';
       print'--------------------------------';

       set @start_time = getdate();
       print'>>truncating table: bronze.crm_cust_info';
       truncate table bronze.crm_cust_info;
       print'>>inserting data into bronze.crm_cust_info';
       bulk insert bronze.crm_cust_info 
       from 'C:\Users\vadla\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
       with
             ( firstrow = 2,
               fieldterminator = ',',
                tablock
                 );
       set @end_time = getdate();
       print 'load duration:'+cast(datediff(second,@start_time,@end_time)AS nvarchar)+'secomds';
       print '>>--------------';

       set @start_time = getdate();
       print'>>truncating table: bronze.crm_prd_info';  
       truncate table bronze.crm_prd_info;
       print'>>inserting data into bronze.crm_prd_info';
       bulk insert bronze.crm_prd_info 
       from 'C:\Users\vadla\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
       with
         ( firstrow = 2,
          fieldterminator = ',',
          tablock
          );
        set @end_time = getdate();
        print 'load duration:'+cast(datediff(second,@start_time,@end_time)AS nvarchar)+'secomds';
        print '>>--------------';

        set @start_time = getdate();
        print'>>truncating table: bronze.crm_sales_details';
        truncate table bronze.crm_sales_details;
        print'>>inserting data into bronze.crm_sales_details';
        bulk insert bronze.crm_sales_details 
        from 'C:\Users\vadla\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
        with
           ( firstrow = 2,
            fieldterminator = ',',
            tablock
            );
        set @end_time = getdate();
        print 'load duration:'+cast(datediff(second,@start_time,@end_time)AS nvarchar)+'secomds';
        print '>>--------------';
               print'--------------------------------';
               print 'loading erp tables';
               print'--------------------------------';
        set @start_time = getdate();
        print'>>truncating table: bronze.erp_CUST_AZ12';
        truncate table bronze.erp_CUST_AZ12;
        print'>>inserting data into bronze.erp_CUST_AZ12';
        bulk insert bronze.erp_CUST_AZ12
        from 'C:\Users\vadla\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
        with
           ( firstrow = 2,
            fieldterminator = ',',
            tablock
            );
        set @end_time = getdate();
        print 'load duration:'+cast(datediff(second,@start_time,@end_time)AS nvarchar)+'secomds';
        print '>>--------------';

        set @start_time = getdate();
        print'>>truncating table: bronze.erp_LOC_A101';
        truncate table bronze.erp_LOC_A101;
        print'>>inserting data into bronze.erp_LOC_A101';
        bulk insert bronze.erp_LOC_A101 
        from 'C:\Users\vadla\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
        with
           ( firstrow = 2,
            fieldterminator = ',',
            tablock
            );
        set @end_time = getdate();
        print 'load duration:'+cast(datediff(second,@start_time,@end_time)AS nvarchar)+'secomds';
        print '>>--------------';

        set @start_time = getdate();
        print'>>truncating table: bronze.erp_PX_CAT_G1V2';
        truncate table bronze.erp_PX_CAT_G1V2;
        print'>>inserting data into bronze.erp_PX_CAT_G1V2';
        bulk insert bronze.erp_PX_CAT_G1V2 
        from 'C:\Users\vadla\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
        with
           ( firstrow = 2,
            fieldterminator = ',',
            tablock
            );
        set @end_time = getdate();
        print 'load duration:'+cast(datediff(second,@start_time,@end_time)AS nvarchar)+'seconds';
        print '>>--------------';
        
        set @batchend_time = getdate();
        print '============================================================================='
        print 'loading silver layer is completed'
        print 'total batch load duration:'+cast(datediff(second,@batch_start_time,@batch_end_time)AS nvarchar)+'secomds';
        print '=============================================================================='
        END TRY
           BEGIN CATCH
           print '================================================================'
           print 'error occured during loading bronze layer'
           print 'error message'+ error_message();
           print 'error message'+ cast(error_number() as nvarchar);
           print 'error message'+ cast(error_state() as nvarchar);
           print '================================================================='
           END CATCH
  END
