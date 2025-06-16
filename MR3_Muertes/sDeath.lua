-- MR3_Muertes
-- Gestiona el sistema de muerte de los personajes
-- Autor: ElTitoJet
-- Fecha: 22/02/2024

-- Variables Globales y Configuración
    local varRespawnOnDeath = {1805.1032714844, -1747.3720703125, 1112.0379638672, 0, 9, 0}; -- X, Y, Z, RotZ, Int, Dim --> varRespawnOnDeath[i]
    local varCosteTratamiento = 300;
    local varControlTable = { "fire", "aim_weapon", "forwards", "backwards", "left", "right", "zoom_in", "zoom_out",
    "change_camera", "jump", "sprint", "look_behind", "crouch", "action", "walk", "conversation_yes", "conversation_no",
    "group_control_forwards", "group_control_back", "enter_exit", "vehicle_fire", "vehicle_secondary_fire", "vehicle_left", "vehicle_right",
    "steer_forward", "steer_back", "accelerate", "brake_reverse", "radio_next", "radio_previous", "radio_user_track_skip", "horn", "sub_mission",
    "handbrake", "vehicle_look_left", "vehicle_look_right", "vehicle_look_behind", "vehicle_mouse_look", "special_control_left", "special_control_right",
    "special_control_down", "special_control_up" }
        
    local lastAttacker = {}
    local cooldown = 5000 -- Cooldown en milisegundos (5 segundos en este caso)
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
-- Funciones Principales
    function DeathDetect(ammo, attacker, weapon, bodypart)
        local varEstado = exports["MR1_Inicio"]:getValue(source, 'Estado')
        
        if not (varEstado ~= nil) then
            return
        end

        if (varEstado.Muerto == true) then
            local DataPJ = exports["MR1_Inicio"]:getValueOne(source)
            local inv = DataPJ.Inventario
            outputChatBox("#FFFFFF        ====== #FF6F00Pruebas de muerto "..getPlayerName(source).."#FFFFFF======", source, 200, 200, 200, true)
        
            local cantidadFormateada = formatNumber(math.abs(math.floor(tonumber(inv.Dinero))))
            outputChatBox("#FF7800Dinero: #FFFFFF"..cantidadFormateada.."", source, 200, 200, 200, true)
            for i, Licencia in pairs(inv.Licencias) do
                outputChatBox("#FF7800"..i..": #FFFFFF x1", source, 200, 200, 200, true)
            end
            if inv.Items then
                for i, Cantidad in pairs(inv.Items) do
                    outputChatBox("#FF7800"..i..": #FFFFFF x"..Cantidad.."", source, 200, 200, 200, true)
                end
            end
            local playerWeapons = (exports["weapon_system"]:getAllFromPed(source))
            if (playerWeapons) then
                for i, weapon in ipairs(playerWeapons) do
                    local fullammo = weapon.ammo + weapon.clip
        
                    if (weapon.id > 0) and (fullammo > 0) then
                        local municionformateada = formatNumber(math.abs(math.floor(tonumber(fullammo))))
                        outputChatBox("#FF7800"..getWeaponNameFromID(weapon.id)..": #FFFFFF"..municionformateada.." balas", source, 200, 200, 200, true)
                    end
                end
            end
            triggerClientEvent(source, "RematarClient", source, source)
            return
        end

        if isPedInVehicle(source) then
            removePedFromVehicle(source) -- removePedFromVehicle(getPedOccupiedVehicle(source))
        end
        
        local skin = getElementModel(source)
        local varX, varY, varZ = getElementPosition(source)
        spawnPlayer(source, varX, varY, varZ, 0, skin, getElementInterior(source), getElementDimension(source))
        setPedAnimation(source, "CRACK", "crckidle4", -1, true, false, false, false)
        varEstado.Muerto = true
        exports["MR1_Inicio"]:setValue(source, 'Estado', varEstado)
        triggerClientEvent(source, "DeathClientUptade", source, source)
        unbindKey(source, "H")
        if attacker then
            local attackerName = "Desconocido"
            
            -- Verificar si el atacante es un vehículo
            if getElementType(attacker) == "vehicle" then
                local driver = getVehicleController(attacker)
                if driver and getElementType(driver) == "player" then
                    attackerName = getPlayerName(driver)
                end
            elseif getElementType(attacker) == "player" then
                attackerName = getPlayerName(attacker)
            end
            
            outputChatBox("#24C5BE" .. attackerName .. "#A03535 te ha dejado INCONSCIENTE.", source, 255, 255, 255, true)
        end
    end
    function ReviveOrderr()
        local skin = getElementModel(source)
        local varEstado = exports["MR1_Inicio"]:getValue(source, 'Estado')
        if (varEstado == nil) or (varEstado == false) then
            return
        end

        if (exports["MRJobs2_FaccLSPD"]:isPlayerJailedIC(source)) then
            spawnPlayer(client, 273, 218, 1037, 0, skin, 3, 0)
        else
            spawnPlayer(client, varRespawnOnDeath[1], varRespawnOnDeath[2], varRespawnOnDeath[3], varRespawnOnDeath[4], skin, varRespawnOnDeath[5], varRespawnOnDeath[6])
        end

        setCameraTarget(client)
        varEstado.Muerto = false;
        exports["MR1_Inicio"]:setValue(client, 'Estado', varEstado)
        exports["weapon_system"]:takeAll(client)
        setPedAnimation(client, nil, nil)
        
        local varInfoClient = exports["MR1_Inicio"]:getValueOne(client)
        if not (varInfoClient) or not (varInfoClient.Informacion) or not (varInfoClient.Inventario) then
            return
        end
        --varInfoClient.Inventario["Dinero"] = varInfoClient.Inventario["Dinero"] - varCosteTratamiento;
        
        local invOri = varInfoClient.Inventario
        invOri.Weapons = {}
        exports["MR6_Economia"]:restarDinero(client, varCosteTratamiento, "MR3_Muertes")
        exports["MR1_Inicio"]:setValue(client, "Inventario", varInfoClient.Inventario)
        for i, v in ipairs(varControlTable) do
            toggleControl(client, v, true)
        end
        outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Se te han removido todas tus armas y "..varCosteTratamiento.."$.", client, 255, 255, 255, true)

        local DataPJ = exports["MR1_Inicio"]:getValueOne(client)
        local inv = DataPJ.Inventario
        outputChatBox("#FFFFFF        ====== #FF6F00Pruebas de resurreccion "..getPlayerName(client).."#FFFFFF======", client, 200, 200, 200, true)
    
        local cantidadFormateada = formatNumber(math.abs(math.floor(tonumber(inv.Dinero))))
        outputChatBox("#FF7800Dinero: #FFFFFF"..cantidadFormateada.."", client, 200, 200, 200, true)
        for i, Licencia in pairs(inv.Licencias) do
            outputChatBox("#FF7800"..i..": #FFFFFF x1", client, 200, 200, 200, true)
        end
        if inv.Items then
            for i, Cantidad in pairs(inv.Items) do
                outputChatBox("#FF7800"..i..": #FFFFFF x"..Cantidad.."", client, 200, 200, 200, true)
            end
        end
        local playerWeapons = (exports["weapon_system"]:getAllFromPed(client))
        if (playerWeapons) then
            for i, weapon in ipairs(playerWeapons) do
                local fullammo = weapon.ammo + weapon.clip
    
                if (weapon.id > 0) and (fullammo > 0) then
                    local municionformateada = formatNumber(math.abs(math.floor(tonumber(fullammo))))
                    outputChatBox("#FF7800"..getWeaponNameFromID(weapon.id)..": #FFFFFF"..municionformateada.." balas", client, 200, 200, 200, true)
                end
            end
        end
    end
    function DamagePlayer(attacker, weapon, bodypart, loss)
        if attacker and attacker ~= source then
            local currentTime = getTickCount()
            local realattacker = nil
            -- Verificar si el atacante ya está registrado y si el cooldown ha pasado
            if not lastAttacker[source] or not lastAttacker[source][attacker] or currentTime - lastAttacker[source][attacker] > cooldown then

                if getElementType( attacker ) == "player" then
                    realattacker = attacker

                elseif (getElementType( attacker ) == "vehicle") then
                    realattacker = getVehicleController(attacker)
                end
                if (realattacker == false) or (realattacker == nil) then
                    return
                end
                outputChatBox("#24C5BE"..getPlayerName(realattacker).. "#A03535 te ha atacado.", source, 255, 255, 255, true)

                -- Actualizar el tiempo del último ataque para este atacante
                lastAttacker[source] = lastAttacker[source] or {}
                lastAttacker[source][realattacker] = currentTime
            end

            if bodypart == 9 and weapon ~= 23 then
                killPed(source, attacker, weapon, bodypart)
            end
        end
    end
    function resucitar(p)
        triggerClientEvent(p, "resucito", p)
        setPedAnimation(p, nil, nil)
        for i, v in ipairs(varControlTable) do
            toggleControl(p, v, true)
        end
    end
    
    function Revivir_a_Jugador(source, command, objetive)
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
        local Estado = exports["MR1_Inicio"]:getValue(objetivo, 'Estado')
        if not (Estado.Muerto == true) then
            return outputChatBox("#56c450El jugador #24C5BE"..getPlayerName(objetivo).." #56c450no esta muerto.", source, 0,0,0, true)
        end
        
        Estado.Muerto = false
        exports["MR1_Inicio"]:setValue(objetivo, 'Estado', Estado)
        exports["MR3_Muertes"]:resucitar(objetivo)
        local staff = getAccountName(getPlayerAccount(source))
        outputChatBox("#FF7800"..staff.." #56c450te ha revivido.", objetivo, 0,0,0, true)
        outputChatBox("#56c450Reviviste a #24C5BE"..getPlayerName(objetivo).."", source, 0,0,0, true)
    end
    function Curar_a_Jugador(source, command, objetive)
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
        setElementHealth(objetivo, 100)
        local staff = getAccountName(getPlayerAccount(source))
        outputChatBox("#FF7800"..staff.." #56c450te ha curado.", objetivo, 0,0,0, true)
        outputChatBox("#56c450Curaste a #24C5BE"..getPlayerName(objetivo).."", source, 0,0,0, true)
    end
-- Eventos y Handlers
    addEventHandler("onPlayerWasted", root, DeathDetect)
    addEvent("ReviveOrder", true)
    addEventHandler("ReviveOrder", root, ReviveOrderr)
    addEventHandler("onPlayerDamage", root, DamagePlayer)
    addEvent("resucitar", true)
    addEventHandler ( "resucitar", root, resucitar)
    addCommandHandler("revivir", Revivir_a_Jugador)
    addCommandHandler("revive", Revivir_a_Jugador)
    addCommandHandler("curar", Curar_a_Jugador)
    addCommandHandler("heal", Curar_a_Jugador)