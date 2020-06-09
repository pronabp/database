CREATE TABLE [dbo].[PURCHASE_ORDER] (
    [Purchase_Order]     VARCHAR (20)    NULL,
    [Supplier]           VARCHAR (20)    NULL,
    [Order_Date]         DATE            NULL,
    [Date_Wanted]        DATE            NULL,
    [Line_Number]        VARCHAR (20)    NULL,
    [SKU]                VARCHAR (20)    NULL,
    [Description]        VARCHAR (100)   NULL,
    [Vendor_Attention]   VARCHAR (20)    NULL,
    [Buyer_Emp]          VARCHAR (20)    NULL,
    [Requisition_Emp]    VARCHAR (20)    NULL,
    [Requisition_Number] VARCHAR (20)    NULL,
    [Ship_VIA_Code]      VARCHAR (20)    NULL,
    [Note]               VARCHAR (100)   NULL,
    [Accept_BO]          VARCHAR (20)    NULL,
    [Gross_Amount]       VARCHAR (20)    NULL,
    [Charge_1]           VARCHAR (20)    NULL,
    [Charge_2]           VARCHAR (20)    NULL,
    [Net_Amount]         DECIMAL (20, 4) NULL,
    [Order_Store]        VARCHAR (20)    NULL,
    [Closed_Order]       VARCHAR (10)    NULL,
    [Order_Amended]      VARCHAR (10)    NULL,
    [PO_Printed]         VARCHAR (10)    NULL,
    [Exported]           VARCHAR (10)    NULL,
    [Order_Closed_EDI]   VARCHAR (10)    NULL,
    [EXPORTED_TO_HO]     VARCHAR (10)    NULL,
    [OP_Key]             VARCHAR (10)    NULL,
    [OverMax]            VARCHAR (10)    NULL,
    [Cost]               DECIMAL (20, 4) NULL,
    [Qty_Wanted]         DECIMAL (20, 4) NULL,
    [Qty_Received]       DECIMAL (20, 4) NULL,
    [Delivery_Store]     VARCHAR (20)    NULL,
    [Line_Completed]     VARCHAR (10)    NULL,
    [UOM]                VARCHAR (10)    NULL,
    [MaxOrderQty]        DECIMAL (20, 4) NULL,
    [TIMESTAMP]          DATETIME        NULL,
    [source_file_name]   VARCHAR (200)   NULL,
    [load_date]          DATETIME        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([Purchase_Order]), PARTITION([Order_Date] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));


GO
CREATE NONCLUSTERED INDEX [Supplier_Index]
    ON [dbo].[PURCHASE_ORDER]([Supplier] ASC);

