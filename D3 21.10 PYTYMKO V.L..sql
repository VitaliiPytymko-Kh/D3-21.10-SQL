USE Academy
GO
SELECT*FROM Teachers
INSERT INTO Teachers ( Name, Salary, Surname)
VALUES
( 'Em', 2600, 'Hurring'),
( 'Garrik', 1930, 'Ferrari'),
( 'Robb', 8440, 'Germon'),
('Carlota', 4090, 'Chapelhow'),
('Samantha', 4090, 'Adams');
GO

SELECT*FROM Curators
INSERT INTO Curators (Name,Surname)
VALUES 
('Ardyth', 'De Bruyn'),
 ('Nobie', 'Disbrey'),
 ('Jessie', 'Kliemchen'),
('Celie', 'Landre'),
 ('Jayme', 'Murkin');
 GO

SELECT*FROM Faculties
INSERT INTO Faculties(Financing,Name)
VALUES 
(5000,'Computer Science'),
(10000,'Software Engineering'),
(7300,'Information Technology Management'),
(45000,'Data Science and Analytics'),
(9000,'Cybersecurity and Network Security');
GO

SELECT*FROM Departments
INSERT INTO Departments(Financing,Name,FacultyId)
VALUES 
(2000,'Computer Science and Engineering Department',1),
(7000,'Software Development and Algorithms Department',2),
(4000,'Artificial Intelligence and Machine Learning Department',3),
(15000,'Information Systems and Technology Department',4),
(6000,'Computer Science and Cybersecurity DepartmenT',5);
GO

SELECT*FROM Groups
INSERT INTO Groups(Name,Year,DepartmentId)
VALUES 
('K216',1,6),
('L105',2,2),
('P107',3,4),
('A111',4,5),
('X9',5,3);
GO

SELECT*FROM Subjects
INSERT INTO Subjects (Name)
VALUES 
('Database Theory '),
('Computer Graphics and Visualization'),
('Machine Learning and Pattern Recognition'),
('Software Engineering and Development Practices'),
('Network Security and Cybersecurity');
GO

SELECT*FROM Lectures
SELECT*FROM Teachers
SELECT*FROM Subjects

INSERT INTO Lectures (LectureRoom,SubjectId,TeacherId)
VALUES ('B103',1,5),
('B105',2,4),
('S15',3,3),
('Y173Y',4,1),
('A111',5,2);
GO

SELECT*FROM Groups
SELECT*FROM Lectures
SELECT*FROM GroupsLectures
INSERT INTO GroupsLectures(GroupId,LectureId)
VALUES(3,1),
(1,2),
(2,3),
(4,4),
(5,5);
go

SELECT*FROM Groups
SELECT*FROM Curators
SELECT*FROM GroupsCurators
insert into GroupsCurators(CuratorId,GroupId)
values (1,1),
(2,2),
(3,3),
(4,4),
(5,5);
go

--1. ¬ивести вс≥ можлив≥ пари р€дк≥в викладач≥в та груп.

select Teachers.Name +' '+Teachers.Surname as Teacher, Groups.Name as Groups_
from Teachers,Groups,Lectures,GroupsLectures
where Teachers.Id=Lectures.Id and Lectures.Id=GroupsLectures.Id and GroupsLectures.Id = Groups.Id;
go

--2. ¬ивести назви факультет≥в, фонд ф≥нансуванн€ кафедр €ких перевищуЇ фонд ф≥нансуванн€ факультету.
select Faculties.Name AS  FacultiesName 
from Faculties,Departments
WHERE Departments.Financing>Faculties.Financing AND Departments.FacultyId=Faculties.Id
GO

UPDATE Departments
SET Financing=17000 WHERE FacultyId=3;

--3 ¬ивести пр≥звища куратор≥в груп та назви груп, €к≥ вони курирують.


SELECT Curators.Surname AS Curators_Surname, Groups.Name as Groups_Name
FROM Curators,Groups,GroupsCurators
WHERE Curators.Id=GroupsCurators.CuratorId AND GroupsCurators.CuratorId=Groups.Id;
GO

UPDATE GroupsCurators
SET CuratorId=5 WHERE GroupId=3;
GO

--4. ¬ивести ≥мена та пр≥звища викладач≥в, €к≥ читають лекц≥њ у груп≥ УP107Ф.

SELECT T.Name+' '+ T.Surname AS TEACHER, G.Name AS GROUP_NAME
FROM Teachers T, Lectures L, GroupsLectures GL, Groups G
WHERE T.Id = L.TeacherId AND L.Id = GL.LectureId
AND GL.GroupId = G.Id
AND G.Name = 'P107';
GO

--5. ¬ивести пр≥звища викладач≥в та назви факультет≥в, на €ких вони читають лекц≥њ.
SELECT  T.Surname AS TEACHER, F.Name AS FACULTIES_NAME
FROM Teachers T,Lectures L,GroupsLectures GL,Groups G,  Departments D,Faculties F
WHERE T.Id = L.TeacherId AND L.Id = GL.LectureId
AND GL.GroupId = G.Id AND G.DepartmentId=D.Id AND D.FacultyId=F.Id;
GO

--6. ¬ивести назви кафедр та назви груп, €к≥ до них належать.

SELECT D.Name AS Department, G.Name AS GROUP_NAME
FROM Departments D, Groups G
WHERE D.Id=G.DepartmentId;
GO

--7. ¬ивести назви дисципл≥н, €к≥ читаЇ викладач УSamantha AdamsФ.

SELECT S.Name AS SUBJECT, T.Name+' '+T.Surname AS TEACHER  
FROM Teachers T, Lectures L, Subjects S
WHERE T.Name= 'Samantha' AND T.Surname= 'Adams' 
AND  T.Id=l.TeacherId and L.Id=L.SubjectId
AND L.SubjectId=S.Id

--8. ¬ивести назви кафедр, де читаЇтьс€ дисципл≥на УDatabase TheoryФ.
SELECT D.Name AS DEPARTMENT, S.Name AS _SUBJECT
FROM Subjects S,Lectures L,GroupsLectures GL,Groups G,Departments D
WHERE  S.Name='Database Theory' AND S.Id=L.SubjectId AND L.Id=GL.LectureId AND GL.GroupId=G.Id
AND G.DepartmentId=D.Id;
GO

--9. ¬ивести назви груп, що належать до факультету Computer Science.
SELECT G.Name AS GROUP_NAME, F.Name AS FACULTIES_NAME
FROM Faculties F,Departments D,Groups G
WHERE F.Name='Computer Science' and F.Id=D.FacultyId AND D.Id=G.DepartmentId; 
GO

--10. ¬ивести назви груп 5-го курсу, а також назву факультет≥в,до €ких вони належать.
SELECT G.Name AS GROUP_NAME, F.Name AS FACULTIES_NAME
FROM Faculties F,Departments D,Groups G
WHERE G.Year=5 AND G.DepartmentId=D.Id AND D.FacultyId=F.Id;
GO

--11.¬ивести повн≥ ≥мена викладач≥в та лекц≥њ, €к≥ вони читають (назви дисципл≥н та груп),
--причому в≥д≥брати лише т≥ лекц≥њ, що читаютьс€ в аудитор≥њ УB103Ф.
SELECT T.Name +' '+T.Surname AS TEACHER, S.Name AS  _SUBJECT, L.LectureRoom as LectureRoom, G.Name AS FOR_GROUP  
FROM Teachers T,Lectures L,Groups G, Subjects S ,GroupsLectures GL
WHERE L.LectureRoom ='B103' AND L.Id=L.SubjectId AND L.SubjectId=S.Id AND L.TeacherId=T.Id
AND L.ID=GL.LectureId AND GL.GroupId=G.Id;
GO
