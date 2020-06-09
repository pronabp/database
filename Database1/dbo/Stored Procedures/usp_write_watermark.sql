CREATE PROC [usp_write_watermark] @LastModifiedtime [datetime],@TableName [varchar](50) AS

BEGIN

	UPDATE watermarktable
	SET [WatermarkValue] = @LastModifiedtime
WHERE [TableName] = @TableName

END