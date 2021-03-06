USE master
GO
ALTER DATABASE [ContentDB_165_One_Month_Ago] SET SINGLE_USER WITH ROLLBACK IMMEDIATE  

RESTORE DATABASE [ContentDB_165_One_Month_Ago] 
FROM  DISK = N'C:\tempBackups\ContentDB_165_One_Month_Ago.bak' 
WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
GO

USE master
GO
ALTER DATABASE [ContentDB_165_Two_Months_Ago] SET SINGLE_USER WITH ROLLBACK IMMEDIATE  

RESTORE DATABASE [ContentDB_165_Two_Months_Ago] 
FROM  DISK = N'C:\tempBackups\ContentDB_165_Two_Months_Ago.bak' 
WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
GO






USE [ContentDB_165_Two_Months_Ago]
GO 

/****** Object:  UserDefinedFunction [dbo].[getValueString_ARG]    Script Date: 03/05/2015 18:52:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getValueString_ARG]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[getValueString_ARG]
GO


/****** Object:  UserDefinedFunction [dbo].[getValueString_ARG]    Script Date: 11/18/2014 18:08:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getValueString_ARG]( @iEntityID int, @satAttributeID int, @iLanguageID int ) 
RETURNS varchar(1000) AS  
BEGIN
	DECLARE @retval varchar(1000)
	set @retval = ''
	SELECT TOP 1 @retval = left(avaValue, 1000) 
		FROM ValueString 
		INNER JOIN Section_Attribute 
			ON satID = avaSatID
		WHERE (avaEntityID = @iEntityID) 
			AND (avaLanguageID = @iLanguageID) 
			AND (satAttributeID = @satAttributeID)
	RETURN @retval
END	

GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getValueText_ARG]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[getValueText_ARG]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getValueText_ARG]( @iEntityID int, @satAttributeID int, @iLanguageID int ) 
RETURNS varchar(8000) AS  
BEGIN
	DECLARE @retval varchar(8000)
	set @retval = ''
	SELECT TOP 1 @retval = left(avaValue, 8000) 
		FROM ValueText 
		INNER JOIN Section_Attribute 
			ON satID = avaSatID
		WHERE (avaEntityID = @iEntityID) 
			AND (avaLanguageID = @iLanguageID) 
			AND (satAttributeID = @satAttributeID)
	RETURN @retval
END



GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WordCount]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[WordCount]
GO

/****** Object:  UserDefinedFunction [dbo].[WordCount]    Script Date: 11/18/2014 18:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[WordCount] ( @InputString VARCHAR(4000) ) 
RETURNS INT
AS
BEGIN

DECLARE @Index          INT
DECLARE @Char           CHAR(1)
DECLARE @PrevChar       CHAR(1)
DECLARE @WordCount      INT

SET @Index = 1
SET @WordCount = 0

WHILE @Index <= LEN(@InputString)
BEGIN
    SET @Char     = SUBSTRING(@InputString, @Index, 1)
    SET @PrevChar = CASE WHEN @Index = 1 THEN ' '
                         ELSE SUBSTRING(@InputString, @Index - 1, 1)
                    END

    IF @PrevChar = ' ' AND @Char != ' '
        SET @WordCount = @WordCount + 1

    SET @Index = @Index + 1
END

RETURN @WordCount

END

GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[udfTrim]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[udfTrim]
GO


/****** Object:  UserDefinedFunction [dbo].[udfTrim]    Script Date: 03/05/2015 18:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udfTrim] 
(
	@StringToClean as varchar(8000)
)
RETURNS varchar(8000)
AS
BEGIN	
	--Replace all non printing whitespace characers with Characer 32 whitespace
	--NULL
	Set @StringToClean = Replace(@StringToClean,CHAR(0),CHAR(32));
	--Horizontal Tab
	Set @StringToClean = Replace(@StringToClean,CHAR(9),CHAR(32));
	--Line Feed
	Set @StringToClean = Replace(@StringToClean,CHAR(10),CHAR(32));
	--Vertical Tab
	Set @StringToClean = Replace(@StringToClean,CHAR(11),CHAR(32));
	--Form Feed
	Set @StringToClean = Replace(@StringToClean,CHAR(12),CHAR(32));
	--Carriage Return
	Set @StringToClean = Replace(@StringToClean,CHAR(13),CHAR(32));
	--Column Break
	Set @StringToClean = Replace(@StringToClean,CHAR(14),CHAR(32));
	--Non-breaking space
	Set @StringToClean = Replace(@StringToClean,CHAR(160),CHAR(32));
 
	Set @StringToClean = LTRIM(RTRIM(@StringToClean));
	Return @StringToClean
END

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDF_Word_Count_From_String]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDF_Word_Count_From_String]
GO



/****** Object:  UserDefinedFunction [dbo].[UDF_Word_Count_From_String]    Script Date: 03/05/2015 18:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[UDF_Word_Count_From_String]
(
 @STRING VARCHAR(MAX) -- Variable for string
)
RETURNS VARCHAR(MAX)
BEGIN
 
    DECLARE @RETURNSTRING AS VARCHAR(MAX)
 
    Set @STRING=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@STRING
    ,CHAR(9),CHAR(32))
    ,CHAR(13),CHAR(32))
    ,CHAR(10),CHAR(32))
    ,CHAR(32),'øù')
    ,'ùø','')
    ,'øù',CHAR(32))
    SELECT @RETURNSTRING =LEN(@String) - LEN(REPLACE(@String,' ', '')) + 1
RETURN @RETURNSTRING
END

GO











USE [ContentDB_165_One_Month_Ago]
GO 

/****** Object:  UserDefinedFunction [dbo].[getValueString_ARG]    Script Date: 03/05/2015 18:52:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getValueString_ARG]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[getValueString_ARG]
GO


/****** Object:  UserDefinedFunction [dbo].[getValueString_ARG]    Script Date: 11/18/2014 18:08:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getValueString_ARG]( @iEntityID int, @satAttributeID int, @iLanguageID int ) 
RETURNS varchar(1000) AS  
BEGIN
	DECLARE @retval varchar(1000)
	set @retval = ''
	SELECT TOP 1 @retval = left(avaValue, 1000) 
		FROM ValueString 
		INNER JOIN Section_Attribute 
			ON satID = avaSatID
		WHERE (avaEntityID = @iEntityID) 
			AND (avaLanguageID = @iLanguageID) 
			AND (satAttributeID = @satAttributeID)
	RETURN @retval
END	

GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getValueText_ARG]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[getValueText_ARG]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getValueText_ARG]( @iEntityID int, @satAttributeID int, @iLanguageID int ) 
RETURNS varchar(8000) AS  
BEGIN
	DECLARE @retval varchar(8000)
	set @retval = ''
	SELECT TOP 1 @retval = left(avaValue, 8000) 
		FROM ValueText 
		INNER JOIN Section_Attribute 
			ON satID = avaSatID
		WHERE (avaEntityID = @iEntityID) 
			AND (avaLanguageID = @iLanguageID) 
			AND (satAttributeID = @satAttributeID)
	RETURN @retval
END



GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WordCount]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[WordCount]
GO

/****** Object:  UserDefinedFunction [dbo].[WordCount]    Script Date: 11/18/2014 18:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[WordCount] ( @InputString VARCHAR(4000) ) 
RETURNS INT
AS
BEGIN

DECLARE @Index          INT
DECLARE @Char           CHAR(1)
DECLARE @PrevChar       CHAR(1)
DECLARE @WordCount      INT

SET @Index = 1
SET @WordCount = 0

WHILE @Index <= LEN(@InputString)
BEGIN
    SET @Char     = SUBSTRING(@InputString, @Index, 1)
    SET @PrevChar = CASE WHEN @Index = 1 THEN ' '
                         ELSE SUBSTRING(@InputString, @Index - 1, 1)
                    END

    IF @PrevChar = ' ' AND @Char != ' '
        SET @WordCount = @WordCount + 1

    SET @Index = @Index + 1
END

RETURN @WordCount

END

GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[udfTrim]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[udfTrim]
GO


/****** Object:  UserDefinedFunction [dbo].[udfTrim]    Script Date: 03/05/2015 18:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udfTrim] 
(
	@StringToClean as varchar(8000)
)
RETURNS varchar(8000)
AS
BEGIN	
	--Replace all non printing whitespace characers with Characer 32 whitespace
	--NULL
	Set @StringToClean = Replace(@StringToClean,CHAR(0),CHAR(32));
	--Horizontal Tab
	Set @StringToClean = Replace(@StringToClean,CHAR(9),CHAR(32));
	--Line Feed
	Set @StringToClean = Replace(@StringToClean,CHAR(10),CHAR(32));
	--Vertical Tab
	Set @StringToClean = Replace(@StringToClean,CHAR(11),CHAR(32));
	--Form Feed
	Set @StringToClean = Replace(@StringToClean,CHAR(12),CHAR(32));
	--Carriage Return
	Set @StringToClean = Replace(@StringToClean,CHAR(13),CHAR(32));
	--Column Break
	Set @StringToClean = Replace(@StringToClean,CHAR(14),CHAR(32));
	--Non-breaking space
	Set @StringToClean = Replace(@StringToClean,CHAR(160),CHAR(32));
 
	Set @StringToClean = LTRIM(RTRIM(@StringToClean));
	Return @StringToClean
END

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDF_Word_Count_From_String]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDF_Word_Count_From_String]
GO



/****** Object:  UserDefinedFunction [dbo].[UDF_Word_Count_From_String]    Script Date: 03/05/2015 18:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[UDF_Word_Count_From_String]
(
 @STRING VARCHAR(MAX) -- Variable for string
)
RETURNS VARCHAR(MAX)
BEGIN
 
    DECLARE @RETURNSTRING AS VARCHAR(MAX)
 
    Set @STRING=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@STRING
    ,CHAR(9),CHAR(32))
    ,CHAR(13),CHAR(32))
    ,CHAR(10),CHAR(32))
    ,CHAR(32),'øù')
    ,'ùø','')
    ,'øù',CHAR(32))
    SELECT @RETURNSTRING =LEN(@String) - LEN(REPLACE(@String,' ', '')) + 1
RETURN @RETURNSTRING
END

GO








