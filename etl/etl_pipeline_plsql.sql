/* ----------------------------------------------------
   PL/SQL ETL Pipeline for Healthcare Data
---------------------------------------------------- */

CREATE OR REPLACE PROCEDURE load_healthcare_data AS
    v_total_records NUMBER := 0;
    v_error_message VARCHAR2(4000);
BEGIN
    -- Step 1: Clean staging table
    DELETE FROM healthcare_staging;

    -- Step 2: Load data into staging
    INSERT INTO healthcare_staging (
        patient_id,
        visit_id,
        department,
        visit_date,
        diagnosis_code
    )
    SELECT
        patient_id,
        visit_id,
        department,
        visit_date,
        diagnosis_code
    FROM healthcare_source
    WHERE visit_date IS NOT NULL;

    v_total_records := SQL%ROWCOUNT;

    -- Step 3: Validate data
    DELETE FROM healthcare_staging
    WHERE patient_id IS NULL
       OR visit_id IS NULL;

    -- Step 4: Load into target table
    INSERT INTO healthcare_fact
    SELECT * FROM healthcare_staging;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('ETL Completed Successfully');
    DBMS_OUTPUT.PUT_LINE('Records Loaded: ' || v_total_records);

EXCEPTION
    WHEN OTHERS THEN
        v_error_message := SQLERRM;
        ROLLBACK;

        INSERT INTO etl_error_log (
            error_date,
            error_message
        )
        VALUES (SYSDATE, v_error_message);

        COMMIT;
END;
/
