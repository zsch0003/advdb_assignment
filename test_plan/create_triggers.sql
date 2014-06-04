
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
DELIMITER $$

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
-- Create a trigger on the staff table to set up correct permissions
DROP TRIGGER IF EXISTS create_staff_permissions $$
CREATE
DEFINER = root
TRIGGER create_staff_permissions AFTER INSERT ON `University Staff Member`
FOR EACH ROW
BEGIN
  -- StaffID is assumed to be the same as database user login
  DECLARE userID int(10);
  SET userID = NEW.StaffID;

  -- We can't use the standard GRANT nor REVOKE syntax here as they cause
  -- implicit COMMITs, which isn't allowed in a trigger.

  -- A work-around is to manipulate mysql.db.user directly. Obviously, this
  -- has draw-backs

  -- GRANT SELECT,INSERT,UPDATE ON rhd.* TO userID@'localhost';
  INSERT INTO db (Host, Db, User, Select_priv, Insert_priv, Update_priv)
  VALUES ('localhost', 'rhd', New.StaffID, 'Y', 'Y', 'Y');

  
  
  -- if this user can't supervise, then let's say that they can't change the
  -- 'Supervise as' relation
--  IF NEW.canSupervise == 0 THEN
--     REVOKE INSERT,UPDATE on rhd.`Supervise as` FROM userID@'localhost';
--  END IF ;
  
END $$

DELIMITER ;
