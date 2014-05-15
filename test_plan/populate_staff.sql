--------------------------------------------------------------------------------
-- UNIVERSITY STAFF MEMBERS

--------------------------------------------------------------------------------
-- Denise de Vries
INSERT INTO UniversityStaffMember(StaffID, LName, FName, canSupervise)
VALUES (1000, 'de Vries', 'Denise', 1);

-- FOR 'computer software not elsewhere classified'
INSERT INTO UniversityStaffMember_ResearchArea (StaffID, FORCode)
VALUES (1000, 080399);

-- FOR 'data format not elsewhere classified'
INSERT INTO UniversityStaffMember_ResearchArea (StaffID, FORCode)
VALUES (1000, 080499);

-- FOR 'information systems not elsewhere classified'
INSERT INTO UniversityStaffMember_ResearchArea (StaffID, FORCode)
VALUES (1000, 080699);

-- FOR 'information and computing sciences not elsewhere classified'
INSERT INTO UniversityStaffMember_ResearchArea (StaffID, FORCode)
VALUES (1000, 089999);


--------------------------------------------------------------------------------
-- Paul Calder
INSERT INTO UniversityStaffMember(StaffID, LName, FName, canSupervise)
VALUES (1001, 'Calder', 'Paul', 1);

-- FOR 'artificial intelligence and image processing not elsewhere classified'
INSERT INTO UniversityStaffMember_ResearchArea (StaffID, FORCode)
VALUES (1001, 080199);

-- FOR 'computer software not elsewhere classified'
INSERT INTO UniversityStaffMember_ResearchArea (StaffID, FORCode)
VALUES (1001, 080399);


--------------------------------------------------------------------------------
-- John Roddick
INSERT INTO UniversityStaffMember(StaffID, LName, FName, canSupervise)
VALUES (1002, 'Roddick', 'John', 1);

-- FOR 'artificial intelligence and image processing not elsewhere classified'
INSERT INTO UniversityStaffMember_ResearchArea (StaffID, FORCode)
VALUES (1002, 080199);

-- FOR 'information systems not elsewhere classified'
INSERT INTO UniversityStaffMember_ResearchArea (StaffID, FORCode)
VALUES (1002, 080699);


--------------------------------------------------------------------------------
-- Jennie Brand
INSERT INTO UniversityStaffMember(StaffID, LName, FName, canSupervise)
VALUES (1003, 'Brand', 'Jennie', 0);
