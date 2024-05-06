
use master;
drop database if exists healthDataHub;
create database healthDataHub;
use healthDataHub;

drop table if exists Users;
create table Users (
UserID BIGINT NOT NULL,
RealName varchar(20) NOT NULL,
Username varchar(50) NOT NULL UNIQUE,
Email varchar(50) NOT NULL UNIQUE,
UPassword varchar (20) NOT NULL,
Researcher bit,
primary key (UserId)
);

drop table if exists Studies;
create table Studies (
StudyID BIGINT NOT NULL,
StudyName varchar(50) NOT NULL unique,
StartsAt Date,
EndsAt Date,
primary key (StudyID)
);

drop table if exists Basic_Data;
create table Basic_Data (
StudyID BIGINT NOT NULL,
Participant BIGINT NOT NULL,
CapturedAt varchar(50) NOT NULL,
Height int,
Weight int,
foreign key(Participant) references Users(UserID),
foreign key(StudyID) references Studies(StudyID),
primary key (StudyID,Participant)
);

drop table if exists Heart_Rate_Data;
create table Heart_Rate_Data (
StudyID BIGINT NOT NULL,
Participant BIGINT NOT NULL,
CapturedAt datetime NOT NULL,
HeartRate int,
foreign key(StudyID) references Studies(StudyID),
foreign key(Participant) references Users(UserID),
primary key (StudyID,Participant,CapturedAt)
);

drop table if exists Calorie_Data;
create table Calorie_Data (
StudyID BIGINT NOT NULL,
Participant BIGINT NOT NULL,
CapturedAt date NOT NULL,
CaloriesBurned int,
foreign key(StudyID) references Studies(StudyID),
foreign key(Participant) references Users(UserID),
primary key (StudyID,Participant,CapturedAt)
);

drop table if exists Condition_Data;
create table Condition_Data (
UserID BIGINT NOT NULL,
ConditionName varchar(50),
foreign key(UserID) references Users(UserID),
primary key(UserID,ConditionName)
);

drop table if exists Study_Access;
create table Study_Access(
StudyID BIGINT NOT NULL,
Researcher BIGINT NOT NULL,
foreign key(StudyID) references Studies(StudyID),
foreign key(Researcher) references Users(UserID),
primary key (StudyID,Researcher)
);