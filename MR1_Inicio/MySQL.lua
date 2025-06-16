-- MR1_Inicio
-- Gestiona la DB de la GM
-- Autor: ElTitoJet
-- Fecha: 11/02/2024

-- Variables Globales y Configuración
-- Funciones Auxiliares
    function getDBConnection()
        return DBConnection
    end
-- Funciones Principales 
    function query(...)
        --iprint("QUERY")
        --iprint(...)
        local queryHandle = dbQuery(DBConnection, ...)
        if (not queryHandle) then
            return nil
        end
        local rows = dbPoll(queryHandle, -1)
        return rows
    end
    function execute(...)
        --iprint("EXECUTE")
        --iprint(...)
        local queryHandle = dbQuery(DBConnection, ...)
        local result, numRows, last_insert_id = dbPoll(queryHandle, -1)
        return numRows, last_insert_id
    end
-- Eventos y Handlers
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
    addEventHandler("onResourceStart", resourceRoot, function(resource)
        DBConnection = dbConnect( "mysql", "dbname=MTAMireonRP;host=127.0.0.1;charset=utf8", "MtA_MiRe0n_R0l3pl4aY", ".5S|54^-O#irC@w1" )
        if (not DBConnection) then
            outputDebugString("Error: Failed to establish connection to the MySQL database server")
        else
            outputDebugString("Success: Connected to the MySQL database server")
        end
    end)