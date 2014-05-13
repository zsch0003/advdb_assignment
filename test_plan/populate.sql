--------------------------------------------------------------------------------
-- Application for PhD studies.txt

INSERT INTO Applicant (FName, LName, Email, Mobile, StreetAddress, City,
Postcode, AddressCountryISOCode)
VALUES ('Shirin', 'Ebadi', 'shirin.ebadi@keb.com.de', '+49 (176) 6488 9999',
'Zwillingstr 99, App 099', 'Munich', 80807, 'DE');
-- capture  LAST_INSERT_ID() as se_applicant_id 


INSERT INTO Degree (ApplicantID, Name, Type, YearCompleted, InstitutionName,
InstitutionCountryCode) 
VALUES (se_applicant_id, 'Electrical Engineering with expertise in Control
Theory and Reat-Time Applications', 'bachelor', 2005, 'University of Tabriz',
'IR') ;


INSERT INTO Degree (ApplicantID, Name, Type, YearCompleted, InstitutionName,
InstitutionCountryCode) 
VALUES (se_applicant_id, 'Electrical Engineering with expertise in Control
Theory and Reat-Time Applications', 'masters', 2008, 'University of Tabriz',
'IR') ;

INSERT INTO Application (ApplicantID, awardType)
VALUES (se_applicant_id, 'PhD') ;

INSERT INTO Document (DocType, UploadLink)
VALUES ('CV', '/mnt/data/rhd/' + se_applicant_id + '/CV/001.pdf');


--------------------------------------------------------------------------------
-- FW Your kind supervision for my intended PhD.txt



-- Fwd Flinders Application - PhD (Comp Sc) - Sem 2 2015.txt
-- Fwd Flinders Application - PhD (Computer Science) Sem 2 2014 .txt
-- Fwd Flinders Application.txt
-- Fwd PhD inquiry.txt
-- Fwd Requesting for PhD supervision.txt
-- PhD Student.txt
-- PhD Student1.txt
-- PhD Student2.txt
-- RHD Admission form - march2014.docx
-- Request for PhD Supervision.txt
-- pg_international_application.pdf
