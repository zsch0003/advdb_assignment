SELECT "Loading populate_apps.sql" ;

-- IDs
--   Applicant 1-9-
--   Application x11 - x19
--   Degree      x21 - x29
--   Document    x31 - x39
--   Correspondence x41 - x49

-- -----------------------------------------------------------------------------
-- Reset tables and import other info
DELETE FROM `Application_Research Area`;
DELETE FROM Decision;
DELETE FROM Degree;
DELETE FROM Document;
DELETE FROM Application;
DELETE FROM Applicant;
DELETE FROM Correspondence;

-- -----------------------------------------------------------------------------
-- Application for PhD studies.txt
-- 01
SELECT "Populating Applicant 1 info" ;

INSERT INTO Applicant (ApplicantID, FName, LName, Email, Mobile, StreetAddress, 
City, Postcode, AddressCountryISOCode, DateAdded, LastModifiedByStaffID)
VALUES (01, 'Shirin', 'Ebadi', 'shirin.ebadi@keb.com.de', 
'+49 (176) 6488 9999', 'Zwillingstr 99, App 099', 'Munich', 80807, 'DE', 
'2014-05-01', 1001);

INSERT INTO Degree (DegID, ApplicantID, Name, Type, YearCompleted, 
InstitutionName, InstitutionCountryISOCode) 
VALUES (121, 01, 'Electrical Engineering with expertise in Control
Theory and Reat-Time Applications', 'bachelor', '2005-12-31', 
'University of Tabriz', 'IR') ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, YearCompleted, 
InstitutionName, InstitutionCountryISOCode) 
VALUES (122, 01, 'Electrical Engineering with expertise in Control
Theory and Reat-Time Applications', 'masters', '2008-12-31', 
'University of Tabriz', 'IR') ;

INSERT INTO Application (ApplicationID, ApplicantID, awardID, DateAdded, 
DateLastChecked, DateLastModified, LastModifiedByStaffID, applicationStatusID)
VALUES (111, 01, 40000, '2014-05-01', '2014-05-01', '2014-05-01', 1002, 10000) ;

INSERT INTO Document (DocID, UploadLink, ApplicantID, DocTypeID, DocStatusID)
VALUES (131, '/mnt/data/rhd/01/CV/001.pdf', 01, 20001, 30000);

-- Denise to supervise this
INSERT INTO `Supervise as` (PrimarySupervisor, ApplicationID, StaffID)
VALUES (1, 111, 1000);


-- -----------------------------------------------------------------------------
-- FW Your kind supervision for my intended PhD.txt
-- 2
SELECT "Populating Applicant 2 info" ;

INSERT INTO Applicant (ApplicantID, FName, LName, Email, Mobile, Phone, 
DateAdded, LastModifiedByStaffID)
VALUES (2, 'Mohammad', 'Almalki', 'don.memo@hotmail.com', '+966 565907070', 
'+966 12 527000000 ext 4951', '2014-05-02', 1003);

INSERT INTO Application (ApplicantID, ApplicationID, awardID, DateAdded, 
DateLastChecked, DateLastModified, LastModifiedByStaffID, applicationStatusID)
VALUES (2, 211, 40000, '2014-05-02', '2014-05-02', '2014-05-02', 1003, 10000) ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, YearCompleted, 
InstitutionName, InstitutionCountryISOCode) 
VALUES (221, 2, 'IT', 'master', '2010-12-31', 
'University of Technology Sydney', 'AU') ;

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, DocStatusID)
VALUES ('/mnt/data/rhd/02/CV/001.pdf', 
02, 20001, 30000) ;

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, Description, 
DocStatusID)
VALUES ('/mnt/data/rhd/02/transcript/001.pdf', 
02, 20005, 'transcript of masters course', 30000) ;

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, Description, 
DocStatusID)
VALUES ('/mnt/data/rhd/02/certificate/001.pdf', 
02, 20004, 'bachelors certificate', 30000) ;

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocTypeID, 
DocStatusID)
VALUES ('/mnt/data/rhd/02/proposal/001.pdf', 
02, 211, 20007, 30000) ;

-- Denise to supervise this (associate supervision)
INSERT INTO `Supervise as` (PrimarySupervisor, ApplicationID, StaffID)
VALUES (0, 211, 1000);

-- -----------------------------------------------------------------------------
-- Fwd Flinders Application - PhD (Comp Sc) - Sem 2 2015.txt
-- 3
SELECT "Populating Applicant 3 info" ;

INSERT INTO Applicant (ApplicantID, FName, LName, StudentID, DateAdded, 
LastModifiedByStaffID)
VALUES (03, 'Azzam', 'Alwash', '1234567', '2014-05-03', 1003) ;

INSERT INTO Application (ApplicationID, ApplicantID, awardID, ProposalSummary, 
ProposedStartDate, DateAdded, DateLastChecked, DateLastModified, 
LastModifiedByStaffID, applicationStatusID)
VALUES (311, 03, 40001,
'Genetic algorithms for Arabic character recognition', '2015-07-01', 
'2014-05-03', '2014-05-03', '2014-05-03', 1001, 10000) ;

INSERT INTO Degree (ApplicantID, Name, Type, GPA, InstitutionCountryISOCode)
VALUES (03, 'IS and CS', 'bachelors', 4.27, 'IQ') ;

INSERT INTO Degree (ApplicantID, Name, Type, GPA, InstitutionCountryISOCode)
VALUES (03, 'IT', 'masters', 6.79, 'MY') ;

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocTypeID, 
DocStatusID)
VALUES ('/mnt/data/rhd/03/Application/0001.pdf', 03, 311, 20000, 30000);

-- Denise to supervise this 
INSERT INTO `Supervise as` (PrimarySupervisor, ApplicationID, StaffID)
VALUES (1, 311, 1000);

-- Paul Calder to supervise this (associate)
INSERT INTO `Supervise as` (PrimarySupervisor, ApplicationID, StaffID)
VALUES (0, 311, 1001);

-- John Roddick to supervise this (associate)
INSERT INTO `Supervise as` (PrimarySupervisor, ApplicationID, StaffID)
VALUES (0, 311, 1002);

-- -----------------------------------------------------------------------------
-- Fwd Flinders Application - PhD (Computer Science) Sem 2 2014 .txt
-- 4
SELECT "Populating Applicant 4 info" ;

INSERT INTO Applicant (ApplicantID, FName, LName, StudentID, DateAdded,
LastModifiedByStaffID)
VALUES (04, 'Mustafa', 'Al Lami', 2130106, '2014-05-04', 1000);

INSERT INTO Application (ApplicationID, ApplicantID, awardID, ProposalSummary,
DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID,
applicationStatusID)
VALUES (411, 04, 40000, 'Cloud computing for large scale data analysis',
'2014-05-04', '2014-05-04', '2014-05-04', 1003, 10000) ;

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, DocStatusID)
VALUES ('/mnt/data/rhd/04/faculty_assessment_memo/0001.pdf',
04, 20003, 30000);

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, DocStatusID)
VALUES ('/mnt/data/rhd/04/general/0001.pdf',
04, 20011, 30000);

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, DocStatusID)
VALUES ('/mnt/data/rhd/04/general/0002.pdf', 04, 20011, 30000);

-- Paul Colder asks for more info about masters
INSERT INTO Decision ( DecID, ApplicationID, Date, DecisionTypeID, Comment, 
StaffID)
VALUES (1, 411, '2014.05.15', 50003, 
'Have asked for more info about Masters project', 1001 );

INSERT INTO Correspondence (CorrID, `Date`, CorrMethodID, Summary, 
ApplicationID, StaffID)
VALUES (441, '2014-05-04', 60000, 'Initial inquiry from applicant', 411, 1001);
  
INSERT INTO Correspondence (CorrID, `Date`, CorrMethodID, Summary, 
ApplicationID, StaffID)
VALUES (442, '2014-05-04', 60000, 'Asked applicant for more information', 411, 
1001);
  

-- -----------------------------------------------------------------------------
-- Fwd Flinders Application.txt
-- 5
SELECT "Populating Applicant 5 info" ;

INSERT INTO Applicant (ApplicantID, FName, StudentID, DateAdded, 
LastModifiedByStaffID)
VALUES (05, 'Ena', '2345678', '2014-05-05', 1001) ;

INSERT INTO Application (ApplicationID, ApplicantID, ProposedStartDate,
DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID, 
applicationStatusID)
VALUES (511, 05, '2014-07-01', '2014-05-05', '2014-05-05', '2014-05-05', 1001, 
10000) ; 

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocTypeID, 
DocStatusID)
VALUES ('/mnt/data/rhd/05/proposal/0001.pdf', 05, 511, 20007, 30000);

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocTypeID, 
DocStatusID)
VALUES ('/mnt/data/rhd/05/Application/0001.pdf', 05, 511, 20000, 30000);

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, Description, 
DocStatusID)
VALUES ('/mnt/data/rhd/05/transcript/0001.pdf', 05, 20005, 
'bachelor certificate and transcript', 30000);

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, Description, 
DocStatusID)
VALUES ('/mnt/data/rhd/05/transcript/0002.pdf', 05, 20005, 
'master certificate and transcript', 30000);

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, DocStatusID)
VALUES ('/mnt/data/rhd/05/financial/0001.pdf',
05, 20010, 30000);

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocTypeID, 
Description, DocStatusID)
VALUES ('/mnt/data/rhd/05/reference/0001.pdf',
05, 511, 20008,
'recommendation letters', 30000);

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocTypeID,
Description, DocStatusID)
VALUES ('/mnt/data/rhd/05/general/0001.pdf',
05, 511, 20011, 'training certificate', 30000);

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, DocStatusID)
VALUES ('/mnt/data/rhd/05/faculty_assessment_memo/0001.pdf', 05, 
20003, 30000);

-- -----------------------------------------------------------------------------
-- Fwd PhD inquiry.txt
-- 6
SELECT "Populating Applicant 6 info" ;

INSERT INTO Applicant (ApplicantID, FName, LName, Sex, DateAdded, 
LastModifiedByStaffID)
VALUES (06, 'Fakhri', 'Bazzaz', 1, '2014-05-05', 1002) ;

INSERT INTO Application (ApplicationID, ApplicantID, awardID, DateAdded, 
DateLastChecked, DateLastModified, LastModifiedByStaffID, applicationStatusID)
VALUES (611, 06, 40000, '2014-05-06', '2014-05-06', '2014-05-06', 1002, 10000);

-- 100503 Computer Communications Networks
INSERT INTO `Application_Research Area` (ApplicationID, FORCode)
VALUES (611, 100503) ;


INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, Description, 
DocStatusID)
VALUES ('/mnt/data/rhd/06/general/0001.pdf', 06, 20011, 'Award of Degree', 
30000);

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocTypeID, 
DocStatusID)
VALUES ('/mnt/data/rhd/06/certificate/0001.pdf', 06, 611, 20004, 30000);

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, DocStatusID)
VALUES ('/mnt/data/rhd/06/cv/0001.pdf', 06, 20001, 30000) ; 

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, Description, 
DocStatusID)
VALUES ('/mnt/data/rhd/06/certificate/0002.pdf', 06, 20004, 'English cert',
30000);

-- add the thesis to documents
INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, Description,
DocStatusID)
VALUES ('/mnt/data/rhd/06/publication/0001.pdf', 06, 20006, 'masters thesis',
30000);

-- add the transcript to documents
INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, Description,
DocStatusID)
VALUES ('/mnt/data/rhd/06/transcript/0001.pdf', 06, 20005, 'masters transcript',
30000);

-- add a reference statement as a document
INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocTypeID, 
DocStatusID)
VALUES ('/mnt/data/rhd/06/reference/0001.pdf', 06, 611, 20008, 30000) ;

-- add the other reference statement as a document
INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocTypeID, 
DocStatusID)
VALUES ('/mnt/data/rhd/06/reference/0002.pdf', 06, 611, 20008, 30000) ;



-- -----------------------------------------------------------------------------
-- Fwd Requesting for PhD supervision.txt
-- 7
SELECT "Populating Applicant 7 info" ;

INSERT INTO Applicant (ApplicantID, FName, DateAdded, Email,
LastModifiedByStaffID)
VALUES (07, 'Nemo', '2014-05-07', 'nemo@gmail.com', 1000) ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, InstitutionName, 
InstitutionCountryISOCode)
VALUES (721, 07, 'IT', 'bachelors', 'Manipal University', 'IN') ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, InstitutionName,
InstitutionCountryISOCode)
VALUES (722, 07, 'Software development and engineering',
'masters', 'West Bengal University', 'IN') ;

INSERT INTO Application (ApplicationID, ApplicantID, awardID, DateAdded,
DateLastChecked, DateLastModified, LastModifiedByStaffID, applicationStatusID)
VALUE (711, 07, 40000, '2014-05-07', '2014-05-07', '2014-05-07', 1000, 10000) ; 

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, DocStatusID)
VALUES ('/mnt/data/rhd/07/resume/0001.pdf', 07, 20002, 30000);

-- add the publication to documents
INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, Description,
DocStatusID)
VALUES ('/mnt/data/rhd/07/publication/0001.pptx', 07, 20009, 'Six-plus
presenting a six-element framework for sentiment analysis.pptx', 30000);

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, Description,
DocStatusID)
VALUES ('/mnt/data/rhd/07/publication/0002.docx', 07, 20009, 'The price
prediction framework based upon representation of the opinions', 30000);

INSERT INTO Document (UploadLink, ApplicantID, DocTypeID, Description,
DocStatusID)
VALUES ('/mnt/data/rhd/07/publication/0003.docx', 07, 20009, 
'The classification framework for the representation of opinions', 30000);

-- Denise de Vries flags interest in this application
INSERT INTO `University Staff Member_Application` (StaffID, ApplicationID)
VALUES (1000, 711);

-- John Roddick flags interest in this application
INSERT INTO `University Staff Member_Application` (StaffID, ApplicationID)
VALUES (1002, 711);

-- -----------------------------------------------------------------------------
-- PhD Student.txt
-- 8
SELECT "Populating Applicant 8 info" ;

INSERT INTO Applicant (ApplicantID, FName, Email, DateAdded,
LastModifiedByStaffID)
VALUES (08, 'Sara', 'sara@gmail.com', '2014-05-08', 1003) ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, YearCompleted, GPA, 
InstitutionCountryISOCode)

VALUES (821, 08, 'Masters Comp Sc (Information Security)', 'masters',
'2013-12-31', 6.79, 'MY');

INSERT INTO Application (ApplicationID, ApplicantID, awardID, DateAdded,
DateLastChecked, DateLastModified, LastModifiedByStaffID, applicationStatusID)
VALUES (811, 08, 40000, '2014-05-08', '2014-05-08', '2014-05-08', 1003, 10000);

-- -----------------------------------------------------------------------------
-- PhD Student1.txt
-- 9
SELECT "Populating Applicant 9 info" ;

INSERT INTO Applicant (ApplicantID, FName, LName, Email, DateAdded,
LastModifiedByStaffID)
VALUES (09, 'Abdul-Allah', 'Al-Sadhan', 'abdul-allah.al-sadhan@gmail.com',
'2014-05-09', 1000) ;

INSERT INTO Application (ApplicationID, ApplicantID, awardID, DateAdded,
DateLastChecked, DateLastModified, LastModifiedByStaffID, applicationStatusID)
VALUES (911, 09, 40000, '2014-05-09', '2014-05-09', '2014-05-09', 1000, 10000);

-- -----------------------------------------------------------------------------
-- PhD Student2.txt
-- 10
SELECT "Populating Applicant 10 info" ;

INSERT INTO Applicant (ApplicantID, FName, LName, Email, DateAdded,
LastModifiedByStaffID)
VALUES (10, 'Fahd', 'Al-Hayyan', 'fahd.al-hayyan@ut.edu.sa', '2014-05-10', 1002)
;

INSERT INTO Application (ApplicationID, ApplicantID, awardID, DateAdded,
DateLastChecked, DateLastModified, LastModifiedByStaffID, applicationStatusID)
VALUES (1011, 10, 40000, '2014-05-10', '2014-05-10', '2014-05-10', 1002, 10000);

-- -----------------------------------------------------------------------------
-- Request for PhD Supervision.txt
-- 11
SELECT "Populating Applicant 11 info" ;

INSERT INTO Applicant (ApplicantID, FName, LName, Email, DateAdded,
LastModifiedByStaffID)
VALUES (11, 'Venkatraman', 'Ramakrishnan', 
'venkatraman.ramakrishnan@gmail.com', '2014-05-11', 1003);

INSERT INTO Application (ApplicationID, ApplicantID, awardID, DateAdded,
DateLastChecked, DateLastModified, LastModifiedByStaffID, applicationStatusID)
VALUES (1111, 11, 40000, '2014-05-11', '2014-05-11', '2014-05-11', 1003, 10000);
