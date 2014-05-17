CREATE TABLE `Decision Type` (
  type varchar(50) NOT NULL , 
  PRIMARY KEY (type), 
  UNIQUE INDEX (type)) ;
CREATE TABLE `Payment Method` (
  Method int(10) NOT NULL AUTO_INCREMENT , 
  PRIMARY KEY (Method), 
  UNIQUE INDEX (Method)) ;
CREATE TABLE Application (
  ApplicationID         int(10) NOT NULL AUTO_INCREMENT, 
  ApplicantID           int(10) NOT NULL , 
  AddressConfirmed      int(1) NOT NULL , 
  DegreeConfirmed       int(1) NOT NULL , 
  VisaStatusConfirmed   int(1) NOT NULL , 
  ProposalConfirmed     int(1) NOT NULL , 
  HasReasearchAreas     int(1) NOT NULL , 
  HasPrimarySuper       int(1) NOT NULL , 
  PayMethConfirmed      int(1) NOT NULL , 
  EngProfConfirmed      int(1) NOT NULL , 
  RefereesConfirmed     int(1) NOT NULL , 
  RequireMoreInfo       int(1), 
  ProposedStartDate     date , 
  ProposalSummary       varchar(2000) , 
  flindersCampus        int(1) , 
  fullTime              int(1) , 
  DateAdded             date NOT NULL , 
  DateLastChecked       date NOT NULL , 
  DateLastModified      date NOT NULL , 
  PaymentMethod         int(10) , 
  ApplicationStatus     varchar(50) NOT NULL , 
  ManagedByStaffID      int(10) , 
  AwardType             varchar(50) , 
  LastModifiedByStaffID int(10) NOT NULL , 
  PRIMARY KEY (ApplicationID), 
  UNIQUE INDEX (ApplicationID), 
  INDEX (ApplicantID)) ;
CREATE TABLE `Document Status` (
  Status      varchar(50) NOT NULL , 
  Description varchar(2000) NOT NULL , 
  PRIMARY KEY (Status), 
  UNIQUE INDEX (Status)) ;
CREATE TABLE Publication (
  PubID             int(10) NOT NULL AUTO_INCREMENT , 
  ApplicantID       int(10) NOT NULL , 
  Title             varchar(255) NOT NULL , 
  Abstract          varchar(2000) , 
  Publication       varchar(255) NOT NULL , 
  IssueNo           int(10) , 
  IssueDate         date NOT NULL , 
  OnlineLink        varchar(255) , 
  OtherAuthorsNames varchar(255) , 
  Language          varchar(50) , 
  PRIMARY KEY (PubID), 
  UNIQUE INDEX (PubID));
CREATE TABLE Degree (
  DegID                     int(10) NOT NULL AUTO_INCREMENT , 
  ApplicantID               int(10) NOT NULL , 
  Name                      varchar(100) NOT NULL , 
  Type                      varchar(100) NOT NULL , 
  YearCompleted             date , 
  GPA                       int(10) , 
  InstitutionName           varchar(100) , 
  InstituitonCountryISOCode char(2) NOT NULL , 
  PRIMARY KEY (DegID), 
  UNIQUE INDEX (DegID), 
  INDEX (ApplicantID)) ;
CREATE TABLE Referee (
  RefID           int(10) NOT NULL AUTO_INCREMENT , 
  ApplicationID   int(10) NOT NULL, 
  Name            varchar(100) NOT NULL , 
  Relation        varchar(100) , 
  Phone           varchar(50) , 
  Email           varchar(100) , 
  Profession      varchar(255) , 
  AcademicLink    varchar(255) , 
  EnglishSpeaker  int(1) , 
  EnglishLiterate int(1) , 
  PRIMARY KEY (RefID), 
  UNIQUE INDEX (RefID)) ;
CREATE TABLE Document (
  DocID         int(10) NOT NULL AUTO_INCREMENT , 
  Title         varchar(254) NOT NULL , 
  Description   varchar(2000) NOT NULL , 
  UploadLink    varchar(254) NOT NULL , 
  ApplicationID int(10), 
  ApplicantID   int(10) NOT NULL , 
  DocStatus     varchar(50) NOT NULL , 
  DocType       varchar(50) NOT NULL , 
  PRIMARY KEY (DocID), 
  UNIQUE INDEX (DocID), 
  INDEX (ApplicationID), 
  INDEX (ApplicantID)) ;
CREATE TABLE Applicant (
  ApplicantID               int(10) NOT NULL AUTO_INCREMENT , 
  FName                     varchar(50) NOT NULL , 
  LName                     varchar(50) , 
  PrefTitle                 varchar(10) , 
  Sex                       int(1) , 
  DOB                       date , 
  StreetAddress             varchar(255) , 
  Suburb                    varchar(100) , 
  Postcode                  int(10) , 
  City                      int(10) , 
  State                     varchar(50) , 
  Mobile                    varchar(50) , 
  Phone                     varchar(50) , 
  Email                     varchar(100) , 
  IsNZAUCitizen             int(1) , 
  EnglishProficient         bit(1) , 
  StudentID                 int(10) , 
  DateAdded                 date NOT NULL , 
  AddressCountryISOCode     char(2), 
  NationalityCountryISOCode char(2), 
  LastModifiedByStaffID     int(10) NOT NULL , 
  PRIMARY KEY (ApplicantID), 
  UNIQUE INDEX (ApplicantID)) ;
CREATE TABLE Visa (
  VisaID               int(10) NOT NULL AUTO_INCREMENT , 
  OriginCountryISOCode char(2) NOT NULL , 
  ValidFrom            date , 
  ValidTo              date , 
  CountryISOCode       char(2) NOT NULL , 
  visaStatus           varchar(50) NOT NULL , 
  ApplicantID          int(10) NOT NULL , 
  PRIMARY KEY (VisaID), 
  UNIQUE INDEX (VisaID)) ;
CREATE TABLE `Visa Status` (
  Status      varchar(50) NOT NULL , 
  description varchar(1000) NOT NULL , 
  PRIMARY KEY (Status), 
  UNIQUE INDEX (Status)) ;
CREATE TABLE Correspondence (
  CorrID        int(10) NOT NULL AUTO_INCREMENT, 
  `Date`        date NOT NULL , 
  Summary       varchar(1000) NOT NULL , 
  Message       varchar(2000) , 
  ApplicationID int(10) NOT NULL , 
  StaffID       int(10) NOT NULL , 
  corrMethod    varchar(50) NOT NULL , 
  PRIMARY KEY (CorrID), 
  UNIQUE INDEX (CorrID)) ;
CREATE TABLE Decision (
  DecID         int(10) NOT NULL AUTO_INCREMENT , 
  `Date`        date NOT NULL , 
  Comment       varchar(1000) , 
  dectype       varchar(50) NOT NULL , 
  ApplicationID int(10) NOT NULL , 
  StaffID       int(10) NOT NULL , 
  PRIMARY KEY (DecID), 
  UNIQUE INDEX (DecID)) ;
CREATE TABLE `Research Area` (
  FORCode      int(10) NOT NULL AUTO_INCREMENT , 
  Description  varchar(2000) NOT NULL , 
  ResearchArea varchar(50) NOT NULL , 
  GeneralArea  varchar(50) NOT NULL , 
  PRIMARY KEY (FORCode), 
  UNIQUE INDEX (FORCode));
CREATE TABLE `University Staff Member` (
  StaffID      int(10) NOT NULL AUTO_INCREMENT , 
  LName        varchar(50) NOT NULL , 
  FName        varchar(50) , 
  canSupervise int(1) NOT NULL , 
  PRIMARY KEY (StaffID), 
  UNIQUE INDEX (StaffID)) ;
CREATE TABLE `Correspondence Method` (
  Method varchar(50) NOT NULL , 
  PRIMARY KEY (Method), 
  UNIQUE INDEX (Method));
CREATE TABLE `Application Status` (
  Status      varchar(50) NOT NULL , 
  Description varchar(1000) NOT NULL , 
  PRIMARY KEY (Status), 
  UNIQUE INDEX (Status)) ;
CREATE TABLE `Document Type` (
  Type        varchar(50) NOT NULL , 
  Description varchar(1000) NOT NULL  , 
  PRIMARY KEY (Type), 
  UNIQUE INDEX (Type)) ;
CREATE TABLE `Award Type` (
  Type        varchar(50) NOT NULL , 
  Description varchar(1000) NOT NULL , 
  PRIMARY KEY (Type), 
  UNIQUE INDEX (Type)) ;
CREATE TABLE Country (
  CountryISOCode char(2) NOT NULL , 
  Name           varchar(50) NOT NULL UNIQUE , 
  PRIMARY KEY (CountryISOCode)) ;
CREATE TABLE `Supervise as` (
  PrimarySupervisor int(1) NOT NULL , 
  ApplicationID     int(10) NOT NULL , 
  StaffID           int(10) NOT NULL , 
  PRIMARY KEY (ApplicationID, 
  StaffID), 
  INDEX (ApplicationID), 
  INDEX (StaffID)) ;
CREATE TABLE `Application_Research Area` (
  ApplicationID int(10) NOT NULL , 
  FORCode       int(10) NOT NULL , 
  PRIMARY KEY (ApplicationID, 
  FORCode)) ;
CREATE TABLE `University Staff Member_Research Area` (
  StaffID int(10) NOT NULL , 
  FORCode int(10) NOT NULL , 
  PRIMARY KEY (StaffID, 
  FORCode), 
  INDEX (StaffID), 
  INDEX (FORCode)) ;
CREATE TABLE `University Staff Member_Research Area2` (
  StaffID int(10) NOT NULL , 
  FORCode int(10) NOT NULL , 
  PRIMARY KEY (StaffID, 
  FORCode), 
  INDEX (StaffID), 
  INDEX (FORCode)) ;
CREATE TABLE `University Staff Member_Application` (
  StaffID       int(10) NOT NULL , 
  ApplicationID int(10) NOT NULL , 
  PRIMARY KEY (StaffID, 
  ApplicationID), 
  INDEX (StaffID), 
  INDEX (ApplicationID)) ;
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
ALTER TABLE Application ADD INDEX `last to update` (LastModifiedByStaffID), ADD CONSTRAINT `last to update` FOREIGN KEY (LastModifiedByStaffID) REFERENCES `University Staff Member` (StaffID) ;
ALTER TABLE Applicant ADD INDEX `last to modify` (LastModifiedByStaffID), ADD CONSTRAINT `last to modify` FOREIGN KEY (LastModifiedByStaffID) REFERENCES `University Staff Member` (StaffID);
ALTER TABLE Correspondence ADD INDEX using btree (corrMethod), ADD CONSTRAINT  FOREIGN KEY (corrMethod) REFERENCES `Correspondence Method` (Method) ON UPDATE Cascade ON DELETE Restrict;
