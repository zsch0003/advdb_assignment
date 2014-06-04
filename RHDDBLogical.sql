-- -----------------------------------------------------------------------------
--
-- Create or re-create the RHD tables, constraints and indexes
--
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Delete existing tables

SELECT "Dropping existing FK constraints" ; 
ALTER TABLE Document DROP FOREIGN KEY associated;
ALTER TABLE Document DROP FOREIGN KEY provides;
ALTER TABLE Decision DROP FOREIGN KEY `specified by`;
ALTER TABLE Visa DROP FOREIGN KEY `originates in`;
ALTER TABLE Degree DROP FOREIGN KEY `studied in`;
ALTER TABLE Applicant DROP FOREIGN KEY `lives in`;
ALTER TABLE Applicant DROP FOREIGN KEY `nationality of`;
ALTER TABLE Application DROP FOREIGN KEY `will pay using`;
ALTER TABLE Application DROP FOREIGN KEY submits;
ALTER TABLE `Supervise as` DROP FOREIGN KEY `will supervise2`;
ALTER TABLE `Supervise as` DROP FOREIGN KEY `will supervise`;
ALTER TABLE `Application_Research Area` DROP FOREIGN KEY `in`;
ALTER TABLE `Application_Research Area` DROP FOREIGN KEY in2;
ALTER TABLE `University Staff Member_Research Area` DROP FOREIGN KEY `works in`;
ALTER TABLE `University Staff Member_Research Area` DROP FOREIGN KEY 
            `works in2`;
ALTER TABLE `University Staff Member_Research Area2` DROP FOREIGN KEY Oversees;
ALTER TABLE `University Staff Member_Research Area2` DROP FOREIGN KEY Oversees2;
ALTER TABLE Decision DROP FOREIGN KEY Decides;
ALTER TABLE Decision DROP FOREIGN KEY Decides2;
ALTER TABLE Visa DROP FOREIGN KEY `categorised by`;
ALTER TABLE Application DROP FOREIGN KEY `defined by`;
ALTER TABLE Document DROP FOREIGN KEY `has a`;
ALTER TABLE `University Staff Member_Application` DROP FOREIGN KEY flags;
ALTER TABLE `University Staff Member_Application` DROP FOREIGN KEY flags2;
ALTER TABLE Referee DROP FOREIGN KEY `supported by`;
ALTER TABLE Correspondence DROP FOREIGN KEY `corresponds with`;
ALTER TABLE Correspondence DROP FOREIGN KEY `corresponds with2`;
ALTER TABLE Document DROP FOREIGN KEY `of`;
ALTER TABLE Application DROP FOREIGN KEY Manages;
ALTER TABLE Degree DROP FOREIGN KEY holds;
ALTER TABLE Publication DROP FOREIGN KEY authored;
ALTER TABLE Visa DROP FOREIGN KEY `may have`;
ALTER TABLE Application DROP FOREIGN KEY seeks;
ALTER TABLE Application DROP FOREIGN KEY `last to update`;
ALTER TABLE Applicant DROP FOREIGN KEY `last to modify`;
ALTER TABLE Correspondence DROP FOREIGN KEY `using`;

SELECT "Dropping tables" ;
DROP TABLE IF EXISTS `Decision Type`;
DROP TABLE IF EXISTS `Payment Method`;
DROP TABLE IF EXISTS Application;
DROP TABLE IF EXISTS `Document Status`;
DROP TABLE IF EXISTS Publication;
DROP TABLE IF EXISTS Degree;
DROP TABLE IF EXISTS Referee;
DROP TABLE IF EXISTS Document;
DROP TABLE IF EXISTS Applicant;
DROP TABLE IF EXISTS Visa;
DROP TABLE IF EXISTS `Visa Status`;
DROP TABLE IF EXISTS Correspondence;
DROP TABLE IF EXISTS Decision;
DROP TABLE IF EXISTS `Research Area`;
DROP TABLE IF EXISTS `University Staff Member`;
DROP TABLE IF EXISTS `Correspondence Method`;
DROP TABLE IF EXISTS `Application Status`;
DROP TABLE IF EXISTS `Document Type`;
DROP TABLE IF EXISTS `Award Type`;
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS `Supervise as`;
DROP TABLE IF EXISTS `Application_Research Area`;
DROP TABLE IF EXISTS `University Staff Member_Research Area`;
DROP TABLE IF EXISTS `University Staff Member_Research Area2`;
DROP TABLE IF EXISTS `University Staff Member_Application`;

-- -----------------------------------------------------------------------------
-- Create tables
SELECT "Creating tables" ;

CREATE TABLE `Decision Type` (
  DecisionTypeID mediumint NOT NULL AUTO_INCREMENT, 
  type varchar(50) NOT NULL UNIQUE comment 'the type of decision/comment made', 
  PRIMARY KEY (DecisionTypeID)
) comment='the possible types of decisions/comments that can be made'
ENGINE=InnoDB;

CREATE TABLE `Payment Method` (
  PayMethodID mediumint NOT NULL AUTO_INCREMENT, 
  Method varchar(50) NOT NULL UNIQUE comment 'Method of payment, e.g. scholarship, letter of financial support etc.', 
  PRIMARY KEY (PayMethodID)
)
comment='the possible payment methods of a Research higher degree'
ENGINE=InnoDB;

CREATE TABLE Application (
  ApplicationID mediumint NOT NULL AUTO_INCREMENT,
  ApplicantEmail varchar (100) 
    comment 'Denormalised column to improve retrieval of applications via email address',
  ApplicantID mediumint NOT NULL 
    comment 'the ID of the applicant who proposed this application',
  AddressConfirmed tinyint(1) NOT NULL comment 'All contact details appear valid',
  DegreeConfirmed tinyint(1) NOT NULL 
    comment 'The degree is a recognised degree of the institution',
  VisaStatusConfirmed tinyint(1) NOT NULL 
    comment 'The visa status is backed by an official document',
  ProposalConfirmed tinyint(1) NOT NULL 
    comment 'The proposal is contains appropriate detail',
  HasResearchAreas tinyint(1) NOT NULL 
    comment 'Has nominated research areas relevant to the proposal',
  HasPrimarySuper tinyint(1) NOT NULL 
    comment 'Has the required number of supervisors',
  PayMethConfirmed tinyint(1) NOT NULL 
    comment 'The payment method is backed by an official document',
  EngProfConfirmed tinyint(1) NOT NULL 
    comment 'The applicant has some level of English literacy',
  RefereesConfirmed tinyint(1) NOT NULL 
    comment 'The referees details appear to be correct',
  RequireMoreInfo tinyint(1),
  ProposedStartDate date 
    comment 'The date the applicant prefers to start the RHD (Entered as 1/1/## for S1 and 1/7/## for S2)',
  ProposalSummary varchar(2000) 
    comment 'What the proposal is about',
  flindersCampus tinyint(1) 
    comment 'the applicant wants to complete the degree a main campus',
  fullTime tinyint(1) comment 'the applicant wants to undergo the degree full time',
  DateAdded date NOT NULL comment 'the date the application was added',
  DateLastChecked date NOT NULL 
    comment 'the date the application was last checked',
  DateLastModified date NOT NULL 
    comment 'the date the application was last modified',
  ManagedByStaffID mediumint 
    comment 'The staff ID of the staff member who has been personally assigned to manage this application (since it may not be used it is nullable)',
  LastModifiedByStaffID mediumint NOT NULL 
    comment 'the staff member ID of the last person to modify the application (all modifications are recorded in the decision table)',
  applicationStatusID mediumint NOT NULL,
  awardID mediumint,
  PayMethodID mediumint,
  PRIMARY KEY (ApplicationID),
  INDEX (ApplicantID),
  INDEX (applicationStatusID),
  INDEX (awardID),
  INDEX (ApplicantEmail)
)
comment='Holds the application details including a checklist of recorded information and applicaiton stage'
ENGINE=InnoDB;

CREATE TABLE `Document Status` (
  DocStatusID mediumint NOT NULL AUTO_INCREMENT,
  Status varchar(50) NOT NULL UNIQUE comment 'Official and translation status of a document associated to an Applicant',
  Description varchar(2000) NOT NULL comment 'the details and implication of this status',
  PRIMARY KEY (DocStatusID)
)
comment='the possible statuses of a document'
ENGINE=InnoDB;

CREATE TABLE Publication (
  PubID mediumint NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the publication',
  ApplicantID mediumint NOT NULL comment 'the ID of the applicant who authored the publication',
  Title varchar(255) NOT NULL comment 'The title of the publication',
  Abstract varchar(2000) comment 'A abstract/description of the publication',
  Publication varchar(255) NOT NULL comment 'The journal/magazine publisher ',
  IssueNo mediumint comment 'The issue/edition number of the publication',
  IssueDate date NOT NULL comment 'The date the publication was issued',
  OnlineLink varchar(255) comment 'An online link to the publication',
  OtherAuthorsNames varchar(255) comment 'Other authors of the publication',
  Language varchar(50) comment 'language of the publication',
  PRIMARY KEY (PubID))
ENGINE=InnoDB;

CREATE TABLE Degree (
  DegID mediumint NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the degree',
  ApplicantID mediumint NOT NULL comment 'the ID of the applicant who holds this degree',
  Name varchar(100) NOT NULL comment 'The title of the degree',
  Type varchar(100) NOT NULL comment 'The type of the degree  -  Could add specific types',
  YearCompleted date comment 'The year the degree was completed or will be completed',
  GPA mediumint comment 'The GPA of the degree',
  InstitutionName varchar(100) comment 'The name of the institution',
  InstitutionCountryISOCode char(2) NOT NULL comment 'the country the institution is based in',
  PRIMARY KEY (DegID),
  INDEX (ApplicantID)
)
comment='Any Degrees already held by the applicant'
ENGINE=InnoDB;

CREATE TABLE Referee (
  RefID mediumint NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the referee supporting an application',
  ApplicationID mediumint NOT NULL,
  Name varchar(100) NOT NULL comment 'The full name of the referee',
  Relation varchar(100) comment 'The referees relation to the applicant',
  Phone varchar(50) comment 'The referees phone number',
  Email varchar(100) comment 'The referees email address',
  Profession varchar(255) comment 'The referees profession',
  AcademicLink varchar(255) comment 'The referees professional page (linked in or university)',
  EnglishSpeaker tinyint(1) comment 'If the Referee can speak English',
  EnglishLiterate tinyint(1) comment 'If the Referee can read and write in English',
  PRIMARY KEY (RefID)
)
comment='A referee for a application'
ENGINE=InnoDB;

CREATE TABLE Document (
  DocID mediumint NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the document',
  Title varchar(254) NOT NULL comment 'The title of the document',
  Description varchar(2000) NOT NULL comment 'A specific summary related to the document i.e. valid till 2015 etc.',
  UploadLink varchar(254) NOT NULL comment 'An link to a version uploaded and stored on the university servers',
  ApplicationID mediumint,
  ApplicantID mediumint NOT NULL comment 'the ID of the applicant who provided this document',
  DocStatusID mediumint NOT NULL,
  DocTypeID mediumint NOT NULL,
  PRIMARY KEY (DocID),
  INDEX (ApplicationID),
  INDEX (ApplicantID),
  INDEX (DocStatusID),
  INDEX (DocTypeID)
)
comment='Links to any relevant documents along with descriptions,
  types and statuses.'
ENGINE=InnoDB;

CREATE TABLE Applicant (
  ApplicantID mediumint NOT NULL AUTO_INCREMENT 
    comment 'The primary key that uniquely identifies the applicant',
  FName varchar(50) NOT NULL comment 'First name',
  LName varchar(50) comment 'Last name',
  PrefTitle varchar(10) comment 'Title Mr,
  Mrs,
  Miss,
  Dr. *',
  Sex tinyint(1) comment 'The sex of the applicant',
  DOB date comment 'Date of birth',
  StreetAddress varchar(255) comment 'Residence number and street of residence',
  Suburb varchar(100) comment 'The suburb of residence',
  Postcode mediumint comment 'The postcode of residence',
  City varchar(50) comment 'The city or town of residence',
  State varchar(50) comment 'The State of residence',
  Mobile varchar(50) comment 'Mobile phone number',
  Phone varchar(50) comment 'Landline phone number',
  Email varchar(100) comment 'The email address of the applicant',
  IsNZAUCitizen tinyint(1) comment 'Is a new Zealand or Australian citizen – a check to see if visa information is required ***',
  EnglishProficient tinyint(1) comment 'English ability',
  StudentID mediumint comment 'The flinders university student id if they are or have been enrolled at flinders university',
  DateAdded date NOT NULL comment 'The date the applicant was added to the system',
  AddressCountryISOCode char(2),
  NationalityCountryISOCode char(2),
  LastModifiedByStaffID mediumint NOT NULL comment 'the staff member ID of the last person to modify the applicant (all modifications are recorded in the decision table)',
  PRIMARY KEY (ApplicantID),
  INDEX (FName),
  INDEX (LName),
  INDEX (Email)
)
comment='Holds the applicant specific details'
ENGINE=InnoDB;

CREATE TABLE Visa (
  VisaID mediumint NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the visa',
  OriginCountryISOCode char(2) NOT NULL comment 'the country the applicant states they are from',
  ValidFrom date comment 'When the visa is valid from',
  ValidTo date comment 'When the visa is valid to',
  CountryISOCode char(2) NOT NULL comment 'the applicant country,
  the visa is granted to',
  ApplicantID mediumint NOT NULL comment 'the ID of the applicant who holds or may hold this visa',
  VisaStatusID mediumint NOT NULL,
  PRIMARY KEY (VisaID),
  INDEX (ApplicantID),
  INDEX (VisaStatusID)
)
comment='The applicants visa details'
ENGINE=InnoDB;

CREATE TABLE `Visa Status` (
  VisaStatusID mediumint NOT NULL AUTO_INCREMENT,
  Status varchar(50) NOT NULL UNIQUE comment 'the status of the visa application',
  description varchar(1000) NOT NULL comment 'a description of the status of the visa',
  PRIMARY KEY (VisaStatusID)
)
comment='the possible statuses of the visa application'
ENGINE=InnoDB;

CREATE TABLE Correspondence (
  CorrID mediumint NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL comment 'The date the correspondence was made/received',
  Summary varchar(1000) NOT NULL comment 'A small summary of the Correspondence',
  Message varchar(2000) comment 'The actual message contained in the correspondence',
  ApplicationID mediumint NOT NULL comment 'the application ID the correspondence is in relation to',
  StaffID mediumint NOT NULL comment 'the staff ID of the staff member the correspondence is to/from',
  CorrMethodID mediumint NOT NULL,
  PRIMARY KEY (CorrID),
  INDEX (ApplicationID),
  INDEX (StaffID)
)
comment='Correspondence between the Applicant and University Staff Member'
ENGINE=InnoDB;

CREATE TABLE Decision (
  DecID mediumint NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the Decision/comment made',
  `Date` date NOT NULL comment 'The date the decision was made on',
  Comment varchar(1000) comment 'Extra information about the decision',
  ApplicationID mediumint comment 'the id of the application this decision is made with regards to, if this is a decision associated with an application',
  StaffID mediumint NOT NULL comment 'the staff ID of the staff member who made this decision/comment',
  DecisionTypeID mediumint NOT NULL,
  Reportable tinyint(1) NOT NULL comment 'a boolean that is automatically ticked if the change is deemed reportable (status changes request filled etc.)',
  Sent tinyint(1) comment 'a boolean to check if the related email has been sent',
  PRIMARY KEY (DecID),
  INDEX (ApplicationID),
  INDEX (StaffID),
  INDEX (DecisionTypeID),
  INDEX (Reportable),
  INDEX (Sent)
)
comment='The decision/comment made for an application by a RHD staff member'
ENGINE=InnoDB;

CREATE TABLE `Research Area` (
  FORCode mediumint(6) NOT NULL AUTO_INCREMENT comment 'The Australian Field Of Research (FOR) code,
  primary key,
  that uniquely identifies the Research area',
  Description varchar(2000) NOT NULL comment 'A small text description of the FOR i.e. 2201',
  ResearchArea varchar(50) NOT NULL comment 'The FOR title; i.e. Applied Ethics',
  GeneralArea varchar(50) NOT NULL comment 'The general area of the FOR',
  PRIMARY KEY (FORCode),
  INDEX (GeneralArea))
ENGINE=InnoDB;

CREATE TABLE `University Staff Member` (
  StaffID mediumint NOT NULL AUTO_INCREMENT comment 'The flinders uni staff ID number,
  the primary key that uniquely identifies the staff member',
  FName varchar(50) NOT NULL comment 'The last name of the staff member',
  LName varchar(50) comment 'The first name of the staff member',
  canSupervise tinyint(1) NOT NULL comment 'if the staff member is able supervise a RHD applicant',
  email varchar(100) NOT NULL,
  PRIMARY KEY (StaffID),
  INDEX (FName)
)
comment='a university staff member who may be able to supervise a application'
ENGINE=InnoDB;

CREATE TABLE `Correspondence Method` (
  CorrMethodID mediumint NOT NULL AUTO_INCREMENT,
  Method varchar(50) NOT NULL UNIQUE comment 'the method of correspondence',
  PRIMARY KEY (CorrMethodID))
ENGINE=InnoDB;

CREATE TABLE `Application Status` (
  ApplicationStatusID mediumint NOT NULL AUTO_INCREMENT,
  Status varchar(50) NOT NULL UNIQUE comment 'the name of the status',
  Description varchar(1000) NOT NULL comment 'a full description of the status',
  PRIMARY KEY (ApplicationStatusID),
  UNIQUE INDEX (ApplicationStatusID)
)
comment='the possible application statuses of an application'
ENGINE=InnoDB;

CREATE TABLE `Document Type` (
  DocTypeID mediumint NOT NULL AUTO_INCREMENT,
  Type varchar(50) NOT NULL UNIQUE comment 'the type of document eg. Publication,
  visa etc.',
  Description varchar(1000) NOT NULL comment 'a full description of the type of the document',
  PRIMARY KEY (DocTypeID)
)
comment='the possible types of a document'
ENGINE=InnoDB;

CREATE TABLE `Award Type` (
  AwardID mediumint NOT NULL AUTO_INCREMENT,
  Type varchar(50) NOT NULL UNIQUE comment 'the type of award sought by the applicant',
  Description varchar(1000) NOT NULL comment 'a full description of the award type',
  PRIMARY KEY (AwardID)
)
comment='the possible award types (degrees) sought by an application'
ENGINE=InnoDB;

CREATE TABLE Country (
  CountryISOCode char(2) NOT NULL
    comment 'the country corresponding ISO 3166-1 alpha-2 code',
  Name varchar(50) NOT NULL UNIQUE comment 'the full name of the country',
  PRIMARY KEY (CountryISOCode)
)
comment='a list of countries for reuse in nationality,
  institution country,
  address and visa country'
ENGINE=InnoDB;

CREATE TABLE `Supervise as` (
  PrimarySupervisor tinyint(1) NOT NULL comment 'if the supervisor is a primary',
  ApplicationID mediumint NOT NULL comment 'the application ID of the application the staff member will supervise',
  StaffID mediumint NOT NULL comment 'the staff ID of the staff member who will supervise the applicaiton',
  PRIMARY KEY (ApplicationID,
  StaffID),
  INDEX (ApplicationID),
  INDEX (StaffID)
)
comment='the staff members who have agreed to supervise an application'
ENGINE=InnoDB;

CREATE TABLE `Application_Research Area` (
  ApplicationID mediumint NOT NULL comment 'the ID of the application',
  FORCode mediumint(6) NOT NULL comment 'the FORCode research area the applicant states they want to study in',
  PRIMARY KEY (ApplicationID, FORCode),
  INDEX (ApplicationID),
  INDEX (FORCode)
)
comment='The application and the research area they are looking to study in'
ENGINE=InnoDB;

CREATE TABLE `University Staff Member_Research Area` (
  StaffID mediumint NOT NULL comment 'the staff ID of the staff member who works in the research area',
  FORCode mediumint(6) NOT NULL comment 'the field of research that the staff member works in',
  PRIMARY KEY (StaffID, FORCode),
  INDEX (StaffID),
  INDEX (FORCode)
)
comment='the research area the staff member states they work in'
ENGINE=InnoDB;

CREATE TABLE `University Staff Member_Research Area2` (
  StaffID mediumint NOT NULL comment 'the staff ID of the staff member who oversees the research area',
  FORCode mediumint(6) NOT NULL comment 'the FORCode of the research area that the staff member oversees',
  PRIMARY KEY (StaffID, FORCode),
  INDEX (StaffID),
  INDEX (FORCode)
)
comment='the research areas that a staff member oversees (can be more than one staff member per area)'
ENGINE=InnoDB;

CREATE TABLE `University Staff Member_Application` (
  StaffID mediumint NOT NULL comment 'the staff ID of the staff member who flagged the application',
  ApplicationID mediumint NOT NULL comment 'the application the staff member has flagged',
  ReceiveEmailUpdates tinyint(1) NOT NULL comment 'a boolean that a user can check if they want to be alerted About an update or simply keep a reference on their application page',
  PRIMARY KEY (StaffID,
  ApplicationID),
  INDEX (StaffID),
  INDEX (ApplicationID)
)
comment='the staff members who have flagged an application to come back and check later'
ENGINE=InnoDB;


-- -----------------------------------------------------------------------------
-- Add constraints and indexes
SELECT "Adding indexes and FK constraints" ;

ALTER TABLE Document 
ADD INDEX associated (ApplicationID),
ADD CONSTRAINT associated FOREIGN KEY (ApplicationID) 
  REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Document 
ADD INDEX provides (ApplicantID),
ADD CONSTRAINT provides FOREIGN KEY (ApplicantID) 
  REFERENCES Applicant (ApplicantID) ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE Decision
ADD INDEX `specified by` (DecisionTypeID),
ADD CONSTRAINT `specified by` FOREIGN KEY (DecisionTypeID) 
  REFERENCES `Decision Type` (DecisionTypeID);

ALTER TABLE Visa
ADD INDEX `originates in` (CountryISOCode),
ADD CONSTRAINT `originates in` FOREIGN KEY (CountryISOCode) 
  REFERENCES Country (CountryISOCode) ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Degree
ADD INDEX `studied in` (InstitutionCountryISOCode),
ADD CONSTRAINT `studied in` FOREIGN KEY (InstitutionCountryISOCode) 
  REFERENCES Country (CountryISOCode) ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Applicant
ADD INDEX `lives in` (AddressCountryISOCode),
ADD CONSTRAINT `lives in` FOREIGN KEY (AddressCountryISOCode) 
  REFERENCES Country (CountryISOCode) ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Applicant
ADD INDEX `nationality of` (NationalityCountryISOCode),
ADD CONSTRAINT `nationality of` FOREIGN KEY (NationalityCountryISOCode)
  REFERENCES Country (CountryISOCode) ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Application
ADD INDEX `will pay using` (PayMethodID),
ADD CONSTRAINT `will pay using` FOREIGN KEY (PayMethodID)
  REFERENCES `Payment Method` (PayMethodID) 
  ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Application
ADD INDEX submits (ApplicantID),
ADD CONSTRAINT submits FOREIGN KEY (ApplicantID)
  REFERENCES Applicant (ApplicantID) ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE `Supervise as`
ADD INDEX `will supervise2` (ApplicationID),
ADD CONSTRAINT `will supervise2` FOREIGN KEY (ApplicationID)
  REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE `Supervise as`
ADD INDEX `will supervise` (StaffID),
ADD CONSTRAINT `will supervise` FOREIGN KEY (StaffID)
  REFERENCES `University Staff Member` (StaffID) 
  ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE `Application_Research Area`
ADD INDEX `in` (ApplicationID),
 
ADD CONSTRAINT `in` FOREIGN KEY (ApplicationID)
  REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE `Application_Research Area`
ADD INDEX in2 (FORCode),
 
ADD CONSTRAINT in2 FOREIGN KEY (FORCode)
  REFERENCES `Research Area` (FORCode) ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE `University Staff Member_Research Area`
ADD INDEX `works in` (StaffID),
 
ADD CONSTRAINT `works in` FOREIGN KEY (StaffID)
  REFERENCES `University Staff Member` (StaffID);

ALTER TABLE `University Staff Member_Research Area`
ADD INDEX `works in2` (FORCode),
 
ADD CONSTRAINT `works in2` FOREIGN KEY (FORCode)
  REFERENCES `Research Area` (FORCode) ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE `University Staff Member_Research Area2`
ADD INDEX Oversees (StaffID),
 
ADD CONSTRAINT Oversees FOREIGN KEY (StaffID)
  REFERENCES `University Staff Member` (StaffID);

ALTER TABLE `University Staff Member_Research Area2`
ADD INDEX Oversees2 (FORCode),
 
ADD CONSTRAINT Oversees2 FOREIGN KEY (FORCode)
  REFERENCES `Research Area` (FORCode) ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Decision
ADD INDEX Decides (ApplicationID),
ADD CONSTRAINT Decides FOREIGN KEY (ApplicationID)
  REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE Decision
ADD INDEX Decides2 (StaffID),
ADD CONSTRAINT Decides2 FOREIGN KEY (StaffID)
  REFERENCES `University Staff Member` (StaffID) 
  ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Visa
ADD INDEX `categorised by` (VisaStatusID),
ADD CONSTRAINT `categorised by` FOREIGN KEY (VisaStatusID)
  REFERENCES `Visa Status` (VisaStatusID) ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Application
ADD INDEX `defined by` (applicationStatusID),
ADD CONSTRAINT `defined by` FOREIGN KEY (applicationStatusID)
  REFERENCES `Application Status` (ApplicationStatusID) 
  ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Document
ADD INDEX `has a` (DocStatusID),
ADD CONSTRAINT `has a` FOREIGN KEY (DocStatusID)
  REFERENCES `Document Status` (DocStatusID) 
  ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE `University Staff Member_Application`
ADD INDEX flags (StaffID),
ADD CONSTRAINT flags FOREIGN KEY (StaffID)
  REFERENCES `University Staff Member` (StaffID) 
  ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE `University Staff Member_Application`
ADD INDEX flags2 (ApplicationID),
ADD CONSTRAINT flags2 FOREIGN KEY (ApplicationID)
  REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE Referee
ADD INDEX `supported by` (ApplicationID),
ADD CONSTRAINT `supported by` FOREIGN KEY (ApplicationID)
  REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE Correspondence
ADD INDEX `corresponds with` (ApplicationID),
ADD CONSTRAINT `corresponds with` FOREIGN KEY (ApplicationID)
  REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE Correspondence
ADD INDEX `corresponds with2` (StaffID),
ADD CONSTRAINT `corresponds with2` FOREIGN KEY (StaffID)
  REFERENCES `University Staff Member` (StaffID) 
  ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Document
ADD INDEX `of` (DocTypeID),
ADD CONSTRAINT `of` FOREIGN KEY (DocTypeID)
  REFERENCES `Document Type` (DocTypeID) ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Application
ADD INDEX Manages (ManagedByStaffID),
ADD CONSTRAINT Manages FOREIGN KEY (ManagedByStaffID)
  REFERENCES `University Staff Member` (StaffID) 
  ON UPDATE Cascade ON DELETE Set null;

ALTER TABLE Degree
ADD INDEX holds (ApplicantID),
ADD CONSTRAINT holds FOREIGN KEY (ApplicantID)
  REFERENCES Applicant (ApplicantID) ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE Publication
ADD INDEX authored (ApplicantID),
ADD CONSTRAINT authored FOREIGN KEY (ApplicantID)
  REFERENCES Applicant (ApplicantID) ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE Visa
ADD INDEX `may have` (ApplicantID),
ADD CONSTRAINT `may have` FOREIGN KEY (ApplicantID)
  REFERENCES Applicant (ApplicantID) ON UPDATE Cascade ON DELETE Cascade;

ALTER TABLE Application
ADD INDEX seeks (awardID),
ADD CONSTRAINT seeks FOREIGN KEY (awardID)
  REFERENCES `Award Type` (AwardID) ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Application
ADD INDEX `last to update` (LastModifiedByStaffID),
ADD CONSTRAINT `last to update` FOREIGN KEY (LastModifiedByStaffID)
  REFERENCES `University Staff Member` (StaffID) 
  ON UPDATE Cascade ON DELETE Restrict;

ALTER TABLE Applicant
ADD INDEX `last to modify` (LastModifiedByStaffID),
ADD CONSTRAINT `last to modify` FOREIGN KEY (LastModifiedByStaffID)
  REFERENCES `University Staff Member` (StaffID);

ALTER TABLE Correspondence
ADD INDEX `using` (CorrMethodID),
ADD CONSTRAINT `using` FOREIGN KEY (CorrMethodID)
  REFERENCES `Correspondence Method` (CorrMethodID) 
  ON UPDATE Cascade ON DELETE Restrict;
