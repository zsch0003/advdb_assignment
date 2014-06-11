-- -----------------------------------------------------------------------------
-- Required queries for user transactions
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- a)
-- -----------------------------------------------------------------------------
-- a1) List all the attributes of an Applicant, given a name
SELECT *
FROM Applicant 
WHERE Applicant.FName = 'Shirin' 
  AND Applicant.LName = 'Ebadi' ;

-- a2) List all the attributes of Publication rows associated with an applicant,
-- given an applicant name
SELECT P.*
FROM Publication P
INNER JOIN (Applicant A) ON P.ApplicantID = A.ApplicantID
WHERE A.FName = 'Abdul-Allah' AND A.LName = 'Al-Sadhan' ;

-- a3) List all attributes of Degree rows associated with an applicant,
-- given an applicant name
SELECT D.*
FROM Degree D
INNER JOIN Applicant A ON  D.ApplicantID = A.ApplicantID 
WHERE A.FName = 'Shirin' AND A.LName = 'Ebadi' ;

-- a4) List all attributes of Visa rows associated with an applicant,
-- given an applicant name
SELECT V.*
FROM Visa V
INNER JOIN Applicant A ON V.ApplicantID = A.ApplicantID 
WHERE A.FName = 'Shirin' AND A.LName = 'Ebadi' ;

-- a5) List all attributes of Document rows associated with an applicant,
-- given an applicant name
SELECT D.*, DT.Type
FROM Document D
INNER JOIN Applicant A ON D.ApplicantID = A.ApplicantID 
INNER JOIN `Document Type` DT ON D.DocTypeID = DT.DocTypeID 
WHERE A.FName = 'Shirin' AND A.LName = 'Ebadi' ;

-- -----------------------------------------------------------------------------
-- b) Look up applicant's applications by applicant name
-- Applicant_Expanded is a view that resolves lookup table IDs to values
SELECT AE.*
FROM Application_Expanded AE
INNER JOIN Applicant Appt ON Appt.ApplicantID = AE.ApplicantID 
WHERE Appt.FName = 'Shirin' AND Appt.LName = 'Ebadi' ;

-- -----------------------------------------------------------------------------
-- c) Look up applicant's applications by applicant email
SELECT AE.*
FROM Application_Expanded AE
INNER JOIN Applicant Appt ON Appt.ApplicantID = AE.ApplicantID 
WHERE Appt.Email = 'don.memo@hotmail.com' ;

-- -----------------------------------------------------------------------------
-- d) Look up incomplete applications
SELECT AE.*
FROM Application_Expanded AE
WHERE AE.applicationStatusID < 10500 ;

-- -----------------------------------------------------------------------------
-- e) Look up all correspondences relevant to an application
SELECT Corr.*
FROM Application App
INNER JOIN Correspondence Corr ON Corr.ApplicationID = App.ApplicationID
INNER JOIN Applicant Appt ON Appt.ApplicantID = App.ApplicantID
WHERE Appt.FName = 'Mustafa' AND Appt.LName =  'Al Lami' ;


-- -----------------------------------------------------------------------------
-- f) Is demonstrated in test plan populate scripts

-- -----------------------------------------------------------------------------
-- g) Look up which staff member updated an Application most recently. Project
-- the StaffID, their first name and last name.
SELECT USM.StaffID, USM.FName, USM.LName
FROM Application App
INNER JOIN `University Staff Member` USM 
  ON USM.StaffID = App.LastModifiedByStaffID
WHERE App.ApplicationID = 311 ;

-- -----------------------------------------------------------------------------
-- h) Check for any decision recorded about an application. Project all
-- Decision attributes.
SELECT Decision.*, DT.type
FROM Application App
INNER JOIN Decision ON Decision.ApplicationID = App.ApplicationID
INNER JOIN `Decision Type` DT 
  ON DT.DecisionTypeID = Decision.DecisionTypeID
WHERE App.ApplicationID = 411 ;

-- -----------------------------------------------------------------------------
-- k) Look up an existing application and list outstanding information
-- (checklist). Use utility view
SELECT AQ.* 
FROM Application_Quickview AQ
WHERE AQ.ApplicationID = 611 ;

-- -----------------------------------------------------------------------------
-- l) Update the checklist to confirm that a mandatory information requirement
-- has been met. 
UPDATE Application 
SET AddressConfirmed = 1 
WHERE Application.ApplicationID = 611 ;

  -- expect success
  -- rerun k), expect AddressConfirmed == 1/true

-- -----------------------------------------------------------------------------
-- m) Retrieve all on-going applications for which the user has made the most
-- recent correspondence
SELECT AE.*
FROM Application_Expanded AE
INNER JOIN `Application Status` AppStat
  ON AppStat.ApplicationStatusID = AE.ApplicationStatusID
WHERE AppStat.Status LIKE 'ongoing%'
  AND AE.LastModifiedByStaffID = CURRENT_RHD_USER();

-- -----------------------------------------------------------------------------
-- o) Update the status of an application. Do nested join to retrieve the ID
-- of the new status, given its string representation.
UPDATE Application App
JOIN 
  (SELECT * FROM `Application Status` AppStat
   WHERE AppStat.Status = 'complete.declined') AS Lookup
SET App.applicationStatusID = Lookup.ApplicationStatusID
WHERE App.ApplicationID = 611 ;

  -- expect success
  -- rerun k), expect Status == 'complete.declined'

-- -----------------------------------------------------------------------------
-- p) Look up, add to, and delete from own current research areas
-- p1) look up current research areas
SELECT RA.FORCode, RA.Description
FROM `Research Area` RA
INNER JOIN `University Staff Member_Research Area` USMRA
  ON USMRA.FORCode = RA.FORCode
INNER JOIN `University Staff Member` USM ON USMRA.StaffID = USM.StaffID
WHERE USM.StaffID = 1000 ;

-- p2) Insert new research areas tested in populate script

-- p3) Delete research areas
DELETE `University Staff Member_Research Area` USMRA
FROM `University Staff Member_Research Area` USMRA
JOIN
  (SELECT RA.FORCode FROM `Research Area` RA
   WHERE Description LIKE 'information systems not elsewhere classified')
  AS Lookup
WHERE StaffID = 1000 
  AND USMRA.FORCode = Lookup.FORCode;

  -- rerun p1) to see a different result

-- -----------------------------------------------------------------------------
-- q) Search for all applications in certain research areas that have been added
-- since a certain time. Use the academic staff view.
SELECT * 
FROM Recent_Applications_In_My_Research_Area;

-- -----------------------------------------------------------------------------
-- s) Retrieve all staff who have flagged an application, or have edited an
-- application. Use an RHD staff view.
SELECT * 
FROM Application_Staff_Overview;

-- -----------------------------------------------------------------------------
-- t) Retrieve all ongoing applications. Use a utility view.
SELECT * 
FROM Application_Quickview AQ
WHERE AQ.Status LIKE 'ongoing%';

-- -----------------------------------------------------------------------------
-- u) List all applications waiting for supervisor agreement. Use an RHD staff
-- view. This view is intended to help RHD staff identify a staff member who may
-- can supervise the application. The following columns are projected:
--
-- ApplicationID
-- FName                       - Applicant's first name
-- LName                       - Applicant's last name
-- Email                       - Applicant's email
-- DateAdded                   - the date the application was first added to the
--                               system
-- Associate supervisor count  - the number of associate (not primary)
--                               supervisors registered for this application
-- FORCode                     - Field of Research codes identified for the 
--                               application. There may be multiple of these, so
--                               the row may be repeated
-- StaffOverseeingAreaFName    - the first name of the member of staff who 
--                               oversees the FORCode research area 
-- StaffOverseeingAreaLName    - the last name of the member of staff who 
--                               oversees the FORCode research area 
SELECT * 
FROM Application_Without_Supervisor;
