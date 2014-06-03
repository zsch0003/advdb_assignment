-- -----------------------------------------------------------------------------
-- Views for RHD staff.

-- All ongoing applications and the contact staff
DROP VIEW IF EXISTS Application_Staff_Overview ;
CREATE VIEW Application_Staff_Overview AS
SELECT 
  AppExpand.ApplicationID,
  AppExpand.FName, 
  AppExpand.LName, 
  AppExpand.Email, 
  PrimaryUSM.FName AS PrimarySupervisorFName,
  PrimaryUSM.LName AS PrimarySupervisorLName,
  COUNT(AssociateSuper.StaffID) AS `Associate supervisor count`,
  LastModifiedByUSM.FName AS LastModifiedByFName,
  LastModifiedByUSM.LName AS LastModifiedByLName
FROM Application_Expanded AS AppExpand
LEFT JOIN (`Supervise as primary` AS PrimarySuper, 
           `University Staff Member` AS PrimaryUSM)
  ON (AppExpand.ApplicationID = PrimarySuper.ApplicationID
      AND PrimarySuper.StaffID = PrimaryUSM.StaffID)
LEFT JOIN (`Supervise as associate` AS AssociateSuper)
  ON (AppExpand.ApplicationID = AssociateSuper.ApplicationID)
LEFT JOIN (`University Staff Member` AS LastModifiedByUSM)
  ON (AppExpand.LastModifiedByStaffID = LastModifiedByUSM.StaffID)
GROUP BY AppExpand.ApplicationID ;


-- a utility view for the view below
DROP VIEW IF EXISTS Application_Primary_Supervisor ;
CREATE VIEW Application_Primary_Supervisor AS
SELECT 
  App.*,
  Super.StaffID, 
  Super.PrimarySupervisor, 
  SUM(Super.PrimarySupervisor) AS PriSuperSum
FROM Application_Expanded App
LEFT OUTER JOIN `Supervise as` Super
  ON Super.ApplicationID = App.ApplicationID 
GROUP BY App.ApplicationID;

-- List only those ongoing applications that don't yet have a primary supervisor
DROP VIEW IF EXISTS Application_Without_Supervisor ;
CREATE VIEW Application_Without_Supervisor AS
SELECT 
  AppPri.ApplicationID,
  AppPri.FName, 
  AppPri.LName, 
  AppPri.Email,
  COUNT(AssociateSuper.StaffID) AS `Associate supervisor count`,
FROM Application_Primary_Supervisor AS AppPri
LEFT JOIN (`Supervise as associate` AS AssociateSuper)
  ON (AppPri.ApplicationID = AssociateSuper.ApplicationID)
WHERE AppPri.PriSuperSum <> 1
  OR AppPri.PriSuperSum IS NULL
GROUP BY AppPri.ApplicationID ;

-- Show those applications that don't yet have a primary supervisor.
-- Where the application has nominated a research area, report which staff
-- member oversees that research area.
DROP VIEW IF EXISTS Application_Research_Area_Overseen_By ;
CREATE VIEW Application_Research_Area_Overseen_By AS
SELECT 
  AppWoSuper.*, 
  AppRA.FORCode, 
  USM.FName as StaffOverseeingAreaFName,
  USM.LName as StaffOverseeingAreaLName
FROM Application_Without_Supervisor AppWoSuper
LEFT JOIN (`Application_Research Area` AS AppRA)
  ON (AppWoSuper.ApplicationID = AppRA.ApplicationID)
LEFT JOIN (`Research Area` AS RA)
  ON (AppRA.FORCode = RA.FORCode)
LEFT JOIN (`University Staff Member_Research Area2` AS USM_RA_Oversees)
  ON (RA.FORCode = USM_RA_Oversees.FORCode)
LEFT JOIN (`University Staff Member` AS USM)
  ON (USM_RA_Oversees.StaffID = USM.StaffID);
