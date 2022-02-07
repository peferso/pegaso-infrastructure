-- Procedimiento para eliminar items duplicados

USE pegaso_db;

DROP PROCEDURE IF EXISTS ltrim_models;

DELIMITER //

CREATE PROCEDURE  ltrim_models()
BEGIN

    DECLARE nRegs INT DEFAULT 0;
    DECLARE iReg INT DEFAULT 0;
    DECLARE aId VARCHAR(60) DEFAULT 'NA';
    DECLARE aModel VARCHAR(60) DEFAULT 'NA';
    
    SELECT COUNT(id) FROM raw_data INTO nRegs;
    
    SET iReg =0; 
    
    WHILE iReg < nRegs DO
      
      SELECT id FROM raw_data LIMIT iReg,1 INTO aId;
      
      SELECT model FROM raw_data LIMIT iReg, 1 INTO aModel;

      UPDATE raw_data SET model=LTRIM(aModel) WHERE id=aId;   
      
      SET iReg = iReg + 1;
      
    END WHILE;

    COMMIT;

END //

DELIMITER ;

