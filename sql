3a. Retrieve the name and address of all employees who work for the ‘Research’ department. 
select Fname, Minit, Lname, Address  
from EMPLOYEE e, DEPARTMENT d where 
e.Dno=d.Dnumber 
and 
d.Dname="Research"; 
+----------+-------+---------+-------------------------+ 
| Fname    | Minit | Lname   | Address                 | 
+----------+-------+---------+-------------------------+ 
| John     | B     | Smith   | 731 Houston,TX          | 
| Franklin | T     | Wong    | 638 Voss, Houston TX    | 
| Joyce    | A     | English | 5631 Rice, Houston TX   | 
| Ramesh   | K     | Narayan | 975 Fire Oak, Humble TX | 
+----------+-------+---------+-------------------------+ 



3b. For every project located in ‘Stafford’, list the project number, the controlling department 
number, and the department manager’s last name, address, and birth date. 
select e.Lname, e.Bdate, e.Address, p.pnumber, p.dnum 
from EMPLOYEE e, PROJECT p, DEPARTMENT d  
where p.plocation="Stafford" and p.dnum=d.Dnumber 
and d.Mgr_ssn=e.Ssn; 
+---------+------------+------------------------+---------+------+ 
| Lname   | Bdate      | Address                | pnumber | dnum | 
+---------+------------+------------------------+---------+------+ 
| Wallace | 1941-06-20 | 291 Berry, Bellaire TX |      10 |    4 | 
| Wallace | 1941-06-20 | 291 Berry, Bellaire TX |      30 |    4 | 
+---------+------------+------------------------+---------+------+ 

3c. For each employee, retrieve the employee’s first and last name and the first and last name   
of   his or her immediate supervisor. 
select e1.Fname, e1.Lname, e2.Fname as manager_Fname, e2.Lname as      
manager_Lname 
from EMPLOYEE as e1, EMPLOYEE as e2  
where e2.Ssn=e1.Super_ssn; 
+----------+---------+---------------+---------------+ 
| Fname    | Lname   | manager_Fname | manager_Lname | 
+----------+---------+---------------+---------------+ 
| Franklin | Wong    | James         | Borg          | 
| Joyce    | English | Franklin      | Wong          | 
| Ramesh   | Narayan | Franklin      | Wong          | 
| Jennifer | Wallace | James         | Borg          | 
| Ahmad    | Jabbar  | Jennifer      | Wallace       | 
| Alicia   | Zelaya  | Jennifer      | Wallace       | 
+----------+---------+---------------+---------------+ 
6 rows in set (0.00 sec) 

3d. Make a list of all project numbers for projects that involve an employee whose last name is    
‘Smith’, either as a worker or as a manager of the department that controls the project. 
(select distinct pnumber 
From PROJECT,DEPARTMENT,EMPLOYEE 
where Dnum=Dnumber AND Mgr_ssn=Ssn AND Lname="Smith") 
UNION 
(Select distinct pnumber 
From PROJECT,WORKS_ON,EMPLOYEE 
where pnumber=Pno AND Essn=Ssn AND Lname="Smith"); 
+---------+ 
| pnumber | 
+---------+ 
|       1 | 
|       2 | 
+---------+ 
2 rows in set (0.00 sec) 

3e. Retrieve all employees whose address is in Houston, Texas. 
select Fname, Minit, Lname  
from EMPLOYEE  
where Address like "%Houston%TX%";    
+----------+-------+---------+ 
| Fname    | Minit | Lname   | 
+----------+-------+---------+ 
| John     | B     | Smith   | 
| Franklin | T     | Wong    | 
| Joyce    | A     | English | 
| James    | E     | Borg    | 
| Ahmad    | V     | Jabbar  | 
+----------+-------+---------+ 
5 rows in set (0.00 sec) 

3f. Retrieve all employees in department 5 whose salary is between $30,000 and $40,000. 
select * 
from EMPLOYEE e, DEPARTMENT d  
where e.Dno=d.Dnumber and d.Dnumber=5 
and e.Salary between 30000 and 40000; 
+----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+----------+---------+-----------+----------------+ 
| Fname    | Minit | Lname   | Ssn       | Bdate      | Address                 
| Sex  | Salary | Super_ssn | Dno | Dname    | Dnumber | Mgr_ssn   | 
Mgr_start_date | 
+----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+----------+---------+-----------+----------------+ 
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Houston,TX          
| M    |  30000 |           |   5 | Research |       5 | 333445555 | 
1988-05-22     | 
| Franklin | T     | Wong    | 333445555 | 1965-12-08 | 638 Voss, 
Houston TX    | M    |  40000 | 888665555 |   5 | Research |       5 | 
333445555 | 1988-05-22     | 
| Ramesh   | K     | Narayan | 666884444 | 1962-09-15 | 975 Fire Oak, 
Humble TX | M    |  38000 | 333445555 |   5 | Research |       5 | 
333445555 | 1988-05-22     | 
+----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+----------+---------+-----------+----------------+ 

4a. Retrieve the names of all employees who do not have supervisors. 
select Fname, Minit, Lname  
from EMPLOYEE e  
where  
not exists(select * from EMPLOYEE as s where e.Super_ssn=s.Ssn); 
+-------+-------+-------+ 
| Fname | Minit | Lname | 
+-------+-------+-------+ 
| John  | B     | Smith | 
| James | E     | Borg  | 
+-------+-------+-------+ 
2 rows in set (0.00 sec) 

4b. Retrieve the name of each employee who has a dependent with the same first name and is  
the same gender as the employee 
select Fname, Minit, Lname  
from EMPLOYEE e, DEPENDENT d where 
e.Fname=d.Dependent_name 
and  
e.Sex=d.Sex; 
+-------+-------+-------+ 
| Fname | Minit | Lname | 
+-------+-------+-------+ 
| John  | B     | Smith | 
+-------+-------+-------+ 
1 row in set (0.00 sec) 

4c. Retrieve the names of employees who have no dependents. 
select Fname, Minit, Lname  
from EMPLOYEE where  
not exists(select * from DEPENDENT where Ssn=Essn); 
+--------+-------+---------+ 
| Fname  | Minit | Lname   | 
+--------+-------+---------+ 
| Joyce  | A     | English | 
| Ramesh | K     | Narayan | 
| James  | E     | Borg    | 
| Ahmad  | V     | Jabbar  | 
| Alicia | J     | Zelaya  | 
+--------+-------+---------+ 
5 rows in set (0.00 sec) 

4d. List the names of managers who have at least one dependent. 
select Fname, Minit, Lname  
from EMPLOYEE where  
exists(select * from DEPARTMENT where Ssn=Mgr_ssn and Dno=Dnumber) 
and 
exists(select * from DEPENDENT where Ssn=Essn); 
+----------+-------+---------+ 
| Fname    | Minit | Lname   | 
+----------+-------+---------+ 
| Franklin | T     | Wong    | 
| Jennifer | S     | Wallace | 
+----------+-------+---------+ 
2 rows in set (0.00 sec) 

4e. Retrieve the Social Security numbers of all employees who work on project numbers 1, 2,   
or 3. 
select distinct Essn from WORKS_ON where Pno in (1,2,3); 
+-----------+ 
| Essn      | 
+-----------+ 
| 123456789 | 
| 453453453 | 
| 333445555 | 
| 666884444 | 
+-----------+ 
4 rows in set (0.00 sec) 
4f. Find the sum of the salaries of all employees of the ‘Research’ department, as well as the  
maximum salary, the minimum salary, and the average salary in this department. 
select sum(Salary), max(Salary), min(Salary), avg(salary) 
from EMPLOYEE, DEPARTMENT  
where Dno=Dnumber and Dname="Research"; 
+-------------+-------------+-------------+-------------+ 
| sum(Salary) | max(Salary) | min(Salary) | avg(salary) | 
+-------------+-------------+-------------+-------------+ 
|      133000 |       40000 |       25000 |  33250.0000 | 
+-------------+-------------+-------------+-------------+ 
1 row in set (0.00 sec) 

4g. For each department, retrieve the department number, the number of employees in the  
department, and their average salary. 
select Dno, count(*), avg(Salary) 
from EMPLOYEE  
group by Dno; 
