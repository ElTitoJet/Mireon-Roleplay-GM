-- MRJobs10_Basurero
-- Script Empresa publica Basurero
-- Autor: ElTitoJet
-- Fecha: 14/09/2024

-- Variables Globales y Configuración
    local PickUpStartJob = createPickup(2440.884765625, -2122.8642578125, 13.546875, 3, 1210, 0, 0)
    local UbiCamionBasureroOce = {
        [1] = {2453.5869140625, -2117.0556640625, 14.087613105774, 0, 0, 358},
        [2] = {2460.6494140625, -2117.0556640625, 14.087613105774, 0, 0, 358},
        [3] = {2467.6494140625, -2117.0556640625, 14.087613105774, 0, 0, 358},
        [4] = {2474.6494140625, -2117.0556640625, 14.087613105774, 0, 0, 358},
        [5] = {2481.6494140625, -2117.0556640625, 14.087613105774, 0, 0, 358},
        [6] = {2488.6494140625, -2117.0556640625, 14.087613105774, 0, 0, 358},
        [7] = {2495.6494140625, -2117.0556640625, 14.087613105774, 0, 0, 358},
        [8] = {2502.6494140625, -2117.0556640625, 14.087613105774, 0, 0, 358},
    }
    local CamionesBasuraLS = {}
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

    function setTempIdToVehicle(who)
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
        for _, spawn in ipairs(UbiCamionBasureroOce) do
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
    function StartJobBasurero(hitElement)
        if not (isElement(CamionesBasuraLS[hitElement])) then
            if not timers[hitElement] then
                timers[hitElement] = {}
            end
            local spawnLibre = getFreeSpawn()
            if not (spawnLibre) then
                return outputChatBox("No hay spawns libres en este job.", hitElement, 255, 0, 0, true)
            end
            local posX, posY, posZ, rotX, rotY, rotZ = unpack(spawnLibre)

            local CamionBasureroLS = createVehicle(408, posX, posY, posZ, rotX, rotY, rotZ, "Camion-")
            local marker = createMarker(posX, posY, posZ, "arrow", 5, 1, 255, 1, 255, hitElement)
            setTimer ( function()
                destroyElement(marker)
            end, 7000, 1)
            local nuevaID = setTempIdToVehicle(CamionBasureroLS)
            if not (nuevaID) then
                return
            end

            local matricula = "Basurero "..nuevaID
            setVehiclePlateText(CamionBasureroLS, matricula)
            local blipCamion = createBlipAttachedTo(CamionBasureroLS, 0, 2, 0, 255, 0, 255, 0, 99999.0, hitElement)
            setElementParent( blipCamion, CamionBasureroLS )
            local Personaje = "Basurero LS";
            local Informacion = {Modelo = 408, Matricula = matricula}
            local Estado = {Salud = 1000, Destruido = false, Bloqueo = false, Motor = true}
            exports["MR1_Inicio"]:setValue(CamionBasureroLS, 'Personaje', Personaje)
            exports["MR1_Inicio"]:setValue(CamionBasureroLS, 'Informacion', Informacion)
            exports["MR1_Inicio"]:setValue(CamionBasureroLS, 'Estado', Estado)
            exports["MR1_Inicio"]:setValue(CamionBasureroLS, 'Propietario', hitElement)

            CamionesBasuraLS[hitElement] = CamionBasureroLS
            outputChatBox("#A03535Sube a tu camion o será eliminada en 20 segundos.", hitElement, 0, 0, 0, true)
            timers[hitElement].CancelJob = setTimer(function()
                outputChatBox("#A03535No empezaste tu trabajo.", hitElement, 0, 0, 0, true)
                clearJob(hitElement)
            end, 20000, 1)
        end
    end
    
    function EnterVehicle(player, seat)
        if (seat == 0) and (getElementModel(source) == 408) then
            if isTimer(timers[player].CancelJob) then
                killTimer(timers[player].CancelJob)
                outputChatBox("#9AA498[#FF7800Basurero#9AA498] #53B440Tomaste el camion, ya puedes trabajar.", player, 0, 0, 0, true)
            end
        end
    end
    function JobBasureroLSPaga(player)
        if not (CamionesBasuraLS[player] and isElement(CamionesBasuraLS[player])) then
            return
        end
        destroyElement(CamionesBasuraLS[player]) -- Si existe, destruye la moto
        CamionesBasuraLS[player] = nil -- Borra la referencia a la moto

        local Paga = 0;
        local valorEntrega = 0;

        valorEntrega = math.random(400, 800)

        Paga = valorEntrega

        local varInfoClient = exports["MR1_Inicio"]:getValueOne(player)
        --varInfoClient.Inventario["Dinero"] = varInfoClient.Inventario["Dinero"] + Paga;
        --exports["MR1_Inicio"]:setValue(client, "Inventario", varInfoClient.Inventario)
        exports["MR6_Economia"]:SumarDinero(player, Paga, "MRJobs10_Basurero")
        outputDebugString("[JOB - BasureroLS] RECORRIDO TERMINADO user: "..getPlayerName(player).." pay: $"..Paga)
        outputChatBox("#9AA498[#FF7800BasureroLS#9AA498] #53B440Terminaste tu recorrido, tu paga es de #FF7800$"..Paga, player, 0, 0, 0, true) 
    end
    function quitJob()
        if CamionesBasuraLS[source] then
            clearJob(source)
        end
    end 
    function clearJob(player)
        --iprint(player)
        if (isElement(CamionesBasuraLS[player])) then
            destroyElement(CamionesBasuraLS[player])
        end
    end
    function vehicleExplode()
        local veh = source
        local infoVeh = exports["MR1_Inicio"]:getValueOne(source)
        if infoVeh then
            if infoVeh.Personaje == "Basurero LS" then
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
            if not (Trabajos.Trabajo == "Basurero LS") then return end
            StartJobBasurero(hitElement)
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
    addEvent("trabajo:BasureroLS:ClearJob", true)
    addEventHandler("trabajo:BasureroLS:ClearJob", root, clearJob)
    addEvent("trabajo:BasureroLS:Paga", true)
    addEventHandler("trabajo:BasureroLS:Paga", root, JobBasureroLSPaga)
    addEventHandler("onVehicleExplode", getRootElement(), vehicleExplode)

-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.



