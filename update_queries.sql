/* when a statement is completed, the method commit is called on that statement automatically. */
SET autocommit = 0;
SELECT * from employees;

SELECT * 
FROM employees
WHERE emp_no = 999903;

UPDATE employees
SET first_name = 'Stella', gender = 'F'
WHERE emp_no = 999903;

SELECT * FROM employees WHERE emp_no = 999903;  # first_name = 'Stella';

/* if one of the queries fails then all the previous queries are reset*/
ROLLBACK;
SELECT * FROM employees WHERE emp_no = 999903; 


-- using commit 

UPDATE employees
SET first_name = 'Stella'
WHERE emp_no = 999903;

SELECT * FROM employees WHERE emp_no = 999903; 

COMMIT;

SELECT *
FROM employees
WHERE emp_no = 999903;

# Since its already commited, ROLLBACK will not have any effect
ROLLBACK;

SELECT * FROM employees WHERE emp_no = 999903; 

# Setting auto commit = 1
SET autocommit = 1;