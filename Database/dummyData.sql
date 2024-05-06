use healthdatahub;

insert into Users values
(1,'Researcher', 'Researcher', 'Researcher@example.edu', '1234', 1),
(2, 'User1', 'User1', 'User1@example.com', '5678', 0),
(12, 'demo', 'demo', 'demo@example.com', 'password', 0);


insert into Studies values
(1,'Study1', '2024-04-05', '2024-12-31');


insert into Study_Access values
(1,1);


--insert into Basic_Data values
--(1, 2, 72, 175);


insert into Heart_Rate_Data values
(1, 2, GETDATE(), 70);

insert into Calorie_Data values
(1, 2, CAST(GETDATE() as date), 70);


insert into condition_data values
(2,'Diabetes');

select * from users;
select * from studies;
select * from study_access;
select * from basic_data;
select * from Heart_Rate_Data;
select * from Calorie_Data;
select * from condition_data;