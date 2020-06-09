CREATE PROC [dbo].[im_write_watermark] @LastModifiedtime [datetime],@TableName [varchar](50) AS

BEGIN

INSERT INTO im_watermarktable values (@TableName,@LastModifiedtime)

END