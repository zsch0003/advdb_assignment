-- -----------------------------------------------------------------------------
-- For a member of staff, create a view that's shows all the ongoing
-- applications that they're in some way responsible for.

-- DROP VIEW IF EXISTS `Overview for staff`;
-- CREATE VIEW `Overview for staff` AS
-- SELECT appt.FName, appt.LName, appt.Email, app.DateLastModified, 
-- AppStat.Status
-- FROM Applicant appt
-- INNER JOIN Application app ON  appt.ApplicantID = app.ApplicantID 
-- INNER JOIN `Application Status` AppStat 
--   ON  AppStat.ApplicationStatusID = app.applicationStatusID
-- WHERE appt.LastModifiedByStaffID = 1000 

-- UNION 

-- SELECT appt.FName, appt.LName, appt.Email, app.DateLastModified, 
-- AppStat.Status
-- FROM Applicant appt
-- INNER JOIN Application app ON  appt.ApplicantID = app.ApplicantID 
-- INNER JOIN `Application Status` AppStat 
--   ON  AppStat.ApplicationStatusID = app.applicationStatusID
-- INNER JOIN `Supervise as` super ON super.ApplicationID = app.ApplicationID
-- WHERE super.StaffID = 1000 
-- ;

DROP VIEW IF EXISTS Application_Expanded ;
CREATE VIEW Application_Expanded AS
SELECT Appt.FName, Appt.LName, Appt.Email, App.*, AppStat.Status 
FROM Application App
INNER JOIN Applicant Appt
  ON Appt.ApplicantID = App.ApplicantID
INNER JOIN `Application Status` AppStat 
  ON AppStat.ApplicationStatusID = App.applicationStatusID
; 

DROP VIEW IF EXISTS `MyRHDApps_SupervisedByMe_Expanded` ;
CREATE VIEW `MyRHDApps_SupervisedByMe_Expanded` AS
SELECT App.* 
FROM Application_Expanded App
INNER JOIN `Supervise as` Super ON Super.ApplicationID = App.ApplicationID
WHERE Super.StaffID = 1000 
;

DROP VIEW IF EXISTS `MyRHDApps_FlaggedByMe_Expanded` ;
CREATE VIEW `MyRHDApps_FlaggedByMe_Expanded` AS
SELECT App.*
FROM Application_Expanded App 
INNER JOIN `University Staff Member_Application` Flag 
  ON Flag.ApplicationID = App.ApplicationID
WHERE Flag.StaffID = 1000 
;

DROP VIEW IF EXISTS MyRHDApps_LastModifiedByMe_Expanded ;
CREATE VIEW MyRHDApps_LastModifiedByMe_Expanded AS
SELECT App.*
FROM Application_Expanded App
WHERE App.LastModifiedByStaffID = 1000 
;

DROP VIEW IF EXISTS `MyRHDApps_Expanded` ;
CREATE VIEW `MyRHDApps_Expanded` AS
SELECT * FROM MyRHDApps_SupervisedByMe_Expanded
UNION
SELECT * FROM MyRHDApps_FlaggedByMe_Expanded
UNION
SELECT * FROM MyRHDApps_LastModifiedByMe_Expanded
;

DROP VIEW IF EXISTS `MyRHDApps` ;
CREATE VIEW `MyRHDApps` AS
SELECT FName, LName, Email, Status FROM MyRHDApps_Expanded

-- CREATE VIEW `Overview for staff` AS
-- SELECT appt.FName, appt.LName, appt.Email 
-- FROM Application app
-- INNER JOIN Applicant appt ON appt.ApplicantID = app.ApplicantID AND Application.LastModifiedByStaffID = 1000;

