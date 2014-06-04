-- -----------------------------------------------------------------------------
-- For a member of staff, create a view that's shows all the ongoing
-- applications that they're in some way working on.
--
-- In the following, we have hard-coded a user/staff ID of 1000, as we don't
-- have permission in the CSEM MySQL server to create database users. In a real
-- system, we would replace the hard-coded values with the function USER() to
-- get the current database user ID.
SELECT 'Creating views for professional/all staff';

-- All the Applications that the current user is marked as supervising
DROP VIEW IF EXISTS `MyRHDApps_SupervisedByMe_Expanded` ;
CREATE VIEW `MyRHDApps_SupervisedByMe_Expanded` AS
SELECT App.* 
FROM Application_Expanded App
INNER JOIN `Supervise as` Super ON Super.ApplicationID = App.ApplicationID
WHERE Super.StaffID = 1000 ;

-- All the Applications that the current user has flagged
DROP VIEW IF EXISTS `MyRHDApps_FlaggedByMe_Expanded` ;
CREATE VIEW `MyRHDApps_FlaggedByMe_Expanded` AS
SELECT App.*
FROM Application_Expanded App 
INNER JOIN `University Staff Member_Application` Flag 
  ON Flag.ApplicationID = App.ApplicationID
WHERE Flag.StaffID = 1000 ;

-- All the Applications that the current user has most recently modified
DROP VIEW IF EXISTS MyRHDApps_LastModifiedByMe_Expanded ;
CREATE VIEW MyRHDApps_LastModifiedByMe_Expanded AS
SELECT App.*
FROM Application_Expanded App
WHERE App.LastModifiedByStaffID = 1000 ;

-- Composite view of the above
DROP VIEW IF EXISTS `MyRHDApps_Expanded` ;
CREATE VIEW `MyRHDApps_Expanded` AS
SELECT * FROM MyRHDApps_SupervisedByMe_Expanded
UNION
SELECT * FROM MyRHDApps_FlaggedByMe_Expanded
UNION
SELECT * FROM MyRHDApps_LastModifiedByMe_Expanded ;

-- As above, but with irrelevent columns suppressed
-- TODO : add checklist items to this view
DROP VIEW IF EXISTS `MyRHDApps` ;
CREATE VIEW `MyRHDApps` AS
SELECT FName, LName, Email, Status FROM MyRHDApps_Expanded ;

