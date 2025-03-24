use CreacionDatabase;

create or alter procedure sp_backupsCompletos3
@basededatos nvarchar(50),
@ruta nvarchar(50),
@nombredeBackup nvarchar(50),
@descripcion nvarchar(150)
AS
BEGIN
DECLARE @SQL NVARCHAR(MAX);

set @SQL='	use master; 
	backup database '+ @basededatos+'
	to disk = '''+@ruta+'/backup'+@basededatos+'.bak'' 
	with 
	name = '''+@nombredeBackup+''',
description= '''+@descripcion+'''';
	  PRINT @SQL;
    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL;
END;
GO

exec sp_backupsCompletos3
@basededatos ='Northwind',
@ruta ='C:\Users\keita\OneDrive\Escritorio',
@nombredeBackup ='Northwincito',
@descripcion ='gjhgjh'
