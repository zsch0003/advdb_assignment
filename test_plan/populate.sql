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
INSERT INTO Applicant(FName, LName, StudentID)
VALUES ('Azzam', 'Alwash', '1234567') ;
-- capture LAST_INSERT_ID() as aa_applicant_id

INSERT INTO Application(ApplicantID, awardType, ProposalSummary, 
ProposedStartDate)
VALUES (aa_applicant_id, 'PhD', 
'Genetic algorithms for Arabic character recognition', '2015/07') ;
-- capture LAST_INSERT_ID() as aa_application_id

INSERT INTO Degree (ApplicantID, Name, Type, GPA, InstitutionCountryCode)
VALUES (aa_applicant_id, 'IS and CS', 'bachelors', 4.27, 'IQ') ;

INSERT INTO Degree (ApplicantID, Name, Type, GPA, InstitutionCountryCode)
VALUES (aa_applicant_id, 'IT', 'masters', 6.79, 'MY') ;

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType)
VALUES ('/mnt/data/rhd/' + aa_applicant_id + '/application/0001.pdf',
aa_applicant_id, aa_application_id, 'application');

--------------------------------------------------------------------------------
-- Fwd Flinders Application - PhD (Computer Science) Sem 2 2014 .txt
-- 4
INSERT INTO Applicant(FName, LName, StudentID)
VALUES ('Mustafa', 'Al Lami', 2130106);
-- capture LAST_INSERT_ID() as mal_applicant_id

INSERT INTO Application(ApplicantID, awardType, ProposalSummary)
VALUES (mal_applicant_id, 'PhD', 
'Cloud computing for large scale data analysis') ;
-- capture LAST_INSERT_ID() as mal_application_id


INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + mal_applicant_id + 
'/faculty_assessment_memo/0001.pdf',
mal_applicant_id, 'faculty_assessment_memo');


INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + mal_applicant_id + 
'/general/0001.pdf',
mal_applicant_id, 'general');


INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + mal_applicant_id + 
'/general/0002.pdf',
mal_applicant_id, 'general');

--------------------------------------------------------------------------------
-- Fwd Flinders Application.txt
-- 5
INSERT INTO Applicant(FName, StudentID)
VALUES ('Ena', '2345678') ;
-- capture LAST_INSERT_ID() as ena_applicant_id

INSERT INTO Application(ApplicantID, ProposedStartDate)
VALUES (ena_applicant_id, '2014/07') ; 
-- capture LAST_INSERT_ID() as ena_application_id

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType)
VALUES ('/mnt/data/rhd/' + ena_applicant_id + '/proposal/0001.pdf',
ena_applicant_id, ena_application_id, 'proposal');

INSERT INTO Document (UploadLink, ApplicantID, ApplicationID, DocType)
VALUES ('/mnt/data/rhd/' + ena_applicant_id + '/application/0001.pdf',
ena_applicant_id, ena_application_id, 'application');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + ena_applicant_id + '/transcript/0001.pdf',
ena_applicant_id, 'transcript', 'bachelor certificate and transcript');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + ena_applicant_id + '/transcript/0002.pdf',
ena_applicant_id, 'transcript', 'master certificate and transcript');

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + ena_applicant_id + '/financial/0001.pdf',
ena_applicant_id, 'financial');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + ena_applicant_id + '/reference/0001.pdf',
ena_applicant_id, ena_application_id, 'reference',
'recommendation letters');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + ena_applicant_id + '/general/0001.pdf',
ena_applicant_id, ena_application_id, 'general', 'training certificate');

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + ena_applicant_id +
 '/faculty_assessment_memo/0001.pdf', ena_applicant_id, 
'faculty_assessment_memo');

--------------------------------------------------------------------------------
-- Fwd PhD inquiry.txt
-- 6
INSERT INTO Applicant (FName, LName, Sex)
VALUES ('Fakhri', 'Bazzaz', 'M') ;
-- capture LAST_INSERT_ID() as fb_applicant_id

INSERT INTO Application (ApplicantID, awardType)
VALUES (fb_applicant_id, 'PhD');
-- capture LAST_INSERT_ID() as fb_application_id

-- 100503 Computer Communications Networks
INSERT INTO Application_ResearchArea (ApplicationID, FORCode)
VALUES (fb_application_id, 100503) ;


INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + fb_applicant_id + '/general/0001.pdf',
fb_applicant_id, 'general', 'Award of Deg');

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + fb_applicant_id + '/certificate/0001.pdf',
fb_applicant_id, fb_application_id, 'certificate');

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + fb_applicant_id + '/cv/0001.pdf',
fb_applicant_id, 'cv') ; 

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + fb_applicant_id + '/certificate/0002.pdf',
fb_applicant_id, 'certificate', 'English cert');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + fb_applicant_id + '/publication/0001.pdf',
fb_applicant_id, 'publication', 'masters thesis');

-- INSERT INTO Publications (UploadLink, ApplicantID, DocType, Description)
-- VALUES ('/mnt/data/rhd/' + fb_applicant_id + '/publication/0001.pdf',
-- fb_applicant_id, 'publication', 'masters thesis');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + fb_applicant_id + '/transcript/0001.pdf',
fb_applicant_id, 'transcript', 'masters transcript');

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + fb_applicant_id + '/reference/0001.pdf',
fb_applicant_id, fb_application_id, 'reference') ;

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + fb_applicant_id + '/reference/0002.pdf',
fb_applicant_id, fb_application_id, 'reference') ;


--------------------------------------------------------------------------------
-- Fwd Requesting for PhD supervision.txt
-- 7
INSERT INTO Applicant (FName)
VALUES ('Nemo') ;
-- capture LAST_INSERT_ID() as nemo_applicant_id

INSERT INTO Degree (ApplicantID, Name, Type, InstitutionName, 
InstitutionCountryCode)
VALUES (aa_applicant_id, 'IT', 'bachelors', 'Manipal University', 'IN') ;

INSERT INTO Degree (ApplicantID, Name, Type, InstitutionName,
InstitutionCountryCode)
VALUES (aa_applicant_id, 'Software development and engineering',
'masters', 'West Bengal University', 'IN') ;

INSERT INTO Application (ApplicantID, Type, Email)
VALUE (nemo_applicant_id, 'PhD', 'nemo@gmail.com') ; 

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + nemo_applicant_id + '/resume/0001.pdf',
nemo_applicant_id, 'resume');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + nemo_applicant_id + '/publication/0001.pptx',
nemo_applicant_id, 'publication', 
'Six-plus presenting a six-element framework for sentiment analysis.pptx');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + nemo_applicant_id + '/publication/0002.docx',
nemo_applicant_id, 'publication', 
'The price prediction framework based upon representation of the opinions');

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + nemo_applicant_id + '/publication/0003.docx',
nemo_applicant_id, 'publication', 
'The classification framework for the representation of opinions.docx');

--------------------------------------------------------------------------------
-- PhD Student.txt
-- 8
INSERT INTO Applicant(Fname, Email)
VALUES ('Sara', 'sara@gmail.com') ;
-- capture LAST_INSERT_ID() as sara_applicant_id

INSERT INTO Degree (ApplicantID, Name, Type, YearCompleted, GPA,
InstitutionName, InstitutionCountryCode)
VALUES 


-- PhD Student1.txt
-- PhD Student2.txt
-- RHD Admission form - march2014.docx
-- Request for PhD Supervision.txt
-- pg_international_application.pdf
