-- Retrieve emp_no, first_name, and last_name column from the Employees table
-- Retrieve the titile, from_date and to_date column from the Titles table
-- Create a new table using the INTO clause.
-- Join both tables on the primary key.
-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
SELECT employees.emp_no, employees.first_name, employees.last_name,
titles.title, titles.from_date, titles.to_date
INTO retiring_employees6
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
order by employees.emp_no


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) retiring_employees6.emp_no,
first_name,
last_name,
title

INTO No_duplicates1
FROM retiring_employees6
WHERE to_date = '9999-01-01'
ORDER BY emp_no, from_date DESC;

SELECT 
COUNT(emp_no),
title
INTO Retiring_Titles
FROM No_duplicates1
GROUP BY title
ORDER BY COUNT(emp_no) DESC


--Create new table for eligible_titles
SELECT employees.emp_no,
     employees.first_name,
     employees.last_name,
	 employees.birth_date, 
	 titles.title,
	 titles.from_date,
	 titles.to_date
INTO eligible_titles
FROM employees 
INNER JOIN titles
ON employees.emp_no = titles.emp_no
ORDER BY employees.emp_no;
		
SELECT * FROM eligible_titles
DROP TABLE eligible_titles;
	
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
birth_date,
title, 
from_date
to_date
INTO eligible_employees
FROM eligible_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, title DESC;

SELECT * FROM eligible_employees;
DROP TABLE eligible_employees;
	
--Create new table for membership eligibility
SELECT DISTINCT ON (eligible_employees.emp_no) eligible_employees.emp_no, 
	eligible_employees.first_name, 
	eligible_employees.last_name,
	eligible_employees.birth_date,
	eligible_titles.title,
	eligible_titles.from_date,
	eligible_titles.to_date
INTO membership_eligibility
FROM eligible_employees
INNER JOIN eligible_titles
ON eligible_employees.emp_no = eligible_titles.emp_no
WHERE eligible_employees.birth_date BETWEEN ('1965-01-01') AND ('1965-12-31')
--ORDER BY eligible_titles.emp_no ASC, eligible_employees.birth_date DESC; 

SELECT * FROM membership_eligibility;
DROP TABLE membership_eligibility;
