CREATE TABLE [meta].[Card_Group] (
    [card_type]        VARCHAR (50)  NULL,
    [card_bucket]      VARCHAR (50)  NULL,
    [Source_name]      VARCHAR (50)  NULL,
    [Source_file_Name] VARCHAR (100) NULL,
    [Load_date]        DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

