-- -----------------------------------------------------------------------------
-- For a member of staff, create a view that's shows all the ongoing
-- applications that they're in some way working on.
--
-- In the following, we have hard-coded a user/staff ID of 1000, as we don't
-- have permission in the CSEM MySQL server to create database users. In a real
-- system, we would replace the hard-coded values with the function USER() to
-- get the current database user ID.
SELECT 'Creating views for professional/all staff';

-- All the Applications that the current user is marked as primary supervisor
DROP VIEW IF EXISTS `MyRHDApps_SupervisedPrimaryByMe_Expanded` ;
CREATE VIEW `MyRHDApps_SupervisedPrimaryByMe_Expanded` AS
SELECT 'a) primary supervisor' AS `My role`, App.*
FROM Application_Ongoing_Expanded App
INNER JOIN `Supervise as primary` Super 
  ON Super.ApplicationID = App.ApplicationID
WHERE Super.StaffID = CURRENT_RHD_USER() ;

-- An associate supervisor
DROP VIEW IF EXISTS `MyRHDApps_SupervisedAssociateByMe_Expanded` ;
CREATE VIEW `MyRHDApps_SupervisedAssociateByMe_Expanded` AS
SELECT 'b) associate supervisor' AS `My role`, App.*
FROM Application_Ongoing_Expanded App
INNER JOIN `Supervise as associate` Super
  ON Super.ApplicationID = App.ApplicationID
WHERE Super.StaffID = CURRENT_RHD_USER() ;

-- All the Applications that the current user has flagged
DROP VIEW IF EXISTS `MyRHDApps_FlaggedByMe_Expanded` ;
CREATE VIEW `MyRHDApps_FlaggedByMe_Expanded` AS
SELECT 'c) flagged by me' AS `My role`, App.*
FROM Application_Ongoing_Expanded App 
INNER JOIN `University Staff Member_Application` Flag 
  ON Flag.ApplicationID = App.ApplicationID
WHERE Flag.StaffID = CURRENT_RHD_USER() ;

-- All the Applications that the current user has most recently modified
DROP VIEW IF EXISTS MyRHDApps_LastModifiedByMe_Expanded ;
CREATE VIEW MyRHDApps_LastModifiedByMe_Expanded AS
SELECT 'd) modified by me' AS `My role`, App.*
FROM Application_Ongoing_Expanded App
WHERE App.LastModifiedByStaffID = CURRENT_RHD_USER() ;

-- Composite view of the above
DROP VIEW IF EXISTS `MyRHDApps_Expanded` ;
CREATE VIEW `MyRHDApps_Expanded` AS
SELECT * FROM MyRHDApps_SupervisedPrimaryByMe_Expanded
UNION
SELECT * FROM MyRHDApps_SupervisedAssociateByMe_Expanded
UNION
SELECT * FROM MyRHDApps_FlaggedByMe_Expanded
UNION
SELECT * FROM MyRHDApps_LastModifiedByMe_Expanded;


-- As above, but with irrelevent columns suppressed
DROP VIEW IF EXISTS `MyRHDApps` ;
CREATE VIEW `MyRHDApps` AS
SELECT 
  `My role`, 
  FName, 
  LName, 
  Email, 
  Status,
  AddressConfirmed,
  DegreeConfirmed,
  VisaStatusConfirmed,
  ProposalConfirmed,
  HasResearchAreas,
  HasPrimarySuper,
  PayMethConfirmed,
  EngProfConfirmed,
  RefereesConfirmed
FROM MyRHDApps_Expanded
GROUP BY ApplicationID
ORDER BY `My role`, LName;

