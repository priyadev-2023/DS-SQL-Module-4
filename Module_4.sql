-- 1. What is the cost of the costliest software development in Basic?
select DCOST as cost from software where DEVELOPIN='Basic'
-- 2. Display details of Packages whose sales crossed the 2000 Mark.
select * from software where SCOST>2000
-- 3. Who are the Programmers who celebrate their Birthdays during the Current Month?
select * from programmer where month(dob)='08'
-- 4. Display the Cost of Package Developed By each Programmer.
select PNAME,sum(Dcost) as COST from software group by PNAME
-- 5. Display the sales values of the Packages Developped by each Programmer.
select PNAME,SUM(SCOST) as SALE_VAL from software group by PNAME
-- 6. Display the Number of Packages sold by Each Programmer.
select  PNAME ,SUM(SOLD) as NUM_OF_PACK from SOFTWARE group by PNAME
-- 7. Display each programmer’s name, costliest and cheapest Packages Developed by him or her.
select PNAME,max(scost),min(scost) from software group by PNAME
-- 8. Display each institute name with the number of Courses, Average Cost per Course.
select INSTITUTE,count(course) as NO_OF_COURSE,avg(COURSE_FEE) as AVG_COURSE_FEE from studies group by INSTITUTE
-- 9. Display each institute Name with Number of Students.
select count(pname) as NO_OF_STUD,INSTITUTE from studies group by INSTITUTE
-- 10. List the programmers (form the software table) and the institutes they studied.
select s.PNAME,s.INSTITUTE from studies s inner join programmer p on p.PNAME=s.PNAME
-- 11. How many packages were developed by students, who studied in institute that charge the lowest course fee?
select count(*) as no_of_packages from software s inner join studies p on p.pname=s.pname where p.COURSE_FEE=
(select min(course_fee) from studies) 
-- 12. What is the AVG salary for those whose software sales is more than 50,000/-.
select p.PNAME,avg(p.salary) from software as s inner join programmer as p on p.PNAME=s.PNAME where (SCOST*SOLD)>50000 group by p.PNAME
-- 13. Which language listed in prof1, prof2 has not been used to develop any package.
select * from software as s inner join programmer as p on p.PNAME=s.PNAME where (p.PROF1 !=s.DEVELOPIN) and (p.PROF2!=s.DEVELOPIN)
-- 14. Display the total sales value of the software, institute wise.
select st.INSTITUTE, round(sum(scost),2) as total_sales from software s right join studies st on st.PNAME=s.PNAME group by st.INSTITUTE
-- 15. Display the details of the Software Developed in C By female programmers of Pragathi.
select * from software as s inner join programmer as p on p.PNAME=s.PNAME inner join studies as st on st.PNAME=p.PNAME
where st.INSTITUTE='PRAGATHI' and p.GENDER='F' and s.DEVELOPIN='C' 
-- 16. Display the details of the packages developed in Pascal by the Female Programmers.
select * from software s inner join programmer p on p.pname=s.pname where GENDER='f' and DEVELOPIN='pascal'
-- 17. Which language has been stated as the proficiency by most of the Programmers?
SELECT x.PROF1, COUNT(*) as cnt
FROM (
    SELECT PNAME, PROF1 FROM programmer WHERE PROF1 NOT IN (SELECT DISTINCT PROF2 FROM programmer WHERE PROF2 IS NOT NULL)
    UNION
    SELECT PNAME, PROF2 FROM programmer WHERE PROF2 NOT IN (SELECT DISTINCT PROF1 FROM programmer WHERE PROF1 IS NOT NULL)
) AS x
GROUP BY x.PROF1 having count(*)>1
-- 18. Who is the Author of the Costliest Package?
SELECT * FROM SOFTWARE WHERE DCOST =( select MAX(DCOST) from software) 
-- 19. Which package has the Highest Development cost?
select max(dcost) from software
-- 20. Who is the Highest Paid Female COBOL Programmer?
select pname from programmer where gender='f' and prof1='cobol' or gender='f' and prof2='cobol'
-- 21. Display the Name of Programmers and Their Packages.
select pname ,developin from software 
-- 22. Display the Number of Packages in Each Language Except C and C++.
select count(developin) from software where DEVELOPIN!='C' and DEVELOPIN!='C++'
-- 23. Display AVG Difference between SCOST, DCOST for Each Package
select (DCOST-SCOST) as cost ,AVG(DCOST-SCOST)-(dcost-scost)  from software 
-- 24. Display the total SCOST, DCOST and amount to Be Recovered for each Programmer for Those Whose Cost has not yet been Recovered.
select scost,dcost,(dcost-scost) as recov from software
-- 25. Who is the Highest Paid C Programmers?
select max(salary) as Highest_sal  from programmer where PROF1='c'  or prof2='c' 
-- 26. Who is the Highest Paid Female COBOL Programmer?
select * from programmer where GENDER='f' and PROF1='cobol' or prof2='cobol' and GENDER='f'