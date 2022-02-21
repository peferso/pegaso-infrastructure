-- Procedimiento para procesar modelos

USE pegaso_db;

DROP PROCEDURE IF EXISTS process_models;

DELIMITER //

CREATE PROCEDURE  process_models()
BEGIN

    DECLARE nRegs INT DEFAULT 0;
    DECLARE iReg INT DEFAULT 0;
    DECLARE aId VARCHAR(60) DEFAULT 'NA';
    DECLARE aModel VARCHAR(60) DEFAULT 'NA';
    DECLARE aModelCode VARCHAR(60) DEFAULT 'NA';
    
    SELECT COUNT(id) FROM raw_data INTO nRegs;

    DROP TABLE IF EXISTS model_code_mapping;
    
    CREATE TABLE model_code_mapping (
       model VARCHAR(60) PRIMARY KEY,
       model_code VARCHAR(60)
    );    

    SET iReg =0; 
    
    WHILE iReg < nRegs DO

      SELECT 'iterating date number ', iReg+1, ' - From a total of ', nRegs, aId;
      
      SELECT id FROM raw_data LIMIT iReg,1 INTO aId;
      
      SELECT model FROM raw_data LIMIT iReg, 1 INTO aModel;

      SELECT SUBSTRING_INDEX(REPLACE(RTRIM(LTRIM(aModel)), '  ', ' '), ' ', 3) INTO aModelCode;

      INSERT INTO 
          model_code_mapping(model,model_code)
      VALUES 
          (aModel,aModelCode)
      ON DUPLICATE KEY UPDATE model=aModel;

      SET iReg = iReg + 1;
      
    END WHILE;

    COMMIT;

END //

DELIMITER ;

