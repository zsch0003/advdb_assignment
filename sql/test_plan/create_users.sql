-- -----------------------------------------------------------------------------
-- Create the roles / users to test RHDDB
-- 
-- Must be run by the DB admin (root)

CREATE USER 'rhdAdmin'@'localhost' IDENTIFIED BY 'rhdAdmin';
GRANT ALL PRIVELEGES ON 'rhd'.* to 'rhdAdmin'@'localhost';

-- create views associated with 3 types of privilege

-- add 3/4 columns to Uni. Staff Member, to say Y, N to 3/4 levels of privilege

CREATE USER 'rhdAdmin'@'localhost' IDENTIFIED BY 'rhdAdmin';


-- add a trigger to send an email on changes to supervision, research areas

-- so what's left?

-- prevent delete by normal users

-- create some views and use them to demonstrate that we understand the concept

-- prevent update to 'as supervise' relation by non-rhd staff

   -- create a view on 'as supervise' that non-rhd access

   -- create new transactions tests for the view

      -- the front end would be responsible for choosing correct one



      
