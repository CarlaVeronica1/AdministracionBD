use CreacionDatabase;
create procedure CreacionLogin6
@loginname nvarchar(50),
@password nvarchar(50),
@databasename nvarchar(50)
as
BEGIN
	DECLARE @SQL NVARCHAR(MAX);
if  exists(SELECT name FROM master.sys.sql_logins 
    WHERE name =@loginname)
	begin
	return -1
	end
else 
	begin
-- Create dynamic SQL for database creation
    SET @SQL = 'use '+@databasename+'; create login ' + @loginname + ' with password='''+@password+'''
				';

    -- Print the SQL for debugging
    PRINT @SQL;

    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL;
	
	return 0 --'database created' 
	end;
END;


create procedure CreacionLoginYUser2
@loginname nvarchar(50),
@username nvarchar(50),
@password nvarchar(50),
@databasename nvarchar(50)
as
BEGIN
	DECLARE @SQL NVARCHAR(MAX);
if  exists(SELECT name FROM master.sys.sql_logins 
    WHERE name =@loginname)
	begin
	return -1
	end
else 
	begin
-- Create dynamic SQL for database creation
    SET @SQL = 'use '+@databasename+';  create login ' + @loginname + ' with password='''+@password+';''
				create user ' +@username+ ' for login '+ @loginname+ ';' ;

    -- Print the SQL for debugging
    PRINT @SQL;

    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL;
	
	return 0 --'database created' 
	end;
END;



EXEC CreacionLogin5
    @loginname = 'Otro',
	@password = '1234'
	use master;


create procedure CreacionUsuarioBd12
@loginname nvarchar(50),
@username nvarchar(50),
@databasename nvarchar(50)
as
BEGIN
	DECLARE @SQL NVARCHAR(MAX);
	DECLARE @SQL2 nvarchar(max);
if  exists(SELECT name FROM master.sys.sql_logins 
    WHERE name =@loginname)
	begin
	SET @SQL2 ='use '+@databasename+'';
	exec sp_executesql @SQL2;
		if exists( SELECT name from sys.sysusers where name=@username)
			begin
				return 2
			end
		else 
			begin
	-- Create dynamic SQL for user creation
				 SET @SQL = 'use '+@databasename+'; create user ' +@username+ ' for login '+ @loginname+ ';' ;

    -- Print the SQL for debugging
			    PRINT @SQL;

    -- Execute the dynamic SQL
			    EXEC sp_executesql @SQL;
	
				return 0 --'user created'
			end
	end
else begin
	return -1
	end;
END;


use CreacionDatabase;

create procedure AplicarRoles15
@permiso nvarchar(50),
@login nvarchar(50),
@database nvarchar(50),
@delete nvarchar(50),
@insert nvarchar(50),
@create nvarchar(50),
@select nvarchar(50)
as
BEGIN
	DECLARE @SQL NVARCHAR(MAX);
	
-- Create dynamic SQL for database creation
    SET @SQL = 'use '+@database+'; 
		GRANT ALTER ANY SCHEMA to '+@login+'; 
		if ('+ @permiso +'=''grant'' ) 
		begin
			if '+@delete+'= ''true'' 
			begin '+ @permiso +' delete to '+@login+' end;
			if '+@insert+'=''true''  
			begin '+ @permiso +' insert to '+@login+' 	end;
			if '+@create+'=''true''  
			begin '+ @permiso +' create table to '+@login+' end;
			if '+@select+'=''true'' 
			begin '+ @permiso +' select to '+@login+' end;
		end
		else
		begin
			if ('+ @permiso +'=''deny'') 
			begin
				if '+@delete+'=''true''  
					begin '+ @permiso +' delete to '+@login+'  end;
				if '+@insert+'=''true''  
					begin '+ @permiso +' insert to '+@login+'  end;
				if '+@create+'=''true''	
					begin '+ @permiso +' create table to '+@login+' end;
				if '+@select+'=''true'' 
					begin '+ @permiso +' select to '+@login+'  end;
			end
			else ('+ @permiso +'=''revoke'' )
			begin
				if '+@delete+'=''true'' 
					begin '+ @permiso +' delete to '+@login+'  end;
				if '+@insert+'=''true'' 
					begin '+ @permiso +' insert to '+@login+' end;
				if '+@create+'='' true''
					begin '+ @permiso +' create table to '+@login+' end;
				if '+@select+'=''true'' 
					begin '+ @permiso +' select to '+@login+' end;
			end;
		end;
		';
    -- Print the SQL for debugging
    PRINT @SQL;
    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL;
	return 0 --'permisos creados' 
END;


exec AplicarRoles17
@permiso ='grant',
@login ='Paquito',
@database ='inventario',
@delete ='',
@insert ='true',
@create ='',
@select ='true'

EXEC CreacionBaseDeDatos8
    @databasename = 'OtroDB4',
	@databasedataname = 'TOtroDB4',
	@databasefilename  = 'C:\SQLData\',
@databasesize  = '100',
@filegrowthdb  = '10',
@databaselogname  = 'TrotoDB4',
@databaselogfilename  = 'C:\SQLData\',
@databaselogsize  = '50',
@filegrowthlog  = '5'




use CreacionDatabase;

create procedure AplicarRoles17
@permiso nvarchar(50),
@login nvarchar(50),
@database nvarchar(50),
@delete nvarchar(50),
@insert nvarchar(50),
@create nvarchar(50),
@select nvarchar(50)
as
BEGIN
	DECLARE @SQL NVARCHAR(MAX);
	
-- Create dynamic SQL for database creation
   SET @SQL = 'USE ' + QUOTENAME(@database) + '; 
        GRANT ALTER ANY SCHEMA TO ' + QUOTENAME(@login) + '; 
        IF (''' + @permiso + ''' = ''grant'') 
        BEGIN
            IF (''' + @delete + ''' = ''true'') 
            BEGIN
                GRANT DELETE TO ' + QUOTENAME(@login) + ';
            END;
            IF (''' + @insert + ''' = ''true'') 
            BEGIN
                GRANT INSERT TO ' + QUOTENAME(@login) + ';
            END;
            IF (''' + @create + ''' = ''true'') 
            BEGIN
                GRANT CREATE TABLE TO ' + QUOTENAME(@login) + ';
            END;
            IF (''' + @select + ''' = ''true'') 
            BEGIN
                GRANT SELECT TO ' + QUOTENAME(@login) + ';
            END;
        END
        ELSE IF (''' + @permiso + ''' = ''deny'')
        BEGIN
            IF (''' + @delete + ''' = ''true'') 
            BEGIN
                DENY DELETE TO ' + QUOTENAME(@login) + ';
            END;
            IF (''' + @insert + ''' = ''true'') 
            BEGIN
                DENY INSERT TO ' + QUOTENAME(@login) + ';
            END;
            IF (''' + @create + ''' = ''true'') 
            BEGIN
                DENY CREATE TABLE TO ' + QUOTENAME(@login) + ';
            END;
            IF (''' + @select + ''' = ''true'') 
            BEGIN
                DENY SELECT TO ' + QUOTENAME(@login) + ';
            END;
        END
        ELSE IF (''' + @permiso + ''' = ''revoke'')
        BEGIN
            IF (''' + @delete + ''' = ''true'') 
            BEGIN
                REVOKE DELETE FROM ' + QUOTENAME(@login) + ';
            END;
            IF (''' + @insert + ''' = ''true'') 
            BEGIN
                REVOKE INSERT FROM ' + QUOTENAME(@login) + ';
            END;
            IF (''' + @create + ''' = ''true'') 
            BEGIN
                REVOKE CREATE TABLE FROM ' + QUOTENAME(@login) + ';
            END;
            IF (''' + @select + ''' = ''true'') 
            BEGIN
                REVOKE SELECT FROM ' + QUOTENAME(@login) + ';
            END;
        END;
    ';
    -- Print the SQL for debugging
    PRINT @SQL;
    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL;
	return 0 --'permisos creados' 
END;


CREATE PROCEDURE GetUsers
    @Database NVARCHAR(50)
AS
BEGIN
DECLARE @SQL NVARCHAR(MAX);

set @SQL='	use' +quotename(@Database)+ ';
     SELECT name,createdate from sys.sysusers where altuid is null';
	  PRINT @SQL;
    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL;
END;
GO

exec GetUsers
@Database ='inventario'



CREATE PROCEDURE SetDefaultRoles4
    @Database NVARCHAR(50),
	@Rol Nvarchar(50),
	@login nvarchar(50)
AS
BEGIN
DECLARE @SQL NVARCHAR(MAX);

set @SQL='	use ' +@Database+ ';
     exec sp_addrolemember
'''+@Rol+''' , '+@login+' ';
	  PRINT @SQL;
    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL;
END;
GO

EXEC SetDefaultRoles4
@Database='inventario',
@Rol='db_datareader',
@login='Paquito'


exec sp_addrolemember
'db_datareader', DevelopmentUser
