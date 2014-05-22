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

-- -----------------------------------------------------------------------------
-- Application for PhD studies.txt
-- 01
INSERT INTO Applicant (ApplicantID, FName, LName, Email, Mobile, StreetAddress, 
City, Postcode, AddressCountryISOCode, DateAdded, LastModifiedByStaffID)
VALUES (01, 'Shirin', 'Ebadi', 'shirin.ebadi@keb.com.de', 
'+49 (176) 6488 9999', 'Zwillingstr 99, App 099', 'Munich', 80807, 'DE', '2014-05-01', 
1001);

INSERT INTO Degree (DegID, ApplicantID, Name, Type, YearCompleted, 
InstitutionName, InstitutionCountryISOCode) 
VALUES (121, 01, 'Electrical Engineering with expertise in Control
Theory and Reat-Time Applications', 'bachelor', '2005-12-31', 'University of Tabriz',
'IR') ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, YearCompleted, InstitutionName,
InstitutionCountryISOCode) 
VALUES (122, 01, 'Electrical Engineering with expertise in Control
Theory and Reat-Time Applications', 'masters', '2008-12-31', 'University of Tabriz',
'IR') ;

INSERT INTO Application (ApplicationID, ApplicantID, awardType, DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID, ApplicationStatus)
VALUES (111, 01, 'PhD', '2014-05-01', '2014-05-01', '2014-05-01', 1002, 'ongoing') ;

INSERT INTO Document (DocID, UploadLink, ApplicantID, DocType, DocStatus)
VALUES (131, '/mnt/data/rhd/01/CV/001.pdf', 01, 'CV', 'original.english');


-- -----------------------------------------------------------------------------
-- FW Your kind supervision for my intended PhD.txt
-- 2
INSERT INTO Applicant (ApplicantID, FName, LName, Email, Mobile, Phone, DateAdded, LastModifiedByStaffID)
VALUES (2, 'Mohammad', 'Almalki', 'don.memo@hotmail.com', '+966 565907070', 
'+966 12 527000000 ext 4951', '2014-05-02', 1003);

INSERT INTO Application (ApplicantID, ApplicationID, awardType, DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID, ApplicationStatus)
VALUES (2, 211, 'PhD', '2014-05-02', '2014-05-02', '2014-05-02', 1003, 'ongoing') ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, YearCompleted, 
InstitutionName, InstitutionCountryISOCode) 
VALUES (221, 2, 'IT', 'master', '2010-12-31',
'University of Technology Sydney', 'AU') ;

INSERT INTO Document (UploadLink, ApplicantID, DocType, DocStatus)
VALUES ('/mnt/data/rhd/02/CV/001.pdf', 
02, 'CV', 'original.english') ;

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description, DocStatus)
VALUES ('/mnt/data/rhd/02/transcript/001.pdf', 
02, 'transcript', 'transcript of masters course', 'original.english') ;

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description, DocStatus)
VALUES ('/mnt/data/rhd/02/certificate/001.pdf', 
02, 'certificate', 'bachelors certificate', 'original.english') ;

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType, DocStatus)
VALUES ('/mnt/data/rhd/02/proposal/001.pdf', 
02, 211, 'proposal', 'original.english') ;


-- -----------------------------------------------------------------------------
-- Fwd Flinders Application - PhD (Comp Sc) - Sem 2 2015.txt
-- 3
INSERT INTO Applicant (ApplicantID, FName, LName, StudentID, DateAdded, LastModifiedByStaffID)
VALUES (03, 'Azzam', 'Alwash', '1234567', '2014-05-03', 1003) ;

INSERT INTO Application (ApplicationID, ApplicantID, awardType, ProposalSummary, 
ProposedStartDate, DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID, ApplicationStatus)
VALUES (311, 03, 'PhD (Comp Sc)', 
'Genetic algorithms for Arabic character recognition', '2015-07-01', '2014-05-03', '2014-05-03', '2014-05-03', 1001, 'ongoing') ;

INSERT INTO Degree (ApplicantID, Name, Type, GPA, InstitutionCountryISOCode)
VALUES (03, 'IS and CS', 'bachelors', 4.27, 'IQ') ;

INSERT INTO Degree (ApplicantID, Name, Type, GPA, InstitutionCountryISOCode)
VALUES (03, 'IT', 'masters', 6.79, 'MY') ;

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType, DocStatus)
VALUES ('/mnt/data/rhd/03/Application/0001.pdf',
03, 311, 'Application', 'original.english');



-- -----------------------------------------------------------------------------
-- Fwd Flinders Application - PhD (Computer Science) Sem 2 2014 .txt
-- 4
INSERT INTO Applicant (ApplicantID, FName, LName, StudentID, DateAdded, LastModifiedByStaffID)
VALUES (04, 'Mustafa', 'Al Lami', 2130106, '2014-05-04', 1003);

INSERT INTO Application (ApplicationID, ApplicantID, awardType, ProposalSummary, DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID, ApplicationStatus)
VALUES (411, 04, 'PhD', 
'Cloud computing for large scale data analysis', '2014-05-04', '2014-05-04', '2014-05-04', 1003, 'ongoing') ;


INSERT INTO Document (UploadLink, ApplicantID, DocType, DocStatus)
VALUES ('/mnt/data/rhd/04/faculty_assessment_memo/0001.pdf',
04, 'faculty_assessment_memo', 'original.english');


INSERT INTO Document (UploadLink, ApplicantID, DocType, DocStatus)
VALUES ('/mnt/data/rhd/04/general/0001.pdf',
04, 'general', 'original.english');


INSERT INTO Document (UploadLink, ApplicantID, DocType, DocStatus)
VALUES ('/mnt/data/rhd/04/general/0002.pdf', 04, 'general', 'original.english');

-- Paul Colder asks for more info about masters
INSERT INTO Decision ( DecID, ApplicationID, Date, dectype, Comment, StaffID)
VALUES (1, 411, '2014.05.15', 'RFI', 
'Have asked for more info about Masters project', 1001 );

INSERT INTO Correspondence (CorrID, `Date`, Summary, ApplicationID, StaffID)
VALUES (441, '2014-05-04', 'Initial inquiry from applicant', 411, 1001);
  
INSERT INTO Correspondence (CorrID, `Date`, Summary, ApplicationID, StaffID)
VALUES (442, '2014-05-04', 'Asked applicant for more information', 411, 1001);
  

-- -----------------------------------------------------------------------------
-- Fwd Flinders Application.txt
-- 5
INSERT INTO Applicant (ApplicantID, FName, StudentID, DateAdded, LastModifiedByStaffID)
VALUES (05, 'Ena', '2345678', '2014-05-05', 1001) ;

INSERT INTO Application (ApplicationID, ApplicantID, ProposedStartDate, DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID, ApplicationStatus)
VALUES (511, 05, '2014-07-01', '2014-05-05', '2014-05-05', '2014-05-05', 1001, 'ongoing') ; 

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType, DocStatus)
VALUES ('/mnt/data/rhd/05/proposal/0001.pdf',
05, 511, 'proposal', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType, DocStatus)
VALUES ('/mnt/data/rhd/05/Application/0001.pdf',
05, 511, 'Application', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description, DocStatus)
VALUES ('/mnt/data/rhd/05/transcript/0001.pdf',
05, 'transcript', 'bachelor certificate and transcript', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description, DocStatus)
VALUES ('/mnt/data/rhd/05/transcript/0002.pdf',
05, 'transcript', 'master certificate and transcript', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, DocType, DocStatus)
VALUES ('/mnt/data/rhd/05/financial/0001.pdf',
05, 'financial', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType, 
Description, DocStatus)
VALUES ('/mnt/data/rhd/05/reference/0001.pdf',
05, 511, 'reference',
'recommendation letters', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType,
Description, DocStatus)
VALUES ('/mnt/data/rhd/05/general/0001.pdf',
05, 511, 'general', 'training certificate', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, DocType, DocStatus)
VALUES ('/mnt/data/rhd/05/faculty_assessment_memo/0001.pdf', 05, 
'faculty_assessment_memo', 'original.english');

-- -----------------------------------------------------------------------------
-- Fwd PhD inquiry.txt
-- 6
INSERT INTO Applicant (ApplicantID, FName, LName, Sex, DateAdded, LastModifiedByStaffID)
VALUES (06, 'Fakhri', 'Bazzaz', 1, '2014-05-05', 1002) ;

INSERT INTO Application (ApplicationID, ApplicantID, awardType, DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID, ApplicationStatus)
VALUES (611, 06, 'PhD', '2014-05-06', '2014-05-06', '2014-05-06', 1002, 'ongoing');

-- 100503 Computer Communications Networks
INSERT INTO `Application_Research Area` (ApplicationID, FORCode)
VALUES (611, 100503) ;


INSERT INTO Document (UploadLink, ApplicantID, DocType, Description, DocStatus)
VALUES ('/mnt/data/rhd/06/general/0001.pdf',
06, 'general', 'Award of Degree', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType, 
DocStatus)
VALUES ('/mnt/data/rhd/06/certificate/0001.pdf',
06, 611, 'certificate', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, DocType, DocStatus)
VALUES ('/mnt/data/rhd/06/cv/0001.pdf',
06, 'cv', 'original.english') ; 

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description, DocStatus)
VALUES ('/mnt/data/rhd/06/certificate/0002.pdf',
06, 'certificate', 'English cert', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description, DocStatus)
VALUES ('/mnt/data/rhd/06/publication/0001.pdf',
06, 'publication', 'masters thesis', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description, DocStatus)
VALUES ('/mnt/data/rhd/06/transcript/0001.pdf',
06, 'transcript', 'masters transcript', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType, 
DocStatus)
VALUES ('/mnt/data/rhd/06/reference/0001.pdf', 06, 611, 'reference', 
'original.english') ;

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType, 
DocStatus)
VALUES ('/mnt/data/rhd/06/reference/0002.pdf', 06, 611, 'reference', 
'original.english') ;




-- -----------------------------------------------------------------------------
-- Fwd Requesting for PhD supervision.txt
-- 7
INSERT INTO Applicant (ApplicantID, FName, DateAdded, Email, LastModifiedByStaffID)
VALUES (07, 'Nemo', '2014-05-07', 'nemo@gmail.com', 1003) ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, InstitutionName, 
InstitutionCountryISOCode)
VALUES (721, 07, 'IT', 'bachelors', 'Manipal University', 'IN') ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, InstitutionName,
InstitutionCountryISOCode)
VALUES (722, 07, 'Software development and engineering',
'masters', 'West Bengal University', 'IN') ;

INSERT INTO Application (ApplicationID, ApplicantID, AwardType, 
DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID, ApplicationStatus)
VALUE (711, 07, 'PhD', '2014-05-07', '2014-05-07', '2014-05-07', 1003, 'ongoing') ; 

INSERT INTO Document (UploadLink, ApplicantID, DocType, DocStatus)
VALUES ('/mnt/data/rhd/07/resume/0001.pdf',
07, 'resume', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description, DocStatus)
VALUES ('/mnt/data/rhd/07/publication/0001.pptx',
07, 'publication', 
'Six-plus presenting a six-element framework for sentiment analysis.pptx', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description, DocStatus)
VALUES ('/mnt/data/rhd/07/publication/0002.docx',
07, 'publication', 
'The price prediction framework based upon representation of the opinions', 'original.english');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description, DocStatus)
VALUES ('/mnt/data/rhd/07/publication/0003.docx',
07, 'publication', 
'The classification framework for the representation of opinions.docx', 'original.english');

-- -----------------------------------------------------------------------------
-- PhD Student.txt
-- 8
INSERT INTO Applicant (ApplicantID, FName, Email, DateAdded, LastModifiedByStaffID)
VALUES (08, 'Sara', 'sara@gmail.com', '2014-05-08', 1003) ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, YearCompleted, GPA, 
InstitutionCountryISOCode)
VALUES (821, 08, 'Masters Comp Sc (Information Security)', 'masters', '2013-12-31', 6.79, 'MY');

INSERT INTO Application (ApplicationID, ApplicantID, AwardType, DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID, ApplicationStatus)
VALUES (811, 08, 'PhD', '2014-05-08', '2014-05-08', '2014-05-08', 1003, 'ongoing');

-- -----------------------------------------------------------------------------
-- PhD Student1.txt
-- 9
INSERT INTO Applicant (ApplicantID, FName, LName, Email, DateAdded, LastModifiedByStaffID)
VALUES (09, 'Abdul-Allah', 'Al-Sadhan', 'abdul-allah.al-sadhan@gmail.com', '2014-05-09', 1003) ;

INSERT INTO Application (ApplicationID, ApplicantID, AwardType, DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID, ApplicationStatus)
VALUES (911, 09, 'PhD', '2014-05-09', '2014-05-09', '2014-05-09', 1003, 'ongoing');

-- -----------------------------------------------------------------------------
-- PhD Student2.txt
-- 10
INSERT INTO Applicant (ApplicantID, FName, LName, Email, DateAdded, LastModifiedByStaffID)
VALUES (10, 'Fahd', 'Al-Hayyan', 'fahd.al-hayyan@ut.edu.sa', '2014-05-10', 1002) ;

INSERT INTO Application (ApplicationID, ApplicantID, AwardType, DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID, ApplicationStatus)
VALUES (1011, 10, 'PhD', '2014-05-10', '2014-05-10', '2014-05-10', 1002, 'ongoing');

-- -----------------------------------------------------------------------------
-- Request for PhD Supervision.txt
-- 11
INSERT INTO Applicant (ApplicantID, FName, LName, Email, DateAdded, LastModifiedByStaffID)
VALUES (11, 'Venkatraman', 'Ramakrishnan', 
'venkatraman.ramakrishnan@gmail.com', '2014-05-11', 1003);

INSERT INTO Application (ApplicationID, ApplicantID, AwardType, DateAdded, DateLastChecked, DateLastModified, LastModifiedByStaffID, ApplicationStatus)
VALUES (1111, 11, 'PhD', '2014-05-11', '2014-05-11', '2014-05-11', 1003, 'ongoing');
