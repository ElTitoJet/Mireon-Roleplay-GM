-- MR2_Cuentas
-- Gestiona el sistema de personajes
-- Autor: ElTitoJet
-- Fecha: 12/02/2024

-- Variables Globales y Configuración
    local FirstSpawn = {1481.03125, -1766.904296875, 20.269758224487, 0, 0};
    local DineroInicio = 30000;
    local PJXCuenta = 2;
    local varTOP = 0;
    local baseNumeroTelefono = 10000000
-- Funciones Auxiliares
    function createDNI()
        local qr = exports["MR1_Inicio"]:query("SELECT max(ID) FROM Personajes")
        if (qr[1]["max(ID)"] == nil) or (qr[1]["max(ID)"] == false) then
            return "1A"
        end
        if not (qr[1]["max(ID)"] > 99999999) then
            return (qr[1]["max(ID)"]+1).."A"
        end
    end
    function RegistrarTiempoInicio(player)
        local varDataPlayer = exports["MR1_Inicio"]:getValueOne(player)
        if varDataPlayer then
            tiempoInicio = getRealTime().timestamp
            
            exports["MR1_Inicio"]:setValue(player, "TiempoInicio", tiempoInicio)
        end
    end
    function guardarTiempoJugado(player)
        local varDataPlayer = exports["MR1_Inicio"]:getValueOne(player)
        if varDataPlayer then
            local varInfoPlayer = varDataPlayer.Informacion
            local TiempoInicio = varDataPlayer.TiempoInicio

            local tiempoConectado = (getRealTime().timestamp - TiempoInicio) / 60 -- Convertir a minutos
            local tiempoJugadoAcumulado = varDataPlayer.Informacion["TiempoJugado"] or 0
            local nuevoTiempoTotal = tiempoJugadoAcumulado + math.floor(tiempoConectado)

            varDataPlayer.Informacion["TiempoJugado"] = nuevoTiempoTotal
            exports["MR1_Inicio"]:setValue(player, "Informacion", varDataPlayer.Informacion)
        end
    end
-- Funciones Principales
    function Script2SStart(resource)
        exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS Personajes (ID INT NOT NULL AUTO_INCREMENT, Cuenta VARCHAR(255) NOT NULL, Nombre VARCHAR(255) NOT NULL UNIQUE, Informacion VARCHAR(255) NOT NULL, Estado VARCHAR(255) NOT NULL, Ubicacion VARCHAR(255) NOT NULL, Inventario VARCHAR(255) NOT NULL, PRIMARY KEY(ID));")
        exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS TrabajosUsers (ID INT NOT NULL AUTO_INCREMENT, Personajes VARCHAR(255) NOT NULL, Trabajo VARCHAR(255) NOT NULL, Rango INT NOT NULL, PRIMARY KEY(ID));")
    end
    function CargarMisPJ(client)
        local Propietario = exports["MR1_Inicio"]:query("SELECT ID FROM Cuentas WHERE Usuario=?", getAccountName(getPlayerAccount(client)))
        local PJs = exports["MR1_Inicio"]:query("SELECT Nombre FROM Personajes WHERE Cuenta=?", Propietario[1].ID)
        local count = 0;     
        for i, PJ in ipairs(PJs) do
            count = count + 1
        end
        if not (count == 0) then
            triggerClientEvent(client, "MostrarPJ", client, PJs)
        end
    end
    function CrearPJs(Nombre, Nacion, Age, Sex)
        local Usuario = getPlayerName(client)
        local Propietario = exports["MR1_Inicio"]:query("SELECT ID FROM Cuentas WHERE Usuario=?", getAccountName(getPlayerAccount(client)))
        local PJs = exports["MR1_Inicio"]:query("SELECT Nombre FROM Personajes WHERE Cuenta=?", Propietario[1].ID)
        local count = 0;     
        for i, PJ in ipairs(PJs) do
            count = count + 1
        end
        if not (count < PJXCuenta) then
            outputDebugString("[UserJoin] - ["..Usuario.."] Intento crear otro PJ extra.")
            return outputChatBox("#9AA498[#FF7800CREACION#9AA498] #A03535Ya no puedes crear mas personajes.", client, 255, 255, 255, true )
        end
        local PJs2 = exports["MR1_Inicio"]:query("SELECT Nombre FROM Personajes WHERE Nombre=?", Nombre)
        if not (#PJs2 < 1) then
            outputDebugString("[UserJoin] - ["..Usuario.."] Intento crear un PJ existente.")
            return outputChatBox("#9AA498[#FF7800CREACION#9AA498] #A03535Este personaje ya existe.", client, 255, 255, 255, true )
        end
        local newDNI = createDNI()
        local numeroTelefono = baseNumeroTelefono + tonumber(string.match(newDNI, "%d+"))

        local Informacion = toJSON({DNI = newDNI, Nacionalidad = Nacion, Edad = Age, Sexo = Sex, Banco = 0, Radio = nil, Telefono = numeroTelefono})
        local Ubicacion = toJSON({X = FirstSpawn[1], Y = FirstSpawn[2], Z = FirstSpawn[3], Interior = FirstSpawn[4], Dimension = FirstSpawn[5]})
        local newLicencias = {DNI = 1}
        local newWeapons = {}
        local Inventario = toJSON({Dinero = DineroInicio, Licencias = newLicencias, Weapons = newWeapons})
    
        if (Sex == "Masculino") then
            Estado = toJSON({Vida = 100, Chaleco = 0, Skin = 26, SkinCustom = 0, Muerto = false})
            exports["MR1_Inicio"]:execute("INSERT INTO Personajes(Cuenta, Nombre, Informacion, Estado, Ubicacion, Inventario) VALUES(?,?,?,?,?,?)", Propietario[1].ID, Nombre, Informacion, Estado, Ubicacion, Inventario)
    
        elseif (Sex == "Femenino") then
            Estado = toJSON({Vida = 100, Chaleco = 0, Skin = 41, SkinCustom = 0, Muerto = false})
            exports["MR1_Inicio"]:execute("INSERT INTO Personajes(Cuenta, Nombre, Informacion, Estado, Ubicacion, Inventario) VALUES(?,?,?,?,?,?)", Propietario[1].ID, Nombre, Informacion, Estado, Ubicacion, Inventario)
        end
        local PJ = exports["MR1_Inicio"]:query("SELECT * FROM Personajes WHERE Nombre=?", Nombre)
    
        exports["MR1_Inicio"]:execute("INSERT INTO JobsUsers(Personajes, Trabajo, Rango) VALUES(?,?,?)", PJ[1].ID, 1, 1)
        exports["MR1_Inicio"]:execute("INSERT INTO FamiliasUsers(Personajes, Familia, Rango) VALUES(?,?,?)", PJ[1].ID, 1, 1)
        
        outputDebugString("[UserJoin] - ["..Usuario.."] Creo el personaje "..Nombre..".")
        
        triggerClientEvent(client, "PJCreado", client)
        CargarMisPJ(client)
    end
    function SpawnPJ(Nombre)
        if client ~= source then 
            return
        end
        local PJ = exports["MR1_Inicio"]:query("SELECT * FROM Personajes WHERE Nombre=?", Nombre)
        if getPlayerName(client) ~= Nombre then
            setPlayerName(client, tostring(Nombre))
        end
        
        exports["MR1_Inicio"]:setValue(client, 'IDPersonaje', PJ[1].ID)
        local Informacion = fromJSON(PJ[1].Informacion)
        local Estado = fromJSON(PJ[1].Estado)
        local Inventario = fromJSON(PJ[1].Inventario)
    
        --Informacion(DNI, Nacionalidad, Edad, Sexo, Banco, Radio), 
            exports["MR1_Inicio"]:setValue(client, 'Informacion', Informacion)

        --Ubicacion(X, Y, Z, Interior, Dimension)
            local Ubicacion = fromJSON(PJ[1].Ubicacion)
            spawnPlayer(client, Ubicacion["X"], Ubicacion["Y"], Ubicacion["Z"], 0, Estado["Skin"], Ubicacion["Interior"], Ubicacion["Dimension"], nil)
        --Estado(Vida, Chaleco, Skin, Muerto) 
            newEstado = {Muerto = Estado["Muerto"], Skin = Estado["Skin"], SkinCustom = Estado["SkinCustom"]}
            exports["MR1_Inicio"]:setValue(client, 'Estado', newEstado)
            setElementHealth(client, Estado["Vida"])
            if Estado["Muerto"] == true then
                killPed(client)
            else
                setElementHealth(client, Estado["Vida"])
                setPedArmor(client, Estado["Chaleco"])
            end
            
        --Inventario
            exports["MR1_Inicio"]:setValue(client, 'Inventario', Inventario)
    
        --Ajustes
            newAjustes = {HUD = true, togmp = false, togb = false, togrf = false}
            exports["MR1_Inicio"]:setValue(client, "Ajustes", newAjustes)
    
    
        exports["MR9_Concesionarios"]:Spawnear_Vehiculos_Player(client)
        exports["MRJobs"]:setJobUser(client)
        exports["MRFamilias"]:setFamUser(client)
    
        local result2 = exports["MR1_Inicio"]:query("SELECT * FROM JailOOCDisconnect WHERE IDPersonaje=?", PJ[1].ID)
        if #result2 > 0 then
            exports["MR12_Moderacion"]:playerJailConnect(client)
        else
            exports["MRJobs2_FaccLSPD"]:playerJailICConnect(client)
        end
    
        fadeCamera(client, true)
        triggerClientEvent(client, "FinSpawn", client)
    
        setPlayerTeam(client, getTeamFromName("Jugando"))
    
        outputChatBox ( "#9AA498Discord: #FF7800https://discord.gg/dvUHAxX22b", client, 255, 255, 255, true )
        outputChatBox ( "#9AA498Foro: #FF7800https://foros.mireonroleplay.site/", client, 255, 255, 255, true )

        RegistrarTiempoInicio(source)
        exports["MR16_Armas"]:loadWeapons(client)
    
        setPedStat(client, 69, 40) -- 9mm
        setPedStat(client, 70, 500) -- Taser
        setPedStat(client, 71, 200) -- DK
        setPedStat(client, 72, 200) -- Escopeta
        setPedStat(client, 73, 200) -- Escopeta de combate
        setPedStat(client, 74, 200) -- Recortada
        setPedStat(client, 75, 50) -- Uzi
        setPedStat(client, 76, 1000) -- MP5
        setPedStat(client, 77, 1000) -- AK
        setPedStat(client, 78, 1000) -- M4
        setPedStat(client, 79, 300) -- Sniper
    
        setPedWalkingStyle(client, 118)
        setPlayerBlurLevel(client, 0)
        local inventario = exports["MR1_Inicio"]:getValue(client, "Inventario")
        local UpdateInventario = toJSON(inventario)
        exports["MR1_Inicio"]:execute("UPDATE Personajes SET Inventario=? WHERE Nombre=?", UpdateInventario, Nombre)
    end
    function SavePJ(quitType)
        local Usuario = getPlayerName(source)
        local cuenta = getAccountName(getPlayerAccount(source))
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (varDataSource ~= nil) then
            return
        end
    
        guardarTiempoJugado(source)

        local Informacion = exports["MR1_Inicio"]:getValue(source, 'Informacion')
        if not (Informacion ~= nil) then
            return
        end
        local UpdateInformacion = toJSON({DNI=Informacion["DNI"], Nacionalidad=Informacion["Nacionalidad"], Edad=Informacion["Edad"], Sexo=Informacion["Sexo"], Banco=Informacion["Banco"], Radio=Informacion["Radio"], TiempoJugado=Informacion["TiempoJugado"] or nil})
    
        --Estado(Vida, Chaleco, Skin, Muerto)
            local Estado = exports["MR1_Inicio"]:getValue(source, 'Estado')
            local UpdateEstado = toJSON({Vida = getElementHealth(source), Chaleco = getPedArmor(source), Skin = Estado["Skin"], SkinCustom = Estado["SkinCustom"], Muerto = Estado["Muerto"]})
    
        --Ubicacion(X, Y, Z, Interior, Dimension)
            local posX, posY, posZ = getElementPosition(source)
            local UpdateUbicacion = toJSON({X = posX, Y = posY, Z = posZ+1, Interior = getElementInterior(source), Dimension = getElementDimension(source)})
        --Armas
            local IDPJ = exports["MR1_Inicio"]:getValue(source, 'IDPersonaje')
            exports["MR12_Moderacion"]:playerJailDisconnect(source, IDPJ)
            if Estado["Muerto"] == false then
                exports["MR16_Armas"]:saveWeapons(source)
            end
        --Inventario
            local Inventario = exports["MR1_Inicio"]:getValue(source, 'Inventario')
            local UpdateInventario = toJSON(Inventario)
    
        exports["MR1_Inicio"]:execute("UPDATE Personajes SET Informacion=?, Estado=?, Ubicacion=?, Inventario=? WHERE Nombre=?", UpdateInformacion, UpdateEstado, UpdateUbicacion, UpdateInventario, Usuario)
    
        outputDebugString("[UserExit] - ["..Usuario.."] salio del servidor ["..quitType.."].")
        
        for i, v in ipairs(getElementsByType("player")) do
            pos2x, pos2y, pos2z = getElementPosition(v)            
            if getDistanceBetweenPoints3D(posX, posY, posZ, pos2x, pos2y, pos2z) <= 15 then
                outputChatBox("#9AA498[#FF7800"..Usuario.."#9AA498] #A03535se desconecto [#FF7800"..quitType.."#A03535]", v, 190, 199, 42, true)
            end
        end
        
        local contadorStaff = 0
        if (varDataSource.InfoCuenta["Rango"] >= 3) then
            for _, player in ipairs(getElementsByType("player")) do
                if player ~= source then
                    local rank = exports["MR1_Inicio"]:getValue(player, 'InfoCuenta')
                    if not (rank == nil) then 
                        if rank["Rango"] >= 3 then
                            contadorStaff = contadorStaff + 1
                        end
                    end
                end
            end

            local TiempoInicio = varDataSource.TiempoInicio
            exports["MR15_Discord"]:sendDiscordLoginQuitStaff("Quit", cuenta, contadorStaff, TiempoInicio)
        end
    end

-- Eventos y Handlers
    addEventHandler("onResourceStart", resourceRoot, Script2SStart)
    addEvent("CargarMisPJ", true)
    addEventHandler("CargarMisPJ", getRootElement(), CargarMisPJ)
    addEvent("LogOut", true)
    addEventHandler("LogOut", getRootElement(), function()
        logOut(client)
        clearChatBox(client)
    end)
    addEvent("CrearPJs", true)
    addEventHandler("CrearPJs", getRootElement(), CrearPJs)
    addEvent("SpawnPJ", true)
    addEventHandler("SpawnPJ", getRootElement(), SpawnPJ)
    addEvent("SyncTimeICServer", true)
    addEventHandler("SyncTimeICServer", getRootElement(), function()
        local varTimeHour, varTimeMinute = getTime()
        triggerClientEvent (source, "SyncTimeICClient", source, timehour, timeminute )
    end)
    addEventHandler ("onPlayerQuit", getRootElement(), SavePJ)
