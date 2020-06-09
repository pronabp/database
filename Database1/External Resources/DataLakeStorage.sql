CREATE EXTERNAL DATA SOURCE [DataLakeStorage]
    WITH (
    TYPE = HADOOP,
    LOCATION = N'abfss://egaus-refined-data@egausimdevadlsg2.dfs.core.windows.net',
    CREDENTIAL = [egausimdevadlsg2]
    );

