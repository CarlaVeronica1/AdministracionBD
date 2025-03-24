create or alter proc sp_backupsCompletos
@basededatos nvarchar(50),
@ruta nvarchar(50),
@nombredeBackup nvarchar(50),
@descripcion nvarchar(150)
AS
BEGIN
DECLARE @SQL NVARCHAR(MAX);

set @SQL='	use master;''
     backup database'+ @basededatos+'
	to disk ='+@ruta+' 
	with 
	name ='+@nombredeBackup+',
description='+@descripcion+'
go';
	  PRINT @SQL;
    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL;
END;
GO
