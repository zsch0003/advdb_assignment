--------------------------------------------------------------------------------
-- USER TRANSACTION TESTING
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- a) Look up applicant + publications + degrees + visa Status + Associated
--    documents by applicant name
SELECT * FROM Applicant 
WHERE Applicant.FName = 'Shirin' 
  AND Applicant.LName = 'Ebadi' ;

SELECT * FROM Publication, Applicant 
WHERE Publication.ApplicantID = Applicant.ApplicantID 
  AND Applicant.FName = 'Shirin'
  AND Applicant.LName = 'Ebadi' ;
 
SELECT * FROM Degree, Applicant 
WHERE Degree.ApplicantID = Applicant.ApplicantID 
  AND Applicant.FName = 'Shirin'
  AND Applicant.LName = 'Ebadi' ;

SELECT Visa.VisaStatus FROM Visa, Applicant
WHERE Visa.ApplicantID = Applicant.ApplicantID 
  AND Applicant.FName = 'Shirin'
  AND Applicant.LName = 'Ebadi' ;

SELECT * FROM Document, Applicant 
WHERE Document.ApplicantID = Applicant.ApplicantID 
  AND Applicant.FName = 'Shirin'
  AND Applicant.LName = 'Ebadi' ;
 
--------------------------------------------------------------------------------
-- b) Look up applicant’s applications by applicant name

SELECT * FROM Application, Applicant 
WHERE Application.ApplicantID = Applicant.ApplicantID 
  AND Applicant.FName = 'Shirin'
  AND Applicant.LName = 'Ebadi' ;
-- expect ApplicationID = 111, Type = 'PhD'

--------------------------------------------------------------------------------
-- c) Look up applicant’s applications by applicant email
SELECT * FROM Application, Applicant 
WHERE Application.ApplicantID = Applicant.ApplicantID 
  AND Applicant.Email = 'don.memo@hotmail.com' ;
-- expect ApplicationID = 211, Type = 'PhD'


--------------------------------------------------------------------------------
-- d) Look up incomplete applications
SELECT * FROM Application
WHERE Application.applicationStatus <> 'complete.accepted' 
  AND  Application.applicationStatus <> 'complete.declined'
  AND  Application.applicationStatus <> 'complete.lapsed' ;
-- expect all 10 applications

--------------------------------------------------------------------------------
-- e) Look up all correspondences relevant to an application
SELECT * FROM Correspondence
WHERE Correspondence.ApplicationID = 2 ;


--------------------------------------------------------------------------------
-- f) Create new applicant and associated application records
-- 
-- tested in populate.sql script


--------------------------------------------------------------------------------
-- g) Look up which staff member updated an Application most recently
SELECT UniversityStaffMember.FName, UniversityStaffMember.LName
FROM UniversityStaffMember, Application
WHERE Application.ApplicationID = 3
  AND Application.LastToModifyStaffID = UniversityStaffMember.StaffID ;
-- expect 'Paul' 'Calder'

--------------------------------------------------------------------------------
-- h) Check for any decision recorded about an application
SELECT * FROM Decision
WHERE Decision.ApplicationID = 4 ;
-- expect COUNT = 1
-- expect StaffID = 1001
-- expect dectype = 'RFI'

--------------------------------------------------------------------------------
-- i) Look up an existing application and attach a new standard type document to
-- an application

-- tested by populate.sql script

--------------------------------------------------------------------------------
-- j) Look up an existing application and attached a new exceptional type
-- document to an application
--
-- tested by populate.sql script

--------------------------------------------------------------------------------
-- k) Look up an existing application and list outstanding information
-- (checklist).
SELECT applicationStatus, AddressConfirmed, DegreeConfirmed, 
VisaStatusConfirmed, ProposalConfirmed, HasResearchAreas, HasPrimarySuper,
PayMethConfirmed, EngProfConfirmed 
FROM Application
WHERE Application.ApplicationID = 611 ;

--------------------------------------------------------------------------------
-- l) Update the checklist to confirm that a mandatory information requirement
-- has been met
UPDATE Application 
SET AddressConfirmed = 1 
WHERE Application.ApplicationID = 611 ;

--------------------------------------------------------------------------------
-- m) Retrieve all on-going applications for which the user has made the most
-- recent correspondence
SELECT *
FROM Application
WHERE Application.applicationStatus = 'ongoing'
  AND Application.LastToModifyStaffID = 1 ; 

--------------------------------------------------------------------------------
-- n) Record making a decision about an application
-- tested in populate.sql script

--------------------------------------------------------------------------------
-- o) Update the status of an application
UPDATE Application
SET Application.ApplicationStatus = 'complete.declined'
WHERE Application.ApplicationID = 611 ;

--------------------------------------------------------------------------------
-- p) Look up, add to, and delete from own current research areas
SELECT *
FROM ResearchArea, UniversityStaffMember_ResearchArea
WHERE ResearchArea.FORCode = UniversityStaffMember_ResearchArea.FORCode 
  AND UniversityStaffMember_ResearchArea.StaffID = 1 ;

--------------------------------------------------------------------------------
-- q) Search for all applications in certain research areas that have been added
-- since a certain time
-- TODO: dates
SELECT * 
FROM Application, Application_ResearchArea
WHERE Application.DateAdded >= '2014.05.14' 
  AND Application.ApplicationID = Application_ResearchArea.ApplicationID
  AND Application_ResearchArea.FORCode = 100503 ;


--------------------------------------------------------------------------------
-- r) Flag interest in an application
INSERT INTO UniversityStaffMember_Application (StaffID, ApplicationID)
VALUES (1000, 07);

INSERT INTO UniversityStaffMember_Application (StaffID, ApplicationID)
VALUES (1002, 07);

--------------------------------------------------------------------------------
-- s) Retrieve all staff who have flagged an application, or have edited an
-- application or applicant record most recently
SELECT UniversityStaffMember.FName, UniversityStaffMember.LName
FROM UniversityStaffMember, UniversityStaffMember_Application
WHERE UniversityStaffMember_Application.ApplicationID = 7
  AND UniversityStaffMember_Application.StaffID = UniversityStaffMember.StaffID;
-- expect Denise de Vries and John Roddick

SELECT UniversityStaffMember.FName, UniversityStaffMember.LName
FROM Application, UniversityStaffMember
WHERE Application.ApplicationID = 7 
  AND Application.LastToModifyStaffID = UniversityStaffMember.StaffID ;
-- expect Denise de Vries

--------------------------------------------------------------------------------
-- t) Retrieve all ongoing applications
SELECT *
FROM Application
WHERE Application.applicationStatus = 'ongoing' ;
