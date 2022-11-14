SELECT FirstName , LastName FROM bank.client WHERE LENGTH(FirstName) < 6 limit 1000;

select * from bank.department where DepartmentCity = 'Lviv';

select  * from bank.client where Education = 'high' ORDER BY LastName ASC;

select * from bank.application order by idApplication desc limit 5;

select * from bank.client where LastName like '%OV' or '%OVA';

select c.* from bank.client c join bank.department  d on c.Department_idDepartment = d.idDepartment where d.idDepartment = 1 or d.idDepartment = 4 ;

select DISTINCT client.FirstName from bank.client;

select c.* from bank.client c join bank.application a on c.idClient = a.Client_idClient where a.Sum > 5000 and a.CreditState = 'Not returned';

select count(client.idClient) from bank.client 
union  select count(c.idClient) from bank.client c join bank.department  d 
on c.Department_idDepartment = d.idDepartment where c.City = 'Lviv' ;

select c.FirstName , c.LastName ,c.idClient , max(a.sum)  from bank.application a join bank.client c 
on  c.idClient = a.Client_idClient group by c.FirstName , c.LastName , c.idClient;

select max(sum) as maxCredit, min(sum) as minCredit from bank.application ;

select count(c.idClient) from bank.client c join bank.application a on
c.idClient = a.Client_idClient where c.Education = 'high';

select c.*,  avg(a.sum) as midSum from bank.application a  join bank.client c on
a.Client_idClient = c.idClient group by c.idClient order by midSum desc limit 1;

select sum(application.sum) as sumCredit,  department.* from bank.application join bank.client on
application.Client_idClient = client.idClient join bank.department on
client.Department_idDepartment = department.idDepartment group by department.idDepartment order by sumCredit desc limit 1;

select max(application.sum) as maxCredit ,  department.* from bank.application join bank.client on
application.Client_idClient = client.idClient join bank.department on
client.Department_idDepartment = department.idDepartment group by department.idDepartment order by maxCredit desc limit 1;

-- update bank.application  inner join bank.client 
-- on application.Client_idClient = client.idClient
-- set application.sum = 6000 , application.Currency = 'Gryvnia'  where client.Education = 'high';

-- update bank.client inner join  bank.department 
-- on client.Department_idDepartment = department.idDepartment 
-- set client.City = 'Kyiv' where  department.DepartmentCity = 'Kyiv';

-- delete from bank.application where application.CreditState = 'Returned';

-- delete bank.application from bank.application inner join bank.client 
-- on application.Client_idClient = client.idClient
-- where SUBSTRING(client.LastName ,2,1) in ('a','e','i','o','u');

select department.* , sum(application.sum) as sumCredit from bank.department join bank.client
on department.idDepartment = client.Department_idDepartment 
join bank.application on application.Client_idClient = client.idClient
where department.DepartmentCity = 'Lviv' group by department.idDepartment having sumCredit > 5000 ;

select client.* from bank.client join bank.application 
on client.idClient = application.Client_idClient 
where application.CreditState = 'Returned' group by client.idClient
having sum(application.sum) > 5000;

select application.* from bank.application where application.CreditState = 'Not returned'
order by sum desc limit 1 ;

select client.*  from bank.client join bank.application 
on client.idClient = application.Client_idClient 
group by client.idClient order by sum(application.sum) asc limit 1; 


select application.* , sum(application.sum) as sumCredit from bank.client join bank.application 
on client.idClient = application.Client_idClient 
group by client.idClient having sumCredit > avg(application.sum);

select application.* from bank.application 
group by application.idApplication having sum > 
(select avg(application.sum) from bank.application) ;


select client.* from bank.client where client.city = (
select client.City from bank.client join
bank.application on client.idClient = application.Client_idClient
group by client.idClient order by count(application.Client_idClient) desc limit 1
);

select client.City from bank.client join
bank.application on client.idClient = application.Client_idClient
group by client.idClient order by count(application.Client_idClient) desc limit 1;










