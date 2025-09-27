

-- create a schema called gold

create schema gold;


-- create some views so I can do join queries or whatever later

create view gold.calendar
    as select * FROM
    OPENROWSET
    (
        BULK 'https://gitdatalake292.blob.core.windows.net/silver/Calendar/',
        FORMAT = 'parquet'
    ) as query1;


create view gold.customer
    as select * FROM
    OPENROWSET
    (
        BULK 'https://gitdatalake292.blob.core.windows.net/silver/Customer/',
        FORMAT = 'parquet'
    ) as query1;

create view gold.product
    as select * FROM
    OPENROWSET
    (
        BULK 'https://gitdatalake292.blob.core.windows.net/silver/Product/',
        FORMAT = 'parquet'
    ) as query1;


create view gold.returnn
    as select * FROM
    OPENROWSET
    (
        BULK 'https://gitdatalake292.blob.core.windows.net/silver/Returns/',
        FORMAT = 'parquet'
    ) as query1;

create view gold.sales15
    as select * FROM
    OPENROWSET
    (
        BULK 'https://gitdatalake292.blob.core.windows.net/silver/Sales2015/',
        FORMAT = 'parquet'
    ) as query1;

create view gold.sales16
    as select * FROM
    OPENROWSET
    (
        BULK 'https://gitdatalake292.blob.core.windows.net/silver/Sales2016/',
        FORMAT = 'parquet'
    ) as query1;

create view gold.sales17
    as select * FROM
    OPENROWSET
    (
        BULK 'https://gitdatalake292.blob.core.windows.net/silver/Sales2017/',
        FORMAT = 'parquet'
    ) as query1;

create view gold.territories
    as select * FROM
    OPENROWSET
    (
        BULK 'https://gitdatalake292.blob.core.windows.net/silver/Territories/',
        FORMAT = 'parquet'
    ) as query1;




--