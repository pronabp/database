CREATE PROC [dbo].[SP_UPDATE_STORAGE_FILENAME] @StorageKey [int],@FileName [varchar](500) AS
BEGIN
UPDATE ctrl.azure_storage set azure_stor_filename=@FileName where azure_stor_key=@StorageKey
END