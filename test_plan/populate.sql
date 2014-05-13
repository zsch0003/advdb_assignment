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

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + se_applicant_id + '/CV/001.pdf', se_applicant_id,
'CV' );


--------------------------------------------------------------------------------
-- FW Your kind supervision for my intended PhD.txt
-- TODO: 2 emails (also memalki@uqu.edu.sa)
INSERT INTO Applicant(FName, LName, Email, Mobile, Phone)
VALUES ('Mohammad', 'Almalki', 'don.memo@hotmail.com', '+966 565907070', 
'+966 12 527000000 ext 4951');
-- capture  LAST_INSERT_ID() as ma_applicant_id 

INSERT INTO Application (ApplicantID, awardType)
VALUES (ma_applicant_id, 'PhD') ;
-- capture LAST_INSERT_ID() as ma_application_id

INSERT INTO Degree (ApplicantID, Name, Type, YearCompleted, InstitutionName,
InstitutionCountryCode) 
VALUES (ma_applicant_id, 'IT', 'master', 2010,
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

INSERT INTO Document (UploadLink, ApplicantID, DocType, Description)
VALUES ('/mnt/data/rhd/' + fb_applicant_id + '/transcript/0001.pdf',
fb_applicant_id, 'transcript', 'masters transcript');

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + fb_applicant_id + '/reference/0001.pdf',
fb_applicant_id, fb_application_id, 'reference') ;

INSERT INTO Document (UploadLink, ApplicantID, DocType)
VALUES ('/mnt/data/rhd/' + fb_applicant_id + '/reference/0002.pdf',
fb_applicant_id, fb_application_id, 'reference') ;


-- Fwd Requesting for PhD supervision.txt
-- PhD Student.txt
-- PhD Student1.txt
-- PhD Student2.txt
-- RHD Admission form - march2014.docx
-- Request for PhD Supervision.txt
-- pg_international_application.pdf
