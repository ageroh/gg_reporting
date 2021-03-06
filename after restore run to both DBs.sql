

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
		FROM [ContentDB_165].dbo.ValueString 
		INNER JOIN [ContentDB_165].dbo.Section_Attribute 
			ON satID = avaSatID
		WHERE (avaEntityID = @iEntityID) 
			AND (avaLanguageID = @iLanguageID) 
			AND (satAttributeID = @satAttributeID)
	RETURN @retval
END
GO

/****** Object:  UserDefinedFunction [dbo].[getValueText_ARG]    Script Date: 11/18/2014 18:08:24 ******/
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
		FROM [ContentDB_165].dbo.ValueText 
		INNER JOIN [ContentDB_165].dbo.Section_Attribute 
			ON satID = avaSatID
		WHERE (avaEntityID = @iEntityID) 
			AND (avaLanguageID = @iLanguageID) 
			AND (satAttributeID = @satAttributeID)
	RETURN @retval
END

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










