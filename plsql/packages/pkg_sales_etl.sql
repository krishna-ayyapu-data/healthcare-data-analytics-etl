/* =====================================================
   Package: PKG_SALES_ETL
===================================================== */

CREATE OR REPLACE PACKAGE pkg_sales_etl AS
    PROCEDURE load_sales_staging;
    PROCEDURE load_sales_fact;
END pkg_sales_etl;
/

CREATE OR REPLACE PACKAGE BODY pkg_sales_etl AS

PROCEDURE load_sales_staging IS
BEGIN
    DELETE FROM sales_staging;

    INSERT INTO sales_staging
    SELECT
        order_id,
        customer_id,
        order_date,
        amount,
        tax,
        status
    FROM sales_source
    WHERE status = 'COMPLETED';

    COMMIT;
END load_sales_staging;

PROCEDURE load_sales_fact IS
BEGIN
    INSERT INTO sales_fact
    SELECT
        order_id,
        customer_id,
        order_date,
        amount,
        tax,
        amount + tax AS total_amount
    FROM sales_staging;

    COMMIT;
END load_sales_fact;

END pkg_sales_etl;
/
