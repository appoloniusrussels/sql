CREATE TABLE [dbo].[sachin_batting_scores] (
    [Match]         SMALLINT      NULL,
    [Innings]       SMALLINT      NULL,
    [match_date]    VARCHAR (50)  NULL,
    [Versus]        NVARCHAR (50) NULL,
    [Ground]        NVARCHAR (50) NULL,
    [How_Dismissed] NVARCHAR (50) NULL,
    [Runs]          TINYINT       NULL,
    [Balls_faced]   TINYINT       NULL,
    [strike_rate]   FLOAT (53)    NULL
);
GO

