-- MR2_Cuentas
-- Gestiona el sistema de registro y login de usuario
-- Autor: ElTitoJet
-- Fecha: 12/02/2024

-- Variables Globales y Configuración
    local UserXSerial = 2;
    local FirstSpawn = {-1753.8720703125, 884.8466796875, 295.875};
-- Funciones Auxiliares
    function table.find(tabla, valor)
        for _, v in ipairs(tabla) do
            if v == valor then
                return true
            end
        end
        return false
    end
    function table.find(tabla, valor)
        for _, v in ipairs(tabla) do
            if v == valor then
                return true
            end
        end
        return false
    end

    function actualizarEnCuenta(player, tipo)
        -- Obtener el valor actual (serial o IP)
        local valorActual
        if tipo == "Serial" then
            valorActual = getPlayerSerial(player)
        elseif tipo == "IP" then
            valorActual = getPlayerIP(player)
        else
            --iprint("Tipo inválido: " .. tostring(tipo))
            return
        end
    
        -- Obtener ID de la cuenta del jugador
        local varDataUser = exports["MR1_Inicio"]:getValueOne(player)
        local cuentaID = varDataUser.InfoCuenta["IDCuenta"]
        if not cuentaID then
            --iprint("Error: cuentaID es nil")
            return
        end
        
        --iprint("cuentaID: ", cuentaID)
    
        -- Construir la consulta dinámicamente en función de 'tipo' (Serial o IP)
        local columna = tipo == "Serial" and "Serial" or "IP"
        --iprint("Columna seleccionada: ", columna)
    
        -- Consulta para obtener los valores actuales (Serial o IP) de la cuenta en formato JSON
        local resultado = exports["MR1_Inicio"]:query('SELECT ' .. columna .. ' FROM Cuentas WHERE ID = ?', cuentaID)
    
        if not resultado then
            --iprint("Error: La consulta a la base de datos devolvió nil.")
            return
        elseif #resultado == 0 then
            --iprint("No se encontraron registros para la cuenta con ID: " .. cuentaID)
        else
            --iprint("Resultado de la consulta: ", resultado)
        end
    
        -- Verificar si el valor devuelto es válido para convertir en JSON
        local valores
        if resultado and #resultado > 0 then
            local valorColumna = resultado[1][columna]
    
            -- Si es false o nil, inicializamos una tabla vacía
            if not valorColumna or valorColumna == false then
                valores = {}
            else
                valores = fromJSON(valorColumna) or {}
            end
    
            -- **Revisión importante**: si `valores` es un string en vez de una tabla, convertirlo a tabla
            if type(valores) == "string" then
                valores = { valores }
            end
    
            --iprint("Valores existentes: ", valores)
    
            -- Verificar si el valor actual ya está en la lista
            if not table.find(valores, valorActual) then
                -- Agregar el valor a la lista y actualizar en la base de datos
                table.insert(valores, valorActual)
                
                --iprint("Nuevo valor agregado: ", valorActual)
                exports["MR1_Inicio"]:execute('UPDATE Cuentas SET ' .. columna .. ' = ? WHERE ID = ?', toJSON(valores), cuentaID)
            else
                --iprint("El valor ya existe en la lista.")
            end
        else
            -- Si no hay datos previos, crear una nueva entrada con el valor actual
            --iprint("No hay datos previos. Creando nueva entrada.")
            exports["MR1_Inicio"]:execute('UPDATE Cuentas SET ' .. columna .. ' = ? WHERE ID = ?', toJSON({valorActual}), cuentaID)
        end
    end
    
    
-- Funciones Principales
    function ScriptSStart(resource)
        createTeam("Jugando", 255, 255, 255)
        createTeam("Logeado", 111, 111, 111)
        createTeam("Sin Loguear", 111, 111, 111)
        exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS Cuentas ( ID INT NOT NULL AUTO_INCREMENT, Usuario VARCHAR(255) NOT NULL UNIQUE, Correo VARCHAR(255) NOT NULL, Serial VARCHAR(255) NOT NULL, Rango INT NOT NULL, PRIMARY KEY (ID));")
        exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS UsersTOP (ID INT NOT NULL AUTO_INCREMENT, Cantidad INT NOT NULL, PRIMARY KEY(ID));")
    end
    function ScriptSStop(resource)
        for i, v in ipairs(getElementsByType("player")) do
            kickPlayer(v, "Reinicio")
        end
    end
    function onPlayerJoin ( )
        setPlayerNametagShowing ( source, false )
        setTempIdToPlayer(source)
    end
    function JoinPlayer(res)
        if (res == getThisResource()) then
    
            local Nombre = getPlayerName(source)
            outputDebugString("[UserJoin] - ["..Nombre.."] entro al servidor")
    
            setPlayerTeam(source, getTeamFromName("Sin Loguear"))
            outputDebugString("[UserJoin] - ["..Nombre.."] equipo 'Sin Logear' colocado")
    
            spawnPlayer(source, FirstSpawn[1], FirstSpawn[2], FirstSpawn[3], 0, 0, 0, 100)
            outputDebugString("[UserJoin] - ["..Nombre.."] spawneado en Espera")
    
            local Cuentas = getAccountsBySerial(getPlayerSerial(source))
            local count = #Cuentas;
    
            if not (count > 0) then
                outputDebugString("[UserJoin] - ["..Nombre.."] entro por primera vez al servidor")
            else
                outputDebugString("[UserJoin] - ["..Nombre.."] tiene las siguientes cuentas")
                local nombresCuentas = {}
                for i, cuenta in ipairs(Cuentas) do
                    local nombreCuenta = getAccountName(cuenta)
                    table.insert(nombresCuentas, nombreCuenta)
                end
            
                local output = "Cuentas de "..Nombre..": [" .. table.concat(nombresCuentas, ", ") .. "]"
                outputDebugString(output)
            end
            
            setPlayerHudComponentVisible(source, "all", false) -- Oculta todo
            local ID = exports["MR2_Cuentas"]:getIDTempFromPlayer(source)
            local settings = {HUD = false, IDTemp = ID}
            exports["MR1_Inicio"]:setValue(source, "Ajustes", settings)
        end
    end
    function UserRegister(Usuario, Contrasena, Email)
        local Nombre = getPlayerName(client)
        local serialpc = getPlayerSerial(client)
        local Cuentas = getAccountsBySerial(serialpc)
    
        if (#Cuentas >= UserXSerial) then
            outputDebugString("[UserJoin] - ["..Nombre.."] Intento registrar una nueva cuenta.")
            return outputChatBox("#9AA498[#FF7800REGISTRO#9AA498] #A03535Ya no puedes crear mas cuentas.", client, 255, 255, 255, true )
        end
    
        if (getAccount(Usuario)) then
            outputDebugString("[UserJoin] - ["..Nombre.."] Intento registrar una cuenta ya existente.")
            return outputChatBox("#9AA498[#FF7800REGISTRO#9AA498] #A03535Esta cuenta ya existe.", client, 255, 255, 255, true )
        end
    
        local checkUser = exports["MR1_Inicio"]:query("SELECT * FROM Cuentas WHERE Usuario = ?", tostring(Usuario))
        if #checkUser > 0 then
            outputChatBox("#9AA498[#FF7800REGISTRO#9AA498] #A03535El nombre de usuario ya existe.", client, 255, 255, 255, true)
            return
        end
    
        local MeterCuenta = exports["MR1_Inicio"]:execute("INSERT INTO Cuentas(Usuario, Correo, Serial, Rango) VALUES(?,?,?,?)", tostring(Usuario), tostring(Email), tostring(serialpc), 1)
        if not (MeterCuenta) then
            outputDebugString("[UserJoin] - ["..Nombre.."] [ERROR] No se pudo añadir la cuenta a la DB.")
            return outputChatBox("#9AA498[#FF7800REGISTRO#9AA498] #A03535Hubo un error en tu registro.", client, 255, 255, 255, true )
        end
    
        local CrearCuenta = addAccount(tostring(Usuario), tostring(Contrasena))
        if not (CrearCuenta) then
            outputDebugString("[UserJoin] - ["..Nombre.."] [ERROR] No se pudo añadir la cuenta.")
            return outputChatBox("#9AA498[#FF7800REGISTRO#9AA498] #A03535Hubo un error en tu registro.", client, 255, 255, 255, true )
        end
    
        logIn(client, getAccount(tostring(Usuario)), tostring(Contrasena))
        clearChatBox(client)
        outputDebugString("[UserJoin] - ["..Nombre.."] Se registro como "..Usuario..".")
        outputChatBox("#9AA498[#FF7800REGISTRO#9AA498] #53B440Te has registrado como "..Usuario..".", client, 255, 255, 255, true )
    
        local AccountInfo = {Rango = 1} 
        exports["MR1_Inicio"]:setValue(client, 'InfoCuenta', AccountInfo)
        triggerClientEvent(client, "ExitRG", client)
        triggerClientEvent(client, "SelectPJ", client)
        CargarMisPJ(client)
        actualizarEnCuenta(client, "Serial")
        actualizarEnCuenta(client, "IP")
    end
    function UserLoggin(Usuario, Contrasena)
        local Nombre = getPlayerName(client)
        
        if not (getAccount(Usuario)) then
            outputDebugString("[UserJoin] - ["..Nombre.."] Intento entrar una cuenta que no existe.")
            return outputChatBox("#9AA498[#FF7800LOGIN#9AA498] #A03535Esta cuenta no existe.", client, 255, 255, 255, true )
        end
    
        if not (logIn(client, getAccount(Usuario), tostring(Contrasena))) then
            outputDebugString("[UserJoin] - ["..Nombre.."] Puso la contraseña erronea de la cuenta "..Usuario..".")
            return outputChatBox("#9AA498[#FF7800LOGIN#9AA498] #A03535Contraseña incorrecta.", client, 255, 255, 255, true )
        end
        
        logIn(client, getAccount(Usuario), tostring(Contrasena))
        
        clearChatBox(client)
        outputDebugString("[UserJoin] - ["..Nombre.."] Se logeo como "..Usuario..".")
        outputChatBox("#9AA498[#FF7800LOGIN#9AA498] #53B440Te has logeado como "..Usuario..".", client, 255, 255, 255, true )
    
        local rankOOC = exports["MR1_Inicio"]:query("SELECT * FROM Cuentas WHERE Usuario=?", getAccountName(getPlayerAccount(client)))
        local AccountInfo = {Rango = rankOOC[1].Rango, IDCuenta = rankOOC[1].ID} 
        exports["MR1_Inicio"]:setValue(client, 'InfoCuenta', AccountInfo)
        triggerClientEvent(client, "ExitLG", client)
        triggerClientEvent(client, "SelectPJ", client)
        CargarMisPJ(client)
        setPlayerTeam(source, getTeamFromName("Logeado"))
        local contadorStaff = 0
        if (rankOOC[1].Rango >= 3) then
            for _, player in ipairs(getElementsByType("player")) do
                local rank = exports["MR1_Inicio"]:getValue(player, 'InfoCuenta')
                if not (rank == nil) then 
                    if rank["Rango"] >= 3 then
                        contadorStaff = contadorStaff + 1
                    end
                end
            end
            exports["MR15_Discord"]:sendDiscordLoginQuitStaff("Login", Usuario, contadorStaff, StaffOn)
        end
        actualizarEnCuenta(client, "Serial")
        actualizarEnCuenta(client, "IP")
    end
    -- Eventos y Handlers
    addEventHandler("onResourceStart", resourceRoot, ScriptSStart)
    addEventHandler("onResourceStop", resourceRoot, ScriptSStop)
    addEventHandler ( "onPlayerJoin", root, onPlayerJoin )
    addEventHandler("onPlayerResourceStart", root, JoinPlayer)
    addEvent("UserRegister", true)
    addEventHandler("UserRegister", getRootElement(), UserRegister)
    addEvent("UserLoggin", true)
    addEventHandler("UserLoggin", getRootElement(), UserLoggin)