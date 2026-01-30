/* =====================================================
   Sales ETL Orchestration Procedure
===================================================== */

CREATE OR REPLACE PROCEDURE load_sales_data IS
BEGIN
    pkg_sales_etl.load_sales_staging;
    pkg_sales_etl.load_sales_fact;

    DBMS_OUTPUT.PUT_LINE('Sales data loaded successfully');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/
