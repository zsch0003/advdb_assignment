-- -----------------------------------------------------------------------------
-- Script to help evaluate speed (throughput) of system


-- -----------------------------------------------------------------------------
-- Benchmark how long it takes to retrieve applications by email, when: doing a
-- JOIN on Applicant and Application to; and when using the denormalised 
-- duplication of the email column into the Application table

-- get all the email addresses
DROP TABLE IF EXISTS applicant_emails ;
CREATE TEMPORARY TABLE applicant_emails 
SELECT a.Email FROM rhd.Applicant a ;

DROP PROCEDURE IF EXISTS perf_app_emails ;
DELIMITER $$

CREATE PROCEDURE perf_app_emails()
BEGIN

  DECLARE email_value VARCHAR(100) DEFAULT "" ;
  DECLARE email_end INT DEFAULT 0 ;
  DECLARE email_cursor CURSOR FOR SELECT Email from applicant_emails ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET email_end = 1;

  OPEN email_cursor ;

  test_email: LOOP

    FETCH email_cursor INTO email_value ; 

    IF email_end = 1 THEN
      LEAVE test_email ; 
    END IF ; 

    SELECT Application.ApplicationID FROM rhd.Applicant, rhd.Application
    WHERE Application.ApplicantID = Applicant.ApplicantID
      AND Applicant.Email = email_value ;

  END LOOP test_email ; 

  CLOSE email_cursor ;

END $$

DELIMITER ;

-- CALL perf_app_emails() ;
SELECT BENCHMARK (10,  CALL perf_app_emails() ) ;


DROP TABLE applicant_emails ;
