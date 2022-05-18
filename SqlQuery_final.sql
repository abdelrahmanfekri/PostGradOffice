create database PostGradOffice
go
use PostGradOffice
go
CREATE TABLE PostGradUser(
id int primary key identity(1,1),
email varchar(50) not null,
password varchar(30) not null
)
CREATE TABLE Admin(
id int primary key foreign key references PostGradUser on delete cascade
on update cascade
)
CREATE TABLE GucianStudent(
id int primary key foreign key references PostGradUser on delete cascade
on update cascade,
firstName varchar(20),
lastName varchar(20),
type varchar(3),
faculty varchar(30),
address varchar(50),
GPA decimal(3,2),
undergradID int
)
CREATE TABLE NonGucianStudent(
id int primary key foreign key references PostGradUser on delete cascade
on update cascade,
firstName varchar(20),
lastName varchar(20),
type varchar(3),
faculty varchar(30),
address varchar(50),
GPA decimal(3,2),
)
CREATE TABLE GUCStudentPhoneNumber(
phone int,
id int,
primary key(id, phone),
foreign key(id) references GucianStudent on delete cascade
on update cascade
)
CREATE TABLE NonGUCStudentPhoneNumber(
phone int,
id int,
primary key(id, phone),
foreign key(id) references NonGucianStudent on delete
cascade on update cascade
)
CREATE TABLE Course(
id int primary key identity(1,1),
fees int,
creditHours int,
code varchar(10)
)
CREATE TABLE Supervisor(
id int primary key foreign key references PostGradUser,
name varchar(20),
faculty varchar(30)
);
CREATE TABLE Examiner(
id int primary key foreign key references PostGradUser on delete cascade
on update cascade,
name varchar(20),
fieldOfWork varchar(100),
isNational BIT
)
CREATE TABLE Payment(
id int primary key identity(1,1),
amount decimal(7,2),
noOfInstallments int,
fundPercentage decimal(4,2)
)
CREATE TABLE Thesis(
serialNumber int primary key identity(1,1),
field varchar(20),
type varchar(3) not null,
title varchar(100) not null,
startDate date not null,
endDate date not null,
defenseDate date,
years as (year(endDate)-year(startDate)),
grade decimal(4,2),
payment_id int foreign key references payment on delete cascade on update
cascade,
noOfExtensions int
)
CREATE TABLE Publication(
id int primary key identity(1,1),
title varchar(100) not null,
dateOfPublication date,
place varchar(100),
accepted BIT,
host varchar(100)
);
Create table Defense (serialNumber int,
date datetime,
location varchar(15),
grade decimal(4,2),
primary key (serialNumber, date),
foreign key (serialNumber) references Thesis on delete cascade on update
cascade)
Create table GUCianProgressReport (
sid int foreign key references GUCianStudent on delete cascade on update
cascade
, no int
, date datetime
, eval int
, state int
, description varchar(200)
, thesisSerialNumber int foreign key references Thesis on delete cascade
on update cascade
, supid int foreign key references Supervisor
, primary key (sid, no) )
Create table NonGUCianProgressReport (sid int foreign key references
NonGUCianStudent on delete
cascade on update cascade,
no int
, date datetime
, eval int
, state int
, description varchar(200)
, thesisSerialNumber int foreign key references Thesis on delete cascade
on update cascade
, supid int foreign key references Supervisor
, primary key (sid, no) )
Create table Installment (date datetime,
paymentId int foreign key references Payment on delete cascade on update
cascade
, amount decimal(8,2)
, done bit
, primary key (date, paymentId))
Create table NonGucianStudentPayForCourse(sid int foreign key references
NonGucianStudent on
delete cascade on update cascade,
paymentNo int foreign key references Payment on delete cascade on update
cascade,
cid int foreign key references Course on delete cascade on update cascade,
primary key (sid, paymentNo, cid))
Create table NonGucianStudentTakeCourse (sid int foreign key references
NonGUCianStudent on delete
cascade on update cascade
, cid int foreign key references Course on delete cascade on update
cascade
, grade decimal (4,2)
, primary key (sid, cid) )
Create table GUCianStudentRegisterThesis (sid int foreign key references
GUCianStudent on delete
cascade on update cascade,
supid int foreign key references Supervisor
, serial_no int foreign key references Thesis on delete cascade on update
cascade
, primary key(sid, supid, serial_no))
Create table NonGUCianStudentRegisterThesis (sid int foreign key
references NonGUCianStudent on
delete cascade on update cascade,
supid int foreign key references Supervisor,
serial_no int foreign key references Thesis on delete cascade on update
cascade ,
primary key (sid, supid, serial_no))
Create table ExaminerEvaluateDefense(date datetime,
serialNo int,
examinerId int foreign key references Examiner on delete cascade on update
cascade,
comment varchar(300),
primary key(date, serialNo, examinerId),
foreign key (serialNo, date) references Defense (serialNumber, date) on
delete cascade on update
cascade)
Create table ThesisHasPublication(serialNo int foreign key references
Thesis on delete cascade on
update cascade,
pubid int foreign key references Publication on delete cascade on update
cascade,
primary key(serialNo,pubid))
go
create proc studentRegister
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@Gucian bit,
@email varchar(50),
@address varchar(50)
as
begin
insert into PostGradUser(email,password)
values(@email,@password)
declare @id int
SELECT @id=SCOPE_IDENTITY()
if(@Gucian=1)
insert into GucianStudent(id,firstName,lastName,faculty,address)
values(@id,@first_name,@last_name,@faculty,@address)
else
insert into NonGucianStudent(id,firstName,lastName,faculty,address)
values(@id,@first_name,@last_name,@faculty,@address)
end
go
create proc supervisorRegister
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@email varchar(50)
as
begin
insert into PostGradUser(email,password)
values(@email,@password)
declare @id int
SELECT @id=SCOPE_IDENTITY()
declare @name varchar(50)
set @name = CONCAT(@first_name,@last_name)
insert into Supervisor(id,name,faculty) values(@id,@name,@faculty)
end
go
Create proc userLogin
@id int,
@password varchar(20),
@success bit output,
@type int output
as
begin
if exists(
select ID,password
from PostGradUser
where id=@id and password=@password)
begin
set @success =1
-- check user type 0-->Student,1-->Admin,2-->Supervisor ,3-->Examiner
if exists(select id from GucianStudent where id=@id union select id from
NonGucianStudent where id=@id )
set @type=0
if exists(select id from Admin where id=@id)
set @type=1
if exists(select id from Supervisor where id=@id)
set @type=2
if exists(select id from Examiner where id=@id)
set @type=3
end
else
set @success=0
end
go
create proc addMobile
@ID varchar(20),
@mobile_number varchar(20)
as
begin
if @ID is not null and @mobile_number is not null
begin
--check Gucian student or not
if(exists(select * from GucianStudent where id=@ID))
insert into GUCStudentPhoneNumber values(@ID,@mobile_number)
if(exists(select * from NonGucianStudent where id=@ID))
insert into NonGUCStudentPhoneNumber values(@ID,@mobile_number)
end
end
go
CREATE Proc AdminListSup
As
Select u.id,u.email,u.password,s.name, s.faculty
from PostGradUser u inner join Supervisor s on u.id = s.id
go
CREATE Proc AdminViewSupervisorProfile
@supId int
As
Select u.id,u.email,u.password,s.name, s.faculty
from PostGradUser u inner join Supervisor s on u.id = s.id
WHERE @supId = s.id
go
CREATE Proc AdminViewAllTheses
As
Select
serialNumber,field,type,title,startDate,endDate,defenseDate,years,grade,payment_id,noOfExtensions
From Thesis
go
CREATE Proc AdminViewOnGoingTheses
@thesesCount int output
As
Select @thesesCount=Count(*)
From Thesis
where endDate > Convert(Date,CURRENT_TIMESTAMP)
go
CREATE Proc AdminViewStudentThesisBySupervisor
As
Select s.name,t.title,gs.firstName
From Thesis t inner join GUCianStudentRegisterThesis sr on
t.serialNumber=sr.serial_no
inner join Supervisor s on s.id=sr.supid inner join GucianStudent gs on sr.sid=gs.id
where t.endDate > Convert(Date,CURRENT_TIMESTAMP)
union
Select s.name,t.title,gs.firstName
From Thesis t inner join NonGUCianStudentRegisterThesis sr on
t.serialNumber=sr.serial_no
inner join Supervisors on s.id=sr.supid inner join NonGucianStudent gs on
sr.sid=gs.id
where t.endDate > Convert(Date,CURRENT_TIMESTAMP)
go
go
CREATE Proc AdminListNonGucianCourse
@courseID int
As
if(exists(select * from Course where id=@courseID))
Select ng.firstName,ng.lastName,c.code,n.grade
From NonGucianStudentTakeCourse n inner join Course c on n.cid=c.id inner
join NonGucianStudent ng
on ng.id=n.sid
where n.cid=@courseID

go


CREATE Proc AdminIssueThesisPayment
@ThesisSerialNo int,
@amount decimal,
@noOfInstallments int,
@fundPercentage decimal
As
if(exists(select * from Thesis where serialNumber=@ThesisSerialNo))
   begin
insert into Payment(amount,noOfInstallments,fundPercentage)
values(@amount,@noOfInstallments,@fundPercentage)
declare @id int
SELECT @id=SCOPE_IDENTITY()
update Thesis
set payment_id=@id
where serialNumber=@ThesisSerialNo;
end
else 
  raiserror('Data is not correct',2000,2000);
go



CREATE Proc AdminViewStudentProfile
@sid int
As
if(exists(select * from GucianStudent where id=@sid))
Select
u.id,u.email,u.password,s.firstName,s.lastName,s.type,s.faculty,s.address,
s.address,s.GPA
from PostGradUser u inner join GucianStudent s on u.id=s.id
WHERE @sid = s.id
else if(exists(select * from NonGucianStudent where id=@sid))
Select
u.id,u.email,u.password,s.firstName,s.lastName,s.type,s.faculty,s.address,
s.address,s.GPA
from PostGradUser u inner join NonGucianStudent s on u.id=s.id
WHERE @sid = s.id
go

CREATE Proc AdminListAcceptPublication
As
select t.serialNumber,p.title
from ThesisHasPublication tp inner join Thesis t on
tp.serialNo=t.serialNumber
inner join Publication p on p.id=tp.pubid
where p.accepted=1
go
CREATE Proc AddCourse
@courseCode varchar(10),
@creditHrs int,
@fees decimal
As
insert into Course values(@fees,@creditHrs,@courseCode)
go
CREATE Proc linkCourseStudent
@courseID int,
@studentID int
As
if(exists(select * from Course ) and exists(select * from NonGucianStudent
where id=@studentID))
insert into
NonGucianStudentTakeCourse(sid,cid,grade)values(@studentID,@courseID,null)
go
CREATE Proc addStudentCourseGrade
@courseID int,
@studentID int,
@grade decimal
As
if(exists(select * from NonGucianStudentTakeCourse where sid=@studentID
and cid=@courseID))
update NonGucianStudentTakeCourse
set grade =@grade
where cid=@courseID and sid=@studentID
go
CREATE Proc ViewExamSupDefense
@defenseDate datetime
As
select s.serial_no,ee.date,e.name,sup.name
from ExaminerEvaluateDefense ee inner join examiner e on
ee.examinerId=e.id
inner join GUCianStudentRegisterThesis s on ee.serialNo=s.serial_no
inner join Supervisor sup on sup.id=s.supid
go
CREATE Proc EvaluateProgressReport
@supervisorID int,
@thesisSerialNo int,
@progressReportNo int,
@evaluation int
As
if(exists(select * from Thesis where serialNumber=@thesisSerialNo ) and
@evaluation in(0,1,2,3) )
begin
if(exists(select * from GUCianStudentRegisterThesis where
serial_no=@thesisSerialNo and
supid=@supervisorID))
begin
declare @gucSid int
select @gucSid=sid
from GUCianStudentRegisterThesis
where serial_no=@thesisSerialNo
update GUCianProgressReport
set eval=@evaluation
where sid=@gucSid and thesisSerialNumber=@thesisSerialNo and
no=@progressReportNo
end
else if(exists(select * from NonGUCianStudentRegisterThesis where
serial_no=@thesisSerialNo and
supid=@supervisorID))
begin
declare @nonGucSid int
select @nonGucSid=sid
from NonGUCianStudentRegisterThesis
where serial_no=@thesisSerialNo
update NonGUCianProgressReport
set eval=@evaluation
where sid=@nonGucSid and thesisSerialNumber=@thesisSerialNo and
no=@progressReportNo
end
end
go
CREATE Proc ViewSupStudentsYears
@supervisorID int
As
if(exists(select * from Supervisor where id=@supervisorID))
begin
select s.firstName,s.lastName,t.years
from GUCianStudentRegisterThesis sr inner join GucianStudent s on
sr.sid=s.id
inner join Thesis t on t.serialNumber=sr.serial_no
union
select s.firstName,s.lastName,t.years
from NonGUCianStudentRegisterThesis sr inner join NonGucianStudent s on
sr.sid=s.id
inner join Thesis t on t.serialNumber=sr.serial_no
end
go
CREATE Proc SupViewProfile
@supervisorID int
As
if(exists(select * from Supervisor where id=@supervisorID))
begin
select u.id,u.email,u.password,s.name,s.faculty
from PostGradUser u inner join Supervisor s on u.id=s.id
end
go
---------------------------------------
create proc UpdateSupProfile
@supervisorID int, @name varchar(20), @faculty varchar(20)
as
update Supervisor
set name = @name, faculty = @faculty
where id = @supervisorID
go
create proc ViewAStudentPublications
@StudentID int
as
select P.*
from GUCianStudentRegisterThesis GUC
inner join Thesis T
on GUC.serial_no = T.serialNumber
inner join ThesisHasPublication TP
on T.serialNumber = TP.serialNo
inner join Publication P
on P.id = TP.pubid
where GUC.sid = @StudentID
union all
select P.*
from NonGUCianStudentRegisterThesis NON
inner join Thesis T
on NON.serial_no = T.serialNumber
inner join ThesisHasPublication TP
on T.serialNumber = TP.serialNo
inner join Publication P
on P.id = TP.pubid
where NON.sid = @StudentID
go
create proc AddDefenseGucian
@ThesisSerialNo int , @DefenseDate Datetime , @DefenseLocation varchar(15)
as
insert into Defense
values(@ThesisSerialNo,@DefenseDate,@DefenseLocation,null)
go
create proc AddDefenseNonGucian
@ThesisSerialNo int , @DefenseDate Datetime , @DefenseLocation varchar(15)
as
declare @idOfStudent int
select @idOfStudent = sid
from NonGUCianStudentRegisterThesis
where serial_no = @ThesisSerialNo
if(not exists(select grade
from NonGucianStudentTakeCourse
where sid = @idOfStudent and grade < 50))
begin
insert into Defense
values(@ThesisSerialNo,@DefenseDate,@DefenseLocation,null)
end
go
create proc AddExaminer
@ThesisSerialNo int , @DefenseDate Datetime , @ExaminerName
varchar(20),@Password varchar(30),
@National bit, @fieldOfWork varchar(20)
as
insert into PostGradUser values(@ExaminerName,@Password)
declare @id int
set @id = SCOPE_IDENTITY()
insert into Examiner values(@id,@ExaminerName,@fieldOfWork,@National)
insert into ExaminerEvaluateDefense
values(@DefenseDate,@ThesisSerialNo,@id,null)
go

create proc CancelThesis
@ThesisSerialNo int
as
if(exists(
select *
from GUCianProgressReport
where thesisSerialNumber = @ThesisSerialNo
))
begin
declare @gucianEval int
set @gucianEval = (
select top 1 eval
from GUCianProgressReport
where thesisSerialNumber = @ThesisSerialNo
order by no desc
)
if(@gucianEval = 0)
begin
delete from Thesis where serialNumber = @ThesisSerialNo
end
else
RAISERROR('error',16,1);
end
else
begin
declare @nonGucianEval int
set @nonGucianEval = (
select top 1 eval
from NonGUCianProgressReport
where thesisSerialNumber = @ThesisSerialNo
order by no desc
)
if(@nonGucianEval = 0)
begin
delete from Thesis where serialNumber = @ThesisSerialNo
end
else
RAISERROR('error',16,1);
end
go
create proc AddGrade
@ThesisSerialNo int
as
declare @grade decimal(4,2)
select @grade = grade
from Defense
where serialNumber = @ThesisSerialNo
update Thesis
set grade = @grade
where serialNumber = @ThesisSerialNo
go
create proc AddDefenseGrade
@ThesisSerialNo int , @DefenseDate Datetime , @grade decimal(4,2)
as
update Defense
set grade = @grade
where serialNumber = @ThesisSerialNo and date = @DefenseDate
if (not exists(select *from  Defense where serialNumber = @ThesisSerialNo and date = @DefenseDate) )
        RAISERROR('error',16,1);
go
create proc AddCommentsGrade
@ThesisSerialNo int , @DefenseDate Datetime , @comments varchar(300)
as
update ExaminerEvaluateDefense
set comment = @comments
where serialNo = @ThesisSerialNo and date = @DefenseDate
if (not exists(select *from  Defense where serialNumber = @ThesisSerialNo and date = @DefenseDate) )
        RAISERROR('error',16,1);

go
create proc viewMyProfile
@studentId int
as
if(exists(
select * from GucianStudent where id = @studentId
))
begin
select G.*,P.email
from GucianStudent G
inner join PostGradUser P
on G.id = P.id
where G.id = @studentId
end
else
begin
select N.*,P.email
from NonGucianStudent N
inner join PostGradUser P
on N.id = P.id
where N.id = @studentId
end
go
create proc editMyProfile
@studentID int, @firstName varchar(20), @lastName varchar(20), @password
varchar(30), @email
varchar(50)
, @address varchar(50), @type varchar(3)
as
update GucianStudent
set firstName = @firstName, lastName = @lastName, address = @address, type
= @type
where id = @studentID
update NonGucianStudent
set firstName = @firstName, lastName = @lastName, address = @address, type
= @type
where id = @studentID
update PostGradUser
set email = @email, password = @password
where id = @studentID
go
create proc addUndergradID
@studentID int, @undergradID varchar(10)
as
update GucianStudent
set undergradID = @undergradID
where id = @studentID
go
create proc ViewCoursesGrades
@studentID int
as
select grade
from NonGucianStudentTakeCourse
where sid = @studentID
go
create proc ViewCoursePaymentsInstall
@studentID int
as
select P.id as 'Payment Number', P.amount as 'Amount of
Payment',P.fundPercentage as 'Percentage of
fund for payment', P.noOfInstallments as 'Number of installments',
I.amount as 'Installment Amount',I.date as 'Installment date', I.done as
'Installment done or not'
from NonGucianStudentPayForCourse NPC
inner join Payment P
on NPC.paymentNo = P.id and NPC.sid = @studentID
inner join Installment I
on I.paymentId = P.id
go
create proc ViewThesisPaymentsInstall
@studentID int
as
select P.id as 'Payment Number', P.amount as 'Amount of Payment',
P.fundPercentage as
'Fund',P.noOfInstallments as 'Number of installments',
I.amount as 'Installment amount',I.date as 'Installment date', I.done as
'Installment done or not'
from GUCianStudentRegisterThesis G
inner join Thesis T
on G.serial_no = T.serialNumber and G.sid = @studentID
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
union
select P.id as 'Payment Number',P.amount as 'Amount of Payment',
P.fundPercentage as
'Fund',P.noOfInstallments as 'Number of installments',
I.amount as 'Installment amount',I.date as 'Installment date', I.done as
'Installment done or not'
from NonGUCianStudentRegisterThesis NG
inner join Thesis T
on NG.serial_no = T.serialNumber and NG.sid = @studentID
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
go
create proc ViewUpcomingInstallments
@studentID int
as
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Installment I
inner join NonGucianStudentPayForCourse NPC
on I.paymentId = NPC.paymentNo and NPC.sid = @studentID and I.date >
CURRENT_TIMESTAMP
union
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Thesis T
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
inner join GUCianStudentRegisterThesis G
on G.serial_no = T.serialNumber and G.sid = @studentID
where I.date > CURRENT_TIMESTAMP
union
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Thesis T
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
inner join NonGUCianStudentRegisterThesis G
on G.serial_no = T.serialNumber and G.sid = @studentID
where I.date > CURRENT_TIMESTAMP
go
create proc ViewMissedInstallments
@studentID int
as
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Installment I
inner join NonGucianStudentPayForCourse NPC
on I.paymentId = NPC.paymentNo and NPC.sid = @studentID and I.date <
CURRENT_TIMESTAMP and
I.done = '0'
union
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Thesis T
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
inner join GUCianStudentRegisterThesis G
on G.serial_no = T.serialNumber and G.sid = @studentID
where I.date < CURRENT_TIMESTAMP and I.done = '0'
union
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Thesis T
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
inner join NonGUCianStudentRegisterThesis G
on G.serial_no = T.serialNumber and G.sid = @studentID
where I.date < CURRENT_TIMESTAMP and I.done = '0'
go
create proc AddProgressReport
@thesisSerialNo int, @progressReportDate date, @studentID
int,@progressReportNo int
as
declare @gucian int
if(exists(
select id
from GucianStudent
where id = @studentID
))
begin
set @gucian = '1'
end
else
begin
set @gucian = '0'
end
if(@gucian = '1')
begin
insert into GUCianProgressReport
values(@studentID,@progressReportNo,@progressReportDate,null,null,null,@thesisSerialNo,null)
end
else
begin
insert into NonGUCianProgressReport
values(@studentID,@progressReportNo,@progressReportDate,null,null,null,@thesisSerialNo,null)
end
go
create proc FillProgressReport
@thesisSerialNo int, @progressReportNo int, @state int, @description
varchar(200),@studentID int
as
declare @gucian bit
if(exists(
select * from GucianStudent
where id = @studentID
))
begin
set @gucian = '1'
end
else
begin
set @gucian = '0'
end
if(@gucian = '1')
begin
update GUCianProgressReport
set state = @state, description = @description, date = CURRENT_TIMESTAMP
where thesisSerialNumber = @thesisSerialNo and sid = @studentID and no =
@progressReportNo
end
else
begin
update NonGUCianProgressReport
set state = @state, description = @description, date = CURRENT_TIMESTAMP
where thesisSerialNumber = @thesisSerialNo and sid = @studentID and no =
@progressReportNo
end
go
create proc ViewEvalProgressReport
@thesisSerialNo int, @progressReportNo int,@studentID int
as
select eval
from GUCianProgressReport
where sid = @studentID and thesisSerialNumber = @thesisSerialNo and no =
@progressReportNo
union
select eval
from NonGUCianProgressReport
where sid = @studentID and thesisSerialNumber = @thesisSerialNo and no =
@progressReportNo
go
create proc addPublication
@title varchar(50), @pubDate datetime, @host varchar(50), @place
varchar(50), @accepted bit
as
insert into Publication values(@title,@pubDate,@place,@accepted,@host)
go
create proc linkPubThesis
@PubID int, @thesisSerialNo int
as
insert into ThesisHasPublication values(@thesisSerialNo,@PubID)
go
create trigger deleteSupervisor
on Supervisor
instead of delete
as
delete from GUCianProgressReport where supid in (select id from deleted)
delete from NonGUCianProgressReport where supid in (select id from
deleted)
delete from GUCianStudentRegisterThesis where supid in (select id from
deleted)
delete from NonGUCianStudentRegisterThesis where supid in (select id from
deleted)
delete from Supervisor where id in (select id from deleted)
delete from PostGradUser where id in (select id from deleted)

go 
create view AllThesisRegisterd
as 
Select * from GUCianStudentRegisterThesis 
union 
Select * from NonGUCianStudentRegisterThesis
go




insert into PostGradUser (email,password) 
values('one@gmail.com','12345678')

go




insert into PostGradUser (email,password) 
values('two@gmail.com','112345678')
select * from GucianStudent

go

insert into payment (amount,noOfInstallments,fundPercentage)
values(150,2,70)
insert into Installment (date,paymentId,amount,done)
values('2020-3-15',1,50,1);
insert into Installment (date,paymentId,amount,done)
values('2020-7-15',1,100,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(500,2,60)
insert into Installment (date,paymentId,amount,done)
values('2020-4-5',2,200,1);
insert into Installment (date,paymentId,amount,done)
values('2020-9-5',2,300,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(180,1,80)
insert into Installment (date,paymentId,amount,done)
values('2020-3-15',3,180,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(170,2,70)
insert into Installment (date,paymentId,amount,done)
values('2020-1-20',4,70,1);
insert into Installment (date,paymentId,amount,done)
values('2020-9-30',4,100,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(130,1,70)
insert into Installment (date,paymentId,amount,done)
values('2020-6-15',5,130,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(125,2,68)
insert into Installment (date,paymentId,amount,done)
values('2020-5-1',6,50,1);
insert into Installment (date,paymentId,amount,done)
values('2020-8-15',6,75,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(150,2,72)
insert into Installment (date,paymentId,amount,done)
values('2020-3-1',7,50,1);
insert into Installment (date,paymentId,amount,done)
values('2020-9-20',7,100,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(115,1,78)
insert into Installment (date,paymentId,amount,done)
values('2020-3-5',8,115,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(150,2,90)
insert into Installment (date,paymentId,amount,done)
values('2020-6-15',9,50,1);
insert into Installment (date,paymentId,amount,done)
values('2020-12-15',9,100,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(200,2,80)
insert into Installment (date,paymentId,amount,done)
values('2020-2-15',10,100,1);
insert into Installment (date,paymentId,amount,done)
values('2020-8-15',10,100,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(140,1,40)
insert into Installment (date,paymentId,amount,done)
values('2020-4-15',11,50,1);
insert into Installment (date,paymentId,amount,done)
values('2020-7-15',11,90,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(170,2,75)
insert into Installment (date,paymentId,amount,done)
values('2020-1-15',12,50,1);
insert into Installment (date,paymentId,amount,done)
values('2020-8-15',12,120,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(180,2,80)
insert into Installment (date,paymentId,amount,done)
values('2020-2-1',13,50,1);
insert into Installment (date,paymentId,amount,done)
values('2020-9-15',13,130,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(150,1,70)
insert into Installment (date,paymentId,amount,done)
values('2020-6-15',14,150,1);
insert into payment (amount,noOfInstallments,fundPercentage)
values(200,1,65)
insert into Installment (date,paymentId,amount,done)
values('2020-6-12',15,200,1);

insert into Thesis (field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','PhD','Computational fluid dynamics investigation', '2018-6-1','2019-6-1','2019-7-1', 95,1,1);
insert into Thesis ( field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','Mas','Model validation for an agile UAV', '2017-7-15','2018-8-1','2018-8-15', 85,2,0);
insert into Thesis ( field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','PhD','Wind tunnel investigation in oblique flow', '2018-6-1','2018-12-1','2019-1-1', 67,3,1);
insert into Thesis ( field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','PhD','Wind tunnel investigation of propeller slipstream', '2018-6-1','2018-12-1','2019-1-1', 82,4,0);
insert into Thesis (field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','Mas','Reconfigurable metamaterials for soft robotics', '2018-6-15','2019-2-15','2019-3-1', 70,5,0);
insert into Thesis (field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','PhD','State Estimation on Matrix Lie Groups', '2019-2-1','2019-8-1','2019-9-1', 73,6,0);
insert into Thesis (field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','PhD','Nonlinear vibrations of architected materials', '2020-1-1','2020-6-1','2020-7-1', 85,7,2);
insert into Thesis (field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','Mas','Multi-robot collaborative state estimation', '2018-6-1','2019-6-1','2019-7-1', 79,8,1);
insert into Thesis (field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','PhD','Dynamics of photon-driven lightsails', '2018-7-1','2019-1-1','2019-1-15', 90,9,0);
insert into Thesis (field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','PhD','Dynamic soaring on a shock wave', '2018-3-1','2018-9-1','2018-10-1', 78,10,2);
insert into Thesis ( field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','PhD','Impact of dust grain on lightsails', '2018-6-1','2019-6-1','2019-7-1', 68,11,0);
insert into Thesis (field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','Mas','Pellet stream propulsion for interstellar flight', '2018-6-1','2022-6-1','2019-7-1', 93,12,0);
insert into Thesis (field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','Mas','Device fabrication for the imaging of protein', '2019-6-1','2022-6-1','2020-7-1', 82,13,0);
insert into Thesis (field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','PhD','Sailing strategies for improved fuel efficiency', '2018-7-15','2022-6-1','2019-7-15', 89,14,1);
insert into Thesis (field, type, title, startDate, endDate, defenseDate, grade,payment_id,noOfExtensions)
values('Engineering','PhD','The use of warm mix asphalt in road construction', '2018-6-1','2019-6-1','2019-7-1', 95,15,1);

insert into PostGradUser (email,password) 
values('ahmedahmed@gmail.com','12245678')
insert into PostGradUser (email,password) 
values('mahmoudmahmoud@gmail.com','12335678')
insert into PostGradUser (email,password) 
values('mostafamostafa@gmail.com','12344678')
insert into Supervisor (id,name,faculty) values(3,'Ahmed','eng')
insert into Supervisor (id,name,faculty) values(4,'Mahmoud','eng')
insert into Supervisor (id,name,faculty) values(5,'Mostafa','eng')



go

create view allStudent
as 
Select * from GucianStudent 
union 
Select *, Null from NonGucianStudent
go

create view allRegThesis
as 
select * from NonGUCianStudentRegisterThesis
union 
select * from GUCianStudentRegisterThesis
go

create proc search 
@id int ,
@search varchar(50)
as
DECLARE  @word  as varchar(50)
set @word = '%'+@search+'%'
select t.*
from Thesis t inner join ExaminerEvaluateDefense E on t.serialNumber=e.serialNo
where e.examinerId=@id and t.title like @word
go 
create proc viewallthesis
@id  int 
as
select ee.examinerId,t.title,s.firstName+''+s.lastName,ss.name
from ExaminerEvaluateDefense ee inner join Thesis t on ee.serialNo=t.serialNumber
inner join AllThesisRegisterd AL on al.serial_no=ee.serialNo
inner join allStudent s on al.sid=s.id
inner join Supervisor ss on al.supid=ss.id
where ee.examinerId=@id
select * 
from AllThesisRegisterd
select * from ExaminerEvaluateDefense
select * from Thesis
where Thesis.serialNumber=10
select * from Examiner
insert into ExaminerEvaluateDefense (date,serialNo,examinerId)
values('2018-10-01',10,8)

select * from Defense

go 


insert into PostGradUser (email,password) 
values('magedmaged@gmail.com','12345278')
insert into PostGradUser (email,password) 
values('karimkarima@gmail.com','12345478')
insert into PostGradUser (email,password) 
values('ayaaya@gmail.com','12345378')
insert into NonGucianStudent(id,firstName, lastName, type,faculty,address,GPA )
values (6,'aya','fawzy','phd','eng','madnity',2)
insert into NonGucianStudent(id,firstName, lastName, type,faculty,address,GPA )
values (7,'mona','ayman','msd','eng','6-oktober',2.1)
insert into NonGucianStudent(id,firstName, lastName, type,faculty,address,GPA )
values (8,'mo','salah','phd','eng','eltahrir',2.3)

insert into course (fees,creditHours, code)
values(5000,4,'501')
insert into course (fees,creditHours, code)
values(3000,2,'503')
insert into course (fees,creditHours, code)
values(4000,3,'602')
insert into course (fees,creditHours, code)
values(5500,5,'701')
insert into course (fees,creditHours, code)
values(6000,6,'502')

insert into NonGucianStudentTakeCourse values(6,1,3.2)
insert into NonGucianStudentTakeCourse values(6,2,1.2)
insert into NonGucianStudentTakeCourse values(6,3,4.2)

insert into NonGUCianStudentRegisterThesis values (6,3,1)
insert into NonGUCianStudentRegisterThesis values (6,3,3)








go
create proc editexaminer
@id int,
@name varchar(20),
@filed varchar(20)
as
update Examiner set name=@name,fieldOfWork=@filed
where id=@id
if (not exists(select *from  Examiner where id=@id ))

        RAISERROR('error',16,1);


go
create proc ExaminerRegister
@first_name varchar(20),
@last_name varchar(20),
@email varchar(50),
@password varchar(20),
@fieldOfWork varchar(20),
@isNational bit
as
insert into PostGradUser(email,password)
values(@email,@password);
declare @id int;
SELECT @id=SCOPE_IDENTITY();
declare @name varchar(50);
set @name = CONCAT(@first_name,@last_name);
insert into Examiner(id,name,fieldOfWork,isNational)
values(@id,@name,@fieldOfWork,@isNational);

go


CREATE Proc AdminUpdateExtension
@ThesisSerialNo int
As
if(exists(select * from Thesis where serialNumber=@ThesisSerialNo))
begin
declare @noOfExtensions int
select @noOfExtensions=noOfExtensions from Thesis where
serialNumber=@ThesisSerialNo
update Thesis
set noOfExtensions=@noOfExtensions+1
where serialNumber=@ThesisSerialNo
end
else raiserror('Extension does not updated',2000,1000);
   
   
go


CREATE Proc AdminIssueInstallPayment @paymentID int,@InstallStartDate date
As
if(exists(select * from Payment where id=@paymentID))
begin
declare @numOfInst int select @numOfInst=noOfInstallments from Payment where id=@paymentID
declare @payAmount int select @payAmount=amount from Payment where id=@paymentID
DECLARE @Counter INT
SET @Counter=1
declare @instdate date
set @instdate=@InstallStartDate
WHILE (@counter<=@numOfInst)
BEGIN
declare @instAmount int
set @instAmount=@payAmount/@numOfInst
if(@counter=1)
insert into
Installment(date,paymentId,amount,done)values(@InstallStartDate,@paymentID
,@instAmount,0)
else
begin
set @instdate=DATEADD(MM, 6, @instdate);
insert into
Installment(date,paymentId,amount,done)values(@instdate,@paymentID,@instAmount,0)
end
SET @counter=@counter+1
END 
end
else raiserror('The Payment Id does not exist',1000,2000);
go
create proc userLogin1
@email varchar(50) ,
@password varchar(20),
@success bit output,
@type varchar(20) output,
@id int output
as
begin
if exists(
select email,password
from PostGradUser
where email=@email and password=@password 
)
begin
set @success='1'

select @id=id from PostGradUser where email=@email and password=@password
if exists(select * from Supervisor where id=@id) 
set @type='Supervisor'
if exists(select * from NonGucianStudent where id=@id) 
set @type='NonGucianStudent'
if exists(select * from GucianStudent where id=@id) 
set @type='GucianStudent'
if exists(select * from Admin where id=@id) 
set @type='Admin'
if exists(select * from Examiner where id=@id) 
set @type='Examiner'
end
else
begin
set @success='0'
end

end

go 
create proc getPub
as
select * from Publication


go
create proc getongoingthesis 
@id int
as
select T.* from GUCianStudentRegisterThesis G inner join Thesis T on G.serial_no = T.serialNumber where sid = @id and CURRENT_TIMESTAMP between T.startDate and T.endDate
 union
select T.* from NonGUCianStudentRegisterThesis G inner join Thesis T on G.serial_no = T.serialNumber where sid = @id and CURRENT_TIMESTAMP between T.startDate and T.endDate

go
create proc getThesisandprogress 
@id int
as
select T.*,GR.no from GUCianStudentRegisterThesis G inner join Thesis T on G.serial_no = T.serialNumber
inner join GUCianProgressReport GR on T.serialNumber=GR.thesisSerialNumber 
where G.sid = @id and CURRENT_TIMESTAMP between T.startDate and T.endDate
union
select T.* , NGR.no from NonGUCianStudentRegisterThesis G inner join Thesis T on G.serial_no = T.serialNumber
inner join NonGUCianProgressReport NGR on T.serialNumber=NGR.thesisSerialNumber
where G.sid = @id and CURRENT_TIMESTAMP between T.startDate and T.endDate

go
create proc getThesis 
@id int
as
select T.* from GUCianStudentRegisterThesis G inner join Thesis T on G.serial_no = T.serialNumber where sid = @id 
 union
select T.* from NonGUCianStudentRegisterThesis G inner join Thesis T on G.serial_no = T.serialNumber where sid = @id

go
create proc NonGucianCourse
@id int
as
select C.* , NG.grade from NonGucianStudentTakeCourse NG inner join Course c on NG.cid=C.id where NG.sid=@id

go
create proc GucianandNonStudentData
@id int 
as
if (exists(select * from GucianStudent where id=@id))
	select * from GucianStudent where id=@id
else
	select * from NonGucianStudent where id=@id


select * from Thesis;

select * from Payment;
select * from Installment;

declare @outp int;

Exec AdminViewOnGoingTheses @outp;
print(@outp);

