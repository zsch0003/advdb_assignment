
-- DROP TABLE IF EXISTS usm_researcharea_changes ; 
-- CREATE TABLE usm_researcharea_changes (
--   usm_researcharea_change_id int(10) NOT NULL AUTO_INCREMENT comment 'PK',
--   date date NOT NULL,
--   time time NOT NULL,
--   description varchar(50) NOT NULL,
--   FORCode int(10) NOT NULL,
--   StaffID int(10) NOT NULL,
--   emailAddress varchar(70) ,
--   emailSentDate date,
--   emailSentTime time,
--   PRIMARY KEY (usm_researcharea_change_id)
-- );

DELIMITER $$

-- -----------------------------------------------------------------------------
-- Record changes to Research Areas to email these to the change subject later
DROP TRIGGER IF EXISTS USM_RESEARCHAREA_AI $$
CREATE TRIGGER USM_RESEARCHAREA_AI AFTER INSERT ON 
`University Staff Member_Research Area`
FOR EACH ROW
BEGIN
  DECLARE v_forCodeDescription varchar(2000) ; 
  DECLARE v_comment varchar(1000) ; 
  DECLARE v_agentFName varchar(50) ;
  DECLARE v_agentLName varchar(50) ;
  DECLARE v_decisionTypeID mediumint(9) ;

  SELECT Description
  FROM `Research Area` RA
  WHERE RA.FORCode = NEW.FORCode
  INTO v_forCodeDescription ;

  SELECT FName, LName
  FROM `University Staff Member` AS USM
  WHERE USM.StaffID = CURRENT_RHD_USER()
  INTO v_agentFName, v_agentLName;

  SELECT DecisionTypeID 
  FROM `Decision Type` AS DT
  WHERE DT.type = 'change.research_area.addition'
  INTO v_decisionTypeID;

  SET v_comment = CONCAT('A new Field Of Research Code ', NEW.FORCode,
  ' - ''', SUBSTRING(v_forCodeDescription, 1, 800), 
  ''' has been associated to your RHD account by ', v_agentFName, ' ', 
  v_agentLName);

  INSERT INTO Decision(Date, Comment, StaffID, DecisionTypeID, Reportable, Sent)
  VALUES (CURRENT_DATE(), v_comment, NEW.StaffID, v_decisionTypeID, 1, 0);
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS USM_RESEARCHAREA_AD $$
CREATE TRIGGER USM_RESEARCHAREA_AD AFTER DELETE ON 
`University Staff Member_Research Area`
FOR EACH ROW
BEGIN
  DECLARE v_forCodeDescription varchar(2000) ; 
  DECLARE v_comment varchar(1000) ; 
  DECLARE v_agentFName varchar(50) ;
  DECLARE v_agentLName varchar(50) ;
  DECLARE v_decisionTypeID mediumint(9) ;

  SELECT Description
  FROM `Research Area` RA
  WHERE RA.FORCode = OLD.FORCode
  INTO v_forCodeDescription ;

  SELECT FName, LName
  FROM `University Staff Member` AS USM
  WHERE USM.StaffID = CURRENT_RHD_USER()
  INTO v_agentFName, v_agentLName;

  SELECT DecisionTypeID 
  FROM `Decision Type` AS DT
  WHERE DT.type = 'change.research_area.deletion'
  INTO v_decisionTypeID;

  SET v_comment = CONCAT('An existing Field Of Research Code ', OLD.FORCode,
  ' - ''', SUBSTRING(v_forCodeDescription, 1, 800), 
  ''' has been removed from association with your RHD account by ', 
  v_agentFName, ' ', v_agentLName);

  INSERT INTO Decision(Date, Comment, StaffID, DecisionTypeID, Reportable, Sent)
  VALUES (CURRENT_DATE(), v_comment, OLD.StaffID, v_decisionTypeID, 1, 0);
END $$
DELIMITER ;

DELIMITER $$
-- -----------------------------------------------------------------------------
-- Record changes to Research Areas to email these to the change subject later
DROP TRIGGER IF EXISTS USM_RESEARCHAREA2_AI $$
CREATE TRIGGER USM_RESEARCHAREA2_AI AFTER INSERT ON 
`University Staff Member_Research Area2`
FOR EACH ROW
BEGIN
  DECLARE v_forCodeDescription varchar(2000) ; 
  DECLARE v_comment varchar(1000) ; 
  DECLARE v_agentFName varchar(50) ;
  DECLARE v_agentLName varchar(50) ;
  DECLARE v_decisionTypeID mediumint(9) ;

  SELECT Description
  FROM `Research Area` RA
  WHERE RA.FORCode = NEW.FORCode
  INTO v_forCodeDescription ;

  SELECT FName, LName
  FROM `University Staff Member` AS USM
  WHERE USM.StaffID = CURRENT_RHD_USER()
  INTO v_agentFName, v_agentLName;

  SELECT DecisionTypeID 
  FROM `Decision Type` AS DT
  WHERE DT.type LIKE 'change.research_area_oversees.addition'
  INTO v_decisionTypeID;

  SET v_comment = CONCAT(
  'You have been registered as overseeing Field Of Research area ', NEW.FORCode,
  ' - ''', SUBSTRING(v_forCodeDescription, 1, 800), 
  ''', this change made by ', v_agentFName, ' ', 
  v_agentLName);

  INSERT INTO Decision(Date, Comment, StaffID, DecisionTypeID, Reportable, Sent)
  VALUES (CURRENT_DATE(), v_comment, NEW.StaffID, v_decisionTypeID, 1, 0);
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS USM_RESEARCHAREA2_AD $$
CREATE TRIGGER USM_RESEARCHAREA2_AD AFTER DELETE ON 
`University Staff Member_Research Area2`
FOR EACH ROW
BEGIN
  DECLARE v_forCodeDescription varchar(2000) ; 
  DECLARE v_comment varchar(1000) ; 
  DECLARE v_agentFName varchar(50) ;
  DECLARE v_agentLName varchar(50) ;
  DECLARE v_decisionTypeID mediumint(9) ;

  SELECT Description
  FROM `Research Area` RA
  WHERE RA.FORCode = OLD.FORCode
  INTO v_forCodeDescription ;

  SELECT FName, LName
  FROM `University Staff Member` AS USM
  WHERE USM.StaffID = CURRENT_RHD_USER()
  INTO v_agentFName, v_agentLName;

  SELECT DecisionTypeID 
  FROM `Decision Type` AS DT
  WHERE DT.type = 'change.research_area_oversees.deletion'
  INTO v_decisionTypeID;

  SET v_comment = CONCAT(
  'You have been deregistered as overseeing Field Of Research area ', 
  OLD.FORCode, ' - ''', SUBSTRING(v_forCodeDescription, 1, 800), 
  ''', this change made by ', v_agentFName, ' ', v_agentLName);

  INSERT INTO Decision(Date, Comment, StaffID, DecisionTypeID, Reportable, Sent)
  VALUES (CURRENT_DATE(), v_comment, OLD.StaffID, v_decisionTypeID, 1, 0);
END $$

DELIMITER ;

-- -----------------------------------------------------------------------------
-- Add a triggers to record changes to supervisors
DELIMITER $$
DROP TRIGGER IF EXISTS SUPERVISE_AS_AI $$
CREATE TRIGGER SUPERVISE_AS_AI AFTER INSERT ON 
`Supervise as`
FOR EACH ROW
BEGIN
  DECLARE v_apptFName varchar(50) ;
  DECLARE v_apptLName varchar(50) ;
  DECLARE v_apptEmail varchar(100) ;
  DECLARE v_agentFName varchar(50) ;
  DECLARE v_agentLName varchar(50) ;
  DECLARE v_decisionTypeID mediumint(9) ;
  DECLARE v_supervisionRole varchar(20) DEFAULT 'an associate';
  DECLARE v_comment varchar(1000) ; 

  SELECT Appt.FName, Appt.LName, Appt.Email
  FROM Application App
  INNER JOIN Applicant Appt ON (App.ApplicantID = Appt.ApplicantID)
  WHERE App.ApplicationID = NEW.ApplicationID
  INTO v_apptFName, v_apptLName, v_apptEmail ;

  IF v_apptLName IS NULL THEN
    SET v_apptLName = ' (no lastname registered)';
  END IF;
  IF v_apptEmail IS NULL THEN
    SET v_apptEmail = ' (no email registered)';
  END IF;

  SELECT FName, LName
  FROM `University Staff Member` AS USM
  WHERE USM.StaffID = CURRENT_RHD_USER()
  INTO v_agentFName, v_agentLName;

  SELECT DecisionTypeID 
  FROM `Decision Type` AS DT
  WHERE DT.type LIKE 'change.supervisor.addition'
  INTO v_decisionTypeID;

  IF NEW.PrimarySupervisor = 1 THEN
    SET v_supervisionRole = 'the primary';
  END IF;

  SET v_comment = CONCAT(
  'You have been registered as ', v_supervisionRole, 
  ' supervisor for an RHD application from ', v_apptFName, ' ', v_apptLName,
  ' (application ID ', NEW.ApplicationID, '). This change made by ', 
  v_agentFName, ' ', v_agentLName, '.');

  INSERT INTO Decision(Date, Comment, StaffID, DecisionTypeID, Reportable, Sent)
  VALUES (CURRENT_DATE(), v_comment, NEW.StaffID, v_decisionTypeID, 1, 0);
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS SUPERVISE_AS_AD $$
CREATE TRIGGER SUPERVISE_AS_AD AFTER DELETE ON 
`Supervise as`
FOR EACH ROW
BEGIN
  DECLARE v_apptFName varchar(50) ;
  DECLARE v_apptLName varchar(50) ;
  DECLARE v_apptEmail varchar(100) ;
  DECLARE v_agentFName varchar(50) ;
  DECLARE v_agentLName varchar(50) ;
  DECLARE v_decisionTypeID mediumint(9) ;
  DECLARE v_supervisionRole varchar(20) DEFAULT 'an associate';
  DECLARE v_comment varchar(1000) ; 

  SELECT Appt.FName, Appt.LName, Appt.Email
  FROM Application App
  INNER JOIN Applicant Appt ON (App.ApplicantID = Appt.ApplicantID)
  WHERE App.ApplicationID = OLD.ApplicationID
  INTO v_apptFName, v_apptLName, v_apptEmail ;

  IF v_apptLName IS NULL THEN
    SET v_apptLName = ' (no lastname registered)';
  END IF;
  IF v_apptEmail IS NULL THEN
    SET v_apptEmail = ' (no email registered)';
  END IF;

  SELECT FName, LName
  FROM `University Staff Member` AS USM
  WHERE USM.StaffID = CURRENT_RHD_USER()
  INTO v_agentFName, v_agentLName;

  SELECT DecisionTypeID 
  FROM `Decision Type` AS DT
  WHERE DT.type LIKE 'change.supervisor.addition'
  INTO v_decisionTypeID;

  IF OLD.PrimarySupervisor = 1 THEN
    SET v_supervisionRole = 'the primary';
  END IF;

  SET v_comment = CONCAT(
  'You have been deregistered as ', v_supervisionRole, 
  ' supervisor for an RHD application from ', v_apptFName, ' ', v_apptLName,
  ' (application ID ', OLD.ApplicationID, '). This change made by ', 
  v_agentFName, ' ', v_agentLName, '.');

  INSERT INTO Decision(Date, Comment, StaffID, DecisionTypeID, Reportable, Sent)
  VALUES (CURRENT_DATE(), v_comment, OLD.StaffID, v_decisionTypeID, 1, 0);
END $$
DELIMITER ;


-- -----------------------------------------------------------------------------
-- Record changes to 'flagging' an application.
-- Adding a flag
DELIMITER $$
DROP TRIGGER IF EXISTS USM_APPLICATION_AI $$
CREATE TRIGGER USM_APPLICATION_AI AFTER INSERT ON 
`University Staff Member_Application`
FOR EACH ROW
BEGIN
  DECLARE v_apptFName varchar(50) ;
  DECLARE v_apptLName varchar(50) ;
  DECLARE v_apptEmail varchar(100) ;
  DECLARE v_agentFName varchar(50) ;
  DECLARE v_agentLName varchar(50) ;
  DECLARE v_decisionTypeID mediumint(9) ;
  DECLARE v_emailUpdates varchar(100) DEFAULT ' not';
  DECLARE v_comment varchar(1000) ; 

  SELECT Appt.FName, Appt.LName, Appt.Email
  FROM Application App
  INNER JOIN Applicant Appt ON (App.ApplicantID = Appt.ApplicantID)
  WHERE App.ApplicationID = NEW.ApplicationID
  INTO v_apptFName, v_apptLName, v_apptEmail ;

  IF v_apptLName IS NULL THEN
    SET v_apptLName = ' (no lastname registered)';
  END IF;
  IF v_apptEmail IS NULL THEN
    SET v_apptEmail = ' (no email registered)';
  END IF;

  SELECT FName, LName
  FROM `University Staff Member` AS USM
  WHERE USM.StaffID = CURRENT_RHD_USER()
  INTO v_agentFName, v_agentLName;

  SELECT DecisionTypeID 
  FROM `Decision Type` AS DT
  WHERE DT.type LIKE 'change.flag.addition'
  INTO v_decisionTypeID;

  IF NEW.ReceiveEmailUpdates = 1 THEN
    SET v_emailUpdates = '';
  END IF;

  SET v_comment = CONCAT(
  'An flag for you on an RHD application from ', 
  v_apptFName, ' ', v_apptLName,
  ' (application ID ', NEW.ApplicationID, ') has been added. ',
  'You are', v_emailUpdates, 
  ' registered for email updates to this application. ',
  'This change made by ', v_agentFName, ' ', v_agentLName, '.');

  INSERT INTO Decision(Date, Comment, StaffID, DecisionTypeID, Reportable, Sent)
  VALUES (CURRENT_DATE(), v_comment, NEW.StaffID, v_decisionTypeID, 1, 0);
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------
-- Record changes to 'flagging' an application.
-- Removing a flag.
DELIMITER $$
DROP TRIGGER IF EXISTS USM_APPLICATION_AD $$
CREATE TRIGGER USM_APPLICATION_AD AFTER DELETE ON 
`University Staff Member_Application`
FOR EACH ROW
BEGIN
  DECLARE v_apptFName varchar(50) ;
  DECLARE v_apptLName varchar(50) DEFAULT ' (no lastname registered)';
  DECLARE v_apptEmail varchar(100) DEFAULT ' (no email registered)';
  DECLARE v_agentFName varchar(50) ;
  DECLARE v_agentLName varchar(50) DEFAULT ' (no lastname registered)';
  DECLARE v_decisionTypeID mediumint(9) ;
  DECLARE v_comment varchar(1000) ; 

  SELECT Appt.FName, Appt.LName, Appt.Email
  FROM Application App
  INNER JOIN Applicant Appt ON (App.ApplicantID = Appt.ApplicantID)
  WHERE App.ApplicationID = OLD.ApplicationID
  INTO v_apptFName, v_apptLName, v_apptEmail ;

  IF v_apptLName IS NULL THEN
    SET v_apptLName = ' (no lastname registered)';
  END IF;
  IF v_apptEmail IS NULL THEN
    SET v_apptEmail = ' (no email registered)';
  END IF;

  SELECT FName, LName
  FROM `University Staff Member` AS USM
  WHERE USM.StaffID = CURRENT_RHD_USER()
  INTO v_agentFName, v_agentLName;

  SELECT DecisionTypeID 
  FROM `Decision Type` AS DT
  WHERE DT.type LIKE 'change.flag.addition'
  INTO v_decisionTypeID;

  SET v_comment = CONCAT(
  'Your flagged interest in an RHD application from ', 
  v_apptFName, ' ', v_apptLName,
  ' (application ID ', OLD.ApplicationID, ') has been removed. ',
  'This change made by ', v_agentFName, ' ', v_agentLName, '.');

  INSERT INTO Decision(Date, Comment, StaffID, DecisionTypeID, Reportable, Sent)
  VALUES (CURRENT_DATE(), v_comment, OLD.StaffID, v_decisionTypeID, 1, 0);
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------
-- Make sure there's only ever one primary supervisor for each application
DELIMITER $$
DROP TRIGGER IF EXISTS checkPrimSuper $$ 
CREATE TRIGGER checkPrimSuper BEFORE INSERT ON `Supervise as`
FOR EACH ROW
BEGIN
  DECLARE existingCount int default 0;
  
  SELECT count(*)
  FROM `Supervise as`
  WHERE PrimarySupervisor>0 
  AND ApplicationID=NEW.ApplicationID
  INTO exis