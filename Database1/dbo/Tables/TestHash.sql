CREATE TABLE [dbo].[TestHash] (
    [id]       INT          NOT NULL,
    [lastName] VARCHAR (20) NULL,
    [zipCode]  VARCHAR (6)  NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([id]), PARTITION([lastName] RANGE FOR VALUES ('c1', 'c2''c3', 'c4')));

