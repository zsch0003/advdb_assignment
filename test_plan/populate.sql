-- IDs
--   Applicant 1-9-
--   Application x11 - x19
--   Degree      x21 - x29
--   Document    x31 - x39

--------------------------------------------------------------------------------
-- Application for PhD studies.txt
-- 01

INSERT INTO Applicant (ApplicantID, FName, LName, Email, Mobile, StreetAddress, 
City, Postcode, AddressCountryISOCode)
VALUES (01, 'Shirin', 'Ebadi', 'shirin.ebadi@keb.com.de', 
'+49 (176) 6488 9999', 'Zwillingstr 99, App 099', 'Munich', 80807, 'DE');

INSERT INTO Degree (DegID, ApplicantID, Name, Type, YearCompleted, 
InstitutionName, InstitutionCountryCode) 
VALUES (121, 01, 'Electrical Engineering with expertise in Control
Theory and Reat-Time Applications', 'bachelor', 2005, 'University of Tabriz',
'IR') ;

INSERT INTO Degree (ApplicantID, Name, Type, YearCompleted, InstitutionName,
InstitutionCountryCode) 
VALUES (122, 'Electrical Engineering with expertise in Control
Theory and Reat-Time Applications', 'masters', 2008, 'University of Tabriz',
'IR') ;

INSERT INTO Application (ApplicationID, ApplicantID, awardType)
VALUES (111, 'PhD') ;

INSERT INTO Document (DocID, UploadLink, ApplicantID, DocType)
VALUES (131, '/mnt/data/rhd/01/CV/001.pdf', 01, 'CV' );


--------------------------------------------------------------------------------
-- FW Your kind supervision for my intended PhD.txt
-- 2
-- TODO: 2 emails (also memalki@uqu.edu.sa)
INSERT INTO Applicant(2, FName, LName, Email, Mobile, Phone)
VALUES ('Mohammad', 'Almalki', 'don.memo@hotmail.com', '+966 565907070', 
'+966 12 527000000 ext 4951');

INSERT INTO Application (ApplicantID, ApplicationID, awardType)
VALUES (2, 211, 'PhD') ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, YearCompleted, 
InstitutionName, InstitutionCountryCode) 
VALUES (221, 2, 'IT', 'master', 2010,
'University of Technology Sydney', 'AU') ;

-- TODO: how to capture 'e-government in higher education organizations' ?
--INSERT INTO Application_ResearchArea (ApplicationID, FORCode)
--VALUES (ma_application_id, );

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + ma_applicant_id + '/CV/001.pdf', 
ma_applicant_id, 'CV' ) ;

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + ma_applicant_id + '/transcript/001.pdf', 
ma_applicant_id, 'transcript', 'transcript of masters course') ;

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + ma_applicant_id + '/certificate/001.pdf', 
ma_applicant_id, 'certificate', 'bachelors certificate') ;

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType)
VALUES ('/mnt/data/rhd/' + ma_applicant_id + '/proposal/001.pdf', 
ma_applicant_id, ma_application_id, 'proposal') ;


--------------------------------------------------------------------------------
-- Fwd Flinders Application - PhD (Comp Sc) - Sem 2 2015.txt
-- 3
INSERT INTO Applicant(ApplicantID, FName, LName, StudentID)
VALUES (03, 'Azzam', 'Alwash', '1234567') ;

INSERT INTO Application(ApplicationID, ApplicantID, awardType, ProposalSummary, 
ProposedStartDate, LastModifiedByStaffID)
VALUES (311, 03, 'PhD (Comp Sc)', 
'Genetic algorithms for Arabic character recognition', '2015/07', 1001) ;

INSERT INTO Degree (ApplicantID, Name, Type, GPA, InstitutionCountryCode)
VALUES (03, 'IS and CS', 'bachelors', 4.27, 'IQ') ;

INSERT INTO Degree (ApplicantID, Name, Type, GPA, InstitutionCountryCode)
VALUES (03, 'IT', 'masters', 6.79, 'MY') ;

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType)
VALUES ('/mnt/data/rhd/' + 03 + '/application/0001.pdf',
03, 311, 'application');



--------------------------------------------------------------------------------
-- Fwd Flinders Application - PhD (Computer Science) Sem 2 2014 .txt
-- 4
INSERT INTO Applicant(ApplicantID, FName, LName, StudentID)
VALUES (04, 'Mustafa', 'Al Lami', 2130106);

INSERT INTO Application(ApplicationID, ApplicantID, awardType, ProposalSummary)
VALUES (411, 04, 'PhD', 
'Cloud computing for large scale data analysis') ;


INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + 04 + 
'/faculty_assessment_memo/0001.pdf',
04, 'faculty_assessment_memo');


INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + 04 + 
'/general/0001.pdf',
04, 'general');


INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + 04 + 
'/general/0002.pdf', 04, 'general');

-- Paul Colder asks for more info about masters
INSERT INTO Decision ( DecID, Date, dectype, Comment, StaffID)
VALUES (1, '2014.05.15', 'RFI', 
'Have asked for more info about Masters project', 1001 );

--------------------------------------------------------------------------------
-- Fwd Flinders Application.txt
-- 5
INSERT INTO Applicant(ApplicantID, FName, StudentID)
VALUES (05, 'Ena', '2345678') ;

INSERT INTO Application(ApplicationID, ApplicantID, ProposedStartDate)
VALUES (511, 05, '2014/07') ; 

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType)
VALUES ('/mnt/data/rhd/' + 05 + '/proposal/0001.pdf',
05, 511, 'proposal');

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType)
VALUES ('/mnt/data/rhd/' + 05 + '/application/0001.pdf',
05, 511, 'application');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + 05 + '/transcript/0001.pdf',
05, 'transcript', 'bachelor certificate and transcript');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + 05 + '/transcript/0002.pdf',
05, 'transcript', 'master certificate and transcript');

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + 05 + '/financial/0001.pdf',
05, 'financial');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + 05 + '/reference/0001.pdf',
05, 511, 'reference',
'recommendation letters');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + 05 + '/general/0001.pdf',
05, 511, 'general', 'training certificate');

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + 05 +
 '/faculty_assessment_memo/0001.pdf', 05, 'faculty_assessment_memo');

--------------------------------------------------------------------------------
-- Fwd PhD inquiry.txt
-- 6
INSERT INTO Applicant (ApplicantID, FName, LName, Sex)
VALUES (06, 'Fakhri', 'Bazzaz', 'M') ;

INSERT INTO Application (ApplicationID, ApplicantID, awardType)
VALUES (611, 06, 'PhD');

-- 100503 Computer Communications Networks
INSERT INTO Application_ResearchArea (ApplicationID, FORCode)
VALUES (611, 100503) ;


INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + 06 + '/general/0001.pdf',
06, 'general', 'Award of Deg');

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + 06 + '/certificate/0001.pdf',
06, 611, 'certificate');

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + 06 + '/cv/0001.pdf',
06, 'cv') ; 

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + 06 + '/certificate/0002.pdf',
06, 'certificate', 'English cert');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + 06 + '/publication/0001.pdf',
06, 'publication', 'masters thesis');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + 06 + '/transcript/0001.pdf',
06, 'transcript', 'masters transcript');

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + 06 + '/reference/0001.pdf',
06, 611, 'reference') ;

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + 06 + '/reference/0002.pdf',
06, 611, 'reference') ;




--------------------------------------------------------------------------------
-- Fwd Requesting for PhD supervision.txt
-- 7
INSERT INTO Applicant (ApplicantID, FName)
VALUES (07, 'Nemo') ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, InstitutionName, 
InstitutionCountryCode)
VALUES (721, 07, 'IT', 'bachelors', 'Manipal University', 'IN') ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, InstitutionName,
InstitutionCountryCode)
VALUES (722, 07, 'Software development and engineering',
'masters', 'West Bengal University', 'IN') ;

INSERT INTO Application (ApplicationID, ApplicantID, Type, Email,
LastToModifyStaffID)
VALUE (711, 07, 'PhD', 'nemo@gmail.com', 1000) ; 

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + 07 + '/resume/0001.pdf',
07, 'resume');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + 07 + '/publication/0001.pptx',
07, 'publication', 
'Six-plus presenting a six-element framework for sentiment analysis.pptx');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + 07 + '/publication/0002.docx',
07, 'publication', 
'The price prediction framework based upon representation of the opinions');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + 07 + '/publication/0003.docx',
07, 'publication', 
'The classification framework for the representation of opinions.docx');

--------------------------------------------------------------------------------
-- PhD Student.txt
-- 8
INSERT INTO Applicant(ApplicantID, FName, Email)
VALUES (08, 'Sara', 'sara@gmail.com') ;

INSERT INTO Degree (DegID, ApplicantID, Name, Type, YearCompleted, GPA,
InstitutionName, InstitutionCountryCode)
VALUES (821, 08, 'Masters Comp Sc (Information Security)', 'masters', 2013, 
6.79);

INSERT INTO Application (ApplicationID, ApplicantID, AwardType)
VALUES (811, 08, 'PhD');

--------------------------------------------------------------------------------
-- PhD Student1.txt
-- 9
INSERT INTO Applicant(ApplicantID, FName, LName, Email)
VALUES (09, 'Abdul-Allah', 'Al-Sadhan', 'abdul-allah.al-sadhan@gmail.com') ;

INSERT INTO Application (ApplicationID, ApplicantID, AwardType)
VALUES (911, 09, 'PhD');

--------------------------------------------------------------------------------
-- PhD Student2.txt
-- 10
INSERT INTO Applicant(ApplicantID, FName, LName, Email)
VALUES (10, 'Fahd', 'Al-Hayyan', 'fahd.al-hayyan@ut.edu.sa') ;

INSERT INTO Application (ApplicationID, ApplicantID, AwardType)
VALUES (1011, 10, 'PhD');

--------------------------------------------------------------------------------
-- Request for PhD Supervision.txt
-- 11
INSERT INTO Applicant(ApplicantID, FName, LName, Email)
VALUES (11, 'Venkatraman', 'Ramakrishnan', 
'venkatraman.ramakrishnan@gmail.com');

INSERT INTO Application (ApplicationID, ApplicantID, AwardType)
VALUES (1111, 11, 'PhD');
