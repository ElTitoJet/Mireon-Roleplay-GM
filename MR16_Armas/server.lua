-- MRJobs16_Armas
-- Script que gestiona todas las armas del servidor
-- Autor: ElTitoJet
-- Fecha: 11/01/2024

-- Weapons = {WeaponID = WeaponAmmo}

-- Variables Globales y Configuración
    local cooldowns = {}
    local players = {};
    local weaponsGrounds = {};
    local costeLicencia = 10000;
    local Tiendas = {
        --[ID] = {x, y, z, int, dim}
        [1] = {296.5, -37.5,  1001.5, 1, 0}, -- Market
        [2] = {312.5, -165.5,  999.5, 6, 0}, -- Willow
        [3] = {290.5, -109.5, 1001.5, 6, 0}, -- Palomino
        [4] = {291.5, -83.5,  1001.5, 4, 0},
        [5] = { 1777.0966796875, -2273.9296875, 26.796022415161, 0, 0}
    }
    local Armamento = {
        --[ID] = {"Nombre", Slot, ID, Precio, Municion},
        [1] = {"Cuchillo", 1, 4, 100, 1},
        [2] = {"Bate", 1, 5, 550, 1},
        [3] = {"Colt 45", 2, 22, 6500, 17},
        [4] = {"Desert Eagle", 2, 24, 7500, 7},
        [5] = {"Paracaidas", 11, 46, 10000, 1},
        [6] = {"Chaleco", 0, 0, 5000},
        --[7] = {"Rocket Launcher", 7, 35, 1000, 1},
        --[7] = {"Uzi", 4, 28, 50, 50},
        --[8] = {"Tec", 4, 32, 50, 50},
        --[9] = {"Minigun", 7, 38, 50, 1000},
        --[7] = {"Taser", 2, 23, 2000, 5},
        --[8] = {"Escopeta", 3, 25, 10000, 1},
        --[9] = {"Escopeta de combate", 3, 27, 10000, 7},
        --[10] = {"MP5", 4, 29, 10000, 30},
        --[7] = {"M4", 5, 31, 10000, 50},
        --[12] = {"Rifle", 6, 33, 10000, 1},
        --[13] = {"Francotirador", 6, 34, 10000, 1},
    }
    local Licenciero = {
        [1] = {249.5, 67.5, 1003.5, 6, 0}
    }
    local glitches = {"quickreload", "fastmove", "fastfire", "crouchbug", "highcloserangedamage", "hitanim", "fastsprint", "baddrivebyhitbox", "quickstand", "kickoutofvehicle_onmodelreplace"}
    local PickUpsTiendas = createElement("PickUps")
    local PickUpsLicencias = createElement("PickUps")
    local WeaponsTiradas = createElement("Weapons")

-- Funciones Auxiliares
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
    -- Comprar armas
        function BuyWeapon(WeaponName, Price)
            local DataPJ = exports["MR1_Inicio"]:getValueOne(client)
            local Inventario = DataPJ.Inventario
            for i, Weapon in ipairs(Armamento) do
                if Weapon[1] == WeaponName then
                    if not (Inventario.Dinero >= Weapon[4]) then
                        return outputChatBox("#ffe100No tengo los "..PrecioWeapon.." dolares del arma...", 255, 255, 255, true) 
                    end
                    --Inventario.Dinero = Inventario.Dinero - Weapon[4]
                    --exports["MR1_Inicio"]:setValue(client, 'Inventario', Inventario)
                    exports["MR6_Economia"]:restarDinero(client, Weapon[4], "MR16_Armas")


                    if (WeaponName == "Chaleco") then
                        setPedArmor( client, 100 )
                        outputChatBox("#ffe100Acabo de comprar un chaleco por "..Weapon[4].." $...", source, 255, 255, 255, true)
                    else
                        outputChatBox("#ffe100Acabo de comprar "..Weapon[5].." balas de "..getWeaponNameFromID(Weapon[3]).." por "..Weapon[4].." $...", source, 255, 255, 255, true)
                    end
                    exports["weapon_system"]:give(client, tonumber(Weapon[3]), Weapon[5], true)
                    exports["MR15_Discord"]:sendDiscordArmasStaff("Dar", client, Weapon[3], Weapon[5], "MR16_Armas(Ammu)")
                    break
                end
            end
        end
    -- Cargar armas Player
        function loadWeapons (client)
            local DataPJ = exports["MR1_Inicio"]:getValueOne(client)
            local Inventario = DataPJ.Inventario
            for i, weapon in pairs(Inventario.Weapons) do
                local totalAmmo = weapon.ammo + weapon.clip
                exports["weapon_system"]:give(client, weapon.id, totalAmmo, false)
                exports["MR15_Discord"]:sendDiscordArmasStaff("Dar", client, totalAmmo, weapon.id, "MR16_Armas(SpawnPJ)")
            end
        end
    -- Guardar Armas Player
        function saveWeapons(client)
            local DataPJ = exports["MR1_Inicio"]:getValueOne(client)
            local Inventario = DataPJ.Inventario
            local EstadoPJ = DataPJ.Estado
            Inventario.Weapons = exports["weapon_system"]:getAllFromPed(client)
            if EstadoPJ.Muerto == true then
                Inventario.Weapons = {}
            end
            exports["MR1_Inicio"]:setValue(client, 'Inventario', Inventario)
        end
    -- Tirar Armas
        function tirarArmaCommandHandler(source, command, cantidad)
            local cooldownTime = 5000 -- 5000 milisegundos = 5 segundos
            if isOnCooldown(source, command, cooldownTime) then
                outputChatBox("Debes esperar antes de volver a usar este comando.", source)
                return
            end
            local DataPJ = exports["MR1_Inicio"]:getValueOne(source)
            local slot, weapon = exports["weapon_system"]:getFromPed(source)
            if not (weapon) or (slot == 0) then
                return outputChatBox("--------#ffe100No puedo soltar mis puños, no soy Rayman...", source, 255, 255, 255, true)
            end

            local ammoToDrop = tonumber(cantidad) or (weapon.clip + weapon.ammo)
            if (ammoToDrop > weapon.clip + weapon.ammo ) then
                return outputChatBox("#ffe100No tengo tanta municion...", source, 255, 255, 255, true)
            end
            exports["weapon_system"]:take(source, weapon.id, ammoToDrop)
            exports["MR15_Discord"]:sendDiscordArmasStaff("Quitar", source, ammoToDrop, weapon.id, "MR16_Armas(TirarArma)")

            -- Obtener la posición del jugador
            local x, y, z = getElementPosition(source)
            local dim = getElementDimension(source)
            local int = getElementInterior(source)
            
            -- Crear un objeto que represente el arma en el suelo
            local droppedWeapon = createObject(2969, x, y, z - 0.9) -- Ajusta la posición según sea necesario
            local markerArmaTirada = createMarker(x, y, z, "cylinder", 1, 250, 250, 250, 0)
            setElementInterior(droppedWeapon, int)
            setElementInterior(markerArmaTirada, int)
            setElementDimension(droppedWeapon, dim)
            setElementDimension(markerArmaTirada, dim)
            setElementParent( droppedWeapon, markerArmaTirada )
            setElementParent( markerArmaTirada, WeaponsTiradas )
            setElementCollisionsEnabled(droppedWeapon, false)
            weaponsGrounds[markerArmaTirada] = {pos = {x, y, z, int, dim}, wID = weapon.id, ammo = ammoToDrop, droppedBy = getPlayerName(source)}
            return outputChatBox("#ffe100He tirado "..ammoToDrop.." balas de "..getWeaponNameFromID(weapon.id).."...", source, 255, 255, 255, true)
        end
        function markerhit(hitElement, md)
            if (getElementType(hitElement) ~= "player") or isPedInVehicle(hitElement) or not md then
                return
            end
            players[hitElement] = source;
        end
        function markerLeave(hitElement, md)
            if isElement(players[hitElement]) then
                players[hitElement] = nil;
            end
        end
    -- Ver Huellas
        function verHuellas(source, command)
            local cooldownTime = 5000 -- 5000 milisegundos = 5 segundos
            if isOnCooldown(source, command, cooldownTime) then
                outputChatBox("Debes esperar antes de volver a usar este comando.", source)
                return
            end
            if isElement(players[source]) then
                local marker = players[source]
                local info = weaponsGrounds[marker]
                outputChatBox("#9AA498[#FF7800Caja#9AA498] #A03535Arma: #24C5BE"..getWeaponNameFromID(info.wID), source, 255, 255, 255, true) 
                outputChatBox("#9AA498[#FF7800Caja#9AA498] #A03535Municion: #24C5BE"..info.ammo, source, 255, 255, 255, true) 
                local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
                if Trabajos.Trabajo == "Los Santos Police Departament" then
                    if Trabajos.OnDuty == true then
                        outputChatBox("#9AA498[#FF7800Caja#9AA498] #A03535Huellas: #24C5BE"..info.droppedBy, source, 255, 255, 255, true) 
                    end
                end
            end
        end
    -- Agarrar arma
        function agarrarWeapon(source, command)
            local cooldownTime = 5000 -- 5000 milisegundos = 5 segundos
            if isOnCooldown(source, command, cooldownTime) then
                outputChatBox("Debes esperar antes de volver a usar este comando.", source)
                return
            end
            if isElement(players[source]) then
                local infoPlayer = exports["MR1_Inicio"]:getValueOne(source)
                if not (infoPlayer) or not (infoPlayer.Estado) or not (infoPlayer.Estado["Muerto"] == false) then
                    cancelEvent()
                    return
                end
                local marker = players[source]
                local info = weaponsGrounds[marker]
                exports["weapon_system"]:give(source, info.wID, info.ammo, true)
                exports["MR15_Discord"]:sendDiscordArmasStaff("Dar", source, info.ammo, info.wID, "MR16_Armas(TomarArma)")
                outputChatBox("#ffe100Acabo de agarrar "..info.ammo.." balas de "..getWeaponNameFromID(info.wID).."...", source, 255, 255, 255, true)
                weaponsGrounds[marker] = nil
                destroyElement(marker)
            end
        end
    -- Dararma
        function dararmaCommand(source, command, objetive, cantidad)
            local cooldownTime = 5000 -- 5000 milisegundos = 5 segundos
            if isOnCooldown(source, command, cooldownTime) then
                outputChatBox("Debes esperar antes de volver a usar este comando.", source)
                return
            end


            if not objetive then
                return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/dararma [Player] [Cantidad]", source, 255, 255, 255, true)
            end
            
            objetivo = nil;
            if tonumber(objetive) then
                objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
            elseif (isElement(getPlayerFromName(objetive))) then
                objetivo = getPlayerFromName(objetive)
            else
                return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
            end
            local posX1, posY1, posZ1 = getElementPosition(source)
            local posX2, posY2, posZ2 = getElementPosition(objetivo)
            if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) <= 2 then 
                local slot, weapon = exports["weapon_system"]:getFromPed(source)
                if not (weapon) or (slot == 0) then
                    return outputChatBox("#ffe100No puedo dar mis puños, no soy Rayman...", source, 255, 255, 255, true)
                end
                local ammoToGive = tonumber(cantidad) or (weapon.clip + weapon.ammo)
                --iprint(ammoToGive)
                --iprint(weapon.clip)
                --iprint(weapon.ammo)
                --iprint(weapon.clip + weapon.ammo)
                if (ammoToGive > weapon.clip + weapon.ammo ) then
                    return outputChatBox("#ffe100No tengo tanta municion...", source, 255, 255, 255, true)
                elseif (ammoToGive < 1) then
                    return outputChatBox("#ffe100No puedo dar 0 balas...", source, 255, 255, 255, true)
                end
                exports["weapon_system"]:take(source, weapon.id, ammoToGive)
                exports["MR15_Discord"]:sendDiscordArmasStaff("Quitar", source, ammoToGive, weapon.id, "MR16_Armas(dararma)")
                exports["weapon_system"]:give(objetivo, weapon.id, ammoToGive, true)
                exports["MR15_Discord"]:sendDiscordArmasStaff("Dar", objetivo, ammoToGive, weapon.id, "MR16_Armas(dararma)")

                outputChatBox("#9AA498[#FF7800Server#9AA498] #FF7800"..getPlayerName(source).." #53B440te ha entregado #FF7800"..ammoToGive.." balas de "..getWeaponNameFromID(weapon.id), objetivo, 255, 255, 255, true) -- USER
                outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Le has entregado #FF7800"..ammoToGive.." #53B440balas de "..getWeaponNameFromID(weapon.id).." a #FF7800"..getPlayerName(objetivo), source, 255, 255, 255, true) -- USER
                for _, player in ipairs(getElementsByType("player")) do
                    local varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z = getElementPosition(player)
                    if getDistanceBetweenPoints3D(posX1, posY1, posZ1, varPosicion_Player_X, varPosicion_Player_Y, varPosicion_Player_Z) <= 7 then
                        outputChatBox("#F600FF"..getPlayerName(source).." saca un maletin y se lo entrega a "..getPlayerName(objetivo)..".", player, 246, 0, 255, true)
                    end
                end
            end
        end


-- Eventos y Handlers
    -- TIENDAS
        addEventHandler("onPickupHit", PickUpsTiendas, function(hitElement, md)
            local key = getElementID(source)
            local value = Tiendas[tonumber(key)]
            bindKey(hitElement, "H", "down", function(hitElement, m)
                triggerClientEvent(hitElement, "WeaponSystem:Client:PannelShop:Open", hitElement)
                unbindKey(hitElement,"H")
            end)
        end)
        addEventHandler("onPickupLeave", PickUpsTiendas, function(hitElement, md)
            unbindKey(hitElement,"H")
        end)
    -- Comprar arma
        addEvent("WeaponSystem:Server:PannelShop:BuyWeapon", true)
        addEventHandler("WeaponSystem:Server:PannelShop:BuyWeapon", getRootElement(), BuyWeapon)
    -- Tocar marcador
        addEventHandler("onMarkerHit", getRootElement(), markerhit)
    -- Abandonar marcador
        addEventHandler("onMarkerLeave", getRootElement(), markerLeave)
    -- COMANDOS
        addCommandHandler("tirararma", tirarArmaCommandHandler)
        addCommandHandler("verhuellas", verHuellas)
        addCommandHandler("vercaja", verHuellas)
        addCommandHandler("tomararma", agarrarWeapon)
        addCommandHandler("dararma", dararmaCommand)
-- Inicialización
    -- Por ejemplo, spawnear vehículos, etc.
    addEventHandler("onResourceStart", resourceRoot, function(resource)
        exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS WeaponPlayer( Usuario INT NOT NULL, Weapons VARCHAR(255) NOT NULL);")
        -- Tiendas de armas
            for i, Tienda in ipairs(Tiendas) do
                local varPickUpTienda = createPickup(Tienda[1], Tienda[2], Tienda[3], 3, 1274, 0, 0)
                setElementInterior(varPickUpTienda, Tienda[4])
                setElementDimension(varPickUpTienda, Tienda[5])
                setElementParent( varPickUpTienda, PickUpsTiendas )
                setElementID(varPickUpTienda, i)
            end
        -- BUGS
            for _, glitch in ipairs(glitches) do
                setGlitchEnabled(glitch, false)
            end
    end)