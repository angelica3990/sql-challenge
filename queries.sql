{\rtf1\ansi\ansicpg1252\deff0\nouicompat\deflang1033{\fonttbl{\f0\fnil\fcharset0 Calibri;}}
{\*\generator Riched20 10.0.19041}\viewkind4\uc1 
\pard\sa200\sl276\slmult1\f0\fs22\lang9 --1. List the List the employee number, last name, first name, sex, and salary of each employee.\par
\par
SELECT S.EMP_NO,\par
\tab E.LAST_NAME,\par
\tab E.FIRST_NAME,\par
\tab E.SEX,\par
\tab S.SALARY\par
FROM EMPLOYEES AS E\par
INNER JOIN SALARIES AS S ON S.EMP_NO = E.EMP_NO\par
ORDER BY S.EMP_NO;\par
\par
-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.\par
\par
SELECT EMP_NO,\par
\tab LAST_NAME,\par
\tab FIRST_NAME,\par
\tab HIRE_DATE\par
FROM EMPLOYEES\par
WHERE EXTRACT(YEAR\par
\tab\tab\tab\tab\tab\tab\tab\tab\tab\tab\tab\tab\tab\tab FROM HIRE_DATE) = 1986;\par
\par
-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.\par
\par
SELECT DISTINCT ON (DEPT_MANAGER.DEPT_NO) DEPT_MANAGER.DEPT_NO,\par
\tab DEPARTMENTS.DEPT_NAME,\par
\tab DEPT_MANAGER.EMP_NO,\par
\tab EMPLOYEES.LAST_NAME,\par
\tab EMPLOYEES.FIRST_NAME\par
FROM DEPT_MANAGER\par
INNER JOIN DEPARTMENTS ON DEPT_MANAGER.DEPT_NO = DEPARTMENTS.DEPT_NO\par
INNER JOIN EMPLOYEES ON DEPT_MANAGER.EMP_NO = EMPLOYEES.EMP_NO\par
ORDER BY DEPT_MANAGER.DEPT_NO DESC;\par
\par
-- 4. List the department number for each employee along with that employee\rquote s employee number, last name, first name, and department name.\par
\par
SELECT DISTINCT ON (E.EMP_NO) E.EMP_NO,\par
\tab E.LAST_NAME,\par
\tab E.FIRST_NAME,\par
\tab D.DEPT_NAME\par
FROM EMPLOYEES AS E\par
LEFT JOIN DEPT_EMP AS DE ON E.EMP_NO = DE.EMP_NO\par
INNER JOIN DEPARTMENTS AS D ON DE.DEPT_NO = D.DEPT_NO\par
ORDER BY E.EMP_NO DESC;\par
\par
-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.\par
\par
SELECT E.LAST_NAME,\par
\tab E.FIRST_NAME\par
FROM EMPLOYEES AS E\par
WHERE (E.FIRST_NAME = 'Hercules')\par
\tab AND (LOWER(E.LAST_NAME) like 'b%')\par
ORDER BY E.LAST_NAME;\par
\par
-- Create table with most current departments for each employee to use for #6 and #7 below:\par
\par
SELECT DISTINCT ON (EMP_NO) * INTO CURRENT_DEPT_EMP\par
FROM DEPT_EMP\par
ORDER BY EMP_NO DESC;\par
\par
-- 6. List each employee in the Sales department, including their employee number, last name, and first name.\par
\par
SELECT E.EMP_NO,\par
\tab E.LAST_NAME,\par
\tab E.FIRST_NAME,\par
\tab D.DEPT_NAME\par
FROM EMPLOYEES AS E\par
INNER JOIN CURRENT_DEPT_EMP AS CDE ON E.EMP_NO = CDE.EMP_NO\par
INNER JOIN DEPARTMENTS AS D ON CDE.DEPT_NO = D.DEPT_NO\par
WHERE LOWER(D.DEPT_NAME) = 'sales';\par
\par
-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.\par
\par
SELECT E.EMP_NO,\par
\tab E.LAST_NAME,\par
\tab E.FIRST_NAME,\par
\tab D.DEPT_NAME\par
FROM EMPLOYEES AS E\par
INNER JOIN CURRENT_DEPT_EMP AS CDE ON E.EMP_NO = CDE.EMP_NO\par
INNER JOIN DEPARTMENTS AS D ON CDE.DEPT_NO = D.DEPT_NO\par
WHERE (LOWER(D.DEPT_NAME) = 'sales')\par
\tab OR (LOWER(D.DEPT_NAME) = 'development');\par
\par
-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).\par
\par
SELECT LAST_NAME,\par
\tab COUNT(LAST_NAME) AS FREQUENCY\par
FROM EMPLOYEES\par
GROUP BY LAST_NAME\par
ORDER BY FREQUENCY DESC;\par
}
 