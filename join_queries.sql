DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup(
dept_no CHAR(4),
dept_name VARCHAR(40),
PRIMARY KEY (dept_no),
UNIQUE KEY (dept_name));

SELECT * FROM departments_dup;

/* Copy every thing from table departments to departments_dup*/

INSERT INTO departments_dup 
SELECT * FROM departments; 

SELECT * FROM departments_dup;

/*Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. */
SELECT e.emp_no, e.first_name, e.last_name, de.dept_no, e.hire_date
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no;

/*Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
See if the output contains a manager with that name.  
‘emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. Order by 'dept_no' descending, and then by 'emp_no'.*/

SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
FROM employees e
LEFT JOIN dept_manager dm ON dm.emp_no = e.emp_no
WHERE e.last_name = "Markovitch"
ORDER BY dm.dept_no DESC, e.emp_no;

/*Select the first and last name, the hire date, 
and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.*/

SELECT e.first_name, e.last_name, e.hire_date, t.title
FROM employees e
LEFT JOIN titles t ON t.emp_no = e.emp_no
WHERE e.first_name = 'Margareta' AND e.last_name = 'Markovitch';


/*cross join with Department Manager and Departments to see possible combination*/
SELECT dm.emp_no, d.dept_name
FROM dept_manager dm
CROSS JOIN departments d
ORDER BY dm.emp_no, d.dept_no;


/*Select all managers’ first and last name, hire date, job title, start date, and department name.*/
SELECT e.first_name,e.last_name,e.hire_date,t.title,de.from_date, d.dept_name
FROM employees e
JOIN titles t ON t.emp_no = e.emp_no
JOIN dept_emp de ON de.emp_no = e.emp_no
JOIN departments d ON d.dept_no = de.dept_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

/*How many male and how many female managers do we have in the ‘employees’ database?*/
SELECT e.gender, COUNT(e.gender) AS total_managers
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY e.gender;

/*Average salary of employees by each department */
SELECT d.dept_name, AVG(s.salary) AS avg_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON s.emp_no = de.emp_no
GROUP BY d.dept_no
ORDER BY 2 DESC;

/* What do you think is the meaning of the minus sign before subset A in the last row (ORDER BY -a.emp_no DESC)?
- operator : tell mysql to left this out. so basically, same as without using ORDER BY*/
SELECT *
FROM
    (SELECT e.emp_no, e.first_name, e.last_name, NULL AS dept_no, NULL AS from_date
    FROM employees e
    WHERE last_name = 'Denis' 
		UNION 
	SELECT NULL AS emp_no, NULL AS first_name, NULL AS last_name, dm.dept_no, dm.from_date
    FROM dept_manager dm) AS a
ORDER BY -a.emp_no DESC;


