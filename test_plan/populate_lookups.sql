SELECT "Loading populate_lookups.sql" ;

-- -----------------------------------------------------------------------------
-- ApplicationStatus
-- [10000..10499] reserved for all kinds of ongoing statuses
-- [10500..10999] reserved for all kinds of completed statuses
INSERT INTO `Application Status` (ApplicationStatusID, Status, Description)
VALUES (10000, 'ongoing', 
'Application/information gathering is currently ongoing' ) ;

INSERT INTO `Application Status` (ApplicationStatusID, Status, Description)
VALUES (10500, 'complete.accepted', 
'Application accepted. Elevated to RHD office.' ) ;

INSERT INTO `Application Status` (ApplicationStatusID, Status, Description)
VALUES (10501, 'complete.declined', 
'Application declined. School chooses not to pursue.' ) ;

INSERT INTO `Application Status` (ApplicationStatusID, Status, Description)
VALUES (10502, 'complete.withdrawn', 'Application withdrawn by applicant.' ) ;

INSERT INTO `Application Status` (ApplicationStatusID, Status, Description)
VALUES (10503, 'complete.lapsed', 'No activity for a significant period.' ) ;


-- -----------------------------------------------------------------------------
-- DocumentType
INSERT INTO `Document Type` (DocTypeID, Type, Description)
VALUES (20000, 'application', 'A completed RHD application form.') ;

INSERT INTO `Document Type` (DocTypeID, Type, Description)
VALUES (20001, 'cv', 'CV') ;

INSERT INTO `Document Type` (DocTypeID, Type, Description)
VALUES (20002, 'resume', 'resume') ;

INSERT INTO `Document Type` (DocTypeID, Type, Description)
VALUES (20003, 'faculty_assessment_memo', 'Faculty assessment memo') ;

INSERT INTO `Document Type` (DocTypeID, Type, Description)
VALUES (20004, 'certificate', 'A certificate of a previous degree.') ;

INSERT INTO `Document Type` (DocTypeID, Type, Description)
VALUES (20005, 'transcript', 'An academic transcript of a previous degree.') ;

INSERT INTO `Document Type` (DocTypeID, Type, Description)
VALUES (20006, 'thesis', 'An previous degree major work.') ;

INSERT INTO `Document Type` (DocTypeID, Type, Description)
VALUES (20007, 'proposal', 'An application proposal.') ;

INSERT INTO `Document Type` (DocTypeID, Type, Description)
VALUES (20008, 'reference', 
'A character/academic reference of the applicant.') ;

INSERT INTO `Document Type` (DocTypeID, Type, Description)
VALUES (20009, 'publication', 
'A scientific publication authored by the applicant.') ;

INSERT INTO `Document Type` (DocTypeID, Type, Description)
VALUES (20010, 'financial', 
'A document relating to how the RHD place is to be funded.') ;

INSERT INTO `Document Type` (DocTypeID, Type, Description)
VALUES (20011, 'general', 'A type of document other than decribed above.') ;


-- -----------------------------------------------------------------------------
-- DocumentStatus
INSERT INTO `Document Status` (DocStatusID, Status, Description)
VALUES (30000, 'original.english', 'Original document in English');

INSERT INTO `Document Status` (DocStatusID, Status, Description)
VALUES (30001, 'original.lote', 'Original document in a language other than English.');

INSERT INTO `Document Status` (DocStatusID, Status, Description)
VALUES (30002, 'translation', 'Official translation into English of original document');

INSERT INTO `Document Status` (DocStatusID, Status, Description)
VALUES (30003, 'summary', 'Not an original source document.');

-- -----------------------------------------------------------------------------
-- AwardType
INSERT INTO `Award Type` (AwardID, Type, Description)
VALUES (40000, 'PhD', 'PhD in any field in the school');

INSERT INTO `Award Type` (AwardID, Type, Description)
VALUES (40001, 'PhD (Comp Sc)', 'PhD in Computer Science');

INSERT INTO `Award Type` (AwardID, Type, Description)
VALUES (40002, 'masters', 'Masters by research in any field in the school');

INSERT INTO `Award Type` (AwardID, Type, Description)
VALUES (40003, 'MIT', 'Masters IT');


-- -----------------------------------------------------------------------------
-- ResearchArea
INSERT INTO `Research Area` (FORCode, Description, ResearchArea, GeneralArea)
VALUES (100503, 'computer communication networks', '', '');

INSERT INTO `Research Area` (FORCode, Description, ResearchArea, GeneralArea)
VALUES (080199, 'artificial intelligence and image processing not elsewhere classified', '', '');

INSERT INTO `Research Area` (FORCode, Description, ResearchArea, GeneralArea)
VALUES (080399, 'computer software not elsewhere classified', '', '');

INSERT INTO `Research Area` (FORCode, Description, ResearchArea, GeneralArea)
VALUES (080499, 'data format not elsewhere classified', '', '');

INSERT INTO `Research Area` (FORCode, Description, ResearchArea, GeneralArea)
VALUES (080699, 'information systems not elsewhere classified', '', '');

INSERT INTO `Research Area` (FORCode, Description, ResearchArea, GeneralArea)
VALUES (089999, 'information and computing sciences not elsewhere classified', '', '');


-- -----------------------------------------------------------------------------
-- DecisionTypes
INSERT INTO `Decision Type` (DecisionTypeID, type)
VALUES (50000, 'GPA too low');

INSERT INTO `Decision Type` (DecisionTypeID, type)
VALUES (50001, 'TOEFL/IELTS score too low');

INSERT INTO `Decision Type` (DecisionTypeID, type)
VALUES (50002, 'Hand over');

INSERT INTO `Decision Type` (DecisionTypeID, type)
VALUES (50003, 'RFI');

-- -----------------------------------------------------------------------------
-- CorrespondenceMethod
INSERT INTO `Correspondence Method` (CorrMethodID, Method)
VALUES (60000, 'email');

INSERT INTO `Correspondence Method` (CorrMethodID, Method)
VALUES (60001, 'telephone');

INSERT INTO `Correspondence Method` (CorrMethodID, Method)
VALUES (60002, 'carrier pigeon');

INSERT INTO `Correspondence Method` (CorrMethodID, Method)
VALUES (69999, 'other');
