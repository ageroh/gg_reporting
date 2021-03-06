USE [ContentDB_165]
GO

/****** Object:  Trigger [setWordCountINS]    Script Date: 03/11/2015 17:12:59 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[setWordCountINS]'))
DROP TRIGGER [dbo].[setWordCountINS]
GO

USE [ContentDB_165]
GO

/****** Object:  Trigger [dbo].[setWordCountINS]    Script Date: 03/11/2015 17:13:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[setWordCountINS] 
ON [dbo].[ValueString]
AFTER INSERT, UPDATE
AS
BEGIN

	declare @avaID int , @avaValue nvarchar(max)
	set @avaID = (select avaID from inserted)
	set @avaValue = (select avaValue from inserted)
	
	IF NOT EXISTS(
		SELECT avaID
		FROM GG_Reporting.dbo.ValueStringWC
		WHERE avaID = @avaID)
	BEGIN

		INSERT INTO GG_Reporting.dbo.ValueStringWC (avaID, WC)
		SELECT @avaID, GG_Reporting.dbo.[WordCount] ( GG_Reporting.[dbo].[udfTrim] ( @avaValue) )
		
	END
	ELSE
	BEGIN
		UPDATE GG_Reporting.dbo.ValueStringWC 
		SET WC = GG_Reporting.dbo.[WordCount] ( GG_Reporting.[dbo].[udfTrim] ( @avaValue) )
		WHERE avaID = @avaID
	END
	
END

GO





USE [ContentDB_165]
GO

/****** Object:  Trigger [setWordCountValueTextINS]    Script Date: 03/11/2015 17:13:15 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[setWordCountValueTextINS]'))
DROP TRIGGER [dbo].[setWordCountValueTextINS]
GO

USE [ContentDB_165]
GO

/****** Object:  Trigger [dbo].[setWordCountValueTextINS]    Script Date: 03/11/2015 17:13:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[setWordCountValueTextINS] 
	ON [dbo].[ValueText]
AFTER INSERT, UPDATE
AS
BEGIN

	declare @avaID int , @avaValue nvarchar(max)
	set @avaID = (select avaID from inserted)
	set @avaValue = (select avaValue from inserted)
	
	IF NOT EXISTS(
		SELECT avaID
		FROM GG_Reporting.dbo.ValueTextWC
		WHERE avaID = @avaID
	)
	BEGIN
		INSERT INTO GG_Reporting.dbo.ValueTextWC (avaID, WC)
		SELECT @avaID, GG_Reporting.dbo.[WordCount] ( GG_Reporting.[dbo].[udfTrim] ( dbo.[_preparemobiletext](@avaValue)) )
	END
	ELSE
	BEGIN
		UPDATE GG_Reporting.dbo.ValueTextWC 
		SET WC = GG_Reporting.dbo.[WordCount] ( GG_Reporting.[dbo].[udfTrim] ( dbo.[_preparemobiletext](@avaValue)) )
		WHERE avaID = @avaID
	END
	
END

GO



