CREATE TABLE [dbo].[STG_TAX_AND_CHARGES] (
    [TaxCharge_Code]        VARCHAR (100) NOT NULL,
    [Type]                  VARCHAR (100) NULL,
    [Sub_Type]              VARCHAR (100) NULL,
    [Name]                  VARCHAR (100) NULL,
    [Applies_On]            VARCHAR (100) NULL,
    [GL]                    VARCHAR (100) NULL,
    [Value]                 VARCHAR (100) NULL,
    [Tax_Type]              VARCHAR (100) NULL,
    [From_Date]             VARCHAR (100) NULL,
    [To_Date]               VARCHAR (100) NULL,
    [Consumption_Tax]       VARCHAR (100) NULL,
    [Tax_Value_for_Purch]   VARCHAR (100) NULL,
    [Calculation_Precision] VARCHAR (100) NULL,
    [Withhold_Liability_GL] VARCHAR (100) NULL,
    [Exported]              VARCHAR (100) NULL,
    [Especifico_Tax]        VARCHAR (100) NULL,
    [Used_Internally]       VARCHAR (100) NULL,
    [ALLOW_LOW_MODIFY]      VARCHAR (100) NULL,
    [ENFORCE_FOR_OS]        VARCHAR (100) NULL,
    [Inventory_Payout]      VARCHAR (100) NULL,
    [Purge]                 VARCHAR (100) NULL,
    [TIMESTAMP]             VARCHAR (100) NULL,
    [Def_Number_Of_Days]    VARCHAR (100) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([TaxCharge_Code]));

