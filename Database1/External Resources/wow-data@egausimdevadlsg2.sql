CREATE EXTERNAL DATA SOURCE [wow-data@egausimdevadlsg2]
    WITH (
    TYPE = HADOOP,
    LOCATION = N'abfss://wow-data@egausimdevadlsg2.dfs.core.windows.net',
    CREDENTIAL = [egausimdevadlsg2]
    );

