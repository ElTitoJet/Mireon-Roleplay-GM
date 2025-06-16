-- MR6_Economia
-- Gestiona el sistema de Economia
-- Autor: ElTitoJet
-- Fecha: 01/03/2024

-- Variables Globales y Configuración
    local atmCols = {}
    local atmBlips = {}
    local cooldowns = {}
    local MAX_TRANSACCION = 100000
    local MIN_TRANSACCION = 1
-- Funciones Auxiliares
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
    function esCantidadValida(cantidad)
        if cantidad == "Todo" then
            return true -- "Todo" es un valor válido
        end
        -- Validar si es un número válido
        return type(cantidad) == "number" and cantidad >= MIN_TRANSACCION and cantidad <= MAX_TRANSACCION
    end
-- Funciones Principales
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
    function spawnCajeros()
        exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS Cajeros ( ID INT NOT NULL AUTO_INCREMENT, Ubicacion VARCHAR(255) NOT NULL, PRIMARY KEY (ID));")

        local varLista_Cajeros = exports["MR1_Inicio"]:query("SELECT * FROM Cajeros")
        if not (varLista_Cajeros) then
            return
        end
        for i, Cajero in ipairs(varLista_Cajeros) do
            local varPosicion = fromJSON(varLista_Cajeros[i].Ubicacion)
            local varCajero = createObject(2942, varPosicion["x"], varPosicion["y"], varPosicion["z"]-0.5, varPosicion["rotX"], varPosicion["rotY"], varPosicion["rotZ"])
            setElementDimension(varCajero, varPosicion["dim"])
            setElementInterior(varCajero, varPosicion["int"])
            setElementData(varCajero, "ID", Cajero.ID)
            setElementCollisionsEnabled(varCajero, false)

            local varColision = createColSphere(varPosicion["x"], varPosicion["y"], varPosicion["z"], 1)
            atmCols[Cajero.ID] = varColision;

            local varIcono_Cajero = createBlip(varPosicion["x"], varPosicion["y"], varPosicion["z"], 52, 2, 255, 0, 0, 255, 0, 200)
            atmBlips[Cajero.ID] = varIcono_Cajero;

            addEventHandler("onColShapeHit", varColision, function(source, Dimension)
                if not (getElementType(source) == "player") or isPedInVehicle(source) then
                    return
                end
                outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Presiona #FFFFFFH #53B440 para abrir el cajero.", source, 255, 255, 255, true)
                bindKey(source, "H", "down", function(source)
                    triggerClientEvent(source, "abrirATM", source, i)
                    unbindKey(source, "H")
                end)
            end)
            addEventHandler("onColShapeLeave", varColision, function(source)
                if getElementType(source) == "player" then
                    unbindKey(source, "H")
                end
            end)
        end
    end
    function Guardar_Dinero(cantidad)
        local varInfoClient = exports["MR1_Inicio"]:getValueOne(client)
        if not (varInfoClient) or not (varInfoClient.Informacion) or not (varInfoClient.Inventario) then
            return
        end
        if not esCantidadValida(cantidad) then
            outputChatBox("#FF0000Cantidad inválida. Solo puedes depositar entre "..MIN_TRANSACCION.."$ y "..MAX_TRANSACCION.."$ o 'Todo'.", client, 255, 255, 255, true)
            return
        end
        local NumeroFormato = formatNumber(varInfoClient.Inventario["Dinero"])
        if (cantidad == "Todo") then
            if varInfoClient.Inventario["Dinero"] <= 0 then
                return outputChatBox("#FF0000No tienes suficiente dinero para guardar.", client, 255, 255, 255, true)
            end
            cantidad = varInfoClient.Inventario["Dinero"]
            varInfoClient.Inventario["Dinero"] = 0
            restarDinero(client, cantidad, "MR6_Economia")
        else
            if cantidad > varInfoClient.Inventario["Dinero"] then
                return outputChatBox("#FF0000No tienes esa cantidad de dinero para guardar.", client, 255, 255, 255, true)
            end
            varInfoClient.Inventario["Dinero"] = varInfoClient.Inventario["Dinero"] - cantidad
            restarDinero(client, cantidad, "MR6_Economia")
        end
        varInfoClient.Informacion["Banco"] = varInfoClient.Informacion["Banco"] + cantidad

        -- Guardar los datos actualizados
        exports["MR1_Inicio"]:setValue(client, "Informacion", varInfoClient.Informacion)
        --exports["MR1_Inicio"]:setValue(client, "Inventario", varInfoClient.Inventario)
    
        -- Mensaje de confirmación
        outputChatBox("#9AA498[#FF7800ATM#9AA498] #53B440Has guardado #FFFFFF"..formatNumber(cantidad).." $.", client, 255, 255, 255, true)
    end
    function Retirar_Dinero(cantidad)
        local varInfoClient = exports["MR1_Inicio"]:getValueOne(client)
        if not varInfoClient or not varInfoClient.Informacion or not varInfoClient.Inventario then
            return
        end
        if not esCantidadValida(cantidad) then
            outputChatBox("#FF0000Cantidad inválida. Solo puedes retirar entre "..MIN_TRANSACCION.."$ y "..MAX_TRANSACCION.."$ o 'Todo'.", client, 255, 255, 255, true)
            return
        end
        if (cantidad == "Todo") then
            if varInfoClient.Informacion["Banco"] <= 0 then
                return outputChatBox("#FF0000No tienes suficiente dinero en el banco.", client, 255, 255, 255, true)
            end
    
            cantidad = varInfoClient.Informacion["Banco"]
            varInfoClient.Informacion["Banco"] = 0
        else
            if cantidad > varInfoClient.Informacion["Banco"] then
                return outputChatBox("#FF0000No tienes esa cantidad de dinero en el banco.", client, 255, 255, 255, true)
            end
    
            varInfoClient.Informacion["Banco"] = varInfoClient.Informacion["Banco"] - cantidad
        end
         -- Añadir el dinero al inventario
        varInfoClient.Inventario["Dinero"] = varInfoClient.Inventario["Dinero"] + cantidad
        SumarDinero(client, cantidad, "MR6_Economia")

        -- Guardar los datos actualizados
        exports["MR1_Inicio"]:setValue(client, "Informacion", varInfoClient.Informacion)
        exports["MR1_Inicio"]:setValue(client, "Inventario", varInfoClient.Inventario)

        -- Mensaje de confirmación
        outputChatBox("#9AA498[#FF7800ATM#9AA498] #53B440Has retirado #FFFFFF"..formatNumber(cantidad).." $.", client, 255, 255, 255, true)
    end
    function Pagar(source, command, objetive, cantidad)
        local cooldownTime = 5000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        local informacion_Source = exports["MR1_Inicio"]:getValueOne(source)
        if not (informacion_Source) or not (informacion_Source.Informacion) or not (informacion_Source.Inventario) then
            return
        end
        if not (objetive) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/pagar [Jugador] [Cantidad]", source, 255, 255, 255, true)
        end
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
        local informacion_Objetive = exports["MR1_Inicio"]:getValueOne(objetivo)
        if not (getPlayerName(source) ~= objetive) then
            return outputChatBox("#ffe100No puedo crear dinero de la nada...", source, 255, 255, 255, true)
        end
        if not (informacion_Objetive) or not (informacion_Objetive.Informacion) or not (informacion_Objetive.Inventario) then
            return outputChatBox("#ffe100No puedo pasarle dinero a un fantasma...", source, 255, 255, 255, true)
        end
        if not (cantidad) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/pagar [Jugador] [Cantidad]", source, 255, 255, 255, true)
        end
        if not (informacion_Source.Inventario["Dinero"] >= math.abs(math.floor(tonumber(cantidad)))) then
            return outputChatBox("#ffe100No tengo ese dinero...", source, 255, 255, 255, true)
        end
        local varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z = getElementPosition(source)
        local varPosicion_Objetivo_X, varPosicion_Objetivo_Y, varPosicion_Objetivo_Z = getElementPosition(objetivo)
        if not (getDistanceBetweenPoints3D(varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z, varPosicion_Objetivo_X, varPosicion_Objetivo_Y, varPosicion_Objetivo_Z) <= 5) then 
            return outputChatBox("#ffe100No puedo pagarle si no esta al lado mio...", source, 255, 255, 255, true)
        end
    
        local cantidadFormateada = formatNumber(math.abs(math.floor(tonumber(cantidad))))
    
        --informacion_Source.Inventario["Dinero"] = informacion_Source.Inventario["Dinero"] - math.abs(math.floor(tonumber(cantidad)));
        --exports["MR1_Inicio"]:setValue(source, "Inventario", informacion_Source.Inventario)
        restarDinero(source, cantidad, "MR6_Economia")

        --informacion_Objetive.Inventario["Dinero"] = informacion_Objetive.Inventario["Dinero"] + math.abs(math.floor(tonumber(cantidad)));
        --exports["MR1_Inicio"]:setValue(objetivo, "Inventario", informacion_Objetive.Inventario)
        SumarDinero(objetivo, cantidad, "MR6_Economia")
        outputChatBox("#9AA498[#FF7800Server#9AA498] #FF7800"..getPlayerName(source).." #53B440te ha entregado #FF7800"..cantidadFormateada, objetivo, 255, 255, 255, true) -- USER
        outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Le has entregado #FF7800"..cantidadFormateada.." #53B440a #FF7800"..getPlayerName(objetivo), source, 255, 255, 255, true) -- USER
        for _, player in ipairs(getElementsByType("player")) do
            local varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z = getElementPosition(player)
            if getDistanceBetweenPoints3D(varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z, varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z) <= 7 then
                outputChatBox("#F600FF"..getPlayerName(source).." saca su dinero y se lo entrega a "..getPlayerName(objetivo)..".", player, 246, 0, 255, true)
            end
        end
    end
    function restarDinero(objetivo, cantidad, script)
        local varDataObjetivo = exports["MR1_Inicio"]:getValueOne(objetivo)
        if not (varDataObjetivo) or not (varDataObjetivo.Informacion) or not (varDataObjetivo.Inventario) then
            return
        end
        varDataObjetivo.Inventario["Dinero"] = varDataObjetivo.Inventario["Dinero"] - cantidad;
        exports["MR1_Inicio"]:setValue(objetivo, "Inventario", varDataObjetivo.Inventario)
        exports["MR15_Discord"]:sendDiscordDineroStaff("Restar", objetivo, cantidad, script)
    end
    function SumarDinero(objetivo, cantidad, script)
        local varDataObjetivo = exports["MR1_Inicio"]:getValueOne(objetivo)
        if not (varDataObjetivo) or not (varDataObjetivo.Informacion) or not (varDataObjetivo.Inventario) then
            return
        end
    
        varDataObjetivo.Inventario["Dinero"] = varDataObjetivo.Inventario["Dinero"] + math.abs(math.floor(tonumber(cantidad)));
        exports["MR1_Inicio"]:setValue(objetivo, "Inventario", varDataObjetivo.Inventario)
        exports["MR15_Discord"]:sendDiscordDineroStaff("Sumar", objetivo, cantidad, script)
    end
    
-- Eventos y Handlers
    addEventHandler("onResourceStart", resourceRoot, spawnCajeros)
    addEvent("GuardarDinero", true)
    addEventHandler("GuardarDinero", root, Guardar_Dinero)
    addEvent("SacarDinero", true)
    addEventHandler("SacarDinero", root, Retirar_Dinero)
    addCommandHandler("pagar", Pagar)

    function CrearCajero(source, commandname)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if varDataSource.InfoCuenta["Rango"] >= 8 then
            x, y, z = getElementPosition(source)
            RotX, RotY, RotZ = getElementRotation(source)
            dim = getElementDimension(source)
            int = getElementInterior(source)
        
            Pos = toJSON({x=x, y=y, z=z, rotX=RotX, rotY=RotY, rotZ=RotZ, dim=dim, int=int})
        
            crear = createObject(2942, x, y, z-0.5, RotX, RotY, RotZ)
            setElementDimension(crear, dim)
            setElementInterior(crear, int)
            setElementCollisionsEnabled(crear, false)
            if crear then
                setElementPosition(source, x, y, z+1)
            end
        
            col = createColSphere(x, y, z, 2)
            table.insert(atmCols, col)
            blip = createBlip(x, y, z, 36, 2, 255, 0, 0, 255, 0, 200)
            table.insert(atmBlips, blip)
            
            exports["MR1_Inicio"]:execute("INSERT INTO Cajeros(Ubicacion) VALUES(?)", Pos)
        end
    end
    addCommandHandler("crearcajero", CrearCajero)