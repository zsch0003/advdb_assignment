-- -----------------------------------------------------------------------------
-- Create views specific to academic staff members
SELECT 'Creating views for academic staff';

-- List all the applications in the same research area as the current user 
-- has nominated an interest in
DROP VIEW IF EXISTS Recent_Applications_In_My_Research_Area;
CREATE VIEW Recent_Applications_In_My_Research_Area AS
SELECT 
  App.DateAdded,
  App.ApplicationID,
  Appt.FName,
  Appt.LName,    
  Appt.Email,
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
  AND DATEDIFF(CURRENT_RHD_DATE(), App.DateAdded) >= 7
ORDER BY App.DateAdded;
