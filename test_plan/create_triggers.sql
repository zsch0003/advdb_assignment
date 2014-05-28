
DROP TABLE IF EXISTS usm_researcharea_changes ; 
CREATE TABLE usm_researcharea_changes (
  usm_researcharea_change_id int(10) NOT NULL AUTO_INCREMENT comment 'PK',
  date date NOT NULL,
  time time NOT NULL,
  description varchar(50) NOT NULL,
  FORCode int(10) NOT NULL,
  StaffID int(10) NOT NULL,
  emailAddress varchar(70) ,
  emailSentDate date,
  emailSentTime time,
  PRIMARY KEY (usm_researcharea_change_id)
);

DELIMITER $$

-- -----------------------------------------------------------------------------
-- Record changes to Research Areas to email these to the change subject later
DROP TRIGGER IF EXISTS usm_researcharea_ai $$
CREATE TRIGGER usm_researcharea_ai AFTER INSERT ON 
`University Staff Member_Research Area`
FOR EACH ROW
BEGIN
  DECLARE emailAddressValue varchar(100) ; 

  SELECT email
  FROM `University Staff Member` usm
  WHERE usm.StaffID = NEW.StaffID
  INTO emailAddressValue ;

  INSERT INTO usm_researcharea_changes(date, time, description, FORCode,
  StaffID, emailAddress)
  VALUES (CURRENT_DATE(), CURRENT_TIME(), 'added', NEW.FORCode, NEW.StaffID,
  emailAddressValue ) ;
END $$


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
