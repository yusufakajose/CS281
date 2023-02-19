/*
Retrieve project name, first and last name employees who work for a project more than 20
hours a week. 
*/
select p.pname, e.fname, e.lname
from works_on w, project p, employee e
where w.hours > 20
and w.pno=p.pnumber and w.essn=e.ssn
/*
Retrieve first and last name employees for female employees and their dependents name,
sex and relationship to the employee. 
*/
select e.fname,e.lname, d.dependent_name, d.sex, d.relationship
from dependent d, employee e
where e.sex='F' and d.essn=e.ssn
/* 
For every department located in ‘Houston’ list the department name and the department
manager's last name, address and birthdate.
*/
select d.dname, e.fname,e.lname, e.address, e.bdate
from dept_locations dl, department d, employee e
where dl.dlocation='Houston' and dl.dnumber=d.dnumber and d.mgrssn=e.ssn
/* 
List the department numbers which are located in more than one location.
*/
select dnumber
from dept_locations
group by dnumber
having count(*) > 1
/* 
Find the minimum, maximum and average salary for each department.
*/
select dno, min(salary), max(salary), avg(salary)
from employee
group by dno
/*
Find average salary for female and male employees in each department  
*/
select dno, sex, avg(salary)
from employee
group by dno, sex
/* 
Find the name and birthdate of the oldest employee.
*/
select fname, lname, bdate from employee where bdate=
(select min(bdate) from employee)
/* 
Find the name and birthdate of the employees who were born in this month
*/
select fname,lname,bdate
from employee
where substr(bdate,6,2) = substr(date(),6,2)
/*  
Find the employee name and department name of all employees
*/ 
select e.fname, e.lname, d.dname
from employee e, department d
where e.dno=d.dnumber
/*
Find employee name, department name of employees who work for project
“Reorganization”.  
*/
select e.fname, e.lname, d.dname
from project p, works_on w, employee e, department d
where p.pname='Reorganization'
and p.pnumber=w.pno and w.essn=e.ssn
and e.dno=d.dnumber
/* 
Find names of employees who has a son.
*/
select e.fname, e.lname
from employee e, dependent d
where e.ssn=d.essn and d.relationship='Son'
/* 
Find average salary of departments which has at least 2 employees
*/
select dno, avg(salary)
from employee
group by dno
having count(*) > 1
/* 
Find the number of male and female employees in each department and sum of their
salaries.
*/
select dno, sex, count(*) , sum(salary)
from employee
group by dno, sex
/* 
Find employees who does not have a immediate supervisor
*/
select fname,lname from employee where superssn is null
/* 
Find names of employees who do not have a dependent
*/
select fname, lname
from employee
where ssn not in
(select essn from dependent)
/* 
Find the total number of hours worked for each employee.
*/
select essn, sum(hours)
from works_on w
group by essn
/* 
Find employees who doesn’t live in Houston
*/
select fname, lname, address
from employee
where address not like '%Houston%'
