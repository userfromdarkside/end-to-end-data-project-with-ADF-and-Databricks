create MASTER KEY ENCRYPTION BY PASSWORD = 'Masterkey@123';

CREATE DATABASE SCOPED CREDENTIAL minh_phan
with IDENTITY = 'Managed Identity';


CREATE EXTERNAL DATA SOURCE silver_source
WITH ( 
    LOCATION = 'https://gitdatalake292.blob.core.windows.net/silver',
    CREDENTIAL = minh_phan
);

CREATE EXTERNAL DATA SOURCE gold_source
WITH (
    LOCATION = 'https://gitdatalake292.blob.core.windows.net/gold',
    CREDENTIAL = minh_phan
);

CREATE EXTERNAL FILE FORMAT parquet
WITH (
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
);


--create some externals tables and save into the gold container

CREATE EXTERNAL TABLE gold.tbsales15
WITH (
    LOCATION = 'tbsales15',
    DATA_SOURCE = gold_source,
    FILE_FORMAT = PARQUET
) as SELECT OrderDate, OrderNumber, ProductKey, OrderQuantity from gold.sales15;

CREATE EXTERNAL TABLE gold.Customers2017
WITH(
    LOCATION = 'Customers2017',
    DATA_SOURCE = gold_source,
    FILE_FORMAT = PARQUET
)
as 
select s.OrderDate, s.stockdate, s.ordernumber,
s.ProductKey, s.customerkey, s.territorykey,
s.orderlineitem, s.orderquantity 
from gold.sales17 s
LEFT JOIN gold.customer c
on c.CustomerKey = s.CustomerKey;









