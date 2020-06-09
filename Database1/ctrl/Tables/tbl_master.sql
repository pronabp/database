CREATE TABLE [ctrl].[tbl_master] (
    [tbl_key]                   INT           IDENTITY (1, 1) NOT NULL,
    [tbl_schema]                VARCHAR (255) NULL,
    [tbl_name]                  VARCHAR (255) NULL,
    [tbl_type]                  VARCHAR (255) NULL,
    [tbl_db_name]               VARCHAR (255) NULL,
    [tbl_comment]               VARCHAR (255) DEFAULT ('dimension table') NULL,
    [tbl_is_active]             BIT           DEFAULT ((1)) NOT NULL,
    [tbl_ref_key_id]            INT           DEFAULT ((0)) NULL,
    [tbl_timestamp_column_name] VARCHAR (255) NULL,
    CONSTRAINT [PK_tbl_master_tbl_key] PRIMARY KEY NONCLUSTERED ([tbl_key] ASC) NOT ENFORCED
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

