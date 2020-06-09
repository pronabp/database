CREATE TABLE [dbo].[im_watermarktable] (
    [TableName]      VARCHAR (255) NULL,
    [WatermarkValue] DATETIME      NULL,
    CONSTRAINT [unique_im_watermarktable_TableName] UNIQUE NONCLUSTERED ([TableName] ASC) NOT ENFORCED
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

