-- -----------------------------------------------------------------------------
-- ApplicationStatus
INSERT INTO `Application Status` (Status, Description)
VALUES ('ongoing', 'Application/information gathering is currently ongoing' ) ;

INSERT INTO `Application Status` (Status, Description)
VALUES ('complete.accepted', 'Application accepted. Elevated to RHD office.' ) ;

INSERT INTO `Application Status` (Status, Description)
VALUES ('complete.declined', 'Application declined. School chooses not to pursue.' ) ;

INSERT INTO `Application Status` (Status, Description)
VALUES ('complete.withdrawn', 'Application withdrawn by applicant.' ) ;

INSERT INTO `Application Status` (Status, Description)
VALUES ('complete.lapsed', 'No activity for a significant period.' ) ;


-- -----------------------------------------------------------------------------
-- DocumentType
INSERT INTO `Document Type` (Type, Description)
VALUES ('application', 'A completed RHD application form.') ;

INSERT INTO `Document Type` (Type, Description)
VALUES ('cv', 'CV') ;

INSERT INTO `Document Type` (Type, Description)
VALUES ('resume', 'resume') ;

INSERT INTO `Document Type` (Type, Description)
VALUES ('faculty_assessment_memo', 'Faculty assessment memo') ;

INSERT INTO `Document Type` (Type, Description)
VALUES ('certificate', 'A certificate of a previous degree.') ;

INSERT INTO `Document Type` (Type, Description)
VALUES ('transcript', 'An academic transcript of a previous degree.') ;

INSERT INTO `Document Type` (Type, Description)
VALUES ('thesis', 'An previous degree major work.') ;

INSERT INTO `Document Type` (Type, Description)
VALUES ('proposal', 'An application proposal.') ;

INSERT INTO `Document Type` (Type, Description)
VALUES ('reference', 'A character/academic reference of the applicant.') ;

INSERT INTO `Document Type` (Type, Description)
VALUES ('publication', 'A scientific publication authored by the applicant.') ;

INSERT INTO `Document Type` (Type, Description)
VALUES ('financial', 'A document relating to how the RHD place is to be funded.') ;

INSERT INTO `Document Type` (Type, Description)
VALUES ('general', 'A type of document other than decribed above.') ;


-- -----------------------------------------------------------------------------
-- DocumentStatus
INSERT INTO `Document Status` (Status, Description)
VALUES ('original.english', 'Original document in English');

INSERT INTO `Document Status` (Status, Description)
VALUES ('original.lote', 'Original document in a language other than English.');

INSERT INTO `Document Status` (Status, Description)
VALUES ('translation', 'Official translation into English of original document');

INSERT INTO `Document Status` (Status, Description)
VALUES ('summary', 'Not an original source document.');

-- -----------------------------------------------------------------------------
-- AwardType
INSERT INTO `Award Type` (Type, Description)
VALUES ('PhD', 'PhD in any field in the school');

INSERT INTO `Award Type` (Type, Description)
VALUES ('PhD (Comp Sc)', 'PhD in Computer Science');

INSERT INTO `Award Type` (Type, Description)
VALUES ('masters', 'Masters by research in any field in the school');

INSERT INTO `Award Type` (Type, Description)
VALUES ('MIT', 'Masters IT');


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
INSERT INTO `Decision Type` (type)
VALUES ('GPA too low');

INSERT INTO `Decision Type` (type)
VALUES ('TOEFL/IELTS score too low');

INSERT INTO `Decision Type` (type)
VALUES ('Hand over');

INSERT INTO `Decision Type` (type)
VALUES ('RFI');
