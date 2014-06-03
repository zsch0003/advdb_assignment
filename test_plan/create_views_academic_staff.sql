-- -----------------------------------------------------------------------------
-- Create views specific to academic staff members


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
CREATE FUNCTION current_rhd_user() 
RETURNS mediumint
DETERMINISTIC
BEGIN
  RETURN 1000;
END $$

CREATE FUNCTION current_rhd_timestamp() 
RETURNS char(19)
DETERMINISTIC
BEGIN
  RETURN '2014-05-01 12:00:00';
--  RETURN current_timestamp();
END $$

DELIMITER ;

-- List all the applications in the same research area as the current user 
-- has nominated an interest in
SELECT 
  App.ApplicationID,
  Appt.FName,
  Appt.LName,    
  Appt.Email,
  App.DateAdded,
  USM.FName AS StaffInResearchAreaFName,
  USM.LName AS StaffInResearchAreaLName
FROM Application App 
INNER JOIN Applicant Appt
  ON App.ApplicantID = Appt.ApplicantID
INNER JOIN `Application_Research Area` ARA
  ON App.ApplicationID = ARA.ApplicationID
INNER JOIN `University Staff Member_Research Area` USM_RA
  ON ARA.FORCode = USM_RA.FORCode
INNER JOIN `University Staff Member` USM
  ON USM_RA.StaffID = USM.StaffID
WHERE App.DateAdded >= '2014-05-01' 
  AND ARA.FORCode = 100503 ;
