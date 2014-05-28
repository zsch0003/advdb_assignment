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

  -- iterate over all the tables in RHD DB
  DECLARE curs CURSOR FOR SELECT TABLE_NAME from information_schema.tables t
                          WHERE t.TABLE_SCHEMA = 'rhd' ;

  OPEN curs ;

  CLOSE curs ;
  
  
END $$

DELIMITER ;
