-- ------------------------------------
-- SQL ZOO: DDL Student Records
-- ------------------------------------
DROP TABLE IF EXISTS public.student
DROP TABLE IF EXISTS public.module

-- -------------------------------
-- CREATE student
-- -------------------------------
CREATE TABLE public.student (
  matric_no CHAR(10) PRIMARY KEY,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30)NOT NULL,
  date_of_birth DATE 
);

INSERT INTO public.student
VALUES ('40001010','Daniel','Radcliffe','1989-07-23'),
		('40001011','Emma','Watson','1990-04-15'),
		('40001012','Rupert','Grint','1988-10-24');

SELECT *
FROM public.student;

-- -------------------------------
-- CREATE module
-- -------------------------------
CREATE TABLE public.module(
  module_code CHAR(8) PRIMARY KEY,
  module_title VARCHAR(50) NOT NULL,
  level INT NOT NULL,
  credits INT NOT NULL DEFAULT 20
);

INSERT INTO public.module(module_code,module_title,level)
VALUES ('HUF07101','Herbology',7),
        ('SLY07102','Defense Against the Dark Arts',7),
		('HUF08102','History of Magic',8);
		
SELECT *
FROM public.module;

-- -------------------------------
-- CREATE registration
-- -------------------------------
CREATE TABLE public.registration(
   matric_no CHAR(10), 
   module_code CHAR(8), 
   result DECIMAL(4,1),
   PRIMARY KEY(matric_no,module_code),
   FOREIGN KEY(matric_no) REFERENCES public.student(matric_no),
   FOREIGN KEY(module_code) REFERENCES public.module(module_code)
);

INSERT INTO public.registration VALUES ('40001010','SLY07102',90);
INSERT INTO public.registration VALUES ('40001010','HUF07101',40);
INSERT INTO public.registration VALUES ('40001010','HUF08102',null);

INSERT INTO public.registration VALUES ('40001011','SLY07102',99);
INSERT INTO public.registration VALUES ('40001011','HUF08102',null);

INSERT INTO public.registration VALUES ('40001012','SLY07102',20);
INSERT INTO public.registration VALUES ('40001012','HUF07101',20);

SELECT *
FROM registration;

-- -------------------------------------------------------------------------
-- Produce the results for SLY07102. 
-- For each student show the surname, firstname, result and 'F' 'P' or 'M'
-- F for a mark of 39 or less
-- P for a mark between 40 and 69
-- M for a mark of 70 or more
-- -------------------------------------------------------------------------
SELECT first_name,last_name,result,
CASE 
  WHEN result<=39 THEN 'F'
  WHEN result>70 THEN 'M'
  ELSE 'P'
 END AS rank
FROM student s JOIN registration r ON s.matric_no=r.matric_no
WHERE module_code='SLY07102';


