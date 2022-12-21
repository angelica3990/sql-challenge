--1. List the List the employee number, last name, first name, sex, and salary of each employee.

SELECT S.EMP_NO,
	E.LAST_NAME,
	E.FIRST_NAME,
	E.SEX,
	S.SALARY
FROM EMPLOYEES AS E
INNER JOIN SALARIES AS S ON S.EMP_NO = E.EMP_NO
ORDER BY S.EMP_NO;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT EMP_NO,
	LAST_NAME,
	FIRST_NAME,
	HIRE_DATE
FROM EMPLOYEES
WHERE EXTRACT(YEAR
														FROM HIRE_DATE) = 1986;

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT DISTINCT ON (DEPT_MANAGER.DEPT_NO) DEPT_MANAGER.DEPT_NO,
	DEPARTMENTS.DEPT_NAME,
	DEPT_MANAGER.EMP_NO,
	EMPLOYEES.LAST_NAME,
	EMPLOYEES.FIRST_NAME
FROM DEPT_MANAGER
INNER JOIN DEPARTMENTS ON DEPT_MANAGER.DEPT_NO = DEPARTMENTS.DEPT_NO
INNER JOIN EMPLOYEES ON DEPT_MANAGER.EMP_NO = EMPLOYEES.EMP_NO
ORDER BY DEPT_MANAGER.DEPT_NO DESC;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT DISTINCT ON (E.EMP_NO) E.EMP_NO,
	E.LAST_NAME,
	E.FIRST_NAME,
	D.DEPT_NAME
FROM EMPLOYEES AS E
LEFT JOIN DEPT_EMP AS DE ON E.EMP_NO = DE.EMP_NO
INNER JOIN DEPARTMENTS AS D ON DE.DEPT_NO = D.DEPT_NO
ORDER BY E.EMP_NO DESC;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT E.LAST_NAME,
	E.FIRST_NAME
FROM EMPLOYEES AS E
WHERE (E.FIRST_NAME = 'Hercules')
	AND (LOWER(E.LAST_NAME) like 'b%')
ORDER BY E.LAST_NAME;

-- Create table with most current departments for each employee to use for #6 and #7 below:

SELECT DISTINCT ON (EMP_NO) * INTO CURRENT_DEPT_EMP
FROM DEPT_EMP
ORDER BY EMP_NO DESC;

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.

SELECT E.EMP_NO,
	E.LAST_NAME,
	E.FIRST_NAME,
	D.DEPT_NAME
FROM EMPLOYEES AS E
INNER JOIN CURRENT_DEPT_EMP AS CDE ON E.EMP_NO = CDE.EMP_NO
INNER JOIN DEPARTMENTS AS D ON CDE.DEPT_NO = D.DEPT_NO
WHERE LOWER(D.DEPT_NAME) = 'sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT E.EMP_NO,
	E.LAST_NAME,
	E.FIRST_NAME,
	D.DEPT_NAME
FROM EMPLOYEES AS E
INNER JOIN CURRENT_DEPT_EMP AS CDE ON E.EMP_NO = CDE.EMP_NO
INNER JOIN DEPARTMENTS AS D ON CDE.DEPT_NO = D.DEPT_NO
WHERE (LOWER(D.DEPT_NAME) = 'sales')
	OR (LOWER(D.DEPT_NAME) = 'development');

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT LAST_NAME,
	COUNT(LAST_NAME) AS FREQUENCY
FROM EMPLOYEES
GROUP BY LAST_NAME
ORDER BY FREQUENCY DESC;
