-- Creating tables for PH-EmployeeDB
--DROP TABLE cities;
-- DROP TABLE dept;
--DROP TABLE people;
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees(
	emp_no INT NOT NULL,
    birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);


CREATE TABLE dept_manager (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE titles ( 
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)

); 

CREATE TABLE dept ( 
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL, 
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY(emp_no, dept_no)
);

SELECT *FROM titles

SELECT *FROM employees
SELECT *from departments



-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');



SELECT emp_no,first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT * FROM retirement_info;

-- Joining retirement_info and dept_emp tables
SELECT  ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
	
FROM retirement_info as ri
LEFT JOIN dept as de
ON ri.emp_no = de.emp_no;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri 
LEFT JOIN dept as de 
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT COUNT(ce.emp_no),de.dept_no
INTO dep_emp
FROM current_emp as ce 
LEFT JOIN dept as de 
ON ce.emp_no = de.emp_no 
GROUP BY de.dept_no
ORDER BY de.dept_no; 

SELECT * FROM employees;
DROP TABLE table_1;

SELECT *
INTO table_3
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');


SELECT emp_no,first_name,last_name
INTO table_1
FROM table_3;


SELECT emp_no, title,from_date,to_date
INTO table_2
FROM titles;

DROP TABLE combined
SELECT table_1.emp_no,table_1.first_name,table_1.last_name,table_2.title,table_2.from_date,table_2.to_date
INTO combined 
FROM table_1
FULL OUTER JOIN table_2 ON table_1.emp_no=table_2.emp_no;


SELECT *
FROM combined
SELECT*
FROM employees

SELECT emp_no 
FROM employees
WHERE employees.birth_date BETWEEN 01-01-1952 AND 12-31-1955;

SELECT *
INTO retirement_titles
FROM combined
WHERE emp_no IS NOT NULL
ORDER BY emp_no;


ALTER TABLE combined
ADD PRIMARY KEY (emp_no);

SELECT * FROM retirement_titles;

SELECT DISTINCT ON(emp_no) emp_no, first_name,last_name,title
INTO Unique_Titles
FROM retirement_titles
WHERE retirement_titles.to_date=('9999-01-01')
ORDER BY emp_no ASC, retirement_titles.to_date DESC;



SELECT COUNT(DISTINCT unique_titles.title) FROM unique_titles;




SELECT DISTINCT unique_titles.title, COUNT(unique_titles.title)
INTO Retiring_Titles
FROM unique_titles
GROUP BY title 
ORDER BY count DESC;


	
select * 
from dept;

SELECT DISTINCT ON(employees.emp_no) employees.emp_no, 
employees.first_name, employees.last_name,
employees.birth_date, dept.from_date,dept.to_date,titles.title
FROM employees, dept,titles
LEFT JOIN dept
ON employees.emp_no=dept.emp_no;


-- join first table 
SELECT DISTINCT ON(employees.emp_no) employees.emp_no, 
employees.first_name, employees.last_name,
employees.birth_date, dept.from_date, dept.to_date
INTO table_one
FROM employees
LEFT JOIN dept
ON employees.emp_no=dept.emp_no;
-- join second table 

SELECT * FROM titles;
SELECT DISTINCT ON(table_one.emp_no) table_one.emp_no, 
table_one.first_name, table_one.last_name,
table_one.birth_date, table_one.from_date, table_one.to_date, titles.title
INTO table_two
FROM table_one
LEFT JOIN titles
ON table_one.emp_no=titles.emp_no;
-- view the table 




SELECT * 
INTO table_mentor
FROM table_two
WHERE (table_two.to_date=('9999-01-01') AND (table_two.birth_date BETWEEN ('01-01-1965') AND ('12-31-1965')))
ORDER BY table_two.emp_no;

SELECT COUNT(table_mentor.emp_no), title
FROM table_mentor GROUP BY table_mentor.title ORDER BY COUNT(table_mentor.emp_no) DESC;




