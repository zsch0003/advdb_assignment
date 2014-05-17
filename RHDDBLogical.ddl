CREATE TABLE `Decision Type` (
  type varchar(50) NOT NULL comment 'the type of decision/comment made', 
  PRIMARY KEY (type), 
  UNIQUE INDEX (type)) comment='the possible types of decisions/comments that can be made';
CREATE TABLE `Payment Method` (
  Method int(10) NOT NULL AUTO_INCREMENT comment 'Method of payment, e.g. scholarship, letter of financial support etc.', 
  PRIMARY KEY (Method), 
  UNIQUE INDEX (Method)) comment='the possible payment methods of a Research higher degree';
CREATE TABLE Application (
  ApplicationID         int(10) NOT NULL AUTO_INCREMENT, 
  ApplicantID           int(10) NOT NULL comment 'the ID of the applicant who proposed this application', 
  AddressConfirmed      int(1) NOT NULL comment 'All contact details appear valid', 
  DegreeConfirmed       int(1) NOT NULL comment 'The degree is a recognised degree of the institution', 
  VisaStatusConfirmed   int(1) NOT NULL comment 'The visa status is backed by an official document', 
  ProposalConfirmed     int(1) NOT NULL comment 'The proposal is contains appropriate detail', 
  HasReasearchAreas     int(1) NOT NULL comment 'Has nominated research areas relevant to the proposal', 
  HasPrimarySuper       int(1) NOT NULL comment 'Has the required number of supervisors', 
  PayMethConfirmed      int(1) NOT NULL comment 'The payment method is backed by an official document', 
  EngProfConfirmed      int(1) NOT NULL comment 'The applicant has some level of English literacy', 
  RefereesConfirmed     int(1) NOT NULL comment 'The referees details appear to be correct', 
  RequireMoreInfo       int(1), 
  ProposedStartDate     date comment 'The date the applicant prefers to start the RHD (Entered as 1/1/## for S1 and 1/7/## for S2)', 
  ProposalSummary       varchar(2000) comment 'What the proposal is about', 
  flindersCampus        int(1) comment 'the applicant wants to complete the degree a main campus', 
  fullTime              int(1) comment 'the applicant wants to undergo the degree full time', 
  DateAdded             date NOT NULL comment 'the date the application was added', 
  DateLastChecked       date NOT NULL comment 'the date the application was last checked', 
  DateLastModified      date NOT NULL comment 'the date the application was last modified', 
  PaymentMethod         int(10) comment 'The method of payment the applicant proposes to pay for the application', 
  ApplicationStatus     varchar(50) NOT NULL comment 'the overall status of the applicaton', 
  ManagedByStaffID      int(10) comment 'The staff ID of the staff member who has been personally assigned to manage this application (since it may not be used it is nullable)', 
  AwardType             varchar(50) comment 'the award type sought by the applicant in this application', 
  LastModifiedByStaffID int(10) NOT NULL comment 'the staff member ID of the last person to modify the application (all modifications are recorded in the decision table)', 
  PRIMARY KEY (ApplicationID), 
  UNIQUE INDEX (ApplicationID), 
  INDEX (ApplicantID)) comment='Holds the application details including a checklist of recorded information and applicaiton stage';
CREATE TABLE `Document Status` (
  Status      varchar(50) NOT NULL comment 'Official and translation status of a document associated to an Applicant', 
  Description varchar(2000) NOT NULL UNIQUE comment 'the details and implication of this status', 
  PRIMARY KEY (Status), 
  UNIQUE INDEX (Status)) comment='the possible statuses of a document';
CREATE TABLE Publication (
  PubID             int(10) NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the publication', 
  ApplicantID       int(10) NOT NULL comment 'the ID of the applicant who authored the publication', 
  Title             varchar(255) NOT NULL comment 'The title of the publication', 
  Abstract          varchar(2000) comment 'A abstract/description of the publication', 
  Publication       varchar(255) NOT NULL comment 'The journal/magazine publisher ', 
  IssueNo           int(10) comment 'The issue/edition number of the publication', 
  IssueDate         date NOT NULL comment 'The date the publication was issued', 
  OnlineLink        varchar(255) comment 'An online link to the publication', 
  OtherAuthorsNames varchar(255) comment 'Other authors of the publication', 
  Language          varchar(50) comment 'language of the publication', 
  PRIMARY KEY (PubID), 
  UNIQUE INDEX (PubID));
CREATE TABLE Degree (
  DegID                     int(10) NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the degree', 
  ApplicantID               int(10) NOT NULL comment 'the ID of the applicant who holds this degree', 
  Name                      varchar(100) NOT NULL comment 'The title of the degree', 
  Type                      varchar(100) NOT NULL comment 'The type of the degree  -  Could add specific types', 
  YearCompleted             date comment 'The year the degree was completed or will be completed', 
  GPA                       int(10) comment 'The GPA of the degree', 
  InstitutionName           varchar(100) comment 'The name of the institution', 
  InstituitonCountryISOCode int(2) NOT NULL comment 'the country the institution is based in', 
  PRIMARY KEY (DegID), 
  UNIQUE INDEX (DegID), 
  INDEX (ApplicantID)) comment='Any Degrees already held by the applicant';
CREATE TABLE Referee (
  RefID           int(10) NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the referee supporting an application', 
  ApplicationID   int(10) NOT NULL, 
  Name            varchar(100) NOT NULL comment 'The full name of the referee', 
  Relation        varchar(100) comment 'The referees relation to the applicant', 
  Phone           varchar(50) comment 'The referees phone number', 
  Email           varchar(100) comment 'The referees email address', 
  Profession      varchar(255) comment 'The referees profession', 
  AcademicLink    varchar(255) comment 'The referees professional page (linked in or university)', 
  EnglishSpeaker  int(1) comment 'If the Referee can speak English', 
  EnglishLiterate int(1) comment 'If the Referee can read and write in English', 
  PRIMARY KEY (RefID), 
  UNIQUE INDEX (RefID)) comment='A referee for a application';
CREATE TABLE Document (
  DocID         int(10) NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the document', 
  Title         varchar(254) NOT NULL comment 'The title of the document', 
  Description   varchar(2000) NOT NULL comment 'A specific summary related to the document i.e. valid till 2015 etc.', 
  UploadLink    varchar(254) NOT NULL comment 'An link to a version uploaded and stored on the university servers', 
  ApplicationID int(10), 
  ApplicantID   int(10) NOT NULL comment 'the ID of the applicant who provided this document', 
  DocStatus     varchar(50) NOT NULL comment 'the status of the document', 
  DocType       varchar(50) NOT NULL comment 'the type of document (publication, payment proof etc.)', 
  PRIMARY KEY (DocID), 
  UNIQUE INDEX (DocID), 
  INDEX (ApplicationID), 
  INDEX (ApplicantID)) comment='Links to any relevant documents along with descriptions, types and statuses.';
CREATE TABLE Applicant (
  ApplicantID               int(10) NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the applicant', 
  FName                     varchar(50) NOT NULL comment 'First name', 
  LName                     varchar(50) comment 'Last name', 
  PrefTitle                 varchar(10) comment 'Title Mr, Mrs, Miss, Dr. *', 
  Sex                       int(1) comment 'The sex of the applicant', 
  DOB                       date comment 'Date of birth', 
  StreetAddress             varchar(255) comment 'Residence number and street of residence', 
  Suburb                    varchar(100) comment 'The suburb of residence', 
  Postcode                  int(10) comment 'The postcode of residence', 
  City                      int(10) comment 'The city or town of residence', 
  State                     varchar(50) comment 'The State of residence', 
  Mobile                    varchar(50) comment 'Mobile phone number', 
  Phone                     varchar(50) comment 'Landline phone number', 
  Email                     varchar(100) comment 'The email address of the applicant', 
  IsNZAUCitizen             int(1) comment 'Is a new Zealand or Australian citizen – a check to see if visa information is required ***', 
  EnglishProficient         bit(1) comment 'English ability', 
  StudentID                 int(10) comment 'The flinders university student id if they are or have been enrolled at flinders university', 
  DateAdded                 date NOT NULL comment 'The date the applicant was added to the system', 
  AddressCountryISOCode     int(2), 
  NationalityCountryISOCode int(2), 
  LastModifiedByStaffID     int(10) NOT NULL comment 'the staff member ID of the last person to modify the applicant (all modifications are recorded in the decision table)', 
  PRIMARY KEY (ApplicantID), 
  UNIQUE INDEX (ApplicantID)) comment='Holds the applicant specific details';
CREATE TABLE Visa (
  VisaID               int(10) NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the visa', 
  OriginCountryISOCode int(2) NOT NULL comment 'the country the applicant states they are from', 
  ValidFrom            date comment 'When the visa is valid from', 
  ValidTo              date comment 'When the visa is valid to', 
  CountryISOCode       int(2) NOT NULL comment 'the applicant country, the visa is granted to', 
  visaStatus           varchar(50) NOT NULL comment 'the status of the visa application (approved, attained, processing etc.)', 
  ApplicantID          int(10) NOT NULL comment 'the ID of the applicant who holds or may hold this visa', 
  PRIMARY KEY (VisaID), 
  UNIQUE INDEX (VisaID)) comment='The applicants visa details';
CREATE TABLE `Visa Status` (
  Status      varchar(50) NOT NULL comment 'the status of the visa application', 
  description varchar(1000) NOT NULL UNIQUE comment 'a description of the status of the visa', 
  PRIMARY KEY (Status), 
  UNIQUE INDEX (Status)) comment='the possible statuses of the visa application';
CREATE TABLE Correspondence (
  CorrID        int(10) NOT NULL AUTO_INCREMENT, 
  `Date`        date NOT NULL comment 'The date the correspondence was made/received', 
  Summary       varchar(1000) NOT NULL comment 'A small summary of the Correspondence', 
  Message       varchar(2000) comment 'The actual message contained in the correspondence', 
  ApplicationID int(10) NOT NULL comment 'the application ID the correspondence is in relation to', 
  StaffID       int(10) NOT NULL comment 'the staff ID of the staff member the correspondence is to/from', 
  corrMethod    varchar(50) NOT NULL comment 'the method of correspondence, phone, email, skype etc.', 
  PRIMARY KEY (CorrID), 
  UNIQUE INDEX (CorrID)) comment='Correspondence between the Applicant and University Staff Member';
CREATE TABLE Decision (
  DecID         int(10) NOT NULL AUTO_INCREMENT comment 'The primary key that uniquely identifies the Decision/comment made', 
  `Date`        date NOT NULL comment 'The date the decision was made on', 
  Comment       varchar(1000) comment 'Extra information about the decision', 
  dectype       varchar(50) NOT NULL comment 'the type of decision/comment that was made', 
  ApplicationID int(10) NOT NULL comment 'the id of the application this decision is made with regards to', 
  StaffID       int(10) NOT NULL comment 'the staff ID of the staff member who made this decision/comment', 
  PRIMARY KEY (DecID), 
  UNIQUE INDEX (DecID)) comment='The decision/comment made for an application by a RHD staff member';
CREATE TABLE `Research Area` (
  FORCode      int(10) NOT NULL AUTO_INCREMENT comment 'The Australian Field Of Research (FOR) code, primary key, that uniquely identifies the Research area', 
  Description  varchar(2000) NOT NULL comment 'A small text description of the FOR i.e. 2201', 
  ResearchArea varchar(50) NOT NULL comment 'The FOR title; i.e. Applied Ethics', 
  GeneralArea  varchar(50) NOT NULL comment 'The general area of the FOR', 
  PRIMARY KEY (FORCode), 
  UNIQUE INDEX (FORCode));
CREATE TABLE `University Staff Member` (
  StaffID      int(10) NOT NULL AUTO_INCREMENT comment 'The flinders uni staff ID number, the primary key that uniquely identifies the staff member', 
  LName        varchar(50) NOT NULL comment 'The first name of the staff member', 
  FName        varchar(50) comment 'The last name of the staff member', 
  canSupervise int(1) NOT NULL comment 'if the staff member is able supervise a RHD applicant', 
  PRIMARY KEY (StaffID), 
  UNIQUE INDEX (StaffID)) comment='a university staff member who may be able to supervise a application';
CREATE TABLE `Correspondence Method` (
  Method varchar(50) NOT NULL comment 'the method of correspondence', 
  PRIMARY KEY (Method), 
  UNIQUE INDEX (Method));
CREATE TABLE `Application Status` (
  Status      varchar(50) NOT NULL comment 'the name of the status', 
  Description varchar(1000) NOT NULL UNIQUE comment 'a full description of the status', 
  PRIMARY KEY (Status), 
  UNIQUE INDEX (Status)) comment='the possible application statuses of an application';
CREATE TABLE `Document Type` (
  Type        varchar(50) NOT NULL comment 'the type of document eg. Publication, visa etc.', 
  Description varchar(1000) NOT NULL UNIQUE comment 'a full description of the type of the document', 
  PRIMARY KEY (Type), 
  UNIQUE INDEX (Type)) comment='the possible types of a document';
CREATE TABLE `Award Type` (
  Type        varchar(50) NOT NULL comment 'the type of award sought by the applicant', 
  Description varchar(1000) NOT NULL UNIQUE comment 'a full description of the award type', 
  PRIMARY KEY (Type), 
  UNIQUE INDEX (Type)) comment='the possible award types (degrees) sought by an application';
CREATE TABLE Country (
  CountryISOCode int(2) NOT NULL AUTO_INCREMENT comment 'the country corresponding ISO 3166-1 alpha-2 code', 
  Name           varchar(50) NOT NULL UNIQUE comment 'the full name of the country', 
  PRIMARY KEY (CountryISOCode)) comment='a list of countries for reuse in nationality, institution country, address and visa country';
CREATE TABLE `Supervise as` (
  PrimarySupervisor int(1) NOT NULL comment 'if the supervisor is a primary', 
  ApplicationID     int(10) NOT NULL comment 'the application ID of the application the staff member will supervise', 
  StaffID           int(10) NOT NULL comment 'the staff ID of the staff member who will supervise the applicaiton', 
  PRIMARY KEY (ApplicationID, 
  StaffID), 
  INDEX (ApplicationID), 
  INDEX (StaffID)) comment='the staff members who have agreed to supervise an application';
CREATE TABLE `Application_Research Area` (
  ApplicationID int(10) NOT NULL comment 'the ID of the application', 
  FORCode       int(10) NOT NULL comment 'the FORCode research area the applicant states they want to study in', 
  PRIMARY KEY (ApplicationID, 
  FORCode)) comment='The application and the research area they are looking to study in';
CREATE TABLE `University Staff Member_Research Area` (
  StaffID int(10) NOT NULL comment 'the staff ID of the staff member who works in the research area', 
  FORCode int(10) NOT NULL comment 'the field of research that the staff member works in', 
  PRIMARY KEY (StaffID, 
  FORCode), 
  INDEX (StaffID), 
  INDEX (FORCode)) comment='the research area the staff member states they work in';
CREATE TABLE `University Staff Member_Research Area2` (
  StaffID int(10) NOT NULL comment 'the staff ID of the staff member who oversees the research area', 
  FORCode int(10) NOT NULL comment 'the FORCode of the research area that the staff member oversees', 
  PRIMARY KEY (StaffID, 
  FORCode), 
  INDEX (StaffID), 
  INDEX (FORCode)) comment='the research areas that a staff member oversees (can be more than one staff member per area)';
CREATE TABLE `University Staff Member_Application` (
  StaffID       int(10) NOT NULL comment 'the staff ID of the staff member who flagged the application', 
  ApplicationID int(10) NOT NULL comment 'the application the staff member has flagged', 
  PRIMARY KEY (StaffID, 
  ApplicationID), 
  INDEX (StaffID), 
  INDEX (ApplicationID)) comment='the staff members who have flagged an application to come back and check later';
ALTER TABLE Document ADD INDEX associated (ApplicationID), ADD CONSTRAINT associated FOREIGN KEY (ApplicationID) REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Document ADD INDEX provides (ApplicantID), ADD CONSTRAINT provides FOREIGN KEY (ApplicantID) REFERENCES Applicant (ApplicantID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE Decision ADD INDEX hasDecisionType (dectype), ADD CONSTRAINT hasDecisionType FOREIGN KEY (dectype) REFERENCES `Decision Type` (type);
ALTER TABLE Visa ADD INDEX `originates in` (CountryISOCode), ADD CONSTRAINT `originates in` FOREIGN KEY (CountryISOCode) REFERENCES Country (CountryISOCode) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Degree ADD INDEX `studied in` (InstituitonCountryISOCode), ADD CONSTRAINT `studied in` FOREIGN KEY (InstituitonCountryISOCode) REFERENCES Country (CountryISOCode) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Applicant ADD INDEX `lives in` (AddressCountryISOCode), ADD CONSTRAINT `lives in` FOREIGN KEY (AddressCountryISOCode) REFERENCES Country (CountryISOCode) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Applicant ADD INDEX `nationality of` (NationalityCountryISOCode), ADD CONSTRAINT `nationality of` FOREIGN KEY (NationalityCountryISOCode) REFERENCES Country (CountryISOCode) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Application ADD INDEX `will pay using` (PaymentMethod), ADD CONSTRAINT `will pay using` FOREIGN KEY (PaymentMethod) REFERENCES `Payment Method` (Method) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Application ADD INDEX submits (ApplicantID), ADD CONSTRAINT submits FOREIGN KEY (ApplicantID) REFERENCES Applicant (ApplicantID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE `Supervise as` ADD INDEX `will supervise2` (ApplicationID), ADD CONSTRAINT `will supervise2` FOREIGN KEY (ApplicationID) REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE `Supervise as` ADD INDEX `will supervise` (StaffID), ADD CONSTRAINT `will supervise` FOREIGN KEY (StaffID) REFERENCES `University Staff Member` (StaffID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE `Application_Research Area` ADD INDEX `in` (ApplicationID), ADD CONSTRAINT `in` FOREIGN KEY (ApplicationID) REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE `Application_Research Area` ADD INDEX in2 (FORCode), ADD CONSTRAINT in2 FOREIGN KEY (FORCode) REFERENCES `Research Area` (FORCode) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE `University Staff Member_Research Area` ADD INDEX `works in` (StaffID), ADD CONSTRAINT `works in` FOREIGN KEY (StaffID) REFERENCES `University Staff Member` (StaffID);
ALTER TABLE `University Staff Member_Research Area` ADD INDEX `works in2` (FORCode), ADD CONSTRAINT `works in2` FOREIGN KEY (FORCode) REFERENCES `Research Area` (FORCode) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE `University Staff Member_Research Area2` ADD INDEX Oversees (StaffID), ADD CONSTRAINT Oversees FOREIGN KEY (StaffID) REFERENCES `University Staff Member` (StaffID);
ALTER TABLE `University Staff Member_Research Area2` ADD INDEX Oversees2 (FORCode), ADD CONSTRAINT Oversees2 FOREIGN KEY (FORCode) REFERENCES `Research Area` (FORCode) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Decision ADD INDEX Decides (ApplicationID), ADD CONSTRAINT Decides FOREIGN KEY (ApplicationID) REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE Decision ADD INDEX Decides2 (StaffID), ADD CONSTRAINT Decides2 FOREIGN KEY (StaffID) REFERENCES `University Staff Member` (StaffID) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Visa ADD INDEX hasVisaStatus (visaStatus), ADD CONSTRAINT hasVisaStatus FOREIGN KEY (visaStatus) REFERENCES `Visa Status` (Status) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Application ADD INDEX hasAppStatus (ApplicationStatus), ADD CONSTRAINT hasAppStatus FOREIGN KEY (ApplicationStatus) REFERENCES `Application Status` (Status) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Document ADD INDEX hasDocStatus (DocStatus), ADD CONSTRAINT hasDocStatus FOREIGN KEY (DocStatus) REFERENCES `Document Status` (Status) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE `University Staff Member_Application` ADD INDEX flags (StaffID), ADD CONSTRAINT flags FOREIGN KEY (StaffID) REFERENCES `University Staff Member` (StaffID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE `University Staff Member_Application` ADD INDEX flags2 (ApplicationID), ADD CONSTRAINT flags2 FOREIGN KEY (ApplicationID) REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE Referee ADD INDEX `supported by` (ApplicationID), ADD CONSTRAINT `supported by` FOREIGN KEY (ApplicationID) REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE Correspondence ADD INDEX `corresponds with` (ApplicationID), ADD CONSTRAINT `corresponds with` FOREIGN KEY (ApplicationID) REFERENCES Application (ApplicationID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE Correspondence ADD INDEX `corresponds with2` (StaffID), ADD CONSTRAINT `corresponds with2` FOREIGN KEY (StaffID) REFERENCES `University Staff Member` (StaffID) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Document ADD INDEX of (DocType), ADD CONSTRAINT of FOREIGN KEY (DocType) REFERENCES `Document Type` (Type) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Application ADD INDEX Manages (ManagedByStaffID), ADD CONSTRAINT Manages FOREIGN KEY (ManagedByStaffID) REFERENCES `University Staff Member` (StaffID) ON UPDATE Cascade ON DELETE Set null;
ALTER TABLE Degree ADD INDEX holds (ApplicantID), ADD CONSTRAINT holds FOREIGN KEY (ApplicantID) REFERENCES Applicant (ApplicantID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE Publication ADD INDEX authored (ApplicantID), ADD CONSTRAINT authored FOREIGN KEY (ApplicantID) REFERENCES Applicant (ApplicantID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE Visa ADD INDEX `may have` (ApplicantID), ADD CONSTRAINT `may have` FOREIGN KEY (ApplicantID) REFERENCES Applicant (ApplicantID) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE Application ADD INDEX seeks (AwardType), ADD CONSTRAINT seeks FOREIGN KEY (AwardType) REFERENCES `Award Type` (Type) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE Application ADD INDEX `last to update` (LastModifiedByStaffID), ADD CONSTRAINT `last to update` FOREIGN KEY (LastModifiedByStaffID) REFERENCES `University Staff Member` (StaffID) ON UPDATE Cascade ON DELETE Set null;
ALTER TABLE Applicant ADD INDEX `last to modify` (LastModifiedByStaffID), ADD CONSTRAINT `last to modify` FOREIGN KEY (LastModifiedByStaffID) REFERENCES `University Staff Member` (StaffID);
ALTER TABLE Correspondence ADD INDEX using (corrMethod), ADD CONSTRAINT using FOREIGN KEY (corrMethod) REFERENCES `Correspondence Method` (Method) ON UPDATE Cascade ON DELETE Restrict;
