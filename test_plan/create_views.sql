-- -----------------------------------------------------------------------------
-- For a member of staff, create a view that's shows all the ongoing
-- applications that they're in some way responsible for.

DROP VIEW IF EXISTS `Overview for staff`;

CREATE VIEW `Overview for staff` AS
SELECT appt.FName, appt.LName, appt.Email, app.DateLastModified, 
AppStat.Status
FROM Applicant appt
INNER JOIN Application app ON  appt.ApplicantID = app.ApplicantID 
INNER JOIN `Application Status` AppStat 
  ON  AppStat.ApplicationStatusID = app.applicationStatusID
WHERE appt.LastModifiedByStaffID = 1003 ;

-- CREATE VIEW `Overview for staff` AS
-- SELECT appt.FName, appt.LName, appt.Email 
-- FROM Application app
-- INNER JOIN Applicant appt ON appt.ApplicantID = app.ApplicantID AND Application.LastModifiedByStaffID = 1000;

