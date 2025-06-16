-- MR4_CHATS
-- Gestiona el sistema de CHAT
-- Autor: ElTitoJet
-- Fecha: 01/03/2024

-- Variables Globales y Configuración
    local varRango_Voz_Susurro = 4;
    local varRango_Voz_Normal = 10;
    local varRango_Voz_Grito = 20;
    local varRango_Comando_Me = 10;
    local varRango_Comando_B = 10;
    local varRango_Comando_Do = 20;
    local cooldowns = {}
-- Funciones Auxiliares
    function Comprobar_Rango_Source(source)
        if isElement( source ) then
            local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
            local result = exports["MR1_Inicio"]:query("SELECT Abreviatura FROM Rangos WHERE ID=?", tonumber(rank.Rango));
            if result and #result == 1 then
                return result[1].Abreviatura
            end
        end
        return 'none'
    end

    function isOnCooldown(player, command, cooldownTime)
        if not cooldowns[player] then
            cooldowns[player] = {}
        end

        if isElement(player) then
            local lastUsed = cooldowns[player][command] or 0
            local currentTime = getTickCount()
        
            if currentTime - lastUsed < cooldownTime then
                return true -- El jugador está en cooldown
            else
                cooldowns[player][command] = currentTime
                return false -- El jugador no está en cooldown
            end
        end
    end
-- Funciones Principales
    function chatComando(source, command, ...)
        local infoPlayer = exports["MR1_Inicio"]:getValueOne(source)
        if not (infoPlayer) or not (infoPlayer.Estado) then
            cancelEvent()
            return
        end

        local cooldownTime = 1000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end

        local message = table.concat({...}, " ")
        if (message == "") then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Mensaje]", source, 255, 255, 255, true)
        end

        local varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z = getElementPosition(source)
        local varInterior_Source = getElementInterior(source)
        local varDimension_Source = getElementDimension(source)

        local color = nil;
        local rangovoz = nil;

        if command == "s" or command == "sus" or command == "susurro" or command == "susurrar" then
            if not (infoPlayer.Estado["Muerto"] == false) then
                return
            end
            text = "#9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #A8A8A8"..getPlayerName(source).." susurro: "..message;
            rangovoz = varRango_Voz_Susurro;
        elseif command == "g" or command == "gr" or command == "gritar" then
            if not (infoPlayer.Estado["Muerto"] == false) then
                return
            end
            text = "#9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #ddd379"..getPlayerName(source).." grita: "..message
            rangovoz = varRango_Voz_Grito;
        elseif command == "b" or command == "ooc" then
            if not (infoPlayer.Estado["Muerto"] == false) then
                return
            end
            text = "#9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #00BFFF((OOC)) "..getPlayerName(source).." ["..Comprobar_Rango_Source(source).."#00BFFF]: "..message
            rangovoz = varRango_Comando_B;
        elseif command == "do" or command == "entorno" then
            text = "#9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #32CD32"..message.." ["..getPlayerName(source).."]"
            rangovoz = varRango_Comando_Do;
        end 

        outputChatBox(text, source, 255,255,255, true)

        for _, player in ipairs(getElementsByType("player")) do
            if getPlayerFromName(getPlayerName(source)) ~= player then
                local varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z = getElementPosition(player)
                local varInterior_Player = getElementInterior(player)
                local varDimension_Player = getElementDimension(player)

                if varDimension_Source == varDimension_Player then
                    if varInterior_Source == varInterior_Player then
                        if (getDistanceBetweenPoints3D(varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z, varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z) <= rangovoz) then
                            outputChatBox(text, player, 255,255,255, true)
                        end
                    end
                end
            end
        end
    end

    function chatDefault(message, messageType)
        local infoPlayer = exports["MR1_Inicio"]:getValueOne(source)
        if not (infoPlayer) or not (infoPlayer.Estado) then
            cancelEvent()
            return
        end
        cancelEvent()
        if not (infoPlayer.Estado["Muerto"] == false) then
            return outputChatBox("Estas muerto genio.", source)
        end
        local command = nil;

        if (messageType == 0) then
            command = "say"
        elseif (messageType == 1) then
            command = "me"
        end

        message = string.gsub(message, "^%s*(.-)%s*$", "%1") -- Eliminar espacios al inicio y al final
        if (message == "") or #message < 2 then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFEl mensaje tiene que ser mas largo.", source, 255, 255, 255, true)
        end

        local cooldownTime = 1000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end

        local color = nil;
        local rangovoz = nil;

        if command == "say" then
            text = "#9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #FFFFFF"..getPlayerName(source).." dice: "..message;
            rangovoz = varRango_Voz_Normal;
        elseif command == "me" then
            text = "#9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #F600FF"..getPlayerName(source).." "..message;
            rangovoz = varRango_Voz_Normal;
        end 

        local varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z = getElementPosition(source)
        local varInterior_Source = getElementInterior(source)
        local varDimension_Source = getElementDimension(source)

        outputChatBox(text, source, 255,255,255, true)

        for _, player in ipairs(getElementsByType("player")) do
            if getPlayerFromName(getPlayerName(source)) ~= player then
                local varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z = getElementPosition(player)
                local varInterior_Player = getElementInterior(player)
                local varDimension_Player = getElementDimension(player)

                if varDimension_Source == varDimension_Player then
                    if varInterior_Source == varInterior_Player then
                        if (getDistanceBetweenPoints3D(varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z, varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z) <= rangovoz) then
                            outputChatBox(text, player, 255,255,255, true)
                        end
                    end
                end
            end
        end
    end

    function Ocultar_Comando_B(source, command)
        local cooldownTime = 2000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        local informacion_Source = exports["MR1_Inicio"]:getValueOne(source)
        if not (informacion_Source) or not (informacion_Source.Informacion) then
            return
        end
        if informacion_Source.Ajustes["togb"] == nil or informacion_Source.Ajustes["togb"] == false then
            informacion_Source.Ajustes["togb"] = true;
            exports["MR1_Inicio"]:setValue(source, 'Ajustes', informacion_Source.Ajustes)
            outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Ahora no puedes ver los /b y /ooc.", source, 255, 255, 255, true)
        else
            informacion_Source.Ajustes["togb"] = false;
            exports["MR1_Inicio"]:setValue(source, 'Ajustes', informacion_Source.Ajustes)
            outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Ahora puedes ver los /b y /ooc.", source, 255, 255, 255, true)
        end
    end

    function Ocultar_Comando_MP(source, command)
        local cooldownTime = 2000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        local informacion_Source = exports["MR1_Inicio"]:getValueOne(source)
        if not (informacion_Source) or not (informacion_Source.Informacion) then
            return
        end
        if informacion_Source.Ajustes["togmp"] == nil or informacion_Source.Ajustes["togmp"] == false then
            informacion_Source.Ajustes["togmp"] = true;
            exports["MR1_Inicio"]:setValue(source, 'Ajustes', informacion_Source.Ajustes)
            outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Ahora no puedes ver los /mp.", source, 255, 255, 255, true)
        else
            informacion_Source.Ajustes["togmp"] = false;
            exports["MR1_Inicio"]:setValue(source, 'Ajustes', informacion_Source.Ajustes)
            outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Ahora puedes ver los /mp.", source, 255, 255, 255, true)
        end
    end

    function Hablar_Privado_Comando_MP(source, command, objetive, ...)
        local cooldownTime = 2000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        local informacion_Source = exports["MR1_Inicio"]:getValueOne(source)
        if not (informacion_Source) or not (informacion_Source.Informacion) then
            return
        end
        if not (informacion_Source.Ajustes["togmp"] == false) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Tienes los /mp apagados. Usa /togmp para encenderlos.", source, 255, 255, 255, true) 
        end
        if not (objetive) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/mp [Jugador o ID] [Mensaje]", source, 255, 255, 255, true)
        end
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end

        local message = table.concat({...}, " ")
        if (message == "") or not (#message >= 1) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/mp [Jugador] [Mensaje]", source, 255, 255, 255, true)
        end

        local informacion_Objetivo = exports["MR1_Inicio"]:getValueOne(objetivo)
        if not (informacion_Objetivo) or not (informacion_Objetivo.Informacion) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535No puedes enviar un mensaje a un jugador sin logear.", source, 255, 255, 255, true)
        end
        if (informacion_Objetivo.Ajustes["togmp"] == true) then
            if not (informacion_Objetivo.InfoCuenta["Rango"] >=3) then
                return outputChatBox("#9AA498[#FF7800Server#9AA498] #24C5BE"..getPlayerName(objetivo).." #A03535tiene los /mp apagados.", source, 255, 255, 255, true) 
            end
            outputChatBox("#9AA498[#53B440MP Staff#9AA498] #53b440-> #9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(objetivo).."#9AA498] #24C5BE"..getPlayerName(objetivo).." :#FF7800 "..message, source, 255, 255, 255, true)
            outputChatBox("#9AA498[#A03535MP Staff#9AA498] #A03535<- #9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #24C5BE"..getPlayerName(source).." :#FF7800 "..message, objetivo, 255, 255, 255, true)
            triggerClientEvent( objetivo, "Recibir_MP", objetivo )
            playSoundFrontEnd ( objetivo, 43)
        else
            outputChatBox("#9AA498[#53B440MP#9AA498] #53b440-> #9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(objetivo).."#9AA498] #24C5BE"..getPlayerName(objetivo).." :#FF7800 "..message, source, 255, 255, 255, true)
            outputChatBox("#9AA498[#A03535MP#9AA498] #A03535<- #9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #24C5BE"..getPlayerName(source).." :#FF7800 "..message, objetivo, 255, 255, 255, true)
            triggerClientEvent( objetivo, "Recibir_MP", objetivo )
            playSoundFrontEnd ( objetivo, 43)
        end

        for i, player in ipairs(getElementsByType("player")) do
            local informacion_Player = exports["MR1_Inicio"]:getValueOne(player)
            if not (informacion_Player == nil) and not (informacion_Player.InfoCuenta == nil) and not (informacion_Player.InfoCuenta["Rango"] == nil) then
                if (informacion_Player.InfoCuenta["Rango"] >= 5) then
                    if (informacion_Player.Ajustes["SpyMp"] == true) then

                        if (informacion_Objetivo.Ajustes["togmp"] == true) then
                            outputChatBox("#9AA498[#53B440MP Staff#9AA498] #9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #24C5BE"..getPlayerName(source).." #53b440-> #9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(objetivo).."#9AA498] #24C5BE"..getPlayerName(objetivo), player, 255, 255, 255, true)
                            outputChatBox("#9AA498[#53B440MP Staff#9AA498]#FF7800 "..message, player, 255, 255, 255, true)   
                        else
                            outputChatBox("#9AA498[#53B440MP#9AA498] #9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #24C5BE"..getPlayerName(source).." #53b440-> #9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(objetivo).."#9AA498] #24C5BE"..getPlayerName(objetivo), player, 255, 255, 255, true)
                            outputChatBox("#9AA498[#A03535MP#9AA498]#FF7800 "..message, player, 255, 255, 255, true)   
                        end
                    end
                end
            end
        end
    end

    function Spy_MP(source, command)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 3) then
            return
        end
        local cooldownTime = 2000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        local informacion_Source = exports["MR1_Inicio"]:getValueOne(source)
        if not (informacion_Source) or not (informacion_Source.Informacion) then
            return
        end
        if informacion_Source.Ajustes["SpyMp"] == nil or informacion_Source.Ajustes["SpyMp"] == false then
            informacion_Source.Ajustes["SpyMp"] = true;
            exports["MR1_Inicio"]:setValue(source, 'Ajustes', informacion_Source.Ajustes)
            outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Ahora puedes ver los /mp de todos.", source, 255, 255, 255, true)
        else
            informacion_Source.Ajustes["SpyMp"] = false;
            exports["MR1_Inicio"]:setValue(source, 'Ajustes', informacion_Source.Ajustes)
            outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Ahora ya no puedes puedes ver los /mp ajenos.", source, 255, 255, 255, true)
        end
    end

    function Hablar_Staff_Comando_A(source, command, ...)
        local informacion_Source = exports["MR1_Inicio"]:getValueOne(source)
        if not (informacion_Source) or not (informacion_Source.Informacion) or not (informacion_Source.InfoCuenta["Rango"] >=3) then
            return
        end
        local message = table.concat({...}, " ")
        if (message == "") then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/a [Mensaje]", source, 255, 255, 255, true)
        end
        for i, player in ipairs(getElementsByType("player")) do
            local informacion_Player = exports["MR1_Inicio"]:getValueOne(player)
            if (informacion_Player) and (informacion_Player.Informacion) and (informacion_Player.InfoCuenta["Rango"] >= 3) then
                outputChatBox("#9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #24c5beSTAFF - #FF7800"..getAccountName(getPlayerAccount(source)).." #24c5be[#FF7800"..Comprobar_Rango_Source(source).."#24c5be]: #FFFFFF"..message, player, 255, 255, 255, true)
            end
        end
        exports["MR15_Discord"]:sendDiscordChatStaff(getAccountName(getPlayerAccount(source)), Comprobar_Rango_Source(source), message)
    end

    
    function Realizar_Anuncio_Staff(source, command, ...)
        local informacion_Source = exports["MR1_Inicio"]:getValueOne(source)
        if not (informacion_Source) or not (informacion_Source.Informacion) or not (informacion_Source.InfoCuenta["Rango"] >=4) then
            return
        end
        local message = table.concat({...}, " ")
        if (message == "") then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/an [Mensaje]", source, 255, 255, 255, true)
        end
        for i, player in ipairs(getElementsByType("player")) do
            outputChatBox("#9AA498======[[ #00FF57Server Announce#9AA498 ]]======", player, 0,0,0, true)
            outputChatBox("#FFFFFF"..message, player, 0,0,0, true)
            outputChatBox(" ", player, 0,0,0, true)
            outputChatBox("#53B440~ #FF7800"..getAccountName(getPlayerAccount(source)), player, 0,0,0, true)
        end
    end

    function setFrecuencia(source, command, frecuencia)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (varDataSource) or not (varDataSource.Informacion) then
            return
        end
        local cooldownTime = 1000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        if not (varDataSource.Inventario.Items) or not (varDataSource.Inventario.Items.Radio) then
            outputChatBox("#ffe100No soy telepata, deberia comprar una radio...", source, 255, 255, 255, true) 
            return 
        end
        varDataSource.Informacion.Radio = varDataSource.Informacion.Radio or nil
        if not (frecuencia) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/hz [Frecuencia]", source, 255, 255, 255, true)
        end
        if (tonumber(frecuencia) < 1) or (tonumber(frecuencia) > 9999) then
            outputChatBox("#ffe100La radio solo tiene las frecuencia del 1 al 9999...", source, 255, 255, 255, true) 
            return
        end
        varDataSource.Informacion.Radio = tonumber(frecuencia)
        exports["MR1_Inicio"]:setValue(source, "Informacion", varDataSource.Informacion)
        local varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z = getElementPosition(source)
        for i, Player in ipairs(getElementsByType("player")) do
            local varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z = getElementPosition(Player)
            if getDistanceBetweenPoints3D(varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z, varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z) <= 5 then
                outputChatBox("#32CD32* Se ve como "..getPlayerName(source).." reajusta la frecuencia de su radio.", Player, 255, 255, 255, true)
            end
        end
        outputChatBox("#ffe100Acabo de ajustar la frecuencia en la "..tonumber(frecuencia).."...", source, 255, 255, 255, true) 
    end

    function hablarRadio(source, command, ...)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (varDataSource) or not (varDataSource.Estado) or not (varDataSource.Estado["Muerto"] == false) then
            cancelEvent()
            return
        end
        
        local cooldownTime = 1000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end

        if not (varDataSource.Inventario.Items) or not (varDataSource.Inventario.Items.Radio) then
            outputChatBox("#ffe100No soy telepata, deberia comprar una radio...", source, 255, 255, 255, true) 
            return 
        end

        if not (varDataSource.Informacion.Radio) then
            outputChatBox("#ffe100¿Esto esta encendido? A si, pero se me olvido ajustar la frecuencia...", source, 255, 255, 255, true) 
            return 
        end

        
        local message = table.concat({...}, " ")
        message = string.gsub(message, "^%s*(.-)%s*$", "%1") -- Eliminar espacios al inicio y al final
        if (message == "") or #message < 2 then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/r [Mensaje]", source, 255, 255, 255, true)
        end

        local varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z = getElementPosition(source)
        local varInterior_Source = getElementInterior(source)
        local varDimension_Source = getElementDimension(source)
        
        for i, player in ipairs(getElementsByType("player")) do
            local varDataPlayer = exports["MR1_Inicio"]:getValueOne(player)
            if (varDataPlayer) and (varDataPlayer.Informacion) and (varDataPlayer.Informacion.Radio) then

                if (varDataPlayer.Informacion.Radio == varDataSource.Informacion.Radio) then
                    outputChatBox("#9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #00ceff[RADIO - "..varDataSource.Informacion.Radio.."] "..getPlayerName(source).." dice: "..message , player, 255, 255, 255, true)
                else
                    if player ~= source then
                        local varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z = getElementPosition(player)
                        if getDistanceBetweenPoints3D(varPosicion_Source_X, varPosicion_Source_Y, varPosicion_Source_Z, varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z) <= varRango_Voz_Normal then
                            outputChatBox("#9AA498["..exports["MR2_Cuentas"]:getIDTempFromPlayer(source).."#9AA498] #FFFFFF"..getPlayerName(source).." habla por radio: "..message , player, 255, 255, 255, true)
                        end
                    end
                end

            end
        end
    end

    function verFrecuencia(source, command, objetive)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] >= 4) then
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
        local varDataObjetivo = exports["MR1_Inicio"]:getValueOne(objetivo)
        if not (varDataObjetivo.Inventario.Items) or not (varDataObjetivo.Inventario.Items.Radio) or not (varDataObjetivo.Informacion.Radio) then
            outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no tiene una radio.", source, 255, 255, 255, true)
            return 
        end
        outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440La frecuencia de "..getPlayerName(objetivo).." es "..varDataObjetivo.Informacion.Radio.. ".", source, 255, 255, 255, true)
    end
-- Eventos y Handlers
    addCommandHandler("hz", setFrecuencia)
    addCommandHandler("frec", setFrecuencia)
    addCommandHandler("r", hablarRadio)
    addCommandHandler("radio", hablarRadio)
    addCommandHandler("verhz", verFrecuencia)
    addCommandHandler("s", chatComando)
    addCommandHandler("sus", chatComando)
    addCommandHandler("susurro", chatComando)
    addCommandHandler("susurrar", chatComando)
    addEventHandler("onPlayerChat", getRootElement(), chatDefault)
    addCommandHandler("g", chatComando)
    addCommandHandler("gr", chatComando)
    addCommandHandler("gritar", chatComando)
    addCommandHandler("togb", Ocultar_Comando_B)
    addCommandHandler("b", chatComando)
    addCommandHandler("ooc", chatComando)
    addCommandHandler("do", chatComando)
    addCommandHandler("entorno", chatComando)
    addCommandHandler("togmp", Ocultar_Comando_MP)
    addCommandHandler("mp", Hablar_Privado_Comando_MP)
    addCommandHandler("spymp", Spy_MP)
    addCommandHandler("a", Hablar_Staff_Comando_A)
    addCommandHandler("A", Hablar_Staff_Comando_A)
    addCommandHandler("an", Realizar_Anuncio_Staff)
    addCommandHandler("anuncio", Realizar_Anuncio_Staff)