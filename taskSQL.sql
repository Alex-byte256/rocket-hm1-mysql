-- 1.Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.
SELECT FirstName , LastName FROM bank.client WHERE LENGTH(FirstName) < 6 limit 1000;

-- 2.Вибрати львівські відділення банку.
select * from bank.department where DepartmentCity = 'Lviv';

-- 3.Вибрати клієнтів з вищою освітою та посортувати по прізвищу.
select  * from bank.client where Education = 'high' ORDER BY LastName ASC;


-- 4.Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.
select * from bank.application order by idApplication desc limit 5;

-- 5.Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.
select * from bank.client where LastName like '%OV' or '%OVA';

-- 6.Вивести клієнтів банку, які обслуговуються київськими відділеннями.
select c.* from bank.client c join bank.department  d on c.Department_idDepartment = d.idDepartment where d.idDepartment = 1 or d.idDepartment = 4 ;


-- 7.Знайти унікальні імена клієнтів.
select DISTINCT client.FirstName from bank.client;

-- 8.Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.
select c.* from bank.client c join bank.application a on c.idClient = a.Client_idClient where a.Sum > 5000 and a.CreditState = 'Not returned';

-- 9.Порахувати кількість клієнтів усіх відділень та лише львівських відділень.
select count(client.idClient) from bank.client 
union  select count(c.idClient) from bank.client c join bank.department  d 
on c.Department_idDepartment = d.idDepartment where d.DepartmentCity = 'Lviv' ;

-- 10.Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.
select c.FirstName , c.LastName ,c.idClient , max(a.sum)  from bank.application a join bank.client c 
on  c.idClient = a.Client_idClient group by c.FirstName , c.LastName , c.idClient;

-- 11. Визначити кількість заявок на крдеит для кожного клієнта.
select max(sum) as maxCredit, min(sum) as minCredit from bank.application ;

-- 12. Визначити найбільший та найменший кредити.
select count(c.idClient) from bank.client c join bank.application a on
c.idClient = a.Client_idClient where c.Education = 'high';

-- 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.
select c.*,  avg(a.sum) as midSum from bank.application a  join bank.client c on
a.Client_idClient = c.idClient group by c.idClient order by midSum desc limit 1;

-- 14. Вивести дані про клієнта, в якого середня сума кредитів найвища.
select sum(application.sum) as sumCredit,  department.* from bank.application join bank.client on
application.Client_idClient = client.idClient join bank.department on
client.Department_idDepartment = department.idDepartment group by department.idDepartment order by sumCredit desc limit 1;

-- 15. Вивести відділення, яке видало в кредити найбільше грошей
select max(application.sum) as maxCredit ,  department.* from bank.application join bank.client on
application.Client_idClient = client.idClient join bank.department on
client.Department_idDepartment = department.idDepartment group by department.idDepartment order by maxCredit desc limit 1;

-- 16. Вивести відділення, яке видало найбільший кредит.
-- update bank.application  inner join bank.client 
-- on application.Client_idClient = client.idClient
-- set application.sum = 6000 , application.Currency = 'Gryvnia'  where client.Education = 'high';

-- 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.
-- update bank.client inner join  bank.department 
-- on client.Department_idDepartment = department.idDepartment 
-- set client.City = 'Kyiv' where  department.DepartmentCity = 'Kyiv';

-- 18. Усіх клієнтів київських відділень пересилити до Києва.
-- delete from bank.application where application.CreditState = 'Returned';

-- 19. Видалити усі кредити, які є повернені.
-- delete bank.application from bank.application inner join bank.client 
-- on application.Client_idClient = client.idClient
-- where SUBSTRING(client.LastName ,2,1) in ('a','e','i','o','u');

-- 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.
select department.* , sum(application.sum) as sumCredit from bank.department join bank.client
on department.idDepartment = client.Department_idDepartment 
join bank.application on application.Client_idClient = client.idClient
where department.DepartmentCity = 'Lviv' group by department.idDepartment having sumCredit > 5000 ;

-- 21.Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000
select client.* from bank.client join bank.application 
on client.idClient = application.Client_idClient 
where application.CreditState = 'Returned' group by client.idClient
having sum(application.sum) > 5000;

-- 22.Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000
select application.* from bank.application where application.CreditState = 'Not returned'
order by sum desc limit 1 ;

-- 23.Знайти максимальний неповернений кредит.
select client.*  from bank.client join bank.application 
on client.idClient = application.Client_idClient 
group by client.idClient order by sum(application.sum) asc limit 1; 

-- 24.Знайти клієнта, сума кредиту якого найменша
select application.* , sum(application.sum) as sumCredit from bank.client join bank.application 
on client.idClient = application.Client_idClient 
group by client.idClient having sumCredit > avg(application.sum);

-- 25.Знайти кредити, сума яких більша за середнє значення усіх кредитів
select application.* from bank.application 
group by application.idApplication having sum > 
(select avg(application.sum) from bank.application) ;

-- 26. Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів
select client.* from bank.client where client.city = (
select client.City from bank.client join
bank.application on client.idClient = application.Client_idClient
group by client.idClient order by count(application.Client_idClient) desc limit 1
);

-- 27. Місто клієнта з найбільшою кількістю кредитів
select client.City from bank.client join
bank.application on client.idClient = application.Client_idClient
group by client.idClient order by count(application.Client_idClient) desc limit 1;










