-- -----------------------------------------------------------------------------
-- The unit tests for RHD DB.
-- 
-- First, load up the stk_unit utility. This must be done as DB admin. E.g.:
-- 
--     sudo bash -c \
--       'mysql -h localhost -D rhd  < ../stk_unit1.0-rc6/sql/stk_unit.sql'
--
-- Then, read this file in as root.
-- had to run as system root => we won't be able to run this on the uni system
--
-- Run the test by issuing, as root:
--
--     CALL stk_unit.tc('test_rhd');
--    
--------------------------------------------------------------------------------

CONNECT mysql ; 

DROP DATABASE IF EXISTS test_rhd ;

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
  ORDER BY problems.DegID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_a3_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_a3_expecteds ;
  DROP TABLE utrans_a3_actuals ;
  DROP TABLE utrans_a3_problems ;
END $$


-- a4 TODO: need to add visa info

-- -----------------------------------------------------------------------------
-- a5
CREATE PROCEDURE test_utrans_a5() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_a5_actuals
  SELECT d.DocID, dt.Type AS DocType 
  FROM rhd.Applicant App 
  INNER JOIN rhd.Document d ON d.ApplicantID = App.ApplicantID 
  INNER JOIN rhd.`Document Type` dt ON d.DocTypeID = dt.DocTypeID 
  WHERE App.FName = 'Shirin'
    AND App.LName = 'Ebadi' ;

  -- create a temporary table to store the expected results
  -- one row, id 131, cv
  CREATE TEMPORARY TABLE utrans_a5_expecteds (
    DocID int(10) NOT NULL,
    DocType varchar(50)
  ) ;
  INSERT INTO utrans_a5_expecteds (DocID, DocType)
  VALUES (131, 'cv');

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_a5_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_a5_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_a5_expecteds expecteds
  )  problems
  GROUP BY problems.DocID
  HAVING COUNT(*) = 1
  ORDER BY problems.DocID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_a5_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_a5_expecteds ;
  DROP TABLE utrans_a5_actuals ;
  DROP TABLE utrans_a5_problems ;
END $$


-- -----------------------------------------------------------------------------
-- b) Look up applicant’s applications by applicant name

CREATE PROCEDURE test_utrans_b() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_b_actuals
  SELECT App.ApplicationID, AwType.Type AS awardType
  FROM rhd.Applicant Appt
  INNER JOIN rhd.Application App ON Appt.ApplicantID = App.ApplicantID 
  INNER JOIN rhd.`Award Type` AwType ON App.AwardID = AwType.AwardID
  WHERE Appt.FName = 'Shirin'
    AND Appt.LName = 'Ebadi' ;

  -- create a temporary table to store the expected results
  -- expect ApplicationID = 111, Type = 'PhD'
  CREATE TEMPORARY TABLE utrans_b_expecteds (
    ApplicationID int(10) NOT NULL,
    awardType varchar(50)
  ) ;
  INSERT INTO utrans_b_expecteds (ApplicationID, awardType)
  VALUES (111, 'PhD');

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_b_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_b_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_b_expecteds expecteds
  )  problems
  GROUP BY problems.ApplicationID
  HAVING COUNT(*) = 1
  ORDER BY problems.ApplicationID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_b_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_b_expecteds ;
  DROP TABLE utrans_b_actuals ;
  DROP TABLE utrans_b_problems ;
END $$

-- -----------------------------------------------------------------------------
-- c) Look up applicant’s applications by applicant email
CREATE PROCEDURE test_utrans_c() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_c_actuals
  SELECT App.ApplicationID, AwType.Type AS awardType
  FROM rhd.Applicant Appt
  INNER JOIN rhd.Application App ON Appt.ApplicantID = App.ApplicantID 
  INNER JOIN rhd.`Award Type` AwType ON App.AwardID = AwType.AwardID
  WHERE Appt.Email = 'don.memo@hotmail.com' ;

  -- create a temporary table to store the expected results
  -- expect ApplicationID = 211, Type = 'PhD'
  CREATE TEMPORARY TABLE utrans_c_expecteds (
    ApplicationID int(10) NOT NULL,
    awardType varchar(50)
  ) ;
  INSERT INTO utrans_c_expecteds (ApplicationID, awardType)
  VALUES (211, 'PhD');

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_c_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_c_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_c_expecteds expecteds
  )  problems
  GROUP BY problems.ApplicationID
  HAVING COUNT(*) = 1
  ORDER BY problems.ApplicationID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_c_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_c_expecteds ;
  DROP TABLE utrans_c_actuals ;
  DROP TABLE utrans_c_problems ;
END $$

-- -----------------------------------------------------------------------------
-- d) Look up incomplete applications
CREATE PROCEDURE test_utrans_d() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_d_actuals
  SELECT App.ApplicationID
  FROM rhd.Application App
  WHERE App.applicationStatusID < 10500 ;

  -- create a temporary table to store the expected results
  -- expect all 11 applications
  CREATE TEMPORARY TABLE utrans_d_expecteds (
    ApplicationID int(10) NOT NULL
  ) ;
  INSERT INTO utrans_d_expecteds (ApplicationID)
  VALUES (111), (211), (311), (411), (511), (611), (711), (811), (911), (1011),
  (1111) ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_d_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_d_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_d_expecteds expecteds
  )  problems
  GROUP BY problems.ApplicationID
  HAVING COUNT(*) = 1
  ORDER BY problems.ApplicationID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_d_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_d_expecteds ;
  DROP TABLE utrans_d_actuals ;
  DROP TABLE utrans_d_problems ;
END $$

-- -----------------------------------------------------------------------------
-- e) Look up all correspondences relevant to an application
CREATE PROCEDURE test_utrans_e() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_e_actuals
  SELECT Corr.CorrID
  FROM rhd.Application App
  INNER JOIN rhd.Correspondence Corr ON Corr.ApplicationID = App.ApplicationID
  WHERE App.ApplicationID = 411 ;

  -- create a temporary table to store the expected results
  -- two rows, id 441 and 442, 
  CREATE TEMPORARY TABLE utrans_e_expecteds (
    CorrID int(10) NOT NULL
  ) ;
  INSERT INTO utrans_e_expecteds (CorrID)
  VALUES (441), (442) ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_e_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_e_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_e_expecteds expecteds
  )  problems
  GROUP BY problems.CorrID
  HAVING COUNT(*) = 1
  ORDER BY problems.CorrID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_e_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_e_expecteds ;
  DROP TABLE utrans_e_actuals ;
  DROP TABLE utrans_e_problems ;
END $$

-- -----------------------------------------------------------------------------
-- g) Look up which staff member updated an Application most recently
CREATE PROCEDURE test_utrans_g() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_g_actuals
  SELECT USM.StaffID, USM.FName, USM.LName
  FROM rhd.Application App
  INNER JOIN rhd.`University Staff Member` USM 
    ON USM.StaffID = App.LastModifiedByStaffID
  WHERE App.ApplicationID = 311 ;

  -- create a temporary table to store the expected results
  -- expect 'Paul' 'Calder'
  CREATE TEMPORARY TABLE utrans_g_expecteds (
    StaffID int(10),
    FName varchar(50),
    LName varchar(50)
  ) ;
  INSERT INTO utrans_g_expecteds (StaffID, FName, LName)
  VALUES (1001, 'Paul', 'Calder') ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_g_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_g_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_g_expecteds expecteds
  )  problems
  GROUP BY problems.StaffID
  HAVING COUNT(*) = 1
  ORDER BY problems.StaffID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_g_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_g_expecteds ;
  DROP TABLE utrans_g_actuals ;
  DROP TABLE utrans_g_problems ;
END $$


DELIMITER ;

