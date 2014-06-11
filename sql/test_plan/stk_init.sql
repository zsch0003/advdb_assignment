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
-- -----------------------------------------------------------------------------

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

-- -----------------------------------------------------------------------------
-- h) Check for any decision recorded about an application
CREATE PROCEDURE test_utrans_h() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_h_actuals
  SELECT Decision.StaffID, DT.type
  FROM rhd.Application App
  INNER JOIN rhd.Decision ON Decision.ApplicationID = App.ApplicationID
  INNER JOIN rhd.`Decision Type` DT 
    ON DT.DecisionTypeID = Decision.DecisionTypeID
  WHERE App.ApplicationID = 411 ;

  -- create a temporary table to store the expected results
  -- expect COUNT = 1
  -- expect StaffID = 1001
  -- expect dectype = 'RFI'
  CREATE TEMPORARY TABLE utrans_h_expecteds (
    StaffID int(10),
    type varchar(50)
  ) ;
  INSERT INTO utrans_h_expecteds (StaffID, type)
  VALUES (1001, 'RFI' ) ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_h_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_h_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_h_expecteds expecteds
  )  problems
  GROUP BY problems.StaffID
  HAVING COUNT(*) = 1
  ORDER BY problems.StaffID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_h_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_h_expecteds ;
  DROP TABLE utrans_h_actuals ;
  DROP TABLE utrans_h_problems ;
END $$

-- -----------------------------------------------------------------------------
-- k) Look up an existing application and list outstanding information
-- (checklist).
CREATE PROCEDURE test_utrans_k() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_k_actuals
  SELECT App.ApplicationID, AppStat.Status, 
    App.AddressConfirmed, App.DegreeConfirmed, 
    App.VisaStatusConfirmed, App.ProposalConfirmed, App.HasResearchAreas, 
    App.HasPrimarySuper, App.PayMethConfirmed, App.EngProfConfirmed 
  FROM rhd.Application App
  INNER JOIN rhd.`Application Status` AppStat
    ON AppStat.ApplicationStatusID = App.ApplicationStatusID
  WHERE App.ApplicationID = 611 ;

  -- create a temporary table to store the expected results
  -- expect count == 1; status=ongoing, others 0/false
  CREATE TEMPORARY TABLE utrans_k_expecteds (
    ApplicationID int(10),
    Status varchar(50),
    AddressConfirmed int(1),
    DegreeConfirmed int(1),
    VisaStatusConfirmed int(1),
    ProposalConfirmed int(1),
    HasResearchAreas int(1),
    HasPrimarySuper int(1),
    PayMethConfirmed int(1),
    EngProfConfirmed int(1)
  ) ;
  INSERT INTO utrans_k_expecteds
  VALUES (611, 'ongoing', 0, 0, 0, 0, 0, 0, 0, 0 ) ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_k_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_k_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_k_expecteds expecteds
  )  problems
  GROUP BY problems.ApplicationID
  HAVING COUNT(*) = 1
  ORDER BY problems.ApplicationID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_k_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_k_expecteds ;
  DROP TABLE utrans_k_actuals ;
  DROP TABLE utrans_k_problems ;
END $$

-- -----------------------------------------------------------------------------
-- l) Update the checklist to confirm that a mandatory information requirement
-- has been met
CREATE PROCEDURE test_utrans_l() 
BEGIN

  UPDATE rhd.Application 
  SET AddressConfirmed = 1 
  WHERE Application.ApplicationID = 611 ;
  -- expect success
  -- rerun k), expect AddressConfirmed == 1/true

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_l_actuals
  SELECT App.ApplicationID, AppStat.Status, 
    App.AddressConfirmed, App.DegreeConfirmed, 
    App.VisaStatusConfirmed, App.ProposalConfirmed, App.HasResearchAreas, 
    App.HasPrimarySuper, App.PayMethConfirmed, App.EngProfConfirmed 
  FROM rhd.Application App
  INNER JOIN rhd.`Application Status` AppStat
    ON AppStat.ApplicationStatusID = App.ApplicationStatusID
  WHERE App.ApplicationID = 611 ;

  -- create a temporary table to store the expected results
  -- expect count == 1; status=ongoing, others 0/false
  CREATE TEMPORARY TABLE utrans_l_expecteds (
    ApplicationID int(10),
    Status varchar(50),
    AddressConfirmed int(1),
    DegreeConfirmed int(1),
    VisaStatusConfirmed int(1),
    ProposalConfirmed int(1),
    HasResearchAreas int(1),
    HasPrimarySuper int(1),
    PayMethConfirmed int(1),
    EngProfConfirmed int(1)
  ) ;
  INSERT INTO utrans_l_expecteds
  VALUES (611, 'ongoing', 1, 0, 0, 0, 0, 0, 0, 0 ) ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_l_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_l_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_l_expecteds expecteds
  )  problems
  GROUP BY problems.ApplicationID
  HAVING COUNT(*) = 1
  ORDER BY problems.ApplicationID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_l_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_l_expecteds ;
  DROP TABLE utrans_l_actuals ;
  DROP TABLE utrans_l_problems ;

  -- reset to initial state
  UPDATE rhd.Application 
  SET AddressConfirmed = 1 
  WHERE Application.ApplicationID = 611 ;

END $$

-- -----------------------------------------------------------------------------
-- m) Retrieve all on-going applications for which the user has made the most
-- recent correspondence
CREATE PROCEDURE test_utrans_m() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_m_actuals
  SELECT App.ApplicationID
  FROM rhd.Application App
  INNER JOIN rhd.`Application Status` AppStat
    ON AppStat.ApplicationStatusID = App.ApplicationStatusID
  WHERE AppStat.Status LIKE 'ongoing%'
    AND App.LastModifiedByStaffID = 1002 ;

  -- create a temporary table to store the expected results
  -- three rows, ids 111, 611 and 1011
  CREATE TEMPORARY TABLE utrans_m_expecteds (
    ApplicationID int(10)
  ) ;
  INSERT INTO utrans_m_expecteds
  VALUES (111), (611), (1011) ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_m_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_m_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_m_expecteds expecteds
  )  problems
  GROUP BY problems.ApplicationID
  HAVING COUNT(*) = 1
  ORDER BY problems.ApplicationID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_m_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_m_expecteds ;
  DROP TABLE utrans_m_actuals ;
  DROP TABLE utrans_m_problems ;

END $$

-- -----------------------------------------------------------------------------
-- o) Update the status of an application
CREATE PROCEDURE test_utrans_o() 
BEGIN

  -- change the status of an application
  UPDATE rhd.Application App
  JOIN 
    (SELECT * FROM rhd.`Application Status` AppStat
     WHERE AppStat.Status = 'complete.declined') AS Lookup
  SET App.applicationStatusID = Lookup.ApplicationStatusID
  WHERE App.ApplicationID = 611 ;

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_o_actuals
  SELECT AppStat.Status
  FROM rhd.`Application Status` AppStat
  INNER JOIN rhd.Application App
    ON AppStat.ApplicationStatusID = App.ApplicationStatusID
  WHERE App.ApplicationID = 611;

  -- create a temporary table to store the expected results
  -- one row, 'complete.declined'
  CREATE TEMPORARY TABLE utrans_o_expecteds (
    Status varchar(50)
  ) ;
  INSERT INTO utrans_o_expecteds
  VALUES ('complete.declined');

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_o_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_o_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_o_expecteds expecteds
  )  problems
  GROUP BY problems.Status
  HAVING COUNT(*) = 1
  ORDER BY problems.Status ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_o_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_o_expecteds ;
  DROP TABLE utrans_o_actuals ;
  DROP TABLE utrans_o_problems ;

  -- reset the status of an application
  UPDATE rhd.Application App
  JOIN 
    (SELECT * FROM rhd.`Application Status` AppStat
     WHERE AppStat.Status = 'ongoing') AS Lookup
  SET App.applicationStatusID = Lookup.ApplicationStatusID
  WHERE App.ApplicationID = 611 ;

END $$

-- -----------------------------------------------------------------------------
-- p) Look up, add to, and delete from own current research areas
-- p1) look up current research areas
CREATE PROCEDURE test_utrans_p1() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_p1_actuals
  SELECT USM.FORCode
  FROM rhd.`University Staff Member_Research Area` USM
  WHERE USM.StaffID = 1000 ;

  -- create a temporary table to store the expected results
  -- expect count == 4, 80399, 80499, 80699, 89999
  CREATE TEMPORARY TABLE utrans_p1_expecteds (
    FORCode int(10)
  ) ;
  INSERT INTO utrans_p1_expecteds
  VALUES  (80399), (80499), (80699), (89999) ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_p1_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_p1_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_p1_expecteds expecteds
  )  problems
  GROUP BY problems.FORCode
  HAVING COUNT(*) = 1
  ORDER BY problems.FORCode ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_p1_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_p1_expecteds ;
  DROP TABLE utrans_p1_actuals ;
  DROP TABLE utrans_p1_problems ;

END $$

-- p2) Insert new research areas tested in populate script

-- p3) Delete research areas
CREATE PROCEDURE test_utrans_p3() 
BEGIN

  -- remove a research area
  DELETE rhd.`University Staff Member_Research Area` USMRA
  FROM rhd.`University Staff Member_Research Area` USMRA
  JOIN
    (SELECT RA.FORCode FROM rhd.`Research Area` RA
     WHERE RA.Description LIKE 'information systems not elsewhere classified')
    AS Lookup
  WHERE StaffID = 1000 
    AND USMRA.FORCode = Lookup.FORCode;

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_p3_actuals
  SELECT USM.FORCode
  FROM rhd.`University Staff Member_Research Area` USM
  WHERE USM.StaffID = 1000 ;

  -- create a temporary table to store the expected results
  -- expect count == 4, 80399, 80499, 89999
  CREATE TEMPORARY TABLE utrans_p3_expecteds (
    FORCode int(10)
  ) ;
  INSERT INTO utrans_p3_expecteds
  VALUES  (80399), (80499), (89999) ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_p3_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_p3_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_p3_expecteds expecteds
  )  problems
  GROUP BY problems.FORCode
  HAVING COUNT(*) = 1
  ORDER BY problems.FORCode ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_p3_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_p3_expecteds ;
  DROP TABLE utrans_p3_actuals ;
  DROP TABLE utrans_p3_problems ;

  -- Re-instate the temporarily removed research area
  INSERT INTO rhd.`University Staff Member_Research Area` 
   (StaffID, FORCode)
  (SELECT USM.StaffID, Lookup.FORCode FROM rhd.`University Staff Member` USM
   JOIN
     (SELECT RA.FORCode FROM rhd.`Research Area` RA
      WHERE RA.Description LIKE 'information systems not elsewhere classified')
     AS Lookup
   WHERE USM.StaffID = 1000 );

END $$

-- -----------------------------------------------------------------------------
-- q) Search for all applications in certain research areas that have been added
-- since a certain time
CREATE PROCEDURE test_utrans_q() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_q_actuals
  SELECT App.ApplicationID
  FROM rhd.Application App 
  INNER JOIN rhd.`Application_Research Area` ARA
    ON App.ApplicationID = ARA.ApplicationID
  WHERE App.DateAdded >= '2014-05-01' 
    AND ARA.FORCode = 100503 ;

  -- create a temporary table to store the expected results
  -- expect 1 row, id 611
  CREATE TEMPORARY TABLE utrans_q_expecteds (
    ApplicationID int(10)
  ) ;
  INSERT INTO utrans_q_expecteds
  VALUES  (611), (811) ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_q_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_q_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_q_expecteds expecteds
  )  problems
  GROUP BY problems.ApplicationID
  HAVING COUNT(*) = 1
  ORDER BY problems.ApplicationID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_q_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_q_expecteds ;
  DROP TABLE utrans_q_actuals ;
  DROP TABLE utrans_q_problems ;

END $$

-- -----------------------------------------------------------------------------
-- s) Retrieve all staff who have flagged an application, or have edited an
-- application or applicant record most recently
--
-- s1) Retrieve the flagged applications
CREATE PROCEDURE test_utrans_s1() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_s1_actuals
  SELECT USM.StaffID, USM.FName, USM.LName
  FROM rhd.`University Staff Member` USM
  INNER JOIN rhd.`University Staff Member_Application` Flags
    ON Flags.StaffID = USM.StaffID
  WHERE Flags.ApplicationID = 711 ;

  -- create a temporary table to store the expected results
  -- expect Denise de Vries and John Roddick
  CREATE TEMPORARY TABLE utrans_s1_expecteds (
    StaffID int(10),
    FName varchar(50),
    LName varchar(50)
  ) ;
  INSERT INTO utrans_s1_expecteds
  VALUES  (1002, 'John', 'Roddick'), (1000, 'Denise', 'de Vries') ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_s1_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_s1_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_s1_expecteds expecteds
  )  problems
  GROUP BY problems.StaffID
  HAVING COUNT(*) = 1
  ORDER BY problems.StaffID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_s1_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_s1_expecteds ;
  DROP TABLE utrans_s1_actuals ;
  DROP TABLE utrans_s1_problems ;

END $$

-- s2) Last staff member to modify an application
CREATE PROCEDURE test_utrans_s2() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_s2_actuals
  SELECT USM.StaffID, USM.FName, USM.LName
  FROM rhd.`University Staff Member` USM
  INNER JOIN rhd.Application App
    ON App.LastModifiedByStaffID = USM.StaffID
  WHERE App.ApplicationID = 711 ;

  -- create a temporary table to store the expected results
  -- expect Denise de Vries and John Roddick
  CREATE TEMPORARY TABLE utrans_s2_expecteds (
    StaffID int(10),
    FName varchar(50),
    LName varchar(50)
  ) ;
  INSERT INTO utrans_s2_expecteds
  VALUES  (1000, 'Denise', 'de Vries') ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_s2_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_s2_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_s2_expecteds expecteds
  )  problems
  GROUP BY problems.StaffID
  HAVING COUNT(*) = 1
  ORDER BY problems.StaffID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_s2_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_s2_expecteds ;
  DROP TABLE utrans_s2_actuals ;
  DROP TABLE utrans_s2_problems ;

END $$

-- -----------------------------------------------------------------------------
-- t) Retrieve all ongoing applications
CREATE PROCEDURE test_utrans_t() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_t_actuals
  SELECT App.ApplicationID
  FROM rhd.Application App
  INNER JOIN rhd.`Application Status` AppStat
    ON App.ApplicationStatusID = AppStat.ApplicationStatusID
  WHERE AppStat.Status LIKE 'ongoing%' ;

  -- create a temporary table to store the expected results
  -- expect all applications at this stage
  CREATE TEMPORARY TABLE utrans_t_expecteds (
    ApplicationID int(10)
  ) ;
  INSERT INTO utrans_t_expecteds
  VALUES (111), (211), (311), (411), (511), (611), (711), (811), (911), (1011),
  (1111) ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_t_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_t_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_t_expecteds expecteds
  )  problems
  GROUP BY problems.ApplicationID
  HAVING COUNT(*) = 1
  ORDER BY problems.ApplicationID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_t_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_t_expecteds ;
  DROP TABLE utrans_t_actuals ;
  DROP TABLE utrans_t_problems ;

END $$

-- -----------------------------------------------------------------------------
-- u) List all applications waiting for supervisor agreement
CREATE PROCEDURE test_utrans_u() 
BEGIN

  -- run the query for this test and create a temporary table for results
  CREATE TEMPORARY TABLE utrans_u_actuals
  SELECT Agg.ApplicationID FROM
    (SELECT 
       App.ApplicationID, 
       Super.StaffID, 
       Super.PrimarySupervisor, 
       SUM(Super.PrimarySupervisor) AS PriSuperSum
     FROM rhd.Application App
     LEFT OUTER JOIN rhd.`Supervise as` Super
       ON Super.ApplicationID = App.ApplicationID 
     GROUP BY App.ApplicationID) 
    AS Agg
  WHERE Agg.PriSuperSum <> 1
    OR Agg.PriSuperSum IS NULL ;

  -- create a temporary table to store the expected results
  -- expect all applications except 111 and 311
  CREATE TEMPORARY TABLE utrans_u_expecteds (
    ApplicationID int(10)
  ) ;
  INSERT INTO utrans_u_expecteds
  VALUES (211), (411), (511), (611), (711), (811), (911), (1011), (1111) ;

  -- create another temporary table that lists the differences between expected
  -- results and actuals
  CREATE TEMPORARY TABLE utrans_u_problems
  SELECT problems.*
  FROM
  (
      SELECT actuals.*
      FROM utrans_u_actuals actuals
      UNION ALL
      SELECT expecteds.*
      FROM utrans_u_expecteds expecteds
  )  problems
  GROUP BY problems.ApplicationID
  HAVING COUNT(*) = 1
  ORDER BY problems.ApplicationID ;

  -- report an error if the 'problems' table isn't empty
  CALL stk_unit.assert_table_empty( 
    DATABASE(),
    'utrans_u_problems', 
    'Incorrect results') ; 

  DROP TABLE utrans_u_expecteds ;
  DROP TABLE utrans_u_actuals ;
  DROP TABLE utrans_u_problems ;

END $$


DELIMITER ;


