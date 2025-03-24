create database CreacionDatabase;
use CreacionDatabase;
create table BasedeDatos(
id int not null identity(1,1),
nombre varchar(15)
);


create procedure CreacionBaseDeDatos8
@databasename nvarchar(50),
@databasedataname nvarchar(50),
@databasefilename nvarchar(100),
@databasesize nvarchar(50),
@filegrowthdb nvarchar(50),
@databaselogname nvarchar(50),
@databaselogfilename nvarchar(100),
@databaselogsize nvarchar(50),
@filegrowthlog nvarchar(50)
as
BEGIN
	DECLARE @SQL NVARCHAR(MAX);
if  exists(SELECT name FROM master.dbo.sysdatabases 
    WHERE name =@databasename)
	begin
	select 'database name already exists'
	end
else 
	begin
-- Create dynamic SQL for database creation
    SET @SQL = 'CREATE DATABASE ' + QUOTENAME(@databasename) + ' 
                ON
                PRIMARY (
                    NAME = ''' + @databasedataname + '_Data'', 
                    FILENAME = ''' + @databasefilename +@databasename +'_Data.mdf'', 
                    SIZE = '+ @databasesize+ 'MB, 
                    FILEGROWTH = '+@filegrowthdb + 'MB
                )
                LOG ON (
                    NAME = ''' + @databaselogname + '_Log'', 
                    FILENAME = ''' + @databaselogfilename +@databasename + '_Log.ldf'', 
                    SIZE = ' + @databaselogsize + 'MB, 
                    FILEGROWTH = ' +@filegrowthlog + 'MB
                )';

    -- Print the SQL for debugging
    PRINT @SQL;

    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL;
	insert into BasedeDatos values (@databasename);
	select 'database created' 
	end;
END;


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

select * from BasedeDatos;


SELECT name FROM master.dbo.sysdatabases