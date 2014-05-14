--------------------------------------------------------------------------------
-- ApplicationStatus
INSERT INTO ApplicationStatus (Status, Description)
VALUES ('ongoing', 'Application/information gathering is currently ongoing' ) ;

INSERT INTO ApplicationStatus (Status, Description)
VALUES ('complete.accepted', 'Application accepted. Elevated to RHD office.' ) ;

INSERT INTO ApplicationStatus (Status, Description)
VALUES ('complete.declined', 'Application declined. School chooses not to pursue.' ) ;

INSERT INTO ApplicationStatus (Status, Description)
VALUES ('complete.withdrawn', 'Application withdrawn by applicant.' ) ;

INSERT INTO ApplicationStatus (Status, Description)
VALUES ('complete.lapsed', 'No activity for a significant period.' ) ;


--------------------------------------------------------------------------------
-- DocumentType
INSERT INTO DocumentType (Type, Description)
VALUES ('application', 'A completed RHD application form.') ;

INSERT INTO DocumentType (Type, Description)
VALUES ('cv', 'CV') ;

INSERT INTO DocumentType (Type, Description)
VALUES ('resume', 'resume') ;

INSERT INTO DocumentType (Type, Description)
VALUES ('faculty_assessment_memo', 'Faculty assessment memo') ;

INSERT INTO DocumentType (Type, Description)
VALUES ('certificate', 'A certificate of a previous degree.') ;

INSERT INTO DocumentType (Type, Description)
VALUES ('transcript', 'An academic transcript of a previous degree.') ;

INSERT INTO DocumentType (Type, Description)
VALUES ('thesis', 'An previous degree major work.') ;

INSERT INTO DocumentType (Type, Description)
VALUES ('proposal', 'An application proposal.') ;

INSERT INTO DocumentType (Type, Description)
VALUES ('reference', 'A character/academic reference of the applicant.') ;

INSERT INTO DocumentType (Type, Description)
VALUES ('publication', 'A scientific publication authored by the applicant.') ;

INSERT INTO DocumentType (Type, Description)
VALUES ('financial', 'A document relating to how the RHD place is to be funded.') ;

INSERT INTO DocumentType (Type, Description)
VALUES ('general', 'A type of document other than decribed above.') ;


--------------------------------------------------------------------------------
-- DocumentStatus
INSERT INTO DocumentStatus (Status, Description)
VALUES ('original.english', 'Original document in English');

INSERT INTO DocumentStatus (Status, Description)
VALUES ('original.lote', 'Original document in a language other than English.');

INSERT INTO DocumentStatus (Status, Description)
VALUES ('translation', 'Official translation into English of original document');

INSERT INTO DocumentStatus (Status, Description)
VALUES ('summary', 'Not an original source document.');

--------------------------------------------------------------------------------
-- CorrespondenceMethod

