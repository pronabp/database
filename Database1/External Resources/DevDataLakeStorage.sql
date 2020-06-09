CREATE EXTERNAL DATA SOURCE [DevDataLakeStorage]
    WITH (
    TYPE = HADOOP,
    LOCATION = N'abfss://adhoc@egausimdevadlsg2.dfs.core.windows.net',
    CREDENTIAL = [egausimdevadlsg2]
    );

