CREATE EXTERNAL DATA SOURCE [DLStorage]
    WITH (
    TYPE = HADOOP,
    LOCATION = N'abfss://eg-data@egausimdevadlsg2.dfs.core.windows.net',
    CREDENTIAL = [egausimdevadlsg2]
    );

