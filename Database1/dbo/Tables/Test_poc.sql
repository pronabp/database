CREATE TABLE [dbo].[Test_poc] (
    [ID] INT NOT NULL,-- id column
    [Name] varchar 
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([ID]));

