-- -----------------------------------------------------------------------------
-- security.sql
--
-- Script to assist DB admins to enforce security policies. This needs to be
-- read into the DB with admin privileges.
--
-- -----------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS insert_new_staff ;


DELIMITER $$

CREATE PROCEDURE insert_new_staff(
  IN p_staffID int(10),
  IN p_password varchar(255),
  IN p_fName varchar(50),
  IN p_lName varchar(50),
  IN p_canSupervise int(1),
  IN p_email varchar(100) )
BEGIN

  -- Create a database user.
  -- Have to use dynamic SQL here because of the password.
  SET @create_user_query = CONCAT(
        'CREATE USER "', p_staffID, '" IDENTIFIED BY "', p_password, '" ');
  PREPARE create_user_stmt FROM @create_user_query ; 
  EXECUTE create_user_stmt ;
  DEALLOCATE PREPARE create_user_stmt;

  -- add the staff member
  INSERT INTO `University Staff Member` (StaffID, FName, LName, canSupervise, 
  Email)
  VALUES (p_staffID, p_fName, p_lName, p_canSupervise, p_email) ;

  -- Set the appropriate permissions:
  --  - no delete permissions
  --  - only select on 'University Staff Member'
  --  - select, update and insert on all other tables
  GRANT SELECT ON TABLE `University Staff Member` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Applicant` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Application` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Application Status` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Application_Research Area` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Award Type` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Correspondence` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Correspondence Method` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Country` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Decision` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Decision Type` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Degree` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Document` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Document Status` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Document Type` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Payment Method` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Publication` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Referee` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Research Area` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Visa` TO p_staffID;
  GRANT SELECT,UPDATE,INSERT ON TABLE `Visa Status` TO p_staffID;

  -- These tables consist (almost) entirely of FKs, so update isn't really needed, and
  -- this makes monitoring changes to these with triggers more straightforward.
  GRANT SELECT,INSERT,DELETE ON TABLE `Supervise as` TO p_staffID;
  GRANT SELECT,INSERT,DELETE ON TABLE `University Staff Member_Application` 
    TO p_staffID;
  GRANT SELECT,INSERT,DELETE ON TABLE `University Staff Member_Research Area` 
    TO p_staffID;
  GRANT SELECT,INSERT,DELETE ON TABLE `University Staff Member_Research Area2` 
    TO p_staffID;

END $$

DELIMITER ;

