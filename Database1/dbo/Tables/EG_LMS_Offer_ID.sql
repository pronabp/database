CREATE TABLE [dbo].[EG_LMS_Offer_ID] (
    [LMS_Offer_ID]         VARCHAR (100) NULL,
    [External_Offer_ID]    VARCHAR (100) NULL,
    [Campaign_Code]        VARCHAR (100) NULL,
    [StartDate]            DATE          NULL,
    [EndDate]              DATE          NULL,
    [Offer]                VARCHAR (250) NULL,
    [Hurdle]               VARCHAR (300) NULL,
    [Qualifying_Product]   VARCHAR (100) NULL,
    [Applicable_Sites]     VARCHAR (100) NULL,
    [ServiceWOW#]          VARCHAR (100) NULL,
    [LMS_Completed]        VARCHAR (100) NULL,
    [Campaign_Description] VARCHAR (300) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

