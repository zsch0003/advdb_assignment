-- sudo bash -c 'mysql -h localhost -D rhd  < ../stk_unit1.0-rc6/sql/stk_unit.sql'
-- had to run as system root => we won't be able to run this on the uni system

CONNECT mysql

DROP DATABASE test_rhd ;

CREATE DATABASE test_rhd CHARACTER SET = utf8;

CONNECT test_rhd;

DELIMITER $$

-- ensure that our populate scripts put at least some data in every table
CREATE PROCEDURE test_populate_contents()
BEGIN
  DECLARE rowCount INT;
  DECLARE tableName varchar(64) DEFAULT "";
  DECLARE tablesDone INTEGER DEFAULT 0;

  -- iterate over all the tables in RHD DB
  DECLARE curs CURSOR FOR SELECT t.TABLE_NAME from information_schema.tables t
                          WHERE t.TABLE_SCHEMA = 'rhd' 
                            AND t.table_type = 'BASE TABLE';

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET tablesDone = 1 ;

  OPEN curs ;

  test_count: LOOP

      FETCH curs INTO tableName ;

      IF tablesDone = 1 THEN
        LEAVE test_count ; 
      END IF ;

      SET @s = CONCAT('SELECT COUNT(*) FROM rhd.`', tableName, '` into @OUTVAR') ; 
      PREPARE rowCountStmt FROM @s ; 
      EXECUTE rowCountStmt;
      SELECT @OUTVAR INTO rowCount;

      CALL stk_unit.assert_false(rowCount = 0, CONCAT('Table has zero rows: ',
                                               tableName)) ;

    END LOOP test_count ;
        
  CLOSE curs ;
  
END $$

DELIMITER ;

--  DECLARE CONTINUE HANDLER FOR NOT FOUND SET tablesDone = 1 ;

