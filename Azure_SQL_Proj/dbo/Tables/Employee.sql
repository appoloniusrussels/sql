CREATE TABLE [dbo].[Employee] (
    [Emp_Id]    INT            NOT NULL,
    [Emp_Name]  NVARCHAR (100) NOT NULL,
    [Emp_Role]  NVARCHAR (100) NOT NULL,
    [ReportsTo] INT            NULL,
    PRIMARY KEY CLUSTERED ([Emp_Id] ASC)
);
GO

