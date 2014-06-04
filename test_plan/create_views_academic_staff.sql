-- -----------------------------------------------------------------------------
-- Create views specific to academic staff members
SELECT 'Creating views for academic staff';

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
DROP FUNCTION IF EXISTS CURRENT_RHD_USER;
CREATE FUNCTION CURRENT_RHD_USER() 
RETURNS mediumint
DETERMINISTIC
BEGIN
  RETURN 1000;
--  RETURN 1001;
END $$

DROP FUNCTION IF EXISTS CURRENT_RHD_TIMESTAMP;
CREATE FUNCTION CURRENT_RHD_TIMESTAMP() 
RETURNS char(19)
DETERMINISTIC
BEGIN
  RETURN '2014-05-17 12:00:00';
--  RETURN current_timestamp();
END $$

DROP FUNCTION IF EXISTS CURRENT_RHD_DATE;
CREATE FUNCTION CURRENT_RHD_DATE()
RETURNS char(10)
DETERMINISTIC
BEGIN
  RETURN DATE(CURRENT_RHD_TIMESTAMP());
END $$

DELIMITER ;

-- List all the applications in the same research area as the current user 
-- has nominated an interest in
DROP VIEW IF EXISTS Recent_Applications_In_My_Research_Area;
CREATE VIEW Recent_Applications_In_My_Research_Area AS
SELECT 
  App.ApplicationID,
  Appt.FName,
  Appt.LName,    
  Appt.Email,
  App.DateAdded,
  RA.Description AS `Research Area Description`,
  USM.FName AS StaffInResearchAreaFName,
  USM.LName AS StaffInResearchAreaLName
FROM Application App 
INNER JOIN Applicant Appt
  ON App.ApplicantID = Appt.ApplicantID
INNER JOIN `Application_Research Area` ARA
  ON App.ApplicationID = ARA.ApplicationID
INNER JOIN `Research Area` AS RA
  ON ARA.FORCode = RA.FORCode
INNER JOIN `University Staff Member_Research Area` USM_RA
  ON ARA.FORCode = USM_RA.FORCode
INNER JOIN `University Staff Member` USM
  ON USM_RA.StaffID = USM.StaffID
WHERE USM_RA.StaffID = CURRENT_RHD_USER()
  AND DATEDIFF(CURRENT_RHD_DATE(), App.DateAdded) >= 7;
