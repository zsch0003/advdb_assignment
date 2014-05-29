-- -----------------------------------------------------------------------------
-- Script to help evaluate speed (throughput) of system


-- -----------------------------------------------------------------------------
-- Benchmark how long it takes to retrieve applications by email, when: doing a
-- JOIN on Applicant and Application to; and when using the denormalised 
-- duplication of the email column into the Application table

-- get all the email addresses
DROP TABLE IF EXISTS applicant_emails ;
CREATE TEMPORARY TABLE applicant_emails 
SELECT a.Email FROM Applicant a ;

DROP PROCEDURE IF EXISTS perf_app_emails ;
DELIMITER $$

CREATE PROCEDURE perf_app_emails(IN iterations INT)
BEGIN

  DECLARE time_elapsed FLOAT;
  DECLARE time_start INT DEFAULT NOW();
  DECLARE counter INT DEFAULT iterations ;
--  SELECT time_start ;

  WHILE counter > 0 DO

    SELECT Application.ApplicationID FROM Application, Applicant
    WHERE Applicant.ApplicantID = Application.ApplicantID
      AND Applicant.Email IN 
      (
	SELECT Email FROM applicant_emails
      )
    ;

    SET counter = counter - 1 ;

  END WHILE ; 

  SET time_elapsed = NOW() - time_start ;
--  SELECT time_elapsed ;

END $$

DELIMITER ;

-- CALL perf_app_emails() ;
-- SELECT BENCHMARK (10,  CALL perf_app_emails() ) ;

CALL perf_app_emails(1000) ;


DROP TABLE applicant_emails ;


-- Let's try a nested query (subquery) instead

