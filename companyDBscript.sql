USE [master]
GO
/****** Object:  Database [CompanyDB]    Script Date: 31-10-2020 08:52:27 PM ******/
CREATE DATABASE [CompanyDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CompanyDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\CompanyDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CompanyDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\CompanyDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CompanyDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CompanyDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CompanyDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CompanyDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CompanyDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CompanyDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CompanyDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CompanyDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CompanyDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CompanyDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CompanyDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CompanyDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CompanyDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CompanyDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CompanyDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CompanyDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CompanyDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CompanyDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CompanyDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CompanyDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CompanyDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CompanyDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CompanyDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CompanyDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CompanyDB] SET RECOVERY FULL 
GO
ALTER DATABASE [CompanyDB] SET  MULTI_USER 
GO
ALTER DATABASE [CompanyDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CompanyDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CompanyDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CompanyDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CompanyDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CompanyDB', N'ON'
GO
ALTER DATABASE [CompanyDB] SET QUERY_STORE = OFF
GO
USE [CompanyDB]
GO
/****** Object:  UserDefinedFunction [dbo].[TotalEmpSalary]    Script Date: 31-10-2020 08:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[TotalEmpSalary](@month varchar(20))  
RETURNS int   
AS   
-- Returns the total salary of all employee.  
BEGIN  
    DECLARE @ret int;  
    SELECT @ret = SUM(s.EMPSAL)   
    FROM SALARY s   
    WHERE s.SAL_MONTH = @month;  
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret;  
END; 
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 31-10-2020 08:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmpId] [int] IDENTITY(1,1) NOT NULL,
	[ENAME] [varchar](20) NOT NULL,
	[JOB] [varchar](20) NOT NULL,
	[EMAIL] [varchar](20) NOT NULL,
	[BIRTHdATE] [date] NULL,
	[HIREDATE] [date] NOT NULL,
	[DEPTNo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALARY]    Script Date: 31-10-2020 08:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALARY](
	[SALARYId] [int] IDENTITY(1,1) NOT NULL,
	[SAL_MONTH] [varchar](20) NOT NULL,
	[EMPSAL] [money] NULL,
	[EmpId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SALARYId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[EmpSalaryInfo]    Script Date: 31-10-2020 08:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EmpSalaryInfo]
AS
select e.EmpId, e.ENAME,
e.JOB,e.EMAIL,s.SAL_MONTH,s.EMPSAL 
from Employee e inner join SALARY s 
ON e.EmpId =s.EmpId;
GO
/****** Object:  Table [dbo].[DEPT]    Script Date: 31-10-2020 08:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEPT](
	[DEPTNO] [int] IDENTITY(1,1) NOT NULL,
	[DNAME] [varchar](20) NULL,
	[LOC] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[DEPTNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALGRADE]    Script Date: 31-10-2020 08:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALGRADE](
	[GRADEId] [int] IDENTITY(1,1) NOT NULL,
	[GRADE] [int] NOT NULL,
	[LOSAL] [money] NULL,
	[HISAL] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[GRADEId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[DEPT] ON 

INSERT [dbo].[DEPT] ([DEPTNO], [DNAME], [LOC]) VALUES (1, N'ACCOUNTING', N'NEW YORK')
INSERT [dbo].[DEPT] ([DEPTNO], [DNAME], [LOC]) VALUES (2, N'RESEARCH', N'DALLAS')
INSERT [dbo].[DEPT] ([DEPTNO], [DNAME], [LOC]) VALUES (3, N'SALES', N'CHICAGO')
INSERT [dbo].[DEPT] ([DEPTNO], [DNAME], [LOC]) VALUES (4, N'OPERATIONS', N'BOSTON')
INSERT [dbo].[DEPT] ([DEPTNO], [DNAME], [LOC]) VALUES (5, N'MECHETRONICS', N'JAPAN')
INSERT [dbo].[DEPT] ([DEPTNO], [DNAME], [LOC]) VALUES (6, N'COMPUTER', N'new jersey')
SET IDENTITY_INSERT [dbo].[DEPT] OFF
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([EmpId], [ENAME], [JOB], [EMAIL], [BIRTHdATE], [HIREDATE], [DEPTNo]) VALUES (2, N'SMITH', N'CLERK', N'smit@gmail.com', CAST(N'1992-03-12' AS Date), CAST(N'2019-01-01' AS Date), 2)
INSERT [dbo].[Employee] ([EmpId], [ENAME], [JOB], [EMAIL], [BIRTHdATE], [HIREDATE], [DEPTNo]) VALUES (4, N'ALLEN', N'SALESMAN', N'P.allen@gmail.com', CAST(N'1993-02-20' AS Date), CAST(N'2019-01-01' AS Date), 3)
INSERT [dbo].[Employee] ([EmpId], [ENAME], [JOB], [EMAIL], [BIRTHdATE], [HIREDATE], [DEPTNo]) VALUES (5, N'WARD', N'SALESMAN', N'w@gmail.com', CAST(N'1993-05-15' AS Date), CAST(N'2019-01-01' AS Date), 3)
INSERT [dbo].[Employee] ([EmpId], [ENAME], [JOB], [EMAIL], [BIRTHdATE], [HIREDATE], [DEPTNo]) VALUES (6, N'JONES', N'MANAGER', N'Jo@gmail.com', CAST(N'1993-04-20' AS Date), CAST(N'2019-01-01' AS Date), 2)
INSERT [dbo].[Employee] ([EmpId], [ENAME], [JOB], [EMAIL], [BIRTHdATE], [HIREDATE], [DEPTNo]) VALUES (7, N'MARTIN', N'SALESMAN', N'marty@gmail.com', CAST(N'1993-06-10' AS Date), CAST(N'2019-01-01' AS Date), 3)
INSERT [dbo].[Employee] ([EmpId], [ENAME], [JOB], [EMAIL], [BIRTHdATE], [HIREDATE], [DEPTNo]) VALUES (8, N'BLAKE', N'MANAGER', N'BL@gmail.com', CAST(N'1993-02-12' AS Date), CAST(N'2019-01-01' AS Date), 3)
INSERT [dbo].[Employee] ([EmpId], [ENAME], [JOB], [EMAIL], [BIRTHdATE], [HIREDATE], [DEPTNo]) VALUES (9, N'CLARK', N'MANAGER', N'clay@gmail.com', CAST(N'1993-08-22' AS Date), CAST(N'2019-01-01' AS Date), 1)
INSERT [dbo].[Employee] ([EmpId], [ENAME], [JOB], [EMAIL], [BIRTHdATE], [HIREDATE], [DEPTNo]) VALUES (10, N'SMITHA', N'CLERK', N'smita@gmail.com', CAST(N'1992-03-12' AS Date), CAST(N'2019-02-01' AS Date), 2)
INSERT [dbo].[Employee] ([EmpId], [ENAME], [JOB], [EMAIL], [BIRTHdATE], [HIREDATE], [DEPTNo]) VALUES (11, N'Abhir', N'SALESMAN', N'Abhir@gmail.com', CAST(N'1992-08-02' AS Date), CAST(N'2019-02-01' AS Date), 3)
INSERT [dbo].[Employee] ([EmpId], [ENAME], [JOB], [EMAIL], [BIRTHdATE], [HIREDATE], [DEPTNo]) VALUES (12, N'Meera', N'SALESMAN', N'Meera@gmail.com', CAST(N'1992-08-12' AS Date), CAST(N'2019-02-01' AS Date), 3)
INSERT [dbo].[Employee] ([EmpId], [ENAME], [JOB], [EMAIL], [BIRTHdATE], [HIREDATE], [DEPTNo]) VALUES (13, N'Luffy', N'MANAGER', N'luffy@gmail.com', CAST(N'1993-07-24' AS Date), CAST(N'2019-02-01' AS Date), 1)
INSERT [dbo].[Employee] ([EmpId], [ENAME], [JOB], [EMAIL], [BIRTHdATE], [HIREDATE], [DEPTNo]) VALUES (15, N'Ganesh Nami', N'CLERK', N'ganesh@gmail.com', CAST(N'1994-12-02' AS Date), CAST(N'2019-05-02' AS Date), 2)
SET IDENTITY_INSERT [dbo].[Employee] OFF
SET IDENTITY_INSERT [dbo].[SALARY] ON 

INSERT [dbo].[SALARY] ([SALARYId], [SAL_MONTH], [EMPSAL], [EmpId]) VALUES (2, N'Jan', 1300.0000, 5)
INSERT [dbo].[SALARY] ([SALARYId], [SAL_MONTH], [EMPSAL], [EmpId]) VALUES (3, N'Jan', 2000.0000, 6)
INSERT [dbo].[SALARY] ([SALARYId], [SAL_MONTH], [EMPSAL], [EmpId]) VALUES (4, N'Jan', 1800.0000, 7)
INSERT [dbo].[SALARY] ([SALARYId], [SAL_MONTH], [EMPSAL], [EmpId]) VALUES (5, N'Jan', 2000.0000, 8)
INSERT [dbo].[SALARY] ([SALARYId], [SAL_MONTH], [EMPSAL], [EmpId]) VALUES (6, N'Jan', 2000.0000, 9)
INSERT [dbo].[SALARY] ([SALARYId], [SAL_MONTH], [EMPSAL], [EmpId]) VALUES (8, N'Jan', 1800.0000, 4)
INSERT [dbo].[SALARY] ([SALARYId], [SAL_MONTH], [EMPSAL], [EmpId]) VALUES (9, N'Jan', 1500.0000, 2)
INSERT [dbo].[SALARY] ([SALARYId], [SAL_MONTH], [EMPSAL], [EmpId]) VALUES (10, N'Feb', 1700.0000, 15)
SET IDENTITY_INSERT [dbo].[SALARY] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [AK_EMAIL]    Script Date: 31-10-2020 08:52:29 PM ******/
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [AK_EMAIL] UNIQUE NONCLUSTERED 
(
	[EMAIL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ix_EMPLOYEE_EMAIL]    Script Date: 31-10-2020 08:52:29 PM ******/
CREATE NONCLUSTERED INDEX [ix_EMPLOYEE_EMAIL] ON [dbo].[Employee]
(
	[EMAIL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([DEPTNo])
REFERENCES [dbo].[DEPT] ([DEPTNO])
GO
ALTER TABLE [dbo].[SALARY]  WITH CHECK ADD FOREIGN KEY([EmpId])
REFERENCES [dbo].[Employee] ([EmpId])
GO
/****** Object:  StoredProcedure [dbo].[spDeleteEmployee]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteEmployee]
	@id int
AS 
BEGIN
If exists(select * from Employee where EmpId = @id)
begin
DELETE FROM Employee where EmpId = @id;
END
End
GO
/****** Object:  StoredProcedure [dbo].[spGetAllDept]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAllDept]
As
BEGIN
Select DEPTNO,DNAME,LOC
from DEPT;
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllEmployee]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAllEmployee]
As
Begin

select e.EmpId,e.ENAME,e.JOB,
e.EMAIL,e.BIRTHdATE,e.HIREDATE,
e.DEPTNo,d.DNAME,d.LOC
from Employee e inner join DEPT d
ON e.DEPTNo = d.DEPTNO;

end
GO
/****** Object:  StoredProcedure [dbo].[spGetAllEmployeeAsPerDate]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAllEmployeeAsPerDate]
@intialDate date,
@endDate date
As
Begin

select e.EmpId,e.ENAME,e.JOB,
e.EMAIL,e.BIRTHdATE,e.HIREDATE,
e.DEPTNo,d.DNAME,d.LOC
from Employee e inner join DEPT d
ON e.DEPTNo = d.DEPTNO
WHERE HIREDATE BETWEEN @intialDate AND @endDate;

end
GO
/****** Object:  StoredProcedure [dbo].[spGetAllSalaryDetail]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAllSalaryDetail]
As
Begin

select e.EmpId,e.ENAME,e.JOB,
s.EMPSAL,s.SAL_MONTH,s.SALARYId
from Employee e inner join SALARY s
ON e.EmpId = s.EmpId;

end
GO
/****** Object:  StoredProcedure [dbo].[spGetAvgSalary]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAvgSalary]
As
Begin
SELECT AVG(EMPSAL) AS AvgSalary
FROM SALARY
end
GO
/****** Object:  StoredProcedure [dbo].[spGetDepartment]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetDepartment]
@id int
As
BEGIN
Select DEPTNO,DNAME,LOC
from DEPT where DEPTNO = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployee]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetEmployee]
@id int
As
Begin

select e.EmpId,e.ENAME,e.JOB,
e.EMAIL,e.BIRTHdATE,e.HIREDATE,
e.DEPTNo,d.DNAME,d.LOC
from Employee e inner join DEPT d
ON e.DEPTNo = d.DEPTNO
where e.EmpId = @id;

end
GO
/****** Object:  StoredProcedure [dbo].[spGetMINSalary]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetMINSalary]
As
Begin
SELECT MIN(EMPSAL) AS MinimumSalary
FROM SALARY
end
GO
/****** Object:  StoredProcedure [dbo].[spRecordSalary]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRecordSalary] 
	-- Add the parameters for the stored procedure here
	@month varchar(20),
	@Salary int,
	@empId int
AS
-- SET XACT_ABORT ON will cause the transaction to be uncommittable  
-- when the constraint violation occurs.   
SET XACT_ABORT ON; 
BEGIN TRY
BEGIN TRANSACTION;
If exists(select * from SALARY where SAL_MONTH = @month and EMPSAL = @Salary and EmpId = @empId)
	RAISERROR('Salary is not able to register due to duplicate email', 11, 1);
ELSE
begin
	INSERT INTO SALARY VALUES(@month,@Salary,@empId);
	COMMIT TRANSACTION;
end
END TRY
BEGIN CATCH
select ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
IF (XACT_STATE()) = -1  
    BEGIN  
        PRINT N'The transaction is in an uncommittable state.' +  'Rolling back transaction.'  
        ROLLBACK TRANSACTION;  
    END;  
    -- Test whether the transaction is committable.
    -- You may want to commit a transaction in a catch block if you want to commit changes 
	-- to statements that ran prior to the error.
IF (XACT_STATE()) = 1  
    BEGIN  
        PRINT  
            N'The transaction is committable.' +  'Committing transaction.'  
        COMMIT TRANSACTION;     
    END;  
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spRegisterDept]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRegisterDept] 
	-- Add the parameters for the stored procedure here
	@DNAME varchar(20),
	@LOC varchar(20)

AS
-- SET XACT_ABORT ON will cause the transaction to be uncommittable  
-- when the constraint violation occurs.   
SET XACT_ABORT ON; 
BEGIN TRY
BEGIN TRANSACTION;
If exists(select * from DEPT where DNAME =@DNAME and LOC = @LOC)
	RAISERROR('Department is not able to register due to duplicate email', 11, 1);
ELSE
begin
	INSERT INTO [dbo].[DEPT] VALUES(@DNAME,@LOC);
	COMMIT TRANSACTION;
end
END TRY
BEGIN CATCH
select ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
IF (XACT_STATE()) = -1  
    BEGIN  
        PRINT N'The transaction is in an uncommittable state.' +  'Rolling back transaction.'  
        ROLLBACK TRANSACTION;  
    END;  
    -- Test whether the transaction is committable.
    -- You may want to commit a transaction in a catch block if you want to commit changes 
	-- to statements that ran prior to the error.
IF (XACT_STATE()) = 1  
    BEGIN  
        PRINT  
            N'The transaction is committable.' +  'Committing transaction.'  
        COMMIT TRANSACTION;     
    END;  
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spRegisterEmp]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRegisterEmp] 
	-- Add the parameters for the stored procedure here
	@name varchar(20),
	@job varchar(20),
	@email varchar(20),
	@birthdate date,
	@hiredate date,
	@DeptNo int

AS
-- SET XACT_ABORT ON will cause the transaction to be uncommittable  
-- when the constraint violation occurs.   
SET XACT_ABORT ON; 
BEGIN TRY
BEGIN TRANSACTION;
If exists(select * from Employee where EMAIL =@email)
	RAISERROR('Employee is not able to register due to duplicate email', 11, 1);
ELSE
begin
	INSERT INTO [dbo].[Employee] VALUES(@name,@job,@email,@birthdate,@hiredate,@DeptNo);
	COMMIT TRANSACTION;
end
END TRY
BEGIN CATCH
select ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
IF (XACT_STATE()) = -1  
    BEGIN  
        PRINT N'The transaction is in an uncommittable state.' +  'Rolling back transaction.'  
        ROLLBACK TRANSACTION;  
    END;  
    -- Test whether the transaction is committable.
    -- You may want to commit a transaction in a catch block if you want to commit changes 
	-- to statements that ran prior to the error.
IF (XACT_STATE()) = 1  
    BEGIN  
        PRINT  
            N'The transaction is committable.' +  'Committing transaction.'  
        COMMIT TRANSACTION;     
    END;  
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spUpdateEmployee]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spUpdateEmployee] 
	-- Add the parameters for the stored procedure here
	@id int,
	@name varchar(20),
	@job varchar(20),
	@email varchar(20),
	@birthdate date,
	@hiredate date,
	@DeptNo int
AS
BEGIN
-- SET XACT_ABORT ON will cause the transaction to be uncommittable  
-- when the constraint violation occurs.   
SET XACT_ABORT ON; 
BEGIN TRY
BEGIN TRANSACTION;
	Update Employee     

   set ENAME = @name, JOB = @job, EMAIL = @email, BIRTHdATE = @birthdate,HIREDATE = @hiredate, 
   DEPTNo = @DeptNo
   where EmpId=@id
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
select ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
IF (XACT_STATE()) = -1  
    BEGIN  
        PRINT N'The transaction is in an uncommittable state.' +  'Rolling back transaction.'  
        ROLLBACK TRANSACTION;  
    END;  
    -- Test whether the transaction is committable.
    -- You may want to commit a transaction in a catch block if you want to commit changes 
	-- to statements that ran prior to the error.
IF (XACT_STATE()) = 1  
    BEGIN  
        PRINT  
            N'The transaction is committable.' +  'Committing transaction.'  
        COMMIT TRANSACTION;     
    END;  
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateEmployeeSalary]    Script Date: 31-10-2020 08:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdateEmployeeSalary] 
	-- Add the parameters for the stored procedure here
	@id int,
	@month varchar(20),
	@salary int,
	@EmpId int
AS
BEGIN
-- SET XACT_ABORT ON will cause the transaction to be uncommittable  
-- when the constraint violation occurs.   
SET XACT_ABORT ON; 
BEGIN TRY
BEGIN TRANSACTION;
	Update SALARY     

   set EMPSAL = @salary
   where SALARYId = @id and SAL_MONTH =@month and EmpId = @EmpId;
   select e.EmpId,e.ENAME,e.JOB,s.EMPSAL,s.SAL_MONTH,s.SALARYId
	from Employee e inner join SALARY s
	ON e.EmpId = s.EmpId where s.SALARYId =@id;
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
select ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
IF (XACT_STATE()) = -1  
    BEGIN  
        PRINT N'The transaction is in an uncommittable state.' +  'Rolling back transaction.'  
        ROLLBACK TRANSACTION;  
    END;  
    -- Test whether the transaction is committable.
    -- You may want to commit a transaction in a catch block if you want to commit changes 
	-- to statements that ran prior to the error.
IF (XACT_STATE()) = 1  
    BEGIN  
        PRINT  
            N'The transaction is committable.' +  'Committing transaction.'  
        COMMIT TRANSACTION;     
    END;  
END CATCH
END
GO
USE [master]
GO
ALTER DATABASE [CompanyDB] SET  READ_WRITE 
GO
USE [CompanyDB]
GO
/****** Object:  Trigger [dbo].[DisplayEmpCount]    Script Date: 31-10-2020 08:56:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[DisplayEmpCount]
ON [dbo].[Employee]
AFTER INSERT
AS
BEGIN
Select count(*) As EmployeeCount From Employee;
End