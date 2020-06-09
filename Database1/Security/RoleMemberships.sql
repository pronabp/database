EXECUTE sp_addrolemember @rolename = N'xlargerc', @membername = N'LoadUser';


GO
EXECUTE sp_addrolemember @rolename = N'db_owner', @membername = N'LoadUser';


GO
EXECUTE sp_addrolemember @rolename = N'db_datareader', @membername = N'LoadUser';


GO
EXECUTE sp_addrolemember @rolename = N'xlargerc', @membername = N'TestUser';


GO
EXECUTE sp_addrolemember @rolename = N'db_datareader', @membername = N'TestUser';


GO
EXECUTE sp_addrolemember @rolename = N'db_datawriter', @membername = N'TestUser';


GO
EXECUTE sp_addrolemember @rolename = N'db_ddladmin', @membername = N'DevUser';


GO
EXECUTE sp_addrolemember @rolename = N'db_datareader', @membername = N'DevUser';


GO
EXECUTE sp_addrolemember @rolename = N'db_datawriter', @membername = N'DevUser';

