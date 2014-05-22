-- -----------------------------------------------------------------------------
-- USER TRANSACTION TESTING
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- a) Look up applicant + publications + degrees + visa Status + Associated
--    documents by applicant name
SELECT * FROM Applicant 
WHERE Applicant.FName = 'Shirin' 
  AND Applicant.LName = 'Ebadi' ;

-- TODO: need to add some publication info
SELECT * FROM Publication, Applicant 
WHERE Publication.ApplicantID = Applicant.ApplicantID 
  AND Applicant.FName = 'Shirin'
  AND Applicant.LName = 'Ebadi' ;
 

SELECT Degree.* FROM Degree, Applicant 
WHERE Degree.ApplicantID = Applicant.ApplicantID 
  AND Applicant.FName = 'Shirin'
  AND Applicant.LName = 'Ebadi' ;
-- two rows, ids 121 and 122, bachelor and masters

-- TODO: need to add visa info
SELECT Visa.VisaStatus FROM Visa, Applicant
WHERE Visa.ApplicantID = Applicant.ApplicantID 
  AND Applicant.FName = 'Shirin'
  AND Applicant.LName = 'Ebadi' ;

SELECT Document.* FROM Document, Applicant 
WHERE Document.ApplicantID = Applicant.ApplicantID 
  AND Applicant.FName = 'Shirin'
  AND Applicant.LName = 'Ebadi' ;
-- one row, id 131, cv
 
-- -----------------------------------------------------------------------------
-- b) Look up applicant’s applications by applicant name

SELECT * FROM Application, Applicant 
WHERE Application.ApplicantID = Applicant.ApplicantID 
  AND Applicant.FName = 'Shirin'
  AND Applicant.LName = 'Ebadi' ;
-- expect ApplicationID = 111, Type = 'PhD'

-- -----------------------------------------------------------------------------
-- c) Look up applicant’s applications by applicant email
SELECT * FROM Application, Applicant 
WHERE Application.ApplicantID = Applicant.ApplicantID 
  AND Applicant.Email = 'don.memo@hotmail.com' ;
-- expect ApplicationID = 211, Type = 'PhD'


-- -----------------------------------------------------------------------------
-- d) Look up incomplete applications
SELECT * FROM Application
WHERE Application.applicationStatus <> 'complete.accepted' 
  AND  Application.applicationStatus <> 'complete.declined'
  AND  Application.applicationStatus <> 'complete.lapsed' ;
-- expect all 11 applications

-- -----------------------------------------------------------------------------
-- e) Look up all correspondences relevant to an application
-- TODO: correspondence info
SELECT * FROM Correspondence
WHERE Correspondence.ApplicationID = 2 ;


-- -----------------------------------------------------------------------------
-- f) Create new applicant and associated application records
-- 
-- tested in populate.sql script


-- -----------------------------------------------------------------------------
-- g) Look up which staff member updated an Application most recently
SELECT `University Staff Member`.FName, `University Staff Member`.LName
FROM `University Staff Member`, Application
WHERE Application.ApplicationID = 311
  AND Application.LastModifiedByStaffID = `University Staff Member`.StaffID ;
-- expect 'Paul' 'Calder'

-- -----------------------------------------------------------------------------
-- h) Check for any decision recorded about an application
-- TODO: some Decision info
SELECT * FROM Decision
WHERE Decision.ApplicationID = 4 ;
-- expect COUNT = 1
-- expect StaffID = 1001
-- expect dectype = 'RFI'

-- -----------------------------------------------------------------------------
-- i) Look up an existing application and attach a new standard type document to
-- an application

-- tested by populate.sql script

-- -----------------------------------------------------------------------------
-- j) Look up an existing application and attached a new exceptional type
-- document to an application
--
-- tested by populate.sql script

-- -----------------------------------------------------------------------------
-- k) Look up an existing application and list outstanding information
-- (checklist).
SELECT applicationStatus, AddressConfirmed, DegreeConfirmed, 
VisaStatusConfirmed, ProposalConfirmed, HasReasearchAreas, HasPrimarySuper,
PayMethConfirmed, EngProfConfirmed 
FROM Application
WHERE Application.ApplicationID = 611 ;

-- -----------------------------------------------------------------------------
-- l) Update the checklist to confirm that a mandatory information requirement
-- has been met
UPDATE Application 
SET AddressConfirmed = 1 
WHERE Application.ApplicationID = 611 ;

-- -----------------------------------------------------------------------------
-- m) Retrieve all on-going applications for which the user has made the most
-- recent correspondence
SELECT *
FROM Application
WHERE Application.applicationStatus = 'ongoing'
  AND Application.LastModifiedByStaffID = 1002 ; 
-- three rows, ids 111, 611 and 1011

-- -----------------------------------------------------------------------------
-- n) Record making a decision about an application
-- tested in populate.sql script

-- -----------------------------------------------------------------------------
-- o) Update the status of an application
UPDATE Application
SET Application.ApplicationStatus = 'complete.declined'
WHERE Application.ApplicationID = 611 ;
-- now two rows for transaction m

-- -----------------------------------------------------------------------------
-- p) Look up, add to, and delete from own current research areas
SELECT *
FROM ResearchArea, `University Staff Member`_ResearchArea
WHERE ResearchArea.FORCode = `University Staff Member`_ResearchArea.FORCode 
  AND `University Staff Member`_ResearchArea.StaffID = 1 ;

-- -----------------------------------------------------------------------------
-- q) Search for all applications in certain research areas that have been added
-- since a certain time
-- TODO: dates
SELECT * 
FROM Application, `Application_Research Area`
WHERE Application.DateAdded >= '2014-05-01' 
  AND Application.ApplicationID = `Application_Research Area`.ApplicationID
  AND `Application_Research Area`.FORCode = 100503 ;
-- expect 1 row, id 611

-- -----------------------------------------------------------------------------
-- r) Flag interest in an application
INSERT INTO `University Staff Member_Application` (StaffID, ApplicationID)
VALUES (1000, 711);

INSERT INTO `University Staff Member_Application` (StaffID, ApplicationID)
VALUES (1002, 711);

-- -----------------------------------------------------------------------------
-- s) Retrieve all staff who have flagged an application, or have edited an
-- application or applicant record most recently
SELECT `University Staff Member`.FName, `University Staff Member`.LName
FROM `University Staff Member`, `University Staff Member_Application`
WHERE `University Staff Member_Application`.ApplicationID = 711
  AND `University Staff Member_Application`.StaffID = `University Staff Member`.StaffID;
-- expect Denise de Vries and John Roddick

SELECT `University Staff Member`.FName, `University Staff Member`.LName
FROM Application, `University Staff Member`
WHERE Application.ApplicationID = 711 
  AND Application.LastModifiedByStaffID = `University Staff Member`.StaffID ;
-- expect Jennie Brand

-- -----------------------------------------------------------------------------
-- t) Retrieve all ongoing applications
SELECT *
FROM Application
WHERE Application.applicationStatus = 'ongoing' ;
-- 10 rows by this stage
