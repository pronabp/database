CREATE TABLE [ctrl].[azure_storage] (
    [azure_stor_key]             INT           IDENTITY (1, 1) NOT NULL,
    [azure_stor_root]            VARCHAR (255) NULL,
    [azure_stor_sub_folder_name] VARCHAR (255) NULL,
    [azure_stor_filename]        VARCHAR (255) NULL,
    [azure_stor_for]             VARCHAR (255) NULL,
    [azure_stor_type]            VARCHAR (255) NULL,
    [azure_stor_comment]         VARCHAR (255) DEFAULT ('blob storage path') NULL,
    [azure_stor_is_active]       BIT           DEFAULT ((1)) NOT NULL,
    [azure_ref_key_id]           INT           DEFAULT ((0)) NULL,
    CONSTRAINT [PK_azure_storage_azure_stor_key] PRIMARY KEY NONCLUSTERED ([azure_stor_key] ASC) NOT ENFORCED
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

