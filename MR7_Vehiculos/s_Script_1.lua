-- MR7_Vehiculos
-- Gestiona el sistema de Vehiculos
-- Autor: ElTitoJet
-- Fecha: 04/03/2024

-- Variables Globales y Configuración
    local letras = {}
    local varTabla_Color_NewCar = {255, 120, 0};
    local Bikes = {509, 481, 510}
    local sinCinturon = {472, 473, 493, 595, 484, 430, 453, 452, 446, 454, 581, 509, 481, 462, 521, 463, 510, 522, 461, 448, 468, 586, 485, 523, 531, 530, 471}
    local cooldowns = {}
    local VehiculosUsuarios = {}
    local pendingSales = {}
-- Funciones Auxiliares
    function isBike(vehModel)
        for i, VehSin in ipairs(Bikes) do
            if VehSin == vehModel then
                return true
            end
        end
    end
    function noCinturon(vehModel)
        for i, VehSin in ipairs(sinCinturon) do
            if VehSin == vehModel then
                return true
            end
        end
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
    function formatNumber(n)
        local formatted = n
        while true do  
            formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
            if (k==0) then
                break
            end
        end
        return formatted
    end

-- Funciones Principales

    function Entrar_Vehiculo(Player, seat, jacked)
        local varDataPlayer = exports["MR1_Inicio"]:getValueOne(Player)
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(source)

        if (varDataPlayer) and (varDataPlayer.Cinturon == true) then
            varDataPlayer.Cinturon = false
            exports["MR1_Inicio"]:setValue(Player, "Cinturon", varDataPlayer.Cinturon)
        end

        local varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z = getElementPosition(Player)
        local varPosicion_Vehiculo_X, varPosicion_Vehiculo_Y, varPosicion_Vehiculo_Z = getElementPosition(source)
        if not (getDistanceBetweenPoints3D(varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z, varPosicion_Vehiculo_X, varPosicion_Vehiculo_Y, varPosicion_Vehiculo_Z) <= 6) then
            cancelEvent()
            return
        end
        if not (varDataVehicle) then
            destroyElement(source)
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Lo siento eso vehiculo no deberia existir.", Player, 255, 255, 255, true) 
        end
        if isElement(jacked) and (getElementType(jacked)=="player") and (tonumber(seat) == 0) then
            cancelEvent()
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Si quieres hacer CJ, rolea sacarlo del seat y que se baje el.", Player, 255, 0, 0, true)
        end
        if (isBike(getVehicleModelFromName(getVehicleName(source))) == true) then
            --iprint(source)
            setVehicleEngineState(source, true)
            --iprint(getVehicleEngineState(source, true))
            varDataVehicle.Estado["Motor"] = true
            varDataVehicle.Estado["Bloqueo"] = false
            exports["MR1_Inicio"]:setValue(source, 'Estado', varDataVehicle.Estado)
            --Establecer_Bloqueo(source, false)
            return
        end
        if (varDataVehicle) and (varDataVehicle.Estado["Bloqueo"] == true) then
            outputChatBox("#BEC72AEl vehiculo ("..getVehicleName(source).." - "..varDataVehicle.Informacion["Matricula"]..") esta cerrado", Player, 255, 255, 255, true)
            cancelEvent()
            return
        end
    end
    function EntroAlVeh(Player, seat, jacked)
        if seat == 0 then
            local varDataVehicle = exports["MR1_Inicio"]:getValueOne(source)
            if varDataVehicle and varDataVehicle.Estado then
                --iprint(varDataVehicle.Inventario)
                setVehicleEngineState(source, varDataVehicle.Estado["Motor"])
                if varDataVehicle.Estado["Luces"] then
                    setVehicleOverrideLights(source, 2)
                else
                    setVehicleOverrideLights(source, 1)
                end
            end
        end
    end
    function Salir_Vehiculo(Player)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(Player)
        if (varDataSource) and (varDataSource.Cinturon == true) then
            outputChatBox("#ffe100Deberia quitarme el cinturon...", Player, 255, 255, 255, true)
            cancelEvent()
        end
    end
    function Vehicle_Damaged(loss)
        if (isBike(getElementModel(source))) then 
            cancelEvent()
            return  
        end
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(source)
        if (varDataVehicle) then
            estado = varDataVehicle.Estado
            if getElementHealth(source) < 300 then
                setElementHealth(source, 300)
                setVehicleEngineState(source, false)
                setVehicleOverrideLights(source, 1)
                estado.Destruido = true
                estado.Motor = false
                estado.Salud = 300
                exports["MR1_Inicio"]:setValue(source, "Estado", estado)
            end
        end
        if not (loss > 100) then
            return
        end
        for i, Player in pairs(getVehicleOccupants(source)) do
            local varDataSource = exports["MR1_Inicio"]:getValueOne(Player)
            if (varDataSource) and (varDataSource.Cinturon == true) then
                setElementHealth(Player, getElementHealth(Player) - ((loss * 0.1) / 2))
            end
            if (varDataSource) and (varDataSource.Cinturon ~= true) then
                setElementHealth(Player, getElementHealth(Player) - (loss * 0.1))
            end
        end
    
    end
    function Vehiculo_Explotado()
        if (isBike(getElementModel(source))) then return cancelEvent() end
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(source)
        if (varDataVehicle) and (varDataVehicle.ID) then
            local varResult_DB = exports["MR1_Inicio"]:query("SELECT * FROM VehiculosUsuarios WHERE ID = ?", varDataVehicle.ID)
            if not (varResult_DB) then
                return
            end
            if (varResult_DB[1].ID == varDataVehicle.ID) then
                --ESTADO
                    local varNewEstado = toJSON{Salud = 300, Destruido = true, Bloqueo = true, Motor = false, Luces = false}
                
                --Tunning
                        local CR0, CG0, CB0, CR1, CG1, CB1, CR2, CG2, CB2, CR3, CG3, CB3 = getVehicleColor(source, true)
                        local LR, LG, LB = getVehicleHeadLightColor(source)
                        local Tunning = {Color = {
                            R0 = CR0, G0 = CG0, B0 = CB0, R1 = CR1, G1 = CG1, B1 = CB1, R2 = CR2, G2 = CG2, B2 = CB2, R3 = CR3, G3 = CG3, B3 = CB3
                        }, Luces = {
                            R = LR, G = LG, B = LB
                        }, Modificaciones = {
                            getVehicleUpgrades(source)
                        }, Paintjob = getVehiclePaintjob(source)
                        };

                exports["MR1_Inicio"]:execute("UPDATE VehiculosUsuarios SET Estado='"..varNewEstado.."', Tunning='"..toJSON(Tunning).."' WHERE ID=?", varDataVehicle.ID)
            end
            setTimer(function(source)
                destroyElement(source)
            end, 3000, 1, source)
        end
        if (varDataVehicle == nil) then
            setTimer(function(source)
                if isElement(source) then
                    destroyElement(source)
                end
            end, 3000, 1, source)
        end
    end
    function Comando_Bloqueo(source, command)
        local cooldownTime = 2000 -- 2000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end

        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        local varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z = getElementPosition(source)
        if not (varDataSource) or not (varDataSource.Informacion) then
            return 
        end
        -- Estas dentro del vehiculo
            if (isPedInVehicle(source)) then
                local varDataVehicle = exports["MR1_Inicio"]:getValueOne(getPedOccupiedVehicle(source))
                if not (varDataVehicle) then
                    return
                end
                --if (isBike(getVehicleModelFromName(getVehicleName(getPedOccupiedVehicle(source)))) ~= true) then
                
                    if (varDataVehicle.IDPersonaje == varDataSource.IDPersonaje) then
                        Cambiar_Bloqueo(source, getPedOccupiedVehicle(source))
                        return
                    end
                    if (varDataVehicle.Personaje == varDataSource.Trabajos["Trabajo"]) then
                        Cambiar_Bloqueo(source, getPedOccupiedVehicle(source))
                        return
                    end
                    if (varDataVehicle.Personaje == varDataSource.Familia["Nombre"]) then
                        Cambiar_Bloqueo(source, getPedOccupiedVehicle(source))
                        return
                    end
                    local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
                    if (rank["Rango"] >= 4) then
                        Cambiar_Bloqueo(source, Vehicle)
                        return
                    end
                --end
                return
            end
        -- No estas dentro del vehiculo
            for i, Vehicle in ipairs(getElementsByType("vehicle")) do
                local varPosicion_Vehiculo_X, varPosicion_Vehiculo_Y, varPosicion_Vehiculo_Z = getElementPosition(Vehicle)
                local varDataVehicle = exports["MR1_Inicio"]:getValueOne(Vehicle)
                if (getDistanceBetweenPoints3D(varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z, varPosicion_Vehiculo_X, varPosicion_Vehiculo_Y, varPosicion_Vehiculo_Z) <= 4) then
                    --if (isBike(getVehicleModelFromName(getVehicleName(Vehicle))) == true) then
                    --    return 
                    --end
                    if not (varDataVehicle) then
                        return 
                    end
                    if (varDataVehicle.IDPersonaje == varDataSource.IDPersonaje) then
                        Cambiar_Bloqueo(source, Vehicle)
                        return
                    end
                    if (varDataVehicle.Personaje == varDataSource.Trabajos["Trabajo"]) then
                        Cambiar_Bloqueo(source, Vehicle)
                        return
                    end
                    if (varDataVehicle.Personaje == varDataSource.Familia["Nombre"]) then
                        Cambiar_Bloqueo(source, Vehicle)
                        return
                    end
                    
                    local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
                    if (rank["Rango"] >= 4) then
                        Cambiar_Bloqueo(source, Vehicle)
                        return
                    end
                end
            end
    end
    function Cambiar_Bloqueo(source, vehicle)
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
        if not (varDataVehicle) then
            return
        end
        if (varDataVehicle.Estado["Bloqueo"] == true) then
            varDataVehicle.Estado["Bloqueo"] = false
            exports["MR1_Inicio"]:setValue(vehicle, 'Estado', varDataVehicle.Estado)
            Establecer_Bloqueo(source, vehicle, false)
            return outputChatBox("#32CD32> Vehiculo ("..getVehicleName(vehicle).." - "..varDataVehicle.Informacion["Matricula"]..") abierto.", source, 246, 0, 255, true)
        end
        varDataVehicle.Estado["Bloqueo"] = true
        exports["MR1_Inicio"]:setValue(vehicle, 'Estado', varDataVehicle.Estado)
        Establecer_Bloqueo(source, vehicle, true)
        setVehicleDoorOpenRatio ( vehicle, 2, 0)
        setVehicleDoorOpenRatio ( vehicle, 3, 0)
        setVehicleDoorOpenRatio ( vehicle, 4, 0)
        setVehicleDoorOpenRatio ( vehicle, 5, 0)
        return outputChatBox("#32CD32> Vehiculo ("..getVehicleName(vehicle).." - "..varDataVehicle.Informacion["Matricula"]..") cerrado.", source, 255, 255, 255, true)
    end
    function Establecer_Bloqueo(source, vehicle, state)
        local accion = nil
        if state then
            accion = "#9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #F600FF"..getPlayerName(source).." toma su llave y bloquea su vehiculo."
        else
            accion = "#9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #F600FF"..getPlayerName(source).." toma su llave y abre su vehiculo."
        end

        setVehicleLocked(vehicle, state)
        local varSourcePosX, varSourcePosY, varSourcePosZ = getElementPosition(source)
        for _, player in ipairs(getElementsByType("player")) do
            local varPlayerPosX, varPlayerPosY, varPlayerPosZ = getElementPosition(player)
            if getDistanceBetweenPoints3D(varSourcePosX, varSourcePosY, varSourcePosZ, varPlayerPosX, varPlayerPosY, varPlayerPosZ) <= 7 then
                outputChatBox(accion, player, 246, 0, 255, true)
            end
        end
    end
    function Comando_Motor(source, command)
        local cooldownTime = 2000 -- 2000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        if not (isPedInVehicle(source)) then
            return
        end
        local vehicle = getPedOccupiedVehicle(source)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
        if not (getVehicleOccupant(vehicle, 0) == source) then
            return
        end
    
        if (isBike(getVehicleModelFromName(getVehicleName(vehicle))) == true) then
            return
        end
        if not (varDataVehicle) then
            return
        end
        estado = varDataVehicle.Estado
        --iprint(estado)
        if (estado.Destruido == "semi") or (estado.Destruido == true) then
            return outputChatBox("#ffe100El vehiculo parece estar roto, mejor llamo a un mecanico...", source, 255, 255, 255, true) 
        end
        if (varDataVehicle.Personaje == "Server") then
            Cambiar_Motor(source, vehicle)
            return
        end
        if (varDataVehicle.IDPersonaje == varDataSource.IDPersonaje) then
            Cambiar_Motor(source, vehicle)
            return
        end
        
        if (varDataVehicle.Personaje == varDataSource.Familia["Nombre"]) then
            Cambiar_Motor(source, vehicle)
            return
        end
        if (varDataVehicle.Personaje == varDataSource.Trabajos["Trabajo"]) then
            Cambiar_Motor(source, vehicle)
            return
        end
        outputChatBox("#ffe100Este no es mi vehiculo ni el de mi trabajo...", source, 255, 255, 255, true)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if (rank["Rango"] >= 4) then
            Cambiar_Motor(source, vehicle)
            return
        end
        
    end 
    function Cambiar_Motor(source, vehicle)
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
        local motor = nil
        local entorno = nil
        if (varDataVehicle.Estado["Motor"] == true) then
            motor = false
            entorno = "#BEC72A* El motor del vehiculo("..getVehicleName(vehicle)..") fue apagado."
        else
            motor = true
            entorno = "#BEC72A* El motor del vehiculo("..getVehicleName(vehicle)..") fue encendido."
        end

        varDataVehicle.Estado["Motor"] = motor
        exports["MR1_Inicio"]:setValue(vehicle, 'Estado', varDataVehicle.Estado)
        setVehicleEngineState(vehicle, motor)
        local varPosicion_Vehiculo_X, varPosicion_Vehiculo_Y, varPosicion_Vehiculo_Z = getElementPosition(vehicle)
        for i, Player in ipairs(getElementsByType("player")) do
            local varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z = getElementPosition(Player)
            if getDistanceBetweenPoints3D(varPosicion_Vehiculo_X, varPosicion_Vehiculo_Y, varPosicion_Vehiculo_Z, varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z) <= 13 then
                outputChatBox(entorno, Player, 255, 255, 255, true)
            end
        end
    end
    function Comando_Luces(source, command)
        if not (getPedOccupiedVehicle(source)) then
            return 
        end
        local vehicle = getPedOccupiedVehicle(source)
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
        if not (getVehicleOccupant(vehicle, 0) == source) then
            return
        end
        if varDataVehicle.Estado["Luces"] then
            setVehicleOverrideLights(vehicle, 2)
            varDataVehicle.Estado["Luces"] = false
        else
            setVehicleOverrideLights(vehicle, 1)
            varDataVehicle.Estado["Luces"] = true
        end
        exports["MR1_Inicio"]:setValue(vehicle, 'Estado', varDataVehicle.Estado)
    end
    function Comando_Cinturon(source, command)

        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (isPedInVehicle(source)) then
            return
        end
        local cooldownTime = 2000 -- 2000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        if (noCinturon(getVehicleModelFromName(getVehicleName(getPedOccupiedVehicle(source)))) == true) then
            outputChatBox("#ffe100Creo que deberia leer como funciona este vehiculo...", source, 255, 255, 255, true)
            return
        end

        local cinturon = nil
        local accion = nil
        if (varDataSource.Cinturon ~= true) then
            varDataSource.Cinturon = true
            accion = "#32CD32* Se ve como "..getPlayerName(source).." se coloca el cinturon."
        else
            varDataSource.Cinturon = false
            accion = "#32CD32* Se ve como "..getPlayerName(source).." se quita el cinturon."
        end
        exports["MR1_Inicio"]:setValue(source, "Cinturon", varDataSource.Cinturon)
        local varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z = getElementPosition(source)
        for i, Player in ipairs(getElementsByType("player")) do
            local varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z = getElementPosition(Player)
            if getDistanceBetweenPoints3D(varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z, varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z) <= 5 then
                outputChatBox(accion, Player, 255, 255, 255, true)
            end
        end
    end
    function localizarvehiculos(source, command)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        local SourcePosX, SourcePosY, SourcePosZ = getElementPosition(source)
        for _, player in ipairs(getElementsByType("player")) do
            local PlayerPosX, PlayerPosY, PlayerPosZ = getElementPosition(player)
            if getDistanceBetweenPoints3D(SourcePosX, SourcePosY, SourcePosZ, PlayerPosX, PlayerPosY, PlayerPosZ) <= 7 then
                outputChatBox("#F600FF"..getPlayerName(source).." saca su GPS y localiza sus vehiculos.", player, 246, 0, 255, true)
            end
        end

        local Vehiculos = exports["MR1_Inicio"]:query('SELECT * FROM VehiculosUsuarios WHERE IDPersonaje = ?', varDataSource.IDPersonaje)
        local count = 0;
        for i, Vehicle in ipairs(Vehiculos) do 
            local vehEstado = fromJSON(Vehicle.ESTADO)
            if (vehEstado.Destruido == true) then
                count = count +1
            end
        end
        if count > 0 then
            outputChatBox("#ffe100Tienes vehiculos en el desguace.", source, 255, 255, 255, true)
        end
        for i, vehicle in ipairs(getElementsByType('vehicle')) do
            local DataVeh = exports['MR1_Inicio']:getValueOne(vehicle)
            if DataVeh ~= nil then
                if DataVeh.IDPersonaje == varDataSource.IDPersonaje then
                    local InfoVeh = DataVeh.Informacion
                    local VehiclePosX, VehiclePosY, VehiclePosZ = getElementPosition(vehicle)
                    outputChatBox("#ffe100Mi vehiculo "..getVehicleNameFromModel(getElementModel(vehicle)).."("..InfoVeh.Matricula..") esta en "..getZoneName(VehiclePosX, VehiclePosY, VehiclePosZ)..".", source, 255, 255, 255, true)
                
                    if not VehiculosUsuarios[vehicle] then
                        VehiculosUsuarios[vehicle] = {}
                        VehiculosUsuarios[vehicle][1] = source
                        blip = createBlipAttachedTo(vehicle, 0, 3, 255, 0, 0, 255, 10, 65535, source)
                        VehiculosUsuarios[vehicle][2] = blip
                        local timer = setTimer(function()
                            destroyElement(VehiculosUsuarios[vehicle][2])
                            VehiculosUsuarios[vehicle] = nil
                        end, 30000, 1)
                        VehiculosUsuarios[vehicle][3] = timer
                    end
                end
            end
        end
    end
    function venderVehiculoCommand(source, command, objetive, precio)
        local cooldownTime = 2000 -- 2000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        
        local vehicle = getPedOccupiedVehicle(source)
        if not vehicle then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Debes estar en el vehiculo subido y de conductor.", source, 255, 255, 255, true) 
        end
        local seat = getPedOccupiedVehicleSeat(source)
        if seat ~= 0 then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Debes estar en el vehiculo subido y de conductor.", source, 255, 255, 255, true) 
        end
    
        -- Verificar si el vehículo tiene dueño
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)

        if string.find(varDataVehicle.Informacion["Matricula"], "Bike") then
            outputChatBox("#FF0000No puedes vender una bicicleta de alquiler.", source, 255, 255, 255, true)
            unbindKey(Conductor, "H")
            return
        end
        if varDataSource["IDPersonaje"] ~= varDataVehicle["IDPersonaje"] then
            return outputChatBox("#ffe100Creo que no esta bien vender un vehiculo que no es mio...", source, 255, 255, 255, true)
        end

        if not (objetive) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/vendervehiculo [Jugador] [Precio]", source, 255, 255, 255, true)
        end
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if source == objetivo then
            return outputChatBox("#ffe100Deberia hacerme un examen de inteligencia...", source, 255, 255, 255, true)
        end
    
        -- Verificar que el precio es un número válido
        if not precio or tonumber(precio) <= 0 then
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/vendervehiculo [Jugador] [Precio]", source, 255, 0, 0, true)
            return
        end

        -- Almacenar la oferta de venta
        pendingSales[objetivo] = { vehicle = vehicle, seller = source, price = tonumber(precio) }
        
        -- Notificar al comprador
        outputChatBox("#24C5BE"..getPlayerName(source) .. " #e8ceb0te ofrece comprar su vehículo "..varDataVehicle.Informacion["Matricula"].." por #00ff57" .. formatNumber(math.abs(math.floor(tonumber(precio)))) .. " $#e8ceb0. Escribe #FFFFFF/confirmarcompra #e8ceb0para aceptar.", objetivo, 0, 255, 0, true)
        outputChatBox("#e8ceb0Has #ffcc00ofrecido #e8ceb0tu vehículo "..varDataVehicle.Informacion["Matricula"].." a #24C5BE" .. getPlayerName(objetivo) .. " #e8ceb0por #00ff57" .. formatNumber(math.abs(math.floor(tonumber(precio)))) .. " $#e8ceb0.", source, 0, 255, 0, true)
    end
    function confirmarCompraCommand(source, command)
        local cooldownTime = 2000 -- 2000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        local sale = pendingSales[source]
        
        if not sale then
            outputChatBox("#ffe100Ojala me vendieran un vehiculo...", Player, 255, 255, 255, true)
            return
        end
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if varDataSource.Inventario["Dinero"] < sale.price then
            outputChatBox("#ffe100¿Y como voy a pagar esto?...", source, 255, 255, 255, true)
            return
        end
    
        local varDataObjetivo = exports["MR1_Inicio"]:getValueOne(sale.seller)
        local cantidadFormateada = formatNumber(math.abs(math.floor(tonumber(sale.price))))
    
        --varDataSource.Inventario["Dinero"] = varDataSource.Inventario["Dinero"] - tonumber(sale.price);
        --exports["MR1_Inicio"]:setValue(source, "Inventario", varDataSource.Inventario)
        exports["MR6_Economia"]:restarDinero(source, tonumber(sale.price), "MR7_Vehiculos")
    
        --varDataObjetivo.Inventario["Dinero"] = varDataObjetivo.Inventario["Dinero"] + tonumber(sale.price);
        --exports["MR1_Inicio"]:setValue(sale.seller, "Inventario", varDataObjetivo.Inventario)
        exports["MR6_Economia"]:SumarDinero(sale.seller, tonumber(sale.price), "MR7_Vehiculos")

        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(sale.vehicle)
        varDataVehicle["IDPersonaje"] = varDataSource["IDPersonaje"]
        exports["MR1_Inicio"]:setValue(sale.vehicle, "IDPersonaje", varDataSource["IDPersonaje"])


        exports["MR1_Inicio"]:execute("UPDATE VehiculosUsuarios SET IDPersonaje='"..varDataSource["IDPersonaje"].."' WHERE ID=?", varDataVehicle.ID)

        -- Notificar a ambas partes
        outputChatBox("#e8ceb0Has comprado el vehículo por #00ff57" .. cantidadFormateada .. " $#e8ceb0.", source, 0, 255, 0, true)
        outputChatBox("#24C5BE"..getPlayerName(source) .. " #e8ceb0ha comprado tu vehículo por #00ff57" .. cantidadFormateada .. " $#e8ceb0.", sale.seller, 0, 255, 0, true)

        pendingSales[source] = nil
    end
    function maletero (source, command)
        local cooldownTime = 2000 -- 2000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        local vehicle = nil;
        local inVehicle = nil;
        if isPedInVehicle(source) then
            vehicle = getPedOccupiedVehicle(source)
            inVehicle = true
        else
            local varPositionSourceX, varPositionSourceY, varPositionSourceZ = getElementPosition(source)
            for i, Vehicle in ipairs(getElementsByType("vehicle")) do
                local varPositionVehX, varPositionVehY, varPositionVehZ = getElementPosition(Vehicle)
                if (getDistanceBetweenPoints3D(varPositionSourceX, varPositionSourceY, varPositionSourceZ, varPositionVehX, varPositionVehY, varPositionVehZ) <= 5) then    
                    vehicle = Vehicle
                end
            end
            inVehicle = false
        end

        if not vehicle then
            return 
        end
        if inVehicle then
            if getVehicleDoorOpenRatio (vehicle, 1) == 1 then
                return outputChatBox("#ffe100Necesito comprarme unas gafas, ya esta abierto...", source, 255, 255, 255, true)
            end
            setVehicleDoorOpenRatio ( vehicle, 1, 1)
        else
            if getVehicleDoorOpenRatio (vehicle, 1) == 1 then
                setVehicleDoorOpenRatio ( vehicle, 1, 0)
                return 
            end
            
            local varDataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
            if (varDataVehicle.Personaje == varDataSource.Trabajos["Trabajo"]) then
                setVehicleDoorOpenRatio ( vehicle, 1, 1)
                return
            end 
            if (varDataVehicle.Personaje == varDataSource.Familia["Nombre"]) then
                setVehicleDoorOpenRatio ( vehicle, 1, 1)
                return
            end
            if (varDataVehicle.IDPersonaje ~= varDataSource.IDPersonaje) then
                return outputChatBox("#ffe100Este vehiculo no es mio...", source, 255, 255, 255, true)
            end
            if varDataVehicle.Estado["Bloqueo"] then
                return outputChatBox("#ffe100El vehiculo esta bloqueado...", source, 255, 255, 255, true)
            end
            setVehicleDoorOpenRatio ( vehicle, 1, 1)
        end
    end
    function capo (source, command)
        local cooldownTime = 2000 -- 2000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        local vehicle = nil;
        local inVehicle = nil;
        if isPedInVehicle(source) then
            vehicle = getPedOccupiedVehicle(source)
            inVehicle = true
        else
            local varPositionSourceX, varPositionSourceY, varPositionSourceZ = getElementPosition(source)
            for i, Vehicle in ipairs(getElementsByType("vehicle")) do
                local varPositionVehX, varPositionVehY, varPositionVehZ = getElementPosition(Vehicle)
                if (getDistanceBetweenPoints3D(varPositionSourceX, varPositionSourceY, varPositionSourceZ, varPositionVehX, varPositionVehY, varPositionVehZ) <= 5) then    
                    vehicle = Vehicle
                end
            end
            inVehicle = false
        end
        if not vehicle then
            return
        end
        if inVehicle then
            if getVehicleDoorOpenRatio (vehicle, 0) == 1 then
                return outputChatBox("#ffe100Necesito comprarme unas gafas, ya esta abierto...", source, 255, 255, 255, true)
            end
            setVehicleDoorOpenRatio ( vehicle, 0, 1)
        else
            if getVehicleDoorOpenRatio (vehicle, 0) == 1 then
                setVehicleDoorOpenRatio ( vehicle, 0, 0)
                return 
            end
            
            local varDataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
            if (varDataVehicle.IDPersonaje ~= varDataSource.IDPersonaje) then
                return outputChatBox("#ffe100Este vehiculo no es mio...", source, 255, 255, 255, true)
            end
            if varDataVehicle.Estado["Bloqueo"] then
                return outputChatBox("#ffe100El vehiculo esta bloqueado...", source, 255, 255, 255, true)
            end
            setVehicleDoorOpenRatio ( vehicle, 0, 1)
        end
    end
    function vermaletero (source, command)
        local cooldownTime = 2000 -- 2000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        local vehicle = nil;
        if isPedInVehicle(source) then
            return outputChatBox("#ffe100No tengo poderes telepaticos, deberia bajarme y verlo yo mismo...", source, 255, 255, 255, true)
        else
            local varPositionSourceX, varPositionSourceY, varPositionSourceZ = getElementPosition(source)
            for i, Vehicle in ipairs(getElementsByType("vehicle")) do
                local varPositionVehX, varPositionVehY, varPositionVehZ = getElementPosition(Vehicle)
                if (getDistanceBetweenPoints3D(varPositionSourceX, varPositionSourceY, varPositionSourceZ, varPositionVehX, varPositionVehY, varPositionVehZ) <= 5) then    
                    vehicle = Vehicle
                end
            end
        end
        if getVehicleDoorOpenRatio (vehicle, 1) == 0 then
            return outputChatBox("#ffe100No tengo rayos X, deberia abrir el maletero...", source, 255, 255, 255, true)
        end
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
        --iprint(varDataVehicle.Inventario)
        outputChatBox("#00ff57======[[ #00ff57Maletero "..varDataVehicle.Informacion["Matricula"].."#00ff57 ]]======", source, 0,0,0, true)

        local slotsOrdenados = {}
        for slot in pairs(varDataVehicle.Inventario) do
            table.insert(slotsOrdenados, slot)
        end
        table.sort(slotsOrdenados, function(a, b)
            return tonumber(a:match("%d+")) < tonumber(b:match("%d+"))
        end)
        for _, slot in ipairs(slotsOrdenados) do
            local data = varDataVehicle.Inventario[slot]
            local objeto = data.Objeto or "Ninguno"
            local cantidad = data.Cantidad or 0
            outputChatBox("#00FF00" .. slot .. ": " .. objeto .. " x" .. cantidad, source, 255, 255, 255, true)
        end
    end
    function MaleteroInsert(source, command, object, cantidad)
        local cooldownTime = 2000 -- 2000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end

        if not (object) then
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/metermaletero [Objeto] [Cantidad]", source, 255, 255, 255, true)
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFObjetos: Dinero, Arma", source, 255, 255, 255, true)
            return 
        end
        
        if not (cantidad) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/metermaletero [Objeto] [Cantidad]", source, 255, 255, 255, true)
        end

        local vehicle = nil;
        if isPedInVehicle(source) then
            return outputChatBox("#ffe100No puedo meter cosas desde aqui...", source, 255, 255, 255, true)
        else
            local varPositionSourceX, varPositionSourceY, varPositionSourceZ = getElementPosition(source)
            for i, Vehicle in ipairs(getElementsByType("vehicle")) do
                local varPositionVehX, varPositionVehY, varPositionVehZ = getElementPosition(Vehicle)
                if (getDistanceBetweenPoints3D(varPositionSourceX, varPositionSourceY, varPositionSourceZ, varPositionVehX, varPositionVehY, varPositionVehZ) <= 5) then    
                    vehicle = Vehicle
                end
            end
        end
        if getVehicleDoorOpenRatio (vehicle, 1) == 0 then
            return outputChatBox("#ffe100No quiero pagar un nuevo maletero, deberia de abrirlo...", source, 255, 255, 255, true)
        end
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
        local inventario = varDataVehicle.Inventario or {}

        local slotsOrdenados = {}
        for slot in pairs(varDataVehicle.Inventario) do
            table.insert(slotsOrdenados, slot)
        end
        table.sort(slotsOrdenados, function(a, b)
            return tonumber(a:match("%d+")) < tonumber(b:match("%d+"))
        end)

        -- Buscar el primer slot vacío
            local slotDisponible = nil
            for _, slot in ipairs(slotsOrdenados) do
                if inventario[slot].Objeto == "Ninguno" then
                    slotDisponible = slot
                    break
                end
            end
            if slotDisponible then
                if object == "dinero" or object == "Dinero" then
                    local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
                    if tonumber(cantidad) > 0 and tonumber(cantidad) <= 20000 then
                        --varDataSource.Inventario["Dinero"] = varDataSource.Inventario["Dinero"] - tonumber(cantidad);
                        
                        exports["MR6_Economia"]:restarDinero(source, cantidad, "MR7_Vehiculos")
                        --exports["MR1_Inicio"]:setValue(source, "Inventario", varDataSource.Inventario)
                        -- Insertar el objeto en el slot disponible
                            inventario[slotDisponible].Objeto = "Dinero"
                            inventario[slotDisponible].Cantidad = tonumber(cantidad)
                    else
                        return outputChatBox("#ffe100Deberia meter como maximo 20.000 $...", source, 255, 255, 255, true)
                    end
                    outputChatBox("#00FF00Has metido " .. cantidad .. " de " .. object .. " en " .. slotDisponible, source, 255, 255, 255, true)
                elseif object == "arma" or object == "Arma" then
                    local varDataSource = exports["MR1_Inicio"]:getValueOne(source)

                    local slot, weapon = exports["weapon_system"]:getFromPed(source)
                    if not (weapon) or (slot == 0) then
                        return outputChatBox("#ffe100No puedo guardar mis puños, no soy Rayman...", source, 255, 255, 255, true)
                    end
                    local ammoToSave = tonumber(cantidad)
                    if (ammoToSave > weapon.clip + weapon.ammo ) then
                        return outputChatBox("#ffe100No tengo tanta municion...", source, 255, 255, 255, true)
                    elseif (ammoToSave > 2000) then
                        return outputChatBox("#ffe100No puedo guardar tanta municion...", source, 255, 255, 255, true)
                    elseif (ammoToSave < 1) then
                        return outputChatBox("#ffe100No puedo guardar 0 balas...", source, 255, 255, 255, true)
                    end
                    exports["weapon_system"]:take(source, weapon.id, ammoToSave)
                    exports["MR15_Discord"]:sendDiscordArmasStaff("Quitar", source, ammoToSave, weapon.id, "MR7_Vehiculos(metermaletero)")
                    inventario[slotDisponible].Objeto = getWeaponNameFromID(weapon.id)
                    inventario[slotDisponible].Cantidad = ammoToSave
                    outputChatBox("#00FF00Has metido " .. cantidad .. " de " .. object .. " en " .. slotDisponible, source, 255, 255, 255, true)
                end
                -- Actualizar la información en el vehículo
                exports["MR1_Inicio"]:setValue(vehicle, 'Inventario', inventario)
            else
                -- No hay slots disponibles
                outputChatBox("#ffe100El maletero está lleno, no puedes meter más objetos.", source, 255, 255, 255, true)
            end
    end
    function MaleteroExtraer(source, command, slot)
        local cooldownTime = 2000 -- 2000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        if not (slot) then
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/sacarmaletero [Slot]", source, 255, 255, 255, true)
            return 
        end
        local vehicle = nil;
        if isPedInVehicle(source) then
            return outputChatBox("#ffe100No quiero pagar un nuevo maletero, deberia de abrirlo...", source, 255, 255, 255, true)
        else
            local varPositionSourceX, varPositionSourceY, varPositionSourceZ = getElementPosition(source)
            for i, Vehicle in ipairs(getElementsByType("vehicle")) do
                local varPositionVehX, varPositionVehY, varPositionVehZ = getElementPosition(Vehicle)
                if (getDistanceBetweenPoints3D(varPositionSourceX, varPositionSourceY, varPositionSourceZ, varPositionVehX, varPositionVehY, varPositionVehZ) <= 5) then    
                    vehicle = Vehicle
                end
            end
        end
        if getVehicleDoorOpenRatio (vehicle, 1) == 0 then
            return outputChatBox("#ffe100No tengo rayos X, deberia abrir el maletero...", source, 255, 255, 255, true)
        end
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
        local inventario = varDataVehicle.Inventario or {}

        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        -- Verificar si el slot existe en el inventario
            local slotKey = "Slot " .. tonumber(slot)
            if inventario[slotKey] then
                local objeto = inventario[slotKey].Objeto
                local cantidad = inventario[slotKey].Cantidad

                -- Verificar si el slot tiene algún objeto
                --iprint(objeto)
                --iprint(cantidad)
                if objeto ~= "Ninguno" and tonumber(cantidad) > 0 then
                    -- Extraer el objeto (puedes ajustar esto según tus necesidades)
                    
                    if objeto == "Dinero" then
                        -- Insertar el objeto en el slot disponible
                        --varDataSource.Inventario["Dinero"] = varDataSource.Inventario["Dinero"] + inventario[slotKey].Cantidad;
                        --exports["MR1_Inicio"]:setValue(source, "Inventario", varDataSource.Inventario)
                        exports["MR6_Economia"]:SumarDinero(source, inventario[slotKey].Cantidad, "MR7_Vehiculos")
                    else
                        if getWeaponIDFromName(objeto) then
                            --iprint(getWeaponIDFromName(objeto))
                            exports["weapon_system"]:give(source, getWeaponIDFromName(objeto), tonumber(cantidad), true)
                            exports["MR15_Discord"]:sendDiscordArmasStaff("Dar", source, tonumber(cantidad), getWeaponIDFromName(objeto), "MR7_Vehiculos(Sacarmaletero)")
                        end
                    end

                    inventario[slotKey] = { Objeto = "Ninguno", Cantidad = 0 }
                    exports["MR1_Inicio"]:setValue(vehicle, 'Inventario', inventario)

                    outputChatBox("#00FF00Has extraído " .. cantidad .. " de " .. objeto .. " del " .. slotKey, source, 255, 255, 255, true)
                else
                    return outputChatBox("#ffe100No hay nada en este hueco...", source, 255, 255, 255, true)
                end
            else
                outputChatBox("#ffe100El " .. slotKey .. " no existe en el maletero.", source, 255, 255, 255, true)
            end

    end

-- Eventos y Handlers
    addEventHandler("onVehicleStartEnter", getRootElement(), Entrar_Vehiculo)
    addEventHandler("onVehicleEnter", getRootElement(), EntroAlVeh)
    addEventHandler("onVehicleStartExit", getRootElement(), Salir_Vehiculo)
    addEventHandler("onVehicleDamage", getRootElement(), Vehicle_Damaged)
    addEventHandler("onVehicleExplode", getRootElement(), Vehiculo_Explotado)
    addCommandHandler("bloqueo", Comando_Bloqueo)
    addCommandHandler("motor", Comando_Motor)
    addCommandHandler("luces", Comando_Luces)
    addCommandHandler("cinturon", Comando_Cinturon)
    addCommandHandler('localizarveh', localizarvehiculos)
    addCommandHandler("vendervehiculo", venderVehiculoCommand)
    addCommandHandler("confirmarcompra", confirmarCompraCommand)
    addCommandHandler("maletero", maletero)
    addCommandHandler("capo", capo)
    addCommandHandler("vermaletero", vermaletero)
    addCommandHandler("metermaletero", MaleteroInsert)
    addCommandHandler("sacarmaletero", MaleteroExtraer)
