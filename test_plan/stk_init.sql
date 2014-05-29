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


CREATE PROCEDURE test_utrans_a1()
BEGIN
  DECLARE appID INT(10);
  DECLARE v_count INT;

  SELECT ApplicantID, COUNT(*) 
  FROM rhd.Applicant 
  WHERE Applicant.FName = 'Shirin' 
    AND Applicant.LName = 'Ebadi' 
  INTO appID, v_count ;

  CALL stk_unit.assert_true(
    v_count = 1, 
    'Expected exactly one applicant of given name') ;

  CALL stk_unit.assert_true(
    appID = 1, 
    'Expected exactly one applicant of given name') ;
END $$

-- CREATE PROCEDURE test_utrans_a2()
-- BEGIN
--   DECLARE pubID INT(10);
--   DECLARE v_count INT;

--   SELECT p.PubID, COUNT(*) FROM rhd.Publication p, rhd.Applicant a
--   WHERE p.ApplicantID = a.ApplicantID 
--     AND a.FName = 'Shirin'
--     AND a.LName = 'Ebadi'
--   INTO pubID, 

--   SELECT ApplicantID, COUNT(*) 
--   FROM rhd.Applicant 
--   WHERE Applicant.FName = 'Shirin' 
--     AND Applicant.LName = 'Ebadi' 
--   INTO appID, v_count ;

--   CALL stk_unit.assert_true(
--     v_count = 1, 
--     'Expected exactly one applicant of given name') ;

--   CALL stk_unit.assert_true(
--     appID = 1, 
--     'Expected exactly one applicant of given name') ;
-- END $$

CREATE PROCEDURE test_utrans_a3() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_a3_actuals
  SELECT d.DegID FROM rhd.Degree d, rhd.Applicant a
  WHERE d.ApplicantID = a.ApplicantID 
    AND a.FName = 'Shirin'
    AND a.LName = 'Ebadi' ;

  -- create a temporary table to store the expected results
  CREATE TEMPORARY TABLE utrans_a3_expecteds (
    DegID int(10) NOT NULL,
    PRIMARY KEY (DegID)
  ) ;
  INSERT INTO utrans_a3_expecteds (DegID)
  VALUES (121), (122);

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_a3_problems
  SELECT problems.DegID
  FROM
  (
      SELECT actuals.DegID
      FROM utrans_a3_actuals actuals
      UNION ALL
      SELECT expecteds.DegID
      FROM utrans_a3_expecteds expecteds
  )  problems
  GROUP BY problems.DegID
  HAVING COUNT(*) = 1
  ORDER BY problems.DegID 
  ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_a3_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_a3_expecteds ;
  DROP TABLE utrans_a3_actuals ;
  DROP TABLE utrans_a3_problems ;
END $$

DELIMITER ;

--  DECLARE CONTINUE HANDLER FOR NOT FOUND SET tablesDone = 1 ;

