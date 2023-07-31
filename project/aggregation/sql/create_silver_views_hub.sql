USE gold;
GO
DROP PROCEDURE IF EXISTS create_silver_views;
GO
CREATE PROCEDURE create_silver_views  @silverns varchar(50), @location varchar(200), @extds varchar(50)
AS
BEGIN
    DECLARE @sqlcmd nvarchar(MAX)
    
    -- Drop the external table Customers if it exists
    EXEC sp_executesql N'IF EXISTS (SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID(''Customers''))
                         DROP EXTERNAL TABLE Customers'

    -- Create the external table CustomersInt with the dynamic data_source parameter
    SET @sqlcmd = N'CREATE EXTERNAL TABLE CustomersInt  (Customer_id INTEGER, FirstName VARCHAR(255), LastName VARCHAR(255), DOB VARCHAR(255), updated_at DATETIME, SK VARCHAR(255)) 
        WITH (LOCATION = ''' +  @silverns  + '/835837/Customers'',  data_source = ''' + @extds + ''', FILE_FORMAT = DeltaLakeFormat)';
    
    -- Execute the dynamic SQL statement
    EXEC sp_executesql @sqlcmd;
END;
GO



