-- MRJobs9_Camionero
-- Script que gestiona el job de Camionero LS
-- Autor: ElTitoJet
-- Fecha: 15/01/2024

-- Variables Globales y Configuración
    local PickUpStartJob = createPickup(2183, -2253, 14.7, 3, 1210, 0, 0)
    local UbiCamionesLS = {
        [1] = {2230.1689453125, -2240.17578125, 13.727977752686, 0, 0, 44.351654052734},
        [2] = {2222.4677734375, -2247.9833984375, 13.728451728821, 0, 0, 44.351654052734},
        [3] = {2215.3251953125, -2255.150390625, 13.728394508362, 0, 0, 45.318695068359},
        [4] = {2207.84375, -2263.0732421875, 13.728461265564, 0, 0, 45.758239746094},
        [5] = {2200.7734375, -2270.806640625, 13.716103553772, 0, 0, 46.197814941406},
        [6] = {2158.5751953125, -2294.537109375, 13.636409759521, 0, 0, 224.04396057129},
        [7] = {2169.4013671875, -2276.63671875, 13.59502696991, 0, 0, 222.72528076172},
        [8] = {2177.5185546875, -2269.28125, 13.600790023804, 0, 0, 221.93406677246},
        [9] = {2190.908203125, -2227.189453125, 13.694915771484, 0, 0, 222.98901367188},
        [10] = {2198.45703125, -2220.08984375, 13.72204208374, 0, 0, 225.27471923828},
        [11] = {2206.1953125, -2212.8935546875, 13.72403717041, 0, 0, 223.25274658203},
        [12] = {2213.8427734375, -2205.6953125, 13.719945907593, 0, 0, 222.98901367188},
    }

    local CamionesCamioneroLS = {}
    local VehicleFromID = {}
    local idFromVehicle = {}
    local timers = {};

-- Funciones Auxiliares
    function getFreeTemporaryID()
        local count = 1
        while isElement(VehicleFromID[count]) do
            count = count + 1
        end
        return count
    end

    function setTempIdToPlayer(who)
        local old_id = idFromVehicle[who]
        if old_id then
            VehicleFromID[old_id] = nil
        end

        local new_id = getFreeTemporaryID()
        VehicleFromID[new_id] = who
        idFromVehicle[who] = new_id

        return new_id
    end

    function getFreeSpawn()
        local spawnLibre = nil
        for _, spawn in ipairs(UbiCamionesLS) do
            local posX, posY, posZ, rotX, rotY, rotZ = unpack(spawn)
            local spawnOcupado = false
            -- Verificar si hay un vehículo en esta posición
            for _, vehiculo in ipairs(getElementsByType("vehicle")) do
                local x, y, z = getElementPosition(vehiculo)
                -- Comprobar si el vehículo está lo suficientemente cerca
                local distancia = getDistanceBetweenPoints3D(x, y, z, posX, posY, posZ)
                if distancia < 4 then
                    spawnOcupado = true
                    break
                end
            end
            if not spawnOcupado then
                -- No hay vehículos en esta posición, es seguro usarla
                spawnLibre = spawn
                return spawnLibre
            end
        end
    end

-- Funciones Principales
    function StartJobCamioneroLS(hitElement)
        if not (isElement(CamionesCamioneroLS[hitElement])) then
            if not timers[hitElement] then
                timers[hitElement] = {}
            end
            local spawnLibre = getFreeSpawn()
            if not (spawnLibre) then
                return outputChatBox("No hay spawns libres en este job.", hitElement, 255, 0, 0, true)
            end
            local posX, posY, posZ, rotX, rotY, rotZ = unpack(spawnLibre)

            local CamionCamionerosLS = createVehicle(456, posX, posY, posZ, rotX, rotY, rotZ, "Camion-")
            local marker = createMarker(posX, posY, posZ, "arrow", 5, 1, 255, 1, 255, hitElement)
            setTimer ( function()
                destroyElement(marker)
            end, 7000, 1)
            local nuevaID = setTempIdToPlayer(CamionCamionerosLS)
            if not (nuevaID) then
                return
            end

            local matricula = "Camion "..nuevaID
            setVehiclePlateText(CamionCamionerosLS, matricula)
            local blipCamion = createBlipAttachedTo(CamionCamionerosLS, 0, 2, 0, 255, 0, 255, 0, 99999.0, hitElement)
            setElementParent( blipCamion, CamionCamionerosLS )
            local Personaje = "Camionero LS";
            local Informacion = {Modelo = 456, Matricula = matricula}
            local Estado = {Salud = 1000, Destruido = false, Bloqueo = false, Motor = true}
            exports["MR1_Inicio"]:setValue(CamionCamionerosLS, 'Personaje', Personaje)
            exports["MR1_Inicio"]:setValue(CamionCamionerosLS, 'Informacion', Informacion)
            exports["MR1_Inicio"]:setValue(CamionCamionerosLS, 'Estado', Estado)
            exports["MR1_Inicio"]:setValue(CamionCamionerosLS, 'Propietario', hitElement)

            CamionesCamioneroLS[hitElement] = CamionCamionerosLS
            outputChatBox("#A03535Sube a tu camion o será eliminado en 20 segundos.", hitElement, 0, 0, 0, true)
            timers[hitElement].CancelJob = setTimer(function()
                if hitElement then
                    outputChatBox("#A03535No empezaste tu trabajo.", hitElement, 0, 0, 0, true)
                end
                clearJob(hitElement)
            end, 20000, 1)
        end
    end

    function EnterVehicle(player, seat)
        if (seat == 0) and (getElementModel(source) == 456) then
            if isTimer(timers[player].CancelJob) then
                killTimer(timers[player].CancelJob)
                outputChatBox("#9AA498[#FF7800Camionero#9AA498] #53B440Tomaste el camion, ya puedes trabajar.", player, 0, 0, 0, true)
            end
        end
    end

    function JobCamioneroLSPaga(player, entregas, distancia)
        if not (CamionesCamioneroLS[player] and isElement(CamionesCamioneroLS[player])) then
            return
        end
        destroyElement(CamionesCamioneroLS[player]) -- Si existe, destruye la moto
        CamionesCamioneroLS[player] = nil -- Borra la referencia a la moto
        local Paga = 0;
        local valorEntrega = 0;

        if (distancia <= 2000) then
            -- Distancias cortas, paga entre 145 y 332 unidades (2.5 min aprox)
            valorEntrega = math.random(200, 332)
        elseif (distancia >= 2001) and (distancia <= 3000) then
            -- Distancias medianas, paga entre 174 y 399 unidades (3 min aprox)
            valorEntrega = math.random(174, 399)
        elseif (distancia >= 3001) and (distancia <= 4000) then
            -- Distancias medianas-altas, paga entre 232 y 532 unidades (4 min aprox)
            valorEntrega = math.random(232, 532)
        elseif (distancia >= 4001) and (distancia <= 5000) then
            -- Distancias largas, paga entre 290 y 665 unidades (5 min aprox)
            valorEntrega = math.random(290, 665)
        elseif (distancia >= 5001) and (distancia <= 6000) then
            -- Distancias muy largas, paga entre 348 y 798 unidades (6 min aprox)
            valorEntrega = math.random(348, 798)
        end

        Paga = valorEntrega

        local varInfoClient = exports["MR1_Inicio"]:getValueOne(player)
        --varInfoClient.Inventario["Dinero"] = varInfoClient.Inventario["Dinero"] + Paga;
        --exports["MR1_Inicio"]:setValue(client, "Inventario", varInfoClient.Inventario)
        exports["MR6_Economia"]:SumarDinero(client, Paga, "MRJobs9_Camionero")
        outputDebugString("[JOB - CamioneroLS] RECORRIDO TERMINADO user: "..getPlayerName(player).." pay: $"..Paga.." distancia: "..distancia)
        outputChatBox("#9AA498[#FF7800Camionero#9AA498] #53B440Terminaste tu recorrido, tu paga es de #FF7800$"..Paga, player, 0, 0, 0, true) 
    end

    function quitJob()
        if CamionesCamioneroLS[source] then
            clearJob(source)
        end
    end

    function clearJob(player)
        if (isElement(CamionesCamioneroLS[player])) then
            destroyElement(CamionesCamioneroLS[player])
        end
    end
    
    function vehicleExplode()
        local veh = source
        local infoVeh = exports["MR1_Inicio"]:getValueOne(source)
        if infoVeh then
            if infoVeh.Personaje == "Camionero LS" then
                local newInfo = infoVeh.Informacion["Matricula"]
                setTimer(function(veh)
                    destroyElement(veh)
                end, 3000, 1, veh)
            end
        end
    end
-- Eventos y Handlers
    addEventHandler("onPickupHit", PickUpStartJob, function(hitElement, md)
        if not (getElementType( hitElement ) == "player") or isPedInVehicle(hitElement) then
            return
        end

        bindKey(hitElement, "H", "down", function(hitElement)
            Trabajos = exports["MR1_Inicio"]:getValue(hitElement, 'Trabajos')
            if not (Trabajos.Trabajo == "Camionero LS") then return end
            StartJobCamioneroLS(hitElement)
            unbindKey(hitElement,"H")
        end)
    end)
    addEventHandler("onPickupLeave", PickUpStartJob, function(hitElement)
        if not (getElementType(hitElement) == "player") then
            return
        end
        unbindKey(hitElement, "H")
    end)
    addEventHandler("onVehicleEnter", root, EnterVehicle)
    addEventHandler("onPlayerQuit", root, quitJob)
    addEvent("trabajo:CamioneroLS:ClearJob", true)
    addEventHandler("trabajo:CamioneroLS:ClearJob", root, clearJob)
    addEvent("trabajo:CamioneroLS:Paga", true)
    addEventHandler("trabajo:CamioneroLS:Paga", root, JobCamioneroLSPaga)
    addEventHandler("onVehicleExplode", getRootElement(), vehicleExplode)

-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.