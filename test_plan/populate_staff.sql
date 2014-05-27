-- -----------------------------------------------------------------------------
-- UNIVERSITY STAFF MEMBERS
-- -----------------------------------------------------------------------------
-- Denise de Vries
INSERT INTO `University Staff Member` (StaffID, LName, FName, canSupervise,
email)
VALUES (1000, 'de Vries', 'Denise', 1, 'denise.deries@flinders.edu.au');

-- FOR 'computer software not elsewhere classified'
INSERT INTO `University Staff Member_Research Area` (StaffID, FORCode)
VALUES (1000, 080399);

-- FOR 'data format not elsewhere classified'
INSERT INTO `University Staff Member_Research Area` (StaffID, FORCode)
VALUES (1000, 080499);

-- FOR 'information systems not elsewhere classified'
INSERT INTO `University Staff Member_Research Area` (StaffID, FORCode)
VALUES (1000, 080699);

-- FOR 'information and computing sciences not elsewhere classified'
INSERT INTO `University Staff Member_Research Area` (StaffID, FORCode)
VALUES (1000, 089999);


-- -----------------------------------------------------------------------------
-- Paul Calder
INSERT INTO `University Staff Member` (StaffID, LName, FName, canSupervise,
email)
VALUES (1001, 'Calder', 'Paul', 1, 'paul.calder@flinders.edu.au');

-- FOR 'artificial intelligence and image processing not elsewhere classified'
INSERT INTO `University Staff Member_Research Area` (StaffID, FORCode)
VALUES (1001, 080199);

-- FOR 'computer software not elsewhere classified'
INSERT INTO `University Staff Member_Research Area` (StaffID, FORCode)
VALUES (1001, 080399);


-- -----------------------------------------------------------------------------
-- John Roddick
INSERT INTO `University Staff Member` (StaffID, LName, FName, canSupervise,
email)
VALUES (1002, 'Roddick', 'John', 1, 'john.roddick@flinders.edu.au');

-- FOR 'artificial intelligence and image processing not elsewhere classified'
INSERT INTO `University Staff Member_Research Area` (StaffID, FORCode)
VALUES (1002, 080199);

-- FOR 'information systems not elsewhere classified'
INSERT INTO `University Staff Member_Research Area` (StaffID, FORCode)
VALUES (1002, 080699);


-- -----------------------------------------------------------------------------
-- Jennie Brand
INSERT INTO `University Staff Member` (StaffID, LName, FName, canSupervise,
email)
VALUES (1003, 'Brand', 'Jennie', 0, 'jennie.brand@flinders.edu.au');
