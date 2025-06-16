--[[
    AJUSTES PRINCIPALES
]]
    
local cooldowns = {}
function MR12_Moderacion(resource)
    exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS Rangos ( ID INT NOT NULL AUTO_INCREMENT, Rango VARCHAR(255) NOT NULL UNIQUE, Abreviatura VARCHAR(255) NOT NULL UNIQUE, PRIMARY KEY (ID));")
end
addEventHandler("onResourceStart", resourceRoot, MR12_Moderacion)
--[[
    METODOS
]]
function formatNumber(n)
    -- Convertir n a un número entero
    local num = math.floor(tonumber(n))
    local formatted = tostring(num)
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end
function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function isOnCooldown(player, command, cooldownTime)
    if not cooldowns[player] then
        cooldowns[player] = {}
    end

    local lastUsed = cooldowns[player][command] or 0
    local currentTime = getTickCount()

    if currentTime - lastUsed < cooldownTime then
        return true -- El jugador está en cooldown
    else
        cooldowns[player][command] = currentTime
        return false -- El jugador no está en cooldown
    end
end
function table.find(tabla, valor)
    for _, v in ipairs(tabla) do
        if v == valor then
            return true
        end
    end
    return false
end
--[[
    COMANDOS
]]
-- Rango 1 Usuarios  
    function Staff(source, command)
        local playersByRank = {} -- Crear una tabla para agrupar a los jugadores por rango

        for _, player in ipairs(getElementsByType("player")) do
            local rank = exports["MR1_Inicio"]:getValue(player, 'InfoCuenta')
            if not (rank == nil) then 
                if rank["Rango"] >= 3 then
                    -- Comprobar si ya existe una tabla para este rango
                    if not playersByRank[rank["Rango"]] then
                        playersByRank[rank["Rango"]] = {} -- Crear una nueva tabla para este rango
                    end
                    -- Agregar el jugador a la tabla correspondiente con su nombre de cuenta y nombre actual
                    table.insert(playersByRank[rank["Rango"]], {cuenta = getAccountName(getPlayerAccount(player)), id = exports["MR2_Cuentas"]:getIDTempFromPlayer(player)})
                end
            end
        end

        -- Obtener una lista de rangos en orden descendente
        local sortedRanks = {}
        for rango, _ in pairs(playersByRank) do
            table.insert(sortedRanks, rango)
        end
        table.sort(sortedRanks, function(a, b) return a > b end)

        -- Mostrar la lista ordenada de mayor a menor
        --outputChatBox("#53B440Lista de Staff activos:", source, 255, 255, 255, true)

        outputChatBox("#00ff57======[[ #00ff57Equipo Staff#00ff57 ]]======", source, 0,0,0, true)
        for _, rango in ipairs(sortedRanks) do
            rankName = exports["MR1_Inicio"]:query("SELECT * FROM Rangos WHERE ID=?", rango)
            local playerList = {}
            for _, playerData in ipairs(playersByRank[rango]) do
                if rango == 10 then
                    table.insert(playerList, "#9AA498["..playerData.id.."#9AA498] #ff4500"..playerData.cuenta)
                elseif rango == 9 then
                    table.insert(playerList, "#9AA498["..playerData.id.."#9AA498] #c4ffff"..playerData.cuenta)
                elseif rango == 8 then
                    table.insert(playerList, "#9AA498["..playerData.id.."#9AA498] #9be6e6"..playerData.cuenta)
                elseif rango == 7 then
                    table.insert(playerList, "#9AA498["..playerData.id.."#9AA498] #72cdcd"..playerData.cuenta)
                elseif rango == 6 then
                    table.insert(playerList, "#9AA498["..playerData.id.."#9AA498] #72cdcd"..playerData.cuenta)
                elseif rango == 5 then
                    table.insert(playerList, "#9AA498["..playerData.id.."#9AA498] #98ff96"..playerData.cuenta)
                elseif rango == 4 then
                    table.insert(playerList, "#9AA498["..playerData.id.."#9AA498] #5ccb5f"..playerData.cuenta)
                elseif rango == 3 then
                    table.insert(playerList, "#9AA498["..playerData.id.."#9AA498] #006414"..playerData.cuenta)
                end
            end
            local playerListStr = table.concat(playerList, ", ")
            if rango == 10 then
                outputChatBox("#ff4500"..rankName[1]["Rango"].." ~> "..playerListStr, source, 255, 255, 255, true)
            elseif rango == 9 then
                outputChatBox("#c4ffff"..rankName[1]["Rango"].." ~> "..playerListStr, source, 255, 255, 255, true)
            elseif rango == 8 then
                outputChatBox("#9be6e6"..rankName[1]["Rango"].." ~> "..playerListStr, source, 255, 255, 255, true)
            elseif rango == 7 then
                outputChatBox("#72cdcd"..rankName[1]["Rango"].." ~> "..playerListStr, source, 255, 255, 255, true)
            elseif rango == 6 then
                outputChatBox("#72cdcd"..rankName[1]["Rango"].." ~> "..playerListStr, source, 255, 255, 255, true)
            elseif rango == 5 then
                outputChatBox("#98ff96"..rankName[1]["Rango"].." ~> "..playerListStr, source, 255, 255, 255, true)
            elseif rango == 4 then
                outputChatBox("#5ccb5f"..rankName[1]["Rango"].." ~> "..playerListStr, source, 255, 255, 255, true)
            elseif rango == 3 then
                outputChatBox("#006414"..rankName[1]["Rango"].." ~> "..playerListStr, source, 255, 255, 255, true)
            end
        end
        
    end
    addCommandHandler("staff", Staff)
    
    function CambiarMiContra(source, command, Contrasena, Confirmacion)
        if not Contrasena or not Confirmacion or not (Contrasena == Confirmacion)then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [nuevaContrasena] [repiteNuevaContraseña]", source, 0, 0, 0, true)
        end
        local account = getPlayerAccount(source)
        if (isGuestAccount(account)) then
            return outputChatBox("#A03535No estas registrado", source, 0, 0, 0, true)
        end
        setAccountPassword(account, Contrasena)
        return outputChatBox("#56c450Contraseña de la cuenta #24C5BE"..getAccountName(account).." #56c450cambiada", source, 0,0,0, true)
    end
    addCommandHandler("cambiarmypass", CambiarMiContra)
-- Rango 3 Soporte a prueba
    function Expulsar_Jugador(source, command, objetive, ...)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 3) then
            return
        end
        local reason = table.concat({...}, " ")
        if not (objetive) or not (#reason > 2) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario] [Razón]", source, 0, 0, 0, true)
        end
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if not (objetivo) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        local staff = getAccountName(getPlayerAccount(source))
        outputChatBox("#56c450El jugador #24C5BE"..getPlayerName(objetivo).." #56c450ha sido #FF0000expulsado #56c450del servidor.\n#56c450Motivo: #24C5BE"..reason, source, 0,0,0, true)
        kickPlayer(objetivo, source, reason.." - "..staff)
    end
    addCommandHandler("echar", Expulsar_Jugador)
    addCommandHandler("kick", Expulsar_Jugador)
    addCommandHandler("expulsar", Expulsar_Jugador)

    function Comando_TraerVeh(source, command, vehObjetive)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 3) then
            return
        end
        if not vehObjetive then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [matricula]", source, 255, 255, 255, true)
        end
        local vehiculoEncontrado = false
        for _, vehiculo in ipairs(getElementsByType("vehicle")) do
            local DataVeh = exports["MR1_Inicio"]:getValueOne(vehiculo)
            if (DataVeh) and (DataVeh["Informacion"].Matricula == vehObjetive) then
                local x, y, z = getElementPosition(source)
                local int = getElementInterior(source)
                local dim = getElementDimension(source)
                setElementPosition(vehiculo, x + 5, y + 5, z) -- Coloca el vehículo cerca del jugador
                setElementInterior(vehiculo, int)
                setElementDimension(vehiculo, dim)
                vehiculoEncontrado = true
                break
            end
        end
    
        if not vehiculoEncontrado then
            outputChatBox("Vehículo con matrícula '" .. tostring(vehObjetive) .. "' no encontrado.", source, 255, 0, 0)
        else
            outputChatBox("Vehículo con matrícula '" .. tostring(vehObjetive) .. "' traído con éxito.", source, 0, 255, 0)
        end
    end
    addCommandHandler("traerveh", Comando_TraerVeh)
    function Banear_Jugador(source, command, objetive, tiempo, unidad, ...)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 3) then
            return
        end
        local staff = getAccountName(getPlayerAccount(source))
        if not (objetive) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario] [Tiempo] [h/d] [Razón]", source, 0, 0, 0, true)
        end
        if not (tiempo) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." "..objetive.." [Tiempo] [h/d] [Razón]", source, 0, 0, 0, true)
        end
        local time;
        local msg;
        if (unidad == "h") then
            time = tonumber(tiempo) * 3600
            msg = "#56c450durante "..tiempo.." hora(s)."
        elseif (unidad == "d") then
            time = tonumber(tiempo) * 86400
            msg = "#56c450durante "..tiempo.." dia(s)."
        else
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." "..objetive.." "..tiempo.." [h/d] [Razón]", source, 0, 0, 0, true)
        end
        local reason = table.concat({...}, " ")
        if not (#reason > 2) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." "..objetive.." "..tiempo.." "..unidad.." [Razón]", source, 0, 0, 0, true)
        end
        local objetivo = getPlayerFromName(objetive)
        -- Jugador desconectado
            if not (isElement(objetivo)) then
                local Account = exports["MR1_Inicio"]:query('SELECT Cuenta FROM Personajes WHERE Nombre = ?', objetive)
                if not Account or #Account == 0 then
                    return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFNo se encontró al jugador en la base de datos.", source, 255, 0, 0, true)
                end

                -- Obtener la información de la cuenta
                    local AccountInfo = exports["MR1_Inicio"]:query('SELECT * FROM Cuentas WHERE ID = ?', Account[1]["Cuenta"])
                    local seriales = fromJSON(AccountInfo[1]["Serial"]) or {}
                    local ips = fromJSON(AccountInfo[1]["IP"]) or {}
                    local usuario = AccountInfo[1]["Usuario"]
                -- Baneo Temporal
                    if not (time == 0) then
                        for _, serial in ipairs(seriales) do
                            addBan(nil, usuario, serial, nil, staff, reason.." - "..staff, time)
                        end
                        for _, ip in ipairs(ips) do
                            addBan(ip, usuario, nil, nil, staff, reason.." - "..staff, time)
                        end
                        return outputChatBox("#56c450El jugador #24C5BE"..objetive.." #56c450ha sido #FF0000baneado #56c450del servidor "..msg..".\n#56c450Motivo: #24C5BE"..reason, source, 0, 0, 0, true)
                    end

                -- Baneo permanente
                    outputChatBox("#56c450El jugador #24C5BE"..objetive.." #56c450ha sido #FF0000baneado #56c450del servidor #FF0000permanentemente#56c450.\n#56c450Motivo: #24C5BE"..reason, source, 0,0,0, true)
                    for _, serial in ipairs(seriales) do
                        addBan(nil, serial, usuario, nil, staff, reason.." - "..staff)
                    end
                    for _, ip in ipairs(ips) do
                        addBan(ip, nil, usuario, nil, staff, reason.." - "..staff)
                    end
                    return
            end

        -- Jugador conectado
            local serial = getPlayerSerial(objetivo)
            local account = getPlayerAccount(objetivo)
            local ip = getPlayerIP(objetivo)

            local AccountInfo = exports["MR1_Inicio"]:query('SELECT Serial, IP FROM Cuentas WHERE Usuario = ?', getAccountName(account))
            local seriales = fromJSON(AccountInfo[1]["Serial"]) or {}
            local ips = fromJSON(AccountInfo[1]["IP"]) or {}

            -- Si la serial no está en la lista, agregarla
                if not table.find(seriales, serial) then
                    table.insert(seriales, serial)
                    exports["MR1_Inicio"]:exec('UPDATE Cuentas SET Serial = ? WHERE Usuario = ?', toJSON(seriales), getAccountName(account))
                end
                if not table.find(ips, ip) then
                    table.insert(ips, ip)
                    exports["MR1_Inicio"]:exec('UPDATE Cuentas SET IP = ? WHERE Usuario = ?', toJSON(ips), getAccountName(account))
                end

                -- Baneamos todas las seriales e IPs
                for _, ser in ipairs(seriales) do
                    if time == 0 then
                        addBan(nil, nil, ser, nil, staff, reason.." - "..staff) -- Baneo permanente
                    else
                        addBan(nil, nil, ser, nil, staff, reason.." - "..staff, time) -- Baneo temporal
                    end
                end
            
                for _, ipban in ipairs(ips) do
                    if time == 0 then
                        addBan(ipban, nil, nil, nil, staff, reason.." - "..staff) -- Baneo permanente
                    else
                        addBan(ipban, nil, nil, nil, staff, reason.." - "..staff, time) -- Baneo temporal
                    end
                end

                if time == 0 then
                    banPlayer(objetivo, true, true, true, staff, reason.." - "..staff) -- Baneo permanente
                    for i, player in ipairs(getElementsByType("player")) do
                        local informacion_Player = exports["MR1_Inicio"]:getValueOne(player)
                        if (informacion_Player) and (informacion_Player.Informacion) and (informacion_Player.InfoCuenta["Rango"] >= 3) then
                            outputChatBox("#56c450El jugador #24C5BE"..objetive.." #56c450ha sido #FF0000baneado #56c450permanentemente.", player, 0,0,0, true)
                        end
                    end
                else
                    banPlayer(objetivo, true, true, true, staff, reason.." - "..staff, time) -- Baneo temporal
                    for i, player in ipairs(getElementsByType("player")) do
                        local informacion_Player = exports["MR1_Inicio"]:getValueOne(player)
                        if (informacion_Player) and (informacion_Player.Informacion) and (informacion_Player.InfoCuenta["Rango"] >= 3) then
                            outputChatBox("#56c450El jugador #24C5BE"..objetive.." #56c450ha sido #FF0000baneado #56c450por "..tiempo.." "..unidad..".", player, 0,0,0, true)
                        end
                    end
                end
    end
    addCommandHandler("ban", Banear_Jugador)
    addCommandHandler("banear", Banear_Jugador)

    function Hacerse_Invisible(source, command)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (varDataSource.InfoCuenta["Rango"] >= 3) then
            return
        end
        if not varDataSource.Staff then
            varDataSource.Staff = {}
            exports["MR1_Inicio"]:setValue(source, "Staff", varDataSource.Staff)
        end
        if not (getElementAlpha(source) == 0) then
            setElementAlpha(source, 0)
            varDataSource.Staff["Vanish"] = true
        else
            setElementAlpha(source, 255)
            varDataSource.Staff["Vanish"] = false
        end
        exports["MR1_Inicio"]:setValue(source, "Staff", varDataSource.Staff)

        for _, player in ipairs(getElementsByType("player")) do
            local varDataPlayer = exports["MR1_Inicio"]:getValueOne(player)
    
            -- Comprobamos que el jugador es staff y tiene rango 3 o mayor
            if varDataPlayer.InfoCuenta and varDataPlayer.InfoCuenta["Rango"] >= 3 then
                -- Notificar a este jugador sobre el cambio de visibilidad del staff
                triggerClientEvent(player, "Staff::ActualizarVisibilidad", source, source, varDataSource.Staff["Vanish"])
            end
        end
    end
    addCommandHandler ("vanish", Hacerse_Invisible)
    addCommandHandler ("invisible", Hacerse_Invisible)
    addCommandHandler ("visible", Hacerse_Invisible)

    function Ir_a_LS(source, command, objetive)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 3) then
            return
        end
        if not (objetive) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario]", source, 0, 0, 0, true)
        end
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if not (objetivo) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        local staff = getAccountName(getPlayerAccount(source))
        if getPedOccupiedVehicle(objetivo) then removePedFromVehicle(objetivo) end
        exports["MR5_Interiores"]:Cambiar_De_Interior_A_Pie(objetivo, 0, 0, 1481.22265625, -1751.8603515625, 15.4453125, 0, 0, 0)	
        outputChatBox("#FF7800"..staff.." #56c450te llevo a Los Santos", objetivo, 0,0,0, true)
    end
    addCommandHandler ("ls", Ir_a_LS)
    
    function Ir_a_SF(source, command, objetive)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 3) then
            return
        end
        if not (objetive) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario]", source, 0, 0, 0, true)
        end
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if not (objetivo) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        local staff = getAccountName(getPlayerAccount(source))
        if getPedOccupiedVehicle(objetivo) then removePedFromVehicle(objetivo) end
        exports["MR5_Interiores"]:Cambiar_De_Interior_A_Pie(objetivo, 0, 0, -2764.7314453125, 375.599609375, 6.3420829772949, 0, 0, 0)	
        outputChatBox("#FF7800"..staff.." #56c450te llevo a San Fierro", objetivo, 0,0,0, true)
    end
    addCommandHandler ("sf", Ir_a_SF)
    
    function Ir_a_LV(source, command, objetive)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 3) then
            return
        end
        if not (objetive) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario]", source, 0, 0, 0, true)
        end
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if not (objetivo) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        local staff = getAccountName(getPlayerAccount(source))
        if getPedOccupiedVehicle(objetivo) then removePedFromVehicle(objetivo) end
        exports["MR5_Interiores"]:Cambiar_De_Interior_A_Pie(objetivo, 0, 0, 2840.68359375, 1291.01953125, 11.390625, 0, 0, 0)	
        outputChatBox("#FF7800"..staff.." #56c450te llevo a Las Venturas", objetivo, 0,0,0, true)
    end
    addCommandHandler ("lv", Ir_a_LV)

    function Ir_a_Jugador(source, command, objetive)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 3) then
            return
        end
        if not (objetive) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario]", source, 0, 0, 0, true)
        end
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if not (objetivo) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if getPedOccupiedVehicle(source) then removePedFromVehicle(source) end
        local varPosXJugador, varPosYJugador, varPosZJugador = getElementPosition(objetivo)
        setElementPosition(source, varPosXJugador, varPosYJugador+1, varPosZJugador+1)
        setElementInterior(source, getElementInterior(objetivo))
        setElementDimension(source, getElementDimension(objetivo))
        outputChatBox("#56c450Fuiste hasta #24C5BE"..getPlayerName(objetivo).."", source, 0,0,0, true)
    end
    addCommandHandler("ir", Ir_a_Jugador)
    
    function Traer_a_Jugador(source, command, objetive)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 3) then
            return
        end
        if not (objetive) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario]", source, 0, 0, 0, true)
        end
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if not (objetivo) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
    
        local staff = getAccountName(getPlayerAccount(source))
        if getPedOccupiedVehicle(objetivo) then removePedFromVehicle(objetivo) end
        local varPosXSource, varPosYSource, varPosZSource = getElementPosition(source)
        setElementPosition(objetivo, varPosXSource, varPosYSource+1, varPosZSource+1)
        setElementInterior(objetivo, getElementInterior(source))
        setElementDimension(objetivo, getElementDimension(source))
        outputChatBox("#56c450Traiste a #24C5BE"..getPlayerName(objetivo).."", source, 0,0,0, true)
        outputChatBox("#FF7800"..staff.." #56c450te llevo hacia el.", objetivo, 0,0,0, true)
    end
    addCommandHandler("traer", Traer_a_Jugador)
    
    function Llevar_a_Jugador(source, command, objetive1, objetive2)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 3) then
            return
        end
        if not (objetive1) or not (objetive2) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario 1] [Usuario 2]", source, 0, 0, 0, true)
        end
        
        objetivo1 = nil;
        if tonumber(objetive1) then
            objetivo1 = exports["MR2_Cuentas"]:getPlayerFromID(objetive1)
        elseif (isElement(getPlayerFromName(objetive1))) then
            objetivo1 = getPlayerFromName(objetive1)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador 1 no esta conectado.", source, 255, 255, 255, true)
        end
        if not (objetivo1) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador 1 no esta conectado.", source, 255, 255, 255, true)
        end
        objetivo2 = nil;
        if tonumber(objetive2) then
            objetivo2 = exports["MR2_Cuentas"]:getPlayerFromID(objetive2)
        elseif (isElement(getPlayerFromName(objetive2))) then
            objetivo2 = getPlayerFromName(objetive2)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador 2 no esta conectado.", source, 255, 255, 255, true)
        end
        if not (objetivo2) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador 2 no esta conectado.", source, 255, 255, 255, true)
        end
    
        if getPedOccupiedVehicle(objetivo1) then removePedFromVehicle(objetivo1) end
        local varPosXJugador2, varPosYJugador2, varPosZJugador2 = getElementPosition(objetivo2)
        --setElementPosition(objetivo1, varPosXJugador2, varPosYJugador2+1, varPosZJugador2+1)
        --setElementInterior(objetivo1, getElementInterior(objetivo2))
        --setElementDimension(objetivo1, getElementDimension(objetivo2))
        local staff = getAccountName(getPlayerAccount(source))
        exports["MR5_Interiores"]:Cambiar_De_Interior_A_Pie(objetivo1, getElementInterior(objetivo2), getElementDimension(objetivo2), varPosXJugador2, varPosYJugador2, varPosZJugador2+1, 0, 0, 0)	
        outputChatBox("#FF7800"..staff.." #56c450te llevo hacia "..objetive2..".", objetivo1, 0,0,0, true)
    end
    addCommandHandler("llevar", Llevar_a_Jugador)
    
    function tppos(source, command, x, y, z, int, dim)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 3) then
            return
        end
        nint = int or 0
        ndim = dim or 0
        setElementPosition(source, x, y, z)
        setElementInterior(source, nint)
        setElementDimension(source, ndim)
    end
    addCommandHandler("tppos", tppos)
    function toggleAirbreak(player)
        local rank = exports["MR1_Inicio"]:getValue(player, 'InfoCuenta') --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
        if not (rank["Rango"] >= 3) then -- COMPROBAMOS SI SU RANGO ES MENOR A 3.
            return --CANCELAMOS LA EJECUCION DEL COMANDO
        end
        if not getElementData(player, "airbreakEnabled") then
            setElementData(player, "airbreakEnabled", true)
            triggerClientEvent(player, "onClientToggleAirbreak", player, true)
        else
            setElementData(player, "airbreakEnabled", false)
            triggerClientEvent(player, "onClientToggleAirbreak", player, false)
        end
    end
    addCommandHandler("airbreak", toggleAirbreak)
        
    function verInvObjetivo(source, command, objetive)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source) --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
        if not (varDataSource.InfoCuenta["Rango"] >= 3) then -- COMPROBAMOS SI SU RANGO ES MENOR A 3.
            return --CANCELAMOS LA EJECUCION DEL COMANDO
        end
        
        local staff = getAccountName(getPlayerAccount(source))
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if not (isElement(objetivo)) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        local varDataObjetivo = exports['MR1_Inicio']:getValueOne(objetivo)
        local inv = varDataObjetivo.Inventario
        outputChatBox("#FFFFFF        ====== #FF6F00Inventario de "..getPlayerName(objetivo).." #FFFFFF======", source, 200, 200, 200, true)
        
        local cantidadFormateada = formatNumber(math.abs(math.floor(tonumber(inv.Dinero))))
        outputChatBox("#FF7800Dinero: #FFFFFF"..cantidadFormateada.."", source, 200, 200, 200, true)
        for i, Licencia in pairs(inv.Licencias) do
            outputChatBox("#FF7800"..i..": #FFFFFF x1", source, 200, 200, 200, true)
        end
        local playerWeapons = (exports["weapon_system"]:getAllFromPed(objetivo))
        if (playerWeapons) then
            for i, weapon in ipairs(playerWeapons) do
                local fullammo = weapon.ammo + weapon.clip

                if (weapon.id > 0) and (fullammo > 0) then
                    local municionformateada = formatNumber(math.abs(math.floor(tonumber(fullammo))))
                    outputChatBox("#FF7800"..getWeaponNameFromID(weapon.id)..": #FFFFFF"..municionformateada.." balas", source, 200, 200, 200, true)
                end
            end
        end
    end
    addCommandHandler("verinventario", verInvObjetivo)
-- Rango 4 Soporte
    function matarObjetivo(source, command, objetive)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source) --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
        if not (varDataSource.InfoCuenta["Rango"] >= 4) then -- COMPROBAMOS SI SU RANGO ES MENOR A 3.
            return --CANCELAMOS LA EJECUCION DEL COMANDO
        end
        
        local staff = getAccountName(getPlayerAccount(source))
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if not (isElement(objetivo)) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        local varDataObjetivo = exports["MR1_Inicio"]:getValueOne(objetivo) --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
        if (varDataObjetivo.InfoCuenta["Rango"] > varDataSource.InfoCuenta["Rango"]) then -- COMPROBAMOS SI SU RANGO ES MENOR A 3.
            killPed(source)
            return 
        end
        killPed(objetivo)
        
        outputChatBox("#56c450Mataste a #24C5BE"..getPlayerName(objetivo).."", source, 0,0,0, true)
        outputChatBox("#FF7800"..staff.." #56c450te mato con comando.", objetivo, 0,0,0, true)
    end
    addCommandHandler("matar", matarObjetivo)

    function verFrecuencia(source, command, objetive)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source) --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
        if not (varDataSource.InfoCuenta["Rango"] >= 4) then -- COMPROBAMOS SI SU RANGO ES MENOR A 3.
            return --CANCELAMOS LA EJECUCION DEL COMANDO
        end
        
        local staff = getAccountName(getPlayerAccount(source))
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if not (isElement(objetivo)) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        local varDataObjetivo = exports['MR1_Inicio']:getValueOne(objetivo)
        outputChatBox("#FF6F00Frecuencia de "..getPlayerName(objetivo)..": "..varDataObjetivo.Informacion["Radio"].."", source, 200, 200, 200, true)


    end
    addCommandHandler("verfrecuencia", verFrecuencia)
-- Rango 5 Super Soporte
    function Desbanear_Jugador(source, command, objetive)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 5) then
            return
        end
        if not (objetive) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario]", source, 0, 0, 0, true)
        end
        local bans = getBans()
        for i,d in ipairs(bans)do
            local nick = getBanNick(d)
            if nick == objetive then
                if(removeBan(d))then
                    return outputChatBox("#56c450El jugador #24C5BE"..objetive.." #56c450ha sido #FF0000desbaneado #56c450del servidor.", source, 0,0,0, true)
                end
            end
        end
        outputChatBox("#56c450El jugador #24C5BE"..objetive.." #56c450no esta #FF0000baneado.", source, 0,0,0, true)
    end
    addCommandHandler("desban", Desbanear_Jugador)
    addCommandHandler("desbanear", Desbanear_Jugador)
    addCommandHandler("unban", Desbanear_Jugador)
    addCommandHandler("unbanear", Desbanear_Jugador)
    
    function Cambiar_Contra(source, command, objetive, ...)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 5) then
            return outputChatBox("No tienes rango", source, 0,0,0, true)
        end
        local newPass = table.concat({...}, " ")
        if not (objetive) or not (#newPass > 2) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Cuenta] [Nueva Contraseña]", source, 0, 0, 0, true)
        end
        local account = getAccount(objetive)
        if not (account) then
            return outputChatBox("#56c450La cuenta #24C5BE"..objetive.." #56c450no existe", source, 0,0,0, true)
        end
        setAccountPassword(account, newPass)
        outputChatBox("#56c450Contrasña de la cuenta #24C5BE"..objetive.." #56c450cambiada", source, 0,0,0, true)
    end
    addCommandHandler("cambiarPass", Cambiar_Contra)
    
    addCommandHandler("cambiarname", function(source, command, objetive, newname)
            
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta') --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
        if not (rank["Rango"] >= 5) then -- COMPROBAMOS SI SU RANGO ES MENOR A 3.
            return --CANCELAMOS LA EJECUCION DEL COMANDO
        end
        local staff = getAccountName(getPlayerAccount(source))
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (varDataSource) or not (varDataSource.Estado) then
            cancelEvent()
            return
        end

        local cooldownTime = 1000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        if not (objetive) or not (newname) then
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/cambiarname [Player] [NewName]", source, 255, 255, 255, true)
            return
        end
        if not (#newname > 3) then
            return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535El nombre no puede ser menosr a 3 caracteres.", source, 255, 255, 255, true )
        end
        if not (#newname < 22) then
            return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535El nombre no puede pasar de los 20 caracteres.", source, 255, 255, 255, true )
        end
        if not (string.find(newname, "_"))then
            return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535El nombre y el apellido tienen que estar separados por un _ (Nombre_Apellido).", source, 255, 255, 255, true )
        end
        if not (string.match(newname, "^[A-Za-z_]+$")) then
            return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535El nombre y el apellido no deben tener caracteres especiales ni numeros.", source, 255, 255, 255, true )
        end

        objetivo = nil;
        if (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end

        if not (objetivo) then
            local DataPJ = exports["MR1_Inicio"]:query('SELECT * FROM Personajes WHERE Nombre = ?', objetive)
            
            if DataPJ == nil or next(DataPJ) == nil then
                outputChatBox("#56c450El personaje #24C5BE"..objetive.." #56c450no existe en la DB", source, 0, 0, 0, true)
                return
            else
                -- Si el personaje existe, proceder con el cambio de nombre
                local updateResult = exports["MR1_Inicio"]:execute('UPDATE Personajes SET Nombre = ? WHERE Nombre = ?', newname, objetive)
                if updateResult then
                    outputChatBox("#56c450El nombre del personaje ha sido cambiado a #24C5BE"..newname, source, 0, 0, 0, true)
                    exports["MR15_Discord"]:sendDiscordChangeName(objetive, newname, staff)
                else
                    outputChatBox("#A03535Hubo un error al intentar cambiar el nombre del personaje.", source, 255, 255, 255, true)
                end
            end
        else
            local DataPJ = exports["MR1_Inicio"]:query('SELECT * FROM Personajes WHERE Nombre = ?', getPlayerName(objetivo))
            
            if DataPJ == nil or next(DataPJ) == nil then
                outputChatBox("#56c450El personaje #24C5BE"..objetive.." #56c450no existe en la DB", source, 0, 0, 0, true)
                return
            else
                -- Si el personaje existe, proceder con el cambio de nombre
                local updateResult = exports["MR1_Inicio"]:execute('UPDATE Personajes SET Nombre = ? WHERE Nombre = ?', newname, getPlayerName(objetivo))
                if updateResult then
                    outputChatBox("#56c450El nombre del personaje ha sido cambiado a #24C5BE"..newname, source, 0, 0, 0, true)
                    exports["MR15_Discord"]:sendDiscordChangeName(getPlayerName(objetivo), newname, staff)
                    setPlayerName(objetivo, newname)
                else
                    outputChatBox("#A03535Hubo un error al intentar cambiar el nombre del personaje.", source, 255, 255, 255, true)
                end
            end
        end
    end)
    addCommandHandler("cambiarnacionalidad", function(source, command, objetive, newnacion)    
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta') --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
        if not (rank["Rango"] >= 5) then -- COMPROBAMOS SI SU RANGO ES MENOR A 3.
            return --CANCELAMOS LA EJECUCION DEL COMANDO
        end
        local staff = getAccountName(getPlayerAccount(source))
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (varDataSource) or not (varDataSource.Estado) then
            cancelEvent()
            return
        end

        local cooldownTime = 1000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        if not (objetive) or not (newnacion) then
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/cambiarnacionalidad [Player] [NewNacion]", source, 255, 255, 255, true)
            return
        end
        if not (#newnacion > 3) then
            return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535La nacionalidad no puede ser menor a 3 caracteres.", source, 255, 255, 255, true )
        end
        if not (#newnacion < 22) then
            return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535La nacionalidad no puede pasar de los 20 caracteres.", source, 255, 255, 255, true )
        end
        if not (string.match(newnacion, "^[A-Za-z_ñÑ]+$")) then
            return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535La nacionalidad no deben tener caracteres especiales ni numeros.", source, 255, 255, 255, true )
        end

        objetivo = nil;
        if (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end

        if (objetivo) then
            local ObjetiveData = exports["MR1_Inicio"]:getValueOne(objetivo) --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
            ObjetiveData.Informacion["Nacionalidad"] = newnacion;
            exports["MR1_Inicio"]:setValue(objetivo, "Informacion", ObjetiveData.Informacion)
            outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Se ha restablecido la nacionalidad a #24C5BE"..newnacion.."#53B440, del personaje #24C5BE"..getPlayerName(objetivo).."#53B440.", source, 255, 255, 255, true )
        
            exports["MR15_Discord"]:sendDiscordChangeNacionalidad(getPlayerName(objetivo), newnacion, staff)
        end
    end)
    addCommandHandler("cambiarsexo", function(source, command, objetive, newSexo)    
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta') --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
        if not (rank["Rango"] >= 5) then -- COMPROBAMOS SI SU RANGO ES MENOR A 3.
            return --CANCELAMOS LA EJECUCION DEL COMANDO
        end
        local staff = getAccountName(getPlayerAccount(source))
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (varDataSource) or not (varDataSource.Estado) then
            cancelEvent()
            return
        end

        local cooldownTime = 1000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        if not (objetive) or not (newSexo) then
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/cambiarsexo [Player] [Masculino/Femenino]", source, 255, 255, 255, true)
            return
        end
        local newSkin = nil
        if newSexo == "Masculino" then
            newSkin = 26
        elseif newSexo == "Femenino" then
            newSkin = 41
        else
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/cambiarsexo [Player] [Masculino/Femenino]", source, 255, 255, 255, true)
            return
        end

        objetivo = nil;
        if (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end

        if (objetivo) then
            local ObjetiveData = exports["MR1_Inicio"]:getValueOne(objetivo) --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
            ObjetiveData.Informacion["Sexo"] = newSexo;
            exports["MR1_Inicio"]:setValue(objetivo, "Informacion", ObjetiveData.Informacion)
            ObjetiveData.Estado["Skin"] = newSkin;
            exports["MR1_Inicio"]:setValue(objetivo, "Estado", ObjetiveData.Estado)

            setPedSkin(objetivo, newSkin)

            outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Se ha restablecido el sexo a #24C5BE"..newSexo.."#53B440, del personaje #24C5BE"..getPlayerName(objetivo).."#53B440.", source, 255, 255, 255, true )
            exports["MR15_Discord"]:sendDiscordChangeSexo(getPlayerName(objetivo), newSexo, staff)
        end
    end)
-- Rango 6 ADM Empresas
-- Rango 7 ADM Familias
-- Rango 8 ADM Facciones
-- Rango 9 ADM Staff
    function setRankOOC(source, command, objetive, rango) 
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (varDataSource.InfoCuenta["Rango"] == 9 or varDataSource.InfoCuenta["Rango"] == 10) then
            return iprint("False")
        end
        local staff = getAccountName(getPlayerAccount(source))
        objetivo = nil;
        if not (objetive) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario] [Rango]", source, 0, 0, 0, true)
        end
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end

        local varDataObjetivo = exports["MR1_Inicio"]:getValueOne(objetivo)
        varDataObjetivo.InfoCuenta["Rango"] = tonumber(rango)
        exports["MR1_Inicio"]:setValue(objetivo, "InfoCuenta", varDataObjetivo.InfoCuenta)

        local AccountObjetivo = getAccountName(getPlayerAccount(objetivo))
        exports["MR1_Inicio"]:execute("UPDATE Cuentas SET Rango='"..tonumber(rango).."' WHERE Usuario = ?", AccountObjetivo)

        outputChatBox("#FF6F00Rango "..tonumber(rango).." entregado a "..getPlayerName(objetivo).."", source, 200, 200, 200, true)

    end
    addCommandHandler("setRank", setRankOOC)
-- Rango 10 OWNER
    function Ir_a_Ver_A_Dios(source, command, objetive)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 10) then
            return
        end
        if not (objetive) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario]", source, 0, 0, 0, true)
        end
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if not (objetivo) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        local staff = getAccountName(getPlayerAccount(source))
        if getPedOccupiedVehicle(objetivo) then removePedFromVehicle(objetivo) end
        local x, y, z = getElementPosition(objetivo)
        exports["MR5_Interiores"]:Cambiar_De_Interior_A_Pie(objetivo, 0, 0, x, y, 100000, 0, 0, 0)	
        outputChatBox("#FF7800"..staff.." #56c450te llevo a ver a Dios", objetivo, 0,0,0, true)
    end
    addCommandHandler ("dios", Ir_a_Ver_A_Dios)
    function Cambiar_Cuenta(source, command, objetive, ...)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 10) then
            return
        end
        local newName = table.concat({...}, " ")
        if not (objetive) or not (#newName > 2) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Cuenta] [Nuevo Nombre]", source, 0, 0, 0, true)
        end
        local account = getPlayerAccount(getPlayerFromName(objetive))
        if not (account) then
            return outputChatBox("#56c450La cuenta #24C5BE"..objetive.." #56c450no existe", source, 0,0,0, true)
        end
        Cuenta = exports["MR1_Inicio"]:query("SELECT * FROM Cuentas WHERE Usuario=?", getAccountName(account))
        if not (Cuenta[1]["Usuario"] == getAccountName(account)) then 
            return outputChatBox("#56c450La cuenta #24C5BE"..Cuenta[1]["Usuario"].." #56c450no existe en la DB", source, 0,0,0, true) 
        end
        exports["MR1_Inicio"]:execute("UPDATE Cuentas SET Usuario='"..newName.."', WHERE Usuario=?", getAccountName(account))
        setAccountName(account, newName)
        outputChatBox("#56c450Nombre de la cuenta #24C5BE"..objetive.." #56c450cambiado a "..newName, source, 0,0,0, true)
    end
    addCommandHandler("cambiarCuenta", Cambiar_Cuenta)
    local blipsUsuarios = {}  -- Tabla para almacenar los blips de los jugadores
    local locaUsers = false
    
    function LocalizarUser(source, command)
        -- Obtener el rango del jugador
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not rank or not (rank["Rango"] >= 4) then
            return outputChatBox("No tienes permiso para usar este comando.", source, 255, 0, 0)
        end
    
        if locaUsers then
            -- Eliminar todos los blips que se han creado anteriormente
            for player, blip in pairs(blipsUsuarios) do
                if isElement(blip) then
                    destroyElement(blip)
                end
                blipsUsuarios[player] = nil  -- Eliminar el jugador de la tabla
            end
            outputChatBox("Se han eliminado todos los blips de los usuarios.", source, 255, 0, 0)
            locaUsers = false
        else
            -- Crear blips para todos los jugadores conectados
            for _, player in ipairs(getElementsByType("player")) do
                if player ~= source and not blipsUsuarios[player] then  -- No marcarse a sí mismo
                    local blip = createBlipAttachedTo(player, 0, 2, 255, 128, 0, 255, 0, 99999, source)
                    blipsUsuarios[player] = blip  -- Almacenar el blip en la tabla
                end
            end
            outputChatBox("Todos los usuarios han sido marcados en el mapa con un blip.", source, 0, 255, 0)
            locaUsers = true
        end
    end
    
    -- Evento para eliminar el blip si un jugador sale del servidor
    addEventHandler("onPlayerQuit", root, function()
        if blipsUsuarios[source] then
            destroyElement(blipsUsuarios[source])  -- Eliminar el blip
            blipsUsuarios[source] = nil  -- Eliminar el jugador de la tabla
        end
    end)
    
    addCommandHandler("locateUser", LocalizarUser)
    



