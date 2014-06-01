-- -----------------------------------------------------------------------------
-- For a member of staff, create a view that's shows all the ongoing
-- applications that they're in some way working on.
--
-- In the following, we have hard-coded a user/staff ID of 1000, as we don't
-- have permission in the CSEM MySQL server to create database users. In a real
-- system, we would replace the hard-coded values with the function USER() to
-- get the current database user ID.

-- A utility view with lookup values cached out
DROP VIEW IF EXISTS Application_Expanded ;
CREATE VIEW Application_Expanded AS
SELECT Appt.FName, Appt.LName, Appt.Email, App.*, AppStat.Status 
FROM Application App
INNER JOIN Applicant Appt
  ON Appt.ApplicantID = App.ApplicantID
INNER JOIN `Application Status` AppStat 
  ON AppStat.ApplicationStatusID = App.applicationStatusID; 

-- All the Applications that the current user is marked as supervising
DROP VIEW IF EXISTS `MyRHDApps_SupervisedByMe_Expanded` ;
CREATE VIEW `MyRHDApps_SupervisedByMe_Expanded` AS
SELECT App.* 
FROM Application_Expanded App
INNER JOIN `Supervise as` Super ON Super.ApplicationID = App.ApplicationID
WHERE Super.StaffID = 1000 
;

-- All the Applications that the current user has flagged
DROP VIEW IF EXISTS `MyRHDApps_FlaggedByMe_Expanded` ;
CREATE VIEW `MyRHDApps_FlaggedByMe_Expanded` AS
SELECT App.*
FROM Application_Expanded App 
INNER JOIN `University Staff Member_Application` Flag 
  ON Flag.ApplicationID = App.ApplicationID
WHERE Flag.StaffID = 1000 
;

-- All the Applications that the current user has most recently modified
DROP VIEW IF EXISTS MyRHDApps_LastModifiedByMe_Expanded ;
CREATE VIEW MyRHDApps_LastModifiedByMe_Expanded AS
SELECT App.*
FROM Application_Expanded App
WHERE App.LastModifiedByStaffID = 1000 
;

-- Composite view of the above
DROP VIEW IF EXISTS `MyRHDApps_Expanded` ;
CREATE VIEW `MyRHDApps_Expanded` AS
SELECT * FROM MyRHDApps_SupervisedByMe_Expanded
UNION
SELECT * FROM MyRHDApps_FlaggedByMe_Expanded
UNION
SELECT * FROM MyRHDApps_LastModifiedByMe_Expanded
;

-- As above, but with irrelevent columns suppressed
-- TODO : add checklist items to this view
DROP VIEW IF EXISTS `MyRHDApps` ;
CREATE VIEW `MyRHDApps` AS
SELECT FName, LName, Email, Status FROM MyRHDApps_Expanded


CREATE VIEW `Supervise as primary` AS
SELECT * 
FROM `Supervise as` AS Super
WHERE Super.PrimarySupervisor = 1;

CREATE VIEW `Supervise as associate` AS
SELECT * 
FROM `Supervise as` AS Super
WHERE Super.PrimarySupervisor = 0;

-- A view for RHD staff.
-- All ongoing applications and contact staff
DROP VIEW IF EXISTS Application_Staff_Overview ;
CREATE VIEW Application_Staff_Overview AS
SELECT 
  AppExpand.FName, 
  AppExpand.LName, 
  AppExpand.Email, 
  PrimaryUSM.FName AS PrimarySupervisorFName,
  PrimaryUSM.LName AS PrimarySupervisorLName
FROM Application_Expanded AS AppExpand
LEFT JOIN (`Supervise as primary` AS PrimarySuper, 
           `University Staff Member` AS PrimaryUSM)
  ON (AppExpand.ApplicationID = PrimarySuper.ApplicationID
      AND PrimarySuper.StaffID = PrimaryUSM.StaffID);

