# -- THIS IS A SIMPLE MANUAL ETL PROCESS USING SHELL SCRIPTING -- #
#!/bin/bash

echo "--------------------------------------------------------"
echo "- ETL PROCESS STARTED SIT DOWN AND LET US DO OUR MAGIC -"
echo "--        THIS SCRIPT DEVELOPED BY TWEETYX            --"
echo "--------------------------------------------------------"
echo " "
echo " "
echo "--              TASKS TABLE            --"
echo "- 1 - CREATE THE DATA WEREHOUSE IN HIVE -"
echo "- 2 - STAGING THE DATA IN POSTGRESQL DB -"
echo "- 3 - EXTRACTING PHASE                  -"
echo "- 4 - TRANSFORMING PHASE                -"
echo "- 5 - LOADING PHASE                     -"
echo "-----------------------------------------"
echo " "
echo " "
dwh_date_s=$(date)
echo "-- CREATING THE DATA WEREHOUSE STARTED AT $dwh_date_s"

hive -f supermarketHiveDB.hql;

dwh_date_e=$(date)
echo "-- CREATING THE DATA WEREHOUSE ENDED AT $dwh_date_e"
echo " "
echo " "
staging_date_s=$(date)
echo "-- STAGING THE DATA IN POSTGRESQL DB STARTED AT $staging_date_s"

psql -U tati -d supermarket -a -f staging.sql

staging_date_e=$(date)
echo "-- STAGING THE DATA IN POSTGRESQL DB ENDED AT $staging_date_e"
echo " "
echo " "
extract_start_date=$(date)
echo "-- EXTRACT PHASE STARTED AT $extract_start_date"

psql -U tati -d supermarket -a -f extract.sql

extract_end_date=$(date)
echo "-- EXTRACT PHASE STARTED AT $extract_end_date"
echo " "
echo " "
tr_start_date=$(date)
echo "-- TRANSFORM PHASE STARTED AT $tr_start_date"

psql -U tati -d supermarket -a -f transform.sql

extract_end_date=$(date)
echo "-- TRANSFORM PHASE ENDED AT $extract_end_date"
echo " "
echo " "
load_date_s=$(date)
echo "-- LOAD PHASE STARTED AT $load_date_s"

hive -f load.hql;

load_date_e=$(date)
echo "-- LOAD PHASE ENDED AT $load_date_e"
echo " "
echo " "
etl_end=$(date)
echo "- ETL PROCESS END AT $etl_end" 
echo ""
echo ""
echo "-- Hadoop work!"
hadoop_start=$(date)
echo "-- Loading the backup data into the HDFS - Started at $hadoop_start"
hadoop fs -put /home/tati/Supermarket-DWH-Backup/* /Supermarket-data/Supermarket-DWH-Backup
hadoop_end=$(date)
echo "-- Loading the backup data into the HDFS - Ended at $hadoop_end"
echo " "
echo " "
echo "- The data warehouse:"
hadoop fs -ls -R /user/hive/warehouse
echo " "
echo " "
echo "- The Backup data:"
hadoop fs -ls -R /Supermarket-data/Supermarket-DWH-Backup
echo " "
echo "By TATI."
