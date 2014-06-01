-- A view for RHD staff.
-- All ongoing applications and contact staff
DROP VIEW IF EXISTS Application_Staff_Overview ;
CREATE VIEW Application_Staff_Overview AS
SELECT 
  AppExpand.ApplicationID,
  AppExpand.FName, 
  AppExpand.LName, 
  AppExpand.Email, 
  PrimaryUSM.FName AS PrimarySupervisorFName,
  PrimaryUSM.LName AS PrimarySupervisorLName,
  COUNT(AssociateSuper.StaffID) AS `Associate supervisor count`
FROM Application_Expanded AS AppExpand
LEFT JOIN (`Supervise as primary` AS PrimarySuper, 
           `University Staff Member` AS PrimaryUSM)
  ON (AppExpand.ApplicationID = PrimarySuper.ApplicationID
      AND PrimarySuper.StaffID = PrimaryUSM.StaffID)
LEFT JOIN (`Supervise as associate` AS AssociateSuper)
  ON (AppExpand.ApplicationID = AssociateSuper.ApplicationID)
GROUP BY AppExpand.ApplicationID ;
