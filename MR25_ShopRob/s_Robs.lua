-- MR25_ShopRob
-- Gestiona los NPC robables de las tiendas.
-- Autor: ElTitoJet
-- Fecha: 24/09/2024

-- Variables Globales y Configuración
    local tiendas = {
        {1778.302734375, -2285.716796875, 26.796022415161, 0, 0}, -- Ubicación 1
        {1771.03515625, -2294.7119140625, 26.796022415161, 0, 0}, -- Ubicación 1
        {1756.7841796875, -2289.7666015625, 26.796022415161, 0, 0}, -- Ubicación 1
        {1764.1796875, -2274.11328125, 26.796022415161, 0, 0}, -- Ubicación 1
    }

    local npcCols = {}
    local npcData = {}
    local cooldownNPC = {}
    local robos = {}
    local validRobNpcWeapons = { 
        4, 5, 22, 24, 28, 29
    }

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
    function crearNPCsTiendas()
        local varListaNPCs = exports["MR1_Inicio"]:query("SELECT * FROM NPCRobos")
        if not varListaNPCs then return end

        -- Iterar sobre cada interior y crear los pickups de entrada y salida
        for i, NPCs in ipairs(varListaNPCs) do
            --outputChatBox("Creando NPC en: " .. x .. ", " .. y .. ", " .. z .. " | Interior: " .. int .. " | Dimensión: " .. dim)
            local randomSkin = math.random(0, 1) == 0 and 211 or 217
            local varNPC = createPed(randomSkin, NPCs.posX, NPCs.posY, NPCs.posZ) -- ID del skin 30 (puedes cambiarlo)
            setElementRotation(varNPC, NPCs.rotX, NPCs.rotY, NPCs.rotZ)
            setElementInterior(varNPC, NPCs.Interior)  -- Asegúrate de usar los nombres correctos en la DB
            setElementDimension(varNPC, NPCs.Dimension) -- Asegúrate de usar los nombres correctos en la DB
            setElementData(varNPC, "ID", i)
            setElementData(varNPC, "inmortal", true) -- Marcar al NPC como inmortal

            -- Crear ColShape alrededor del NPC
            local varColision = createColSphere(NPCs.posX, NPCs.posY, NPCs.posZ, 3) -- Radio de 2 metros
            setElementInterior(varColision, NPCs.Interior)
            setElementDimension(varColision, NPCs.Dimension)

            npcCols[varNPC] = varColision;
            npcData[varNPC] = {
                x = NPCs.blipx,
                y = NPCs.blipy,
                z = NPCs.blipz,
                int = NPCs.Interior,
                dim = NPCs.Dimension,
                col = varColision,
                robo = false,
                ladron = false,
                cooldown = false,
                maxRecompensa = 0,
                acumulado = 0
            }
            
            addEventHandler("onColShapeHit", varColision, function(source, Dimension)
                if not (getElementType(source) == "player") or isPedInVehicle(source) then
                    return
                end
                local playerDim = getElementDimension(source)
                --iprint("PlayerDim = "..playerDim )
                local colDim = getElementDimension(varColision)
                --iprint("colDim = "..colDim )
                if playerDim ~= colDim then
                    --outputChatBox("Estás en una dimensión diferente al NPC.", source, 255, 0, 0)
                    return
                end
                local countLSPD = 0
                local jugadoresConectados = getElementsByType("player")
                for _, player in ipairs(jugadoresConectados) do
                    local Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')

                    if Trabajos and Trabajos.Trabajo then
                        if (Trabajos.Trabajo == "Los Santos Police Departament") then 
                            if (Trabajos.OnDuty == true) then
                                countLSPD = countLSPD+1
                            end
                        end
                    end
                end

                if countLSPD >= 2 then
                    local ArmaActual = exports["weapon_system"]:getCurrentSlot(source)
                    if validRobNpcWeapons[ArmaActual] then
                        outputChatBox("#9AA498[#FF7800NPC#9AA498] #53B440Presiona #FFFFFFH #53B440 para robar la tienda.", source, 255, 255, 255, true)
                        bindKey(source, "H", "down", function()
                            iniciarRobo(source, varNPC)
                            --outputChatBox("Has presionado H frente al NPC con ID: " .. getElementData(varNPC, "ID"), source, 255, 255, 255)
                        end)
                    end
               end

            end)
            addEventHandler("onColShapeLeave", varColision, function(source)
                if getElementType(source) == "player" then
                    if (npcData[varNPC].robo == true) then
                        if npcData[varNPC].ladron == source then
                            outputChatBox("Has dejado la zona del robo, el robo ha sido cancelado.", source, 255, 0, 0)
                            finalizarRobo(source, varNPC)
                        end
                    end
                    unbindKey(source, "H")
                end
            end)
        end

    end
    function iniciarRobo(player, NPC)
        local armaActual = getPedWeapon(player)
        if armaActual == 0 then  -- El 0 significa que no tiene arma
            outputChatBox("Necesitas tener un arma en la mano para iniciar el robo.", player, 255, 0, 0)
            return
        end
        if npcData[NPC].cooldown then
            outputChatBox("Este NPC está en cooldown, no puedes robarlo ahora.", player, 255, 0, 0)
            return
        end
        if (npcData[NPC].robo == true) then
            if npcData[NPC].ladron == player then
                finalizarRobo(player, NPC)
            else
                outputChatBox("¡Ya están robando a este NPC!", player, 255, 0, 0)
            end
            unbindKey(player, "H")
            return
        end
        setPedAnimation(NPC, "shop", "shp_rob_handsup", -1, false, false, false, true)
        outputChatBox("¡El robo ha comenzado!", player, 0, 255, 0)
        npcData[NPC].robo = true
        npcData[NPC].maxRecompensa = math.random(1000, 3500)
        npcData[NPC].acumulado = 0
        npcData[NPC].ladron = player
        outputChatBox("Maxima posible $".. npcData[NPC].maxRecompensa..".", player, 0, 255, 0)
        robos[player] = setTimer(function()
            if npcData[NPC].acumulado < npcData[NPC].maxRecompensa then
                npcData[NPC].acumulado = npcData[NPC].acumulado + math.random(50, 100)
                outputChatBox("Has acumulado $".. npcData[NPC].acumulado.." del robo.", player, 0, 255, 0)
            else
                outputChatBox("¡Has alcanzado el máximo de $"..npcData[NPC].acumulado.." del robo!", player, 255, 255, 0)
                finalizarRobo(player, NPC)
            end
        end, 5000, 0) -- Cada 5 segundos
        setTimer(function()
            for _, players in ipairs(getElementsByType("player")) do -- Obtenemos una lista de TODOS los jugadores
                local Trabajos = exports["MR1_Inicio"]:getValue(players, 'Trabajos')
                if Trabajos and Trabajos.Trabajo then
                    if (Trabajos.Trabajo == "Los Santos Police Departament" and Trabajos.OnDuty == true) then
                        outputChatBox("#9AA498[#0058ffLSPD-Central#9AA498]#FFFFFF Estan robando en una tienda, la descripccion del sujeto es la siguiente \n#9AA498[#0058ffLSPD-Central#9AA498] #F600FFLa centralita describe a "..getPlayerName(player), players, 255,255,255, true)
                        local blip = createBlip(npcData[NPC].x, npcData[NPC].y, npcData[NPC].z, 58, 2, 255, 0, 0, 255, 0, 65535, players)
                        setTimer ( function()
                            destroyElement(blip)
                        end, 120000, 1 )
                    end
                end
            end
        end, 10000, 1)

    end
    function finalizarRobo(player, NPC)
        if isTimer(robos[player]) then
            killTimer(robos[player])
        end
        setPedAnimation(NPC, false)

        npcData[NPC].robo = false
        npcData[NPC].ladron = false

        npcData[NPC].cooldown = true
        setTimer(function()
            npcData[NPC].cooldown = false -- 1 hora
        end, 1800000, 1)

        local varDataSource = exports["MR1_Inicio"]:getValueOne(player)

        local cantidadFormateada = formatNumber(math.abs(math.floor(tonumber(npcData[NPC].acumulado))))
        exports["MR6_Economia"]:SumarDinero(player, math.abs(math.floor(tonumber(npcData[NPC].acumulado))), "MR25_ShopRob")
        
        --varDataSource.Inventario["Dinero"] = varDataSource.Inventario["Dinero"] + math.abs(math.floor(tonumber(npcData[NPC].acumulado)));
        --exports["MR1_Inicio"]:setValue(player, "Inventario", varDataSource.Inventario)

        outputDebugString("Robo de "..getPlayerName(player).." - Recibido "..cantidadFormateada)
        npcData[NPC].maxRecompensa = 0
        outputChatBox("¡El robo ha terminado! Has escapado con un botín de "..cantidadFormateada.."", player, 0, 255, 0)
        npcData[NPC].acumulado = 0
    end
-- Eventos y Handlers


-- Inicialización
addEventHandler("onResourceStart", resourceRoot, crearNPCsTiendas)