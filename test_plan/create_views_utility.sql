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

