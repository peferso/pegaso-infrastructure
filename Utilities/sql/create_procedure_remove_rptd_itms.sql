-- Procedimiento para eliminar items duplicados

USE pegaso_db;

DROP PROCEDURE IF EXISTS remove_repeated_items_per_week;

DELIMITER //

CREATE PROCEDURE  remove_repeated_items_per_week()
BEGIN
    DECLARE nDates INT DEFAULT 0;
    DECLARE iDate  INT DEFAULT 0;
    DECLARE aDate DATE DEFAULT '2022-01-01';
    
    
    SELECT COUNT(distinct batch_ts) FROM raw_data INTO nDates;
    
    SET iDate =0; 
    
    WHILE iDate < nDates DO
      
      SELECT DISTINCT batch_ts FROM raw_data ORDER BY batch_ts LIMIT iDate,1 INTO aDate;
      
      DROP TABLE IF EXISTS repeated_ids;
      CREATE TABLE repeated_ids AS
        SELECT 
          id 
        FROM
          raw_data
        WHERE 
          batch_ts = aDate
        AND
          hash 
        IN (
            SELECT DISTINCT rdh.hash FROM raw_data rdh 
            WHERE
              rdh.batch_ts = aDate
            GROUP BY 
              rdh.hash
            HAVING
              COUNT(rdh.hash) > 1
        );
        
      SELECT 'iterating date number ', iDate, 
        ' - Corresponding to ', aDate,
        ' - From a total of ', nDates,
        ' - Number of IDs to delete for this date: ', (SELECT count(id) from repeated_ids) as numRepIds, 
        ' - Number of IDs in total for this date (before deletion): ', (SELECT count(DISTINCT id) from raw_data where batch_ts=aDate) as numtotIds
      ;
      
      DELETE FROM 
        raw_data 
      WHERE 
        id 
      IN (SELECT ri.id FROM repeated_ids ri);
      
      SELECT 'iterating date number ', iDate, 
        ' - Corresponding to ', aDate,
        ' - From a total of ', nDates,
        ' - Number of IDs to delete for this date: ', (SELECT count(id) from repeated_ids) as numRepIds, 
        ' - Number of IDs in total for this date (after deletion): ',(SELECT count(DISTINCT id) from raw_data where batch_ts=aDate) as numtotIds
      ;
      
      SET iDate = iDate + 1;
      
      DROP TABLE repeated_ids;
      
    END WHILE;
END //

DELIMITER ;

