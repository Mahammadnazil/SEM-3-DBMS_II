----Semester 3 DBMS-II all Practical----

--Lab_1--

--Practical-1.1--
create database Bank_System_157

--Practical- 2.1--

create table Bank_Master
(
	Bank_ID int Primary key,
	Bank_Name varchar(40),
	Bank_ShortName varchar(10)
);
exec sp_help Bank_Master

create table Branch_Master
(
	Branch_Id int Primary key,
	Branch_Name varchar(30),
	Branch_IFSC varchar(11) UNIQUE,
	Bank_Id int
	constraint FK_Bank_ID FOREIGN KEY (Bank_ID)
	REFERENCES Bank_Master(Bank_ID)
	on delete cascade on update cascade
);
exec sp_help Branch_Master

create table Employee_Master
(
	Emp_No int Primary key,
	Branch_IFSC varchar(11),
	Emp_FullName varchar(30),
	Emp_Designation varchar(25),
	Emp_Manager_No bigint,
	Emp_Salary float
	constraint FK_Bank_ID1 FOREIGN KEY (Branch_IFSC)
	REFERENCES Branch_Master(Branch_IFSC)
	on delete cascade on update cascade
);
exec sp_help Employee_Master

create table Customer_Master
(
	Cust_Id int Primary key,
	Cust_FullName varchar(30),
	Cust_DOB date,
	Cust_Address varchar(80),
	Cust_MobileNo bigint,
	Cust_EmailID varchar(30),
	Cust_City varchar(20)
);
exec sp_help Customer_Master

create table Account_Master
(
	Acc_No bigint Primary key,
	Cust_Id int,
	Acc_Type varchar(7),
	Branch_IFSC varchar(11)
	constraint FK_Bank_ID2 FOREIGN KEY (Cust_Id)
	REFERENCES Customer_Master(Cust_Id)
	on delete cascade on update cascade,
	constraint check_abc check (Acc_Type in('SB','CR')),
	constraint FK_Bank_ID3 FOREIGN KEY (Branch_IFSC)
	REFERENCES Branch_Master(Branch_IFSC)
	on delete cascade on update cascade,
);
exec sp_help Account_Master

create table Transaction_Master
(
	Tran_Id int Primary key,
	Tran_Acc_No bigint,
	Tran_Date datetime,
	Tran_Type varchar(7),
	Tran_Amount_Debit_Credit varchar(6),
	Tran_Amount FLOAT
	constraint FK_Bank_ID4 FOREIGN KEY (Tran_Acc_No)
	REFERENCES Account_Master(Acc_No)
	on delete cascade on update cascade,
	constraint check_abc1 check (Tran_Type in('CH','CQ','OL','RG')),
	constraint check_abc2 check (Tran_Amount_Debit_Credit in('D','c')),
);
drop table Transaction_Master
exec sp_help Transaction_Master

--data entry--
--3.1--
insert into Bank_Master(Bank_Id ,Bank_Name,Bank_ShortName)
values (101 , 'State Bank of India ','SBI')

insert into Bank_Master(Bank_Id ,Bank_Name,Bank_ShortName)
values (102 , 'Bank of India','BOI')

insert into Bank_Master(Bank_Id ,Bank_Name,Bank_ShortName)
values (103 , 'Bank of Baroda','BOB')

insert into Bank_Master(Bank_Id ,Bank_Name,Bank_ShortName)
values (104 , 'Punjab National Bank','PNB')

insert into Bank_Master(Bank_Id ,Bank_Name,Bank_ShortName)
values (105 , 'Central Bank of India','CBI')

select * from Bank_Master

--3.2--
insert into Branch_Master(Branch_Id ,Branch_Name,Branch_IFSC,Bank_Id)
  values(201,'Green Chowk, Morbi','SBI101MB201',101),
		(202,'Lati Plot, Morbi','CBI105MB202',105),
		(203,'Ravapar Road, Morbi','BOI102MB203 ',102),
		(204,'Kalawad Road, Rajkot','PNB104RJ204',104),
		(205,'Nanavati Chowk, Rajkot','BOB103RJ205 ',103),
		(206,'Lal Darwaja, Ahemdabad ','BOB103AM206',103),
		(207,'Zanjar Cinema Road,Wankaner','PNB104WK207',104),
		(208,'AksharDham Road,Ahemdabad','CBI105AM208',105),
		(209,'Maharana Pratap Circle,Morbi','PNB104MB209',104),
		(210,'Race Course Ring Road,Rajkot','SBI101RJ210 ',101)
	
select * from Branch_Master
--3.3--
insert into Employee_Master(Emp_No ,Branch_IFSC,Emp_FullName,Emp_Designation,Emp_Manager_No,Emp_Salary)
values	(301,'SBI101MB201','Shashikant Das','Bank Manager',9876543210, 250000),
		(302,'BOI102MB203','Dinesh Khara','Bank Manager',8765432109 ,45000),
		(303,'BOB103AM206','Nirav Modi','Loan Officer',7654321098,36500),
		(304,'CBI105AM208','Lalit Modi','Lalit Modi',6543210987,70000),
		(305,'PNB104MB209','P.V. Sindhu','Credit Analyst ',5432109876,65300),
		(306,'SBI101RJ210','Shikha Sharma','Credit Analyst',4321098765,56700),
		(307,'CBI105AM208','Archana Bhargav','Audit Officer',3210987654,60000),
		(308,'BOB103AM206','Arundhati Bhatt ','Audit Officer',2109876543,55000),
		(309,'SBI101RJ210','kalpana Moria','Finance Manager',1098765432,62500),
		(310,'CBI105AM208','Atul Goe','Finance Manager',9876543201,54000)

select * from Employee_Master
--3.4--
insert into Customer_Master(Cust_Id,Cust_FullName,Cust_DOB,Cust_Address,Cust_MobileNo,Cust_EmailID,Cust_City)

values	(401, 'C N Kanani', '1985-08-20', 'Milap Nagar, University Road', 2134567890, 'cnk@gmail.com', 'Gandhinagar'),
		(402, 'A N Siddhpura', '1987-10-15', 'Royal Park, Ravapar road', 1243567890, 'ans@gmail.com', 'Ahemdabad'),
		(403, 'V K Makwana', '1987-07-04', '150 Feet Ring Road', 1234567890, 'vkm@gmail.com', 'Ahemdabad'),
		(404, 'H K Vyas', '1990-12-10', 'Madhapar Circle', 1234567809, 'hkv@gmail.com', 'Rajkot'),
		(405, 'K B Bhalodia', '1996-03-25', 'Nanavati Chowk', 1234568790, 'kbb@gmail.com', 'Rajkot'),
		(406, 'N H Patel', '1990-06-13', 'Ayodhya Chwok', 1234567980, 'nhp@gmail.com', 'Baroda'),
		(407, 'T D Solanki', '1996-10-25', 'Bhaktinagar Circle', 9314567820, 'tds@gmail.com', 'Baroda'),
		(408, 'N H Ahuja', '1994-09-15', 'Seth Nagar Road', 1234567089, 'nha@gmail.com', 'Jamnagar'),
		(409, 'B K Chattrala', '1995-07-02', 'Trikon Baug', 1234568710, 'bkc@gmail.com', 'Jamnagar'),
		(410, 'A B Pandya', '2000-08-20', 'Sanala Road', 1432567890, 'abp@gmail.com', 'Morbi');

select * from Customer_Master
--3.5--
INSERT INTO Account_Master (Acc_No, Cust_Id, Acc_Type, Branch_IFSC)
 VALUES (501, 401, 'SB', 'CBI105AM208'),
		(502, 402, 'SB', 'CBI105AM208'),
		(503, 403, 'SB', 'BOB103AM206'),
		(504, 404, 'CR', 'BOB103RJ205'),
		(505, 405, 'SB', 'SBI101RJ210'),
		(506, 406, 'CR', 'BOB103AM206'),
		(507, 407, 'CR', 'BOB103AM206'),
		(508, 408, 'SB', 'PNB104RJ204'),
		(509, 409, 'CR', 'SBI101RJ210'),
		(510, 410, 'SB', 'SBI101MB201');
select * from Account_Master
--3.6--
INSERT INTO Transaction_Master (Tran_Id, Tran_Acc_No, Tran_Date, Tran_Type,Tran_Amount_Debit_Credit, Tran_Amount)
 VALUES (601, 501, '2022-11-22 00:00:00:000', 'CH', 'C', 500000),
		(602, 503, '2018-10-15 00:00:00:000', 'CQ', 'D', 25020),
		(603, 506, '2017-12-01 00:00:00:000', 'OL', 'C', 200000),
		(604, 510, '2021-03-03 00:00:00:000', 'RG', 'D', 25000),
		(605, 504, '2021-11-10 00:00:00:000', 'CH', 'C', 65000),
		(606, 502, '2022-05-15 00:00:00:000', 'CQ', 'C', 24571),
		(607, 509, '2020-01-26 00:00:00:000', 'OL', 'C' ,69704),
		(608,507 ,'2009-07-04 00:00:00:000', 'RG','D', 30000),
		(609, 508, '2015-10-16 00:00:00.000','CH' ,'D', 70050),
		(610, 505, '2022-08-20 00:00:00.000', 'CQ' ,'C' ,26320)
select * from Transaction_Master

-------------------------------------------------------------------------------------------------------------------------

----lab_2----

--1--
--Display Employee number, name and branch name.--
select Emp_No,Emp_FullName,Emp_Designation from Employee_Master

--2--
--Display Account number, customer id, name and branch IFSC code using--
select Account_Master.Acc_No,
Customer_Master.Cust_Id,
Customer_Master.Cust_FullName,
Account_Master.Branch_IFSC
from Account_Master inner join Customer_Master
on Account_Master.Cust_Id = Customer_Master.Cust_Id

--3--
--Display Transaction ID, amount, account number, account type whose transaction type is Online.--
select Tran_Id,Tran_Amount,Tran_Acc_No,Tran_Type from Transaction_Master
where Tran_Type='OL'

--4--
--Display Account number, type, transaction account number and amount using left outer join.--


--6--
--Display customer name, mobile number who has highest transaction amount.--
select Cust_FullName,Cust_MobileNo
from Customer_Master where
Cust_Id=(select Cust_Id from Account_Master where
Acc_No=(select Tran_Acc_No from Transaction_Master where
Tran_Amount=(select Max(Tran_Amount) from Transaction_Master)))

--7--
--Display Branch name, IFSC and Bank ID who has lowest paying amount employee.--
select BM.Branch_Name,BM.Branch_IFSC,BM.Bank_Id,Emp_Salary
from Employee_Master EM
inner join
Branch_Master BM on EM.Branch_IFSC=BM.Branch_IFSC
where EM.Emp_Salary=
(select MIN(Emp_Salary) from Employee_Master)

--8--
--Display the count of total designation of an employees.--
select Emp_Designation,COUNT(*)
from Employee_Master
GROUP BY Emp_Designation;

--9--
--Display the count of how many customers have saving account.--
select Acc_Type,COUNT(*)
 as Using_Members from Account_Master
GROUP BY Acc_Type Having Acc_Type='SB'
select * from Account_Master


--10--
--Display details of branch master branch name wise in descending order.--
select * from Branch_Master ORDER BY Branch_Name DESC


---------------------------------------------------------------------------------------------------------------------

---lab_3---

----practical-3
----query-1
--Write a T - SQL block to check whether the given number is a positive number or a
--negative number using a simple if statement.
declare @number int
set @number=-25
if(@number>0)
	begin
		print concat(@number,' is possitive');
	end
else
	begin
		print concat(@number,' is negative');
	end

-----query-2
----Write a T - SQL block to find the maximum number from the given two numbers. 
declare @n1 int,@n2 int
set @n1=100
set @n2=56
if(@n1>@n2)
	begin
		print concat(@n1,' is maximum');
	end
else
	begin
		print concat(@n2,' is maximum');
	end


-----query-3
----Write a T-SQL block to find the maximum number from the given three numbers.
declare @n1 int,@n2 int,@n3 int
set @n1=1000
set @n2=256
set @n3=150
if(@n1>@n2 and @n1>@n3)
	begin
		print concat(@n1,' is maximum');
	end
else if(@n2>@n1 and @n2>@n3)
	begin
		print concat(@n2,' is maximum');
	end
else
	begin
		print concat(@n3,' is maximum');
	end


------query-4
----Write a T - SQL block to print the first 25 natural numbers using a loop.
declare @number int,@i int
set @number=25
set @i=1
while(@i<=@number)
	begin
		print (@i);
		set @i=@i+1;
	end

----query-5
----Write a T - SQL Program to Print Odd Numbers From 1 to 100.
declare @number int,@i int
set @number=100
set @i=1
while(@i<=@number)
	begin
		if(@i%2!=0)
			begin
				print(@i);
			end
			set @i=@i+1;
	end

----query-6
---Write a T - SQL block to find the sum of the first 100 natural nos. 
declare @number int,@i int,@sum int
set @number=100
set @i=1
set @sum=0
while(@i<=@number)
	begin
		if(@i%2!=0)
			begin
				set @sum=@sum+@i;
			end
			set @i=@i+1;
	end
	print concat(' answer is:',@sum);


-----query-7
---Write a T-SQL block to find whether the number is even or odd. 
declare @number int,@i int
set @number=100
		if(@number%2!=0)
			begin
				print concat(@number,' is odd');
			end
		else
			begin
				print concat(@number,' is even');
			end

-----query-8
---Write a T - SQL block to print the first 25 Odd numbers using a loop in Reverse order.
declare @i int,@number int
set @number=1
set @i=50
while(@i>=@number)
	begin
		if(@i%2!=0)
			begin
				print(@i);
			end
			set @i=@i-1;
	end

-----query-9
/*Write a T-SQL block for given conditions: marks > 70 then Print '1st Class', marks>50
and marks<=70 then print '2nd Class', marks>=35 and marks<=50 then print '3rd
Class', marks<35 then print 'Fail !!'.*/
declare @marks int
set @marks=15
if(@marks > 70)
	begin
		 Print '1st Class'
	end
else if(@marks>50 and @marks<=70)
	begin
		 Print '2nd Class'
	end
else if(@marks>=35 and @marks<=50)
	begin
		 Print '3rd Class'
	end
else
	begin
		 Print 'Fail'`
	end

-------------------------------------------------------------------------------------------------------------------------

---lab_4---

------1------
create view Bank_view
as
select Bank_id,Bank_name from Bank_master
select * from Bank_view;

-------2-------
create view customer_view
as 
select Cust_fullname,Cust_MobileNo,Cust_EmailId from Customer_Master
select* from customer_view;

--------3--------
create view Complex_view
as
select Account_Master.Acc_No,
	   Account_Master.Cust_Id,
	   Branch_Master.Branch_Name,
	   Bank_Master.Bank_Name
	from  Account_Master inner join Branch_Master
	on Account_Master.Branch_IFSC=Branch_Master.Branch_IFSC inner join Bank_Master
	on Bank_Master.Bank_Id=Branch_Master.Bank_Id
select *from Complex_view

-------4-----
create view  simple_view
as
select  Cust_FullName,Cust_city
from Customer_Master
with check option
select*from simple_view

-------5-------
create sequence Bank_Master_seq
start with 107
increment by 1
select next value for Bank_Master_seq
insert into Bank_Master values(next value for Bank_Master_seq,'SBI bank','SBI')
select*from Bank_Master

create sequence Branch_Master_seq
start with 211
increment by 1
select next value for Branch_Master_seq

create sequence Employee_Master_seq
start with 311
increment by 1
select next value for Employee_Master_seq

-----6---
create synonym T_master for transaction_master
select*from T_master

-------7-------
create view Tr_view
as
select Tran_id,Tran_acc_no from Transaction_Master
where Tran_Type='ol'
select*from Tr_view

------8---
alter view cust_city_view	
as
select*from Customer_Master
where Cust_City='Rajkot'
with check option
insert into cust_city_view(cust_id, cust_fullName,cust_DOB, cust_address,cust_mobileNo,cust_emailId,cust_city) VALUES 
(418,'C N Kanani','1985-08-20','Milap Nagar,University Road',2134567890,'cnk@gmail.com','Raj');
select*from cust_city_view

-------9-----

create table student_table(roll_no int)
create sequence student_seq
start with 101
increment by 5
maxvalue 120
minvalue 100
cycle
insert into student_table values(next value for student_seq
)
select next value for student_seq

----10-----

insert into Employee_Master 
values(next value for Employee_Master_seq,'SBI101MB201','Shashikant Das','Bank Manager', 9876543210,250000);
select * from Employee_Master

--11---

alter view Tr_View as
select Tran_Id, Tran_Acc_No, Tran_Amount  from Transaction_Master
where Tran_Type='ol'
select * from Tr_View

--12
drop view Customer_View

--13
drop sequence Employee_Master
insert into Employee_Master
values(next value for Employee_Master_seq,'abc','Shashikant Das','Bank Manager',5643398473,250000)

--------------------------------------------------------------------------------------------------------------------

---lab_5---

--1--

select dbo.odd(1,10)

create function simple_interest
(
   @P int, @R int, @N int
)
returns float
as
begin
     return(@P*@R*@N)/100
end
select dbo.simple_interest(1000,5,2)

--2--

alter function feet
(
   @feet float
)
returns float
as 
begin
      return @feet*12
end
select dbo.feet(10)

--
--3---



create function cf(@c float)
returns float
as
begin
return (@c*9/5)+32
end

select dbo.cf(77)



---4---

create function factorial(@n int)
returns int
as
begin
declare @i int = 1,@fact int=1
while(@n>=@i)
begin
set @fact=@fact*@i
set @i=@i+1
end
return @fact
end

select dbo.factorial(5)

---5---

create function odd(@ll int,@ul int)
returns int
as
begin
declare @i int = @ll,@sum int=0
while(@i<@ul)
begin
if(@i%2!=0)
begin 
set @sum=@sum+@i
end
set @i=@i+1
end
return @sum
end

select dbo.odd(5,10)

-----------------------------------------------------------------------------------------------------------------------

---lab_6---

--1--

create proc fact
(
  @number int
)
as
begin 
      declare @i int=1,@fact int=1;
	  while(@i<=@number)
	  begin
	        set @fact=@fact*@i;
			set @i=@i+1
	  end
	  print @fact
end
exec fact 5 

---2---

alter proc maximum
(
    @a int,
	@b int
)
as
begin
      if(@a>@b)
	  begin
	         print concat(@a,' is max')
	  end
	  else
	  begin
	         print concat(@b,' is max') 
	  end
end
exec maximum 5,2

--3--

create proc squares
(
   @no int
)
as
begin
      set @no=@no*@no
	  print @no
end
exec squares 12

---4---
create proc even
	as
	begin
		declare @n int=1,@sum int=0
		 while(@n<=100)
		begin
		if(@n%2=0)
		begin
		 set @sum=@sum+@n;
		 end
		set @n=@n+1;
		 end
		print @sum;
	end
exec even

--5---

 create procedure pr_marks
 (
	@s1 int,
	@s2 int,
	@s3 int,
	@total int output
 )
 as 
 begin
	if(@s1>35 and @s2>35 and @s3>35)
	begin
		set @total=@s1+@s2+@s3
	end
	else
		begin
			print 'Fail'
			set @total=0
		end
 end
 declare @total int=0;
 exec pr_marks 40,40,40, @total=@total output
 print @total 

 -----------------------------------------------------------------------------------------------------------------------------

 ---lab_7---

 --1--

create trigger Tr_create
on database
for create_table 
as
begin
       print 'Table Created Successfully!!'
end

create table demo_tr
(
   xyz varchar(20)
)

--2--

create trigger Tr_alter
on database
for alter_table
as
begin
       print 'Table Updated Successfully!!'
end

alter table demo_tr
alter column xyz varchar(50)


--3--

create trigger Tr_drop
on database
for drop_table
as
begin
       print 'Table drop Successfully!!'
end

drop table demo_tr

--4--

create table log_table(
   log_id int identity(1,1) primary key,
   event_data xml not null,
   event_date datetime not null,
   event_by varchar (20) not null
); 

create trigger log_table
on database
for create_table,alter_table,drop_table
as
begin
      insert into log_table(event_data,event_date,event_by)
	  values (eventdata(),getdate(),user)
end

create table demo_tr
(
   xyz varchar(20)
)
select * from log_table

------------------------------------------------------------------------------------------------------------------------

---lab_8---

---1---

create table demo1_tr
 (
	rollno int, 
	name varchar(60)
 )

 create trigger tr_insert
 on demo1_tr
 for insert
 as
 begin
	print'successful event'
 end

 insert into demo1_tr(name,rollno)
 values('nazil',152)

 ---2---
 create trigger tr_update
 on demo1_tr
 for update
 as
 begin
	print' upadte successful event'
 end

 update demo1_tr
 set name='Result'
 where rollno=152

 --3----
 create trigger tr_delete
 on demo1_tr
 for delete
 as
 begin
	print' delete successful event'
 end

 delete from demo1_tr
 where rollno=152

 --4---

 create table DmL_log_table
(
   Event_id int identity(1,1) primary key,
   Event_name varchar(20) not null,
   Event_date datetime not null,
); 
drop table DmL_log_table
create trigger Dml_log_tr
on demo1_tr
for insert,update,delete
as
begin
      declare @insertid int,@deleteid int;
	  select @insertid=rollno from inserted
	  select @deleteid=rollno from deleted     
	  if(@insertid is not null) and (@deleteid is not null)
	  begin
	        insert into DmL_log_table
			values('update', getdate())
	  end
	  else if(@insertid is not null)
	  begin
	        insert into Dml_log_table
	        values('insert', getdate())
	  end
	  else 
	  begin
	        insert into Dml_log_table
	        values('delete',getdate())
	  end
end

select * from DmL_log_table

---------------------------------------------------------------------------------------------------------------------

---lab_9---

--1--

declare @bank_name varchar(50),
        @bank_short_name varchar(20);
declare static_cursor cursor
static
for select bank_name,Bank_ShortName from Bank_Master
open static_cursor
if @@CURSOR_ROWS >0
begin
      fetch next from static_cursor into @bank_name,@bank_short_name 
	  while @@FETCH_STATUS =0
	  begin
	        print concat(@bank_name,@bank_short_name)
			fetch next from static_cursor into @bank_name,@bank_short_name 
	  end
end
close static_cursor
deallocate static_cursor

---2---
declare second_cursor cursor
static
for select * from Bank_Master
open second_cursor
if @@CURSOR_ROWS >0
begin
       fetch first from second_cursor
	   fetch last from second_cursor
end
close second_cursor
deallocate second_cursor

---3---
declare @Id int,
        @Name varchar(50), 
        @shortname varchar(20);
declare update_cursor cursor
static
for select * from Bank_Master
open update_cursor
if @@CURSOR_ROWS >0
begin
      fetch next from update_cursor into @Id ,@Name ,@shortname;
	  while @@FETCH_STATUS =0
	  begin
	        update Bank_Master set Bank_ShortName='xyz'
			where current of update_cursor
			print concat (@Id,@Name,@shortname) 
			fetch next from update_cursor into @Id ,@Name ,@shortname;
	  end
end
close update_cursor
deallocate update_cursor

-----------------------------------------------------------------------------------------------------------------------

---lab_10---


create table emp(
  id int,
  name varchar(20),
  salary int
)
insert into emp
values(101,'abc',10000),
      (102,'def',20000),
	  (103,'ghi',50000),
	  (104,'jkl',40000)
	  
select * from emp

---1---
declare @emp_id int,@emp_name varchar(50),@emp_salary int
declare D_cursor1 cursor
dynamic
for select * from emp
open D_cursor1
fetch next from D_cursor1 into @emp_id,@emp_name,@emp_salary
while (@@FETCH_STATUS=0)
 begin
       update emp set salary=20000
	   where current of D_cursor1
	   print concat (@emp_name,@emp_salary)
	   fetch next from D_cursor1 into @emp_id,@emp_name,@emp_salary
 end
 close D_cursor1
 deallocate D_cursor1

 ---2---
declare @emp_id int,@emp_name varchar(50),@emp_salary int
declare D_cursor2 cursor
dynamic
for select * from emp
open D_cursor2
fetch next from D_cursor2 into @emp_id,@emp_name,@emp_salary
while (@@FETCH_STATUS=0)
 begin
       waitfor delay '00:00:02'
	   print concat (@emp_name,@emp_salary)
	   fetch next from D_cursor2 into @emp_id,@emp_name,@emp_salary
 end
 close D_cursor2
 deallocate D_cursor2

 -------------------------------------------------------------------------------------------------------------------

 ---lab_11----

 ---1---
begin try
   declare @a int,@b varchar(20)='xyz'
   set @a = @b
end try
begin catch
      select ERROR_MESSAGE() as ERROR_MESSAGE,
	         ERROR_NUMBER() as ERROR_NUMBER,
	         ERROR_LINE() as ERROR_LINE,
			 ERROR_STATE() as ERROR_STATE,
			 ERROR_SEVERITY() as ERROR_SEVERITY,
			 ERROR_PROCEDURE() as ERROR_PROCEDURE
end catch
---2---
begin try	declare @a int=10,@b int=0,@c int	set @c=@a/@b	print @cend try
begin catch
      select ERROR_MESSAGE() as ERROR_MESSAGE,
	         ERROR_NUMBER() as ERROR_NUMBER,
	         ERROR_LINE() as ERROR_LINE,
			 ERROR_STATE() as ERROR_STATE,
			 ERROR_SEVERITY() as ERROR_SEVERITY,
			 ERROR_PROCEDURE() as ERROR_PROCEDURE
end catch

---3---
begin try
  declare @age int=10;
  if (@age<14)
  begin
       raiserror('child labour is not legal',16,1)
  end
  print('age is acceptable')
end try
begin catch
      select ERROR_MESSAGE() as ERROR_MESSAGE,
	         ERROR_NUMBER() as ERROR_NUMBER,
	         ERROR_LINE() as ERROR_LINE,
			 ERROR_STATE() as ERROR_STATE,
			 ERROR_SEVERITY() as ERROR_SEVERITY,
			 ERROR_PROCEDURE() as ERROR_PROCEDURE
end catch
---4---
create table stu_demo
(
  rollno int,
  name varchar(50),
  age int check(age>=5)
)
begin try
       insert into stu_demo
	   values (101,'xyz',2)
	   print('row insserted')
end try
begin catch
      select ERROR_MESSAGE() as ERROR_MESSAGE,
	         ERROR_NUMBER() as ERROR_NUMBER,
	         ERROR_LINE() as ERROR_LINE,
			 ERROR_STATE() as ERROR_STATE,
			 ERROR_SEVERITY() as ERROR_SEVERITY,
			 ERROR_PROCEDURE() as ERROR_PROCEDURE
end catch
---5---
begin try
       delete from Bank_Master
	   where Bank_Id=110
	   if @@Rowcount=0
	   begin
	         throw 50001,'record not found',1;
	   end                      
end try
begin catch
      select ERROR_MESSAGE() as ERROR_MESSAGE,
	         ERROR_NUMBER() as ERROR_NUMBER,
	         ERROR_LINE() as ERROR_LINE,
			 ERROR_STATE() as ERROR_STATE,
			 ERROR_SEVERITY() as ERROR_SEVERITY,
			 ERROR_PROCEDURE() as ERROR_PROCEDURE
end catch
---6---
begin try 
        insert into Bank_Master
		values(101,'state bank of india','SBI')
end try
begin catch
      select ERROR_MESSAGE() as ERROR_MESSAGE,
	         ERROR_NUMBER() as ERROR_NUMBER, 
	         ERROR_LINE() as ERROR_LINE,
			 ERROR_STATE() as ERROR_STATE,
			 ERROR_SEVERITY() as ERROR_SEVERITY,
			 ERROR_PROCEDURE() as ERROR_PROCEDURE
end catch
---7---
begin try
      declare @a int=0,
	          @b int=2,
			  @c int=3;
	 if (@a=0 or @b=0 or @c=0)
	  begin
	      throw 50001 ,'0 is not valid',1;
	  end
	 else
	  begin
	      print (@a* @b* @c)
	  end
end try
begin catch
      select ERROR_MESSAGE() as ERROR_MESSAGE,
	         ERROR_NUMBER() as ERROR_NUMBER,  
	         ERROR_LINE() as ERROR_LINE,
			 ERROR_STATE() as ERROR_STATE,
			 ERROR_SEVERITY() as ERROR_SEVERITY,
			 ERROR_PROCEDURE() as ERROR_PROCEDURE
end catch

---------------------------------------------------------------------------------------------------------------------------

---lab_12---

---1---
begin transaction
      update Customer_Master set Cust_City='rajkot'
	  where Cust_Id=401
save transaction update_point 
     insert into Customer_Master
	 values (430,'C N Kanani','1985-08-20','Milap Nagar,University Road',2134567890,'cnk@gmail.com','Gandhinagar');
save transaction insert_point

 rollback transaction update_point 
commit 

select * from Customer_Master 

---3---
begin transaction t2
      update Transaction_Master set Tran_Amount=50000
	  where Tran_Id=601
save transaction update_point 
     insert into Transaction_Master
	 values (611,501,'2022-11-22 00:00:00.000','CH','C',500000);
save transaction insert_point
rollback transaction update_point 
commit

select * from Transaction_Master

--2--
create login user2 with password='user@123'
create user testuser1 for login user2

grant select,update on employee_master to testuser1
revoke select,update on employee_master to testuser1

--4--
create login user5 with password='user@123'
create user testuser3 for login user5

grant select,update on account_master to testuser3 with grant option
revoke select,update on account_master from testuser3 cascade

