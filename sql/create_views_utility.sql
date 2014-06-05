SELECT 'Creating utility views';

-- A utility view with lookup values cached out
DROP VIEW IF EXISTS Application_Ongoing_Expanded ;
CREATE VIEW Application_Ongoing_Expanded AS
SELECT Appt.FName, Appt.LName, Appt.Email, App.*, AppStat.Status 
FROM Application App
INNER JOIN Applicant Appt
  ON Appt.ApplicantID = App.ApplicantID
INNER JOIN `Application Status` AppStat 
  ON AppStat.ApplicationStatusID = App.applicationStatusID
WHERE AppStat.Status LIKE 'ongoing%'; 


-- Create views to separate primary supervisors from associate
DROP VIEW IF EXISTS `Supervise as primary` ;
CREATE VIEW `Supervise as primary` AS
SELECT * 
FROM `Supervise as` AS Super
WHERE Super.PrimarySupervisor = 1;

DROP VIEW IF EXISTS `Supervise as associate` ;
CREATE VIEW `Supervise as associate` AS
SELECT * 
FROM `Supervise as` AS Super
WHERE Super.PrimarySupervisor = 0;



DELIMITER $$

-- A function to simulate user switching
-- +--------+--------+----------+--------------+-------------------------------+
-- |StaffID | FName  | LName    | canSupervise | email                         |
-- +--------+--------+----------+--------------+-------------------------------+
-- |   1000 | Denise | de Vries |            1 | denise.deries@flinders.edu.au |
-- |   1001 | Paul   | Calder   |            1 | paul.calder@flinders.edu.au   |
-- |   1002 | John   | Roddick  |            1 | john.roddick@flinders.edu.au  |
-- |   1003 | Jennie | Brand    |            0 | jennie.brand@flinders.edu.au  |
-- +--------+--------+----------+--------------+-------------------------------+
DROP FUNCTION IF EXISTS CURRENT_RHD_USER $$
CREATE FUNCTION CURRENT_RHD_USER() 
RETURNS mediumint
DETERMINISTIC
BEGIN
  RETURN 1000;
--  RETURN 1001;
END $$

DROP FUNCTION IF EXISTS CURRENT_RHD_TIMESTAMP $$
CREATE FUNCTION CURRENT_RHD_TIMESTAMP() 
RETURNS char(19)
DETERMINISTIC
BEGIN
  RETURN '2014-05-17 12:00:00';
--  RETURN current_timestamp();
END $$

DROP FUNCTION IF EXISTS CURRENT_RHD_DATE $$
CREATE FUNCTION CURRENT_RHD_DATE()
RETURNS char(10)
DETERMINISTIC
BEGIN
  RETURN DATE(CURRENT_RHD_TIMESTAMP());
END $$

DELIMITER ;

