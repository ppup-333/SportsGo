--CREATE DATABASE Sport_Project;
--GO

USE Sport_Project;
GO
---------------------------------------Account
CREATE TABLE user_status(
STATUS_CODE varchar(10) PRIMARY KEY,
STATUS varchar(50),
VER datetime
)
GO

CREATE TABLE user_city(
CITY_CODE varchar(10) PRIMARY KEY,
CITY varchar(20),
VER datetime
)
GO

CREATE TABLE user_district(
USER_DISTRICT_CODE int IDENTITY(1001,1) primary key, 
CITY_CODE varchar(10) FOREIGN KEY REFERENCES user_city(CITY_CODE),
DISTRICT varchar(20),
VER datetime
)
GO

CREATE TABLE users(
ACCOUNT varchar(20) PRIMARY KEY,
PASSWORD varchar(MAX),
NAME varchar(50),
ID varchar(20),
GENDER varchar(10),
BIRTHDAY varchar(10),
EMAIL varchar(50),
CITY_CODE varchar(10) FOREIGN KEY REFERENCES user_city(CITY_CODE),
USER_DISTRICT_CODE int FOREIGN KEY REFERENCES user_district(USER_DISTRICT_CODE), 
ADDRESS varchar(200),
TEL varchar(20),
MOBILE varchar(20),
STATUS_CODE varchar(10) FOREIGN KEY REFERENCES user_status(STATUS_CODE), 
ACT_REGISTERED_TIME datetime,
LOGIN_FAIL_COUNT int,
PW_LAST_UPDATE_DATE datetime,
VER datetime,
CONSTRAINT users_UK_1 UNIQUE(EMAIL),
CONSTRAINT users_UK_2 UNIQUE(ID)
)
GO

CREATE TABLE user_auth(
AUTH_CODE varchar(10) primary key,
AUTH_NAME varchar(50),
VER datetime
)
GO

CREATE TABLE user_auth_list(
USER_AUTH_LIST_OID varchar(32) PRIMARY KEY,
ACCOUNT varchar(20) FOREIGN KEY REFERENCES users(ACCOUNT),
AUTH_CODE varchar(10) FOREIGN KEY REFERENCES user_auth(AUTH_CODE),
VER datetime
)
GO

CREATE TABLE user_act_validate_temp(
ACCOUNT varchar(20) PRIMARY KEY,
VALIDATE_CODE varchar(4),
EXPIRED_TIME datetime
)
GO

--------------------------------------bulletin
CREATE TABLE bulletinClass(
id int primary key IDENTITY(1,1) not null,
name nvarchar(200) UNIQUE not null
)
GO

CREATE TABLE bulletin(
id int primary key IDENTITY(1,1) not null,
title nvarchar(200) not null,
contents nvarchar(MAX) not null,
date datetime not null, 
update_time datetime not null,
class_id int not null FOREIGN KEY REFERENCES bulletinClass(id),
)
GO

--------------------------------------bbs

----------------------------------------------------product

-------------------------------------------------course

----------------------------------------------activity

-----------------------------------------------field
CREATE TABLE fieldType(
id int PRIMARY KEY,
name varchar(30) UNIQUE,
img varbinary(MAX)
)
GO

CREATE TABLE field(
id varchar(30) PRIMARY KEY,
name varchar(30) UNIQUE,
typeId int FOREIGN KEY REFERENCES fieldType(id),
position varchar(30),
rentForMember int,
rentForAct int,
situation int,
remark varchar(50),
buildDate varchar(30),
createDate datetime,
updateDate datetime,
)
GO

CREATE TABLE fieldMemberOrder(
id int PRIMARY KEY IDENTITY(1,1),
account varchar(20) FOREIGN KEY REFERENCES users(ACCOUNT),
createTime datetime,
updateTime datetime,
paymentMethod varchar(20),
paymentStatus int,
attendance int,
orderStatus int,
remark varchar(50)
)
GO

CREATE TABLE fieldActOrder(
id int PRIMARY KEY IDENTITY(1,1),
courseId int FOREIGN KEY REFERENCES course(courseId),
actId int FOREIGN KEY REFERENCES activity(actId),
createTime datetime,
updateTime datetime,
paymentMethod varchar(20),
paymentStatus int,
orderStatus int,
remark varchar(50)
)
GO

CREATE TABLE fieldPeriod(
id int PRIMARY KEY,
period varchar(50)
)
GO

CREATE TABLE fieldOrderDetail(
id int PRIMARY KEY IDENTITY(1,1),
memberOrderId int FOREIGN KEY REFERENCES fieldMemberOrder(id),
actOrderId int FOREIGN KEY REFERENCES fieldActOrder(id),
fieldId varchar(30) FOREIGN KEY REFERENCES field(id),
date date,
periodId int FOREIGN KEY REFERENCES fieldPeriod(id)
)
GO

CREATE TABLE fieldItem(
id int PRIMARY KEY IDENTITY(1,1),
name varchar(30) UNIQUE,
typeId int FOREIGN KEY REFERENCES fieldType(id),
img varbinary(MAX),
rentForMember int,
rentForAct int,
amount int,
situation int,
remark varchar(50)
)
GO

CREATE TABLE fieldItemOrder(
id int PRIMARY KEY IDENTITY(1,1),
fieldMemberOrderId int FOREIGN KEY REFERENCES fieldMemberOrder(id),
fieldActOrderId int FOREIGN KEY REFERENCES fieldActOrder(id),
createTime datetime,
updateTime datetime
)
GO

CREATE TABLE fieldItemOrderDetail(
id int PRIMARY KEY IDENTITY(1,1),
itemId int FOREIGN KEY REFERENCES fieldItem(id),
amount int,
date date,
periodId int FOREIGN KEY REFERENCES fieldPeriod(id)
)
GO