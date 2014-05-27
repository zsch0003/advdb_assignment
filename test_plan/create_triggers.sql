
DROP TABLE IF EXISTS usm_researcharea_changes ; 
CREATE TABLE usm_researcharea_changes (
  usm_researcharea_change_id int(10) NOT NULL AUTO_INCREMENT comment 'PK',
  date date NOT NULL,
  time time NOT NULL,
  description varchar(50) NOT NULL,
  FORCode int(10) NOT NULL,
  StaffID int(10) NOT NULL,
  PRIMARY KEY (usm_researcharea_change_id)
);

DELIMITER $$

DROP TRIGGER IF EXISTS usm_researcharea_ai $$
CREATE TRIGGER usm_researcharea_ai AFTER INSERT ON 
`University Staff Member_Research Area`
FOR EACH ROW
BEGIN
  INSERT INTO usm_researcharea_changes(date, time, description, FORCode, 
  StaffID)
  VALUES (CURRENT_DATE(), CURRENT_TIME(), 'added', NEW.FORCode, NEW.StaffID) ;
END $$

DELIMITER ;

