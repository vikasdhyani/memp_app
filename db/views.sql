-- view for branches from jbprod

CREATE OR REPLACE FORCE VIEW "MEMP"."BRANCHES" ("ID", "NAME", "ADDRESS", "CITY", "PHONE", "EMAIL", "CATEGORY", "PARENT_ID", "PARENT_NAME", "CARD_ID")
AS
  SELECT a.branchid id,
    a.branchid
    || ' - '
    || a.branchname name,
    a.branchaddress address,
    b.cityname city,
    a.contactnumbers phone,
    a.emailid email,
    a.branchtype category,
    a.parentbranchid parent_id,
    c.branchname parent_name,
    c.branchcard card_id
  FROM jbprod.branch a,
    jbprod.city b,
    jbprod.branch c
  WHERE a.cityid       = b.cityid (+)
  AND A.Parentbranchid = C.Branchid (+)
WITH read only;


-- view for db_cities
CREATE OR REPLACE FORCE VIEW "MEMP"."DB_CITIES" ("CITYID", "CITYNAME", "CURRENT_CITY", "DBLINK")
AS
  SELECT CITYID, CITYNAME, CURRENT_CITY, DBLINK FROM jbprod.db_cities
WITH read only ;


-- view for companies

CREATE OR REPLACE FORCE VIEW "MEMP"."COMPANIES" ("ID", "NAME", "ADDRESS", "CITY", "STATE", "PINCODE", "CONTACTPERSON", "PHONE1", "PHONE2")
AS
  SELECT companycode id,
    companyname name,
    address1
    ||' '
    ||address2
    ||' '
    ||address3 address,
    city city,
    state state,
    pin pincode,
    contactperson contactperson,
    phone1 phone1,
    Phone2 Phone2
  FROM jbprod.company_information_xref

WITH read only ;

