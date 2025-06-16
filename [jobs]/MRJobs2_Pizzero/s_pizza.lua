-- MRJobs2_Pizzero
-- Script que gestiona el job de Pizzero
-- Autor: ElTitoJet
-- Fecha: 25/11/2024

-- Variables Globales y Configuración
    local PickUpsJobs2 = {
        [1] = {
            x = 2124.87109375,
            y = -1791.7001953125,
            z = 13.5546875,
            interior = 0,
            dimension = 0,
            tipoPickUp = 3,
            modelo = 1210,
            tipo = "Job2"
        }
    }
    local PickUpsStartJob = createElement("PickUps")
    local SpawnMotosPizza = {
        [1] = {2127.83984375, -1788, 13.152804374695, 0, 0, 89.626373291016},
        [2] = {2127.83984375, -1793, 13.152804374695, 0, 0, 89.626373291016},
        [3] = {2127.83984375, -1798, 13.152804374695, 0, 0, 89.626373291016},
        [4] = {2127.83984375, -1803, 13.152804374695, 0, 0, 89.626373291016},
        [5] = {2127.83984375, -1808, 13.152804374695, 0, 0, 89.626373291016},
        [6] = {2127.83984375, -1813, 13.152804374695, 0, 0, 89.626373291016},
        [7] = {2127.83984375, -1818, 13.152804374695, 0, 0, 89.626373291016},
        [8] = {2127.83984375, -1823, 13.152804374695, 0, 0, 89.626373291016},
    }
    local MotosPizza = {}
    local VehicleFromID = {}
    local idFromVehicle = {}
    local timers = {};
    local PosEntregas = {
        [1] = {2070.2724609375, -1731.4853515625, 13.142994880676},
        [2] = {2068.2734375, -1717.267578125, 13.144593238831}, 
        [3] = {2071.5947265625, -1703.34765625, 13.143730163574}, 
        [4] = {2013.974609375, -1703.8154296875, 13.143439292908}, 
        [5] = {2014.4453125, -1716.9814453125, 13.140905380249}, 
        [6] = {2010.873046875, -1732.5380859375, 13.146847724915}, 
        [7] = {2012.03125, -1655.931640625, 13.142993927002},
        [8] = {2013.0751953125, -1641.458984375, 13.13937664032},
        [9] = {2016.087890625, -1630.4072265625, 13.147324562073},
        [10] = {2070.7548828125, -1629.0087890625, 13.145222663879},
        [11] = {2068.703125, -1643.7958984375, 13.143175125122},
        [12] = {2067.8818359375, -1656.189453125, 13.143635749817},
        [13] = {1984.8564453125, -1719.103515625, 15.565910339355},
        [14] = {1973.30859375, -1707.0009765625, 15.56471824646},
        [15] = {1969.4736328125, -1706.7646484375, 15.565327644348},
        [16] = {1985.6123046875, -1682.91796875, 15.567611694336},
        [17] = {1974.7392578125, -1672.09765625, 15.560410499573},
        [18] = {1969.798828125, -1672.0380859375, 15.56497764587},
        [19] = {1977.9462890625, -1672.6923828125, 15.568934440613},
        [20] = {1969.193359375, -1656.259765625, 15.563012123108},
        [21] = {1973.3427734375, -1656.15234375, 15.559283256531},
        [22] = {1975.46875, -1635.0888671875, 15.5682554245},
        [23] = {1972.2353515625, -1635.0888671875, 15.568535804749},
        [24] = {1967.384765625, -1635.091796875, 15.568676948547},
        [25] = {1958.75, -1561.3515625, 13.191395759583},
        [26] = {2002.875, -1595.2607421875, 13.165699005127},
        [27] = {1987.7412109375, -1606.2197265625, 13.118905067444},
        [28] = {2185.8720703125, -1813.0322265625, 13.151057243347},
        [29] = {2169.478515625, -1813.3759765625, 13.138726234436},
        [30] = {2152.7783203125, -1808.349609375, 13.14502620697},
        [31] = {2152.38671875, -1789.466796875, 13.097741127014},
        [32] = {2069.779296875, -1779.80078125, 13.151679992676},
        [33] = {2072.0390625, -1793.841796875, 13.146501541138},
        [34] = {1543.8759765625, -1675.3798828125, 13.15350151062}
    }
    local Rutas = {}
    local Progreso = {}
    local Checkpoints = {}
    local Blips = {}
-- Funciones Auxiliares    
    function crearPickUp(x, y, z, int, dim, tipoPickUp, ModeloPickup, parentElement, tipo, index)
        local pickup = createPickup(x, y, z, tipoPickUp, ModeloPickup, 0, 0) -- Crear el pickup
        setElementInterior(pickup, int) -- Establecer interior
        setElementDimension(pickup, dim) -- Establecer dimensión
        setElementParent(pickup, parentElement) -- Agrupar el pickup
        setElementID(pickup, tipo .. "_" .. index) -- Asignar un ID único
    end
    function getFreeSpawn()
        local spawnLibre = nil
        for _, spawn in ipairs(SpawnMotosPizza) do
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
    function getFreeTemporaryID()
        local count = 1
        while isElement(VehicleFromID[count]) do
            count = count + 1
        end
        return count
    end
    function clearJob(player)
        if (isElement(MotosPizza[player])) then
            destroyElement(MotosPizza[player])
        end
        if Checkpoints[player] and isElement(Checkpoints[player]) then
            destroyElement(Checkpoints[player])
        end
        if Blips[player] and isElement(Blips[player]) then
            destroyElement(Blips[player])
        end
        
            Rutas[player] = nil
            Progreso[player] = nil
            Checkpoints[player] = nil
            Blips[player] = nil
    
    end
    function setTempId(who)
        local old_id = idFromVehicle[who]
        if old_id then
            VehicleFromID[old_id] = nil
        end
    
        local new_id = getFreeTemporaryID()
        VehicleFromID[new_id] = who
        idFromVehicle[who] = new_id
    
        return new_id
    end
    function PizzaPrepararRuta(player)
        if not (isElement(MotosPizza[player])) then
            return
        end
        if not Rutas[player] then
            Rutas[player] = {}
        end
        if #Rutas[player] == 0 then
            
            outputChatBox("#9AA498[#FF7800Pizzero#9AA498] #53B440Preparando ruta.", player, 0, 0, 0, true)
            local maxEntregas = math.random(5, 15) -- 5 a 15
            table.insert(Rutas[player], {2090.8564453125, -1806.8759765625, 13.546875})
            while (#Rutas[player] < maxEntregas - 1) do
                local i = math.random(#PosEntregas)
                local punto = PosEntregas[i]
    
                -- Verificar si el punto ya está en la ruta
                local check = false
                for _, v in ipairs(Rutas[player]) do
                    if v[1] == punto[1] and v[2] == punto[2] and v[3] == punto[3] then
                        check = true
                        break
                    end
                end
    
                -- Si no está, añadir el punto a la ruta
                if not check then
                    table.insert(Rutas[player], punto)
                end
            end
            
            table.insert(Rutas[player], {2125.666015625, -1787.7236328125, 13.5546875})
            
            outputChatBox("#9AA498[#FF7800Pizzero#9AA498] #53B440Ruta lista para trabajar entregas pendientes: "..#Rutas[player]..".", player, 0, 0, 0, true)
            Progreso[player] = 1
            PizzaCrearCheckpoint(player)
        else
            local PedidosRestantes = #Rutas[player] - Progreso[player] + 1
            outputChatBox("#9AA498[#FF7800Pizzero#9AA498] #53B440Continua con tu ruta de entregas, pendientes:"..PedidosRestantes..".", player, 0, 0, 0, true)
        end
    end
-- Funciones Principales
    function StartJobs2()
        setTimer(function()
            for i, PickUp in ipairs(PickUpsJobs2) do
                -- Crear Pickup de Entrada con Blip
                crearPickUp(PickUp.x, PickUp.y, PickUp.z, PickUp.interior, PickUp.dimension, PickUp.tipoPickUp, PickUp.modelo, PickUpsStartJob, PickUp.tipo, i)
            end
        end, 3000, 1)
    end
    function IniciarJob2(hitElement)
        if eventName == "onPickupHit" then
            if getElementType(hitElement) == "player" then
                local key = getElementID(source):match("Job2_(%d+)")
                local value = PickUpsJobs2[tonumber(key)]

                local varDataSource = exports["MR1_Inicio"]:getValueOne(hitElement)
                if not varDataSource then return end
                if not varDataSource.Jobs then return end
                local varDataJob = varDataSource.Jobs
                if varDataJob.Normal["IDJob"] == 2 or varDataJob.VIP["IDJob"] == 2 then
                    bindKey(hitElement, "H", "down", function(hitElement)
                        StartJobPizza(hitElement)
                        unbindKey(hitElement,"H")
                    end)
                end
            end
        else
            if getElementType(hitElement) == "player" then
                unbindKey(hitElement, "H")
            end
        end
    end
    function StartJobPizza(hitElement)
        if not (isElement(MotosPizza[hitElement])) then
            if not timers[hitElement] then
                timers[hitElement] = {}
            end

            local spawnLibre = getFreeSpawn()
            if not (spawnLibre) then
                return outputChatBox("No hay spawns libres en este job.", hitElement, 255, 0, 0, true)
            end

            local posX, posY, posZ, rotX, rotY, rotZ = unpack(spawnLibre)
            local MotoPizzaIdle = createVehicle(448, posX, posY, posZ, rotX, rotY, rotZ, "Pizza-")
            local marker = createMarker(posX, posY, posZ, "arrow", 5, 1, 255, 1, 255, hitElement)
            local blipMoto = createBlipAttachedTo(MotoPizzaIdle, 0, 2, 0, 255, 0, 255, 0, 99999.0, hitElement)
            setElementParent( blipMoto, MotoPizzaIdle )
            setTimer ( function()
                destroyElement(marker)
            end, 7000, 1)

            local nuevaID = setTempId(MotoPizzaIdle)
            if not (nuevaID) then
                return
            end
            setVehiclePlateText(MotoPizzaIdle, "Pizza-"..nuevaID)

            -- Info Veh
                local Job = {JobID = 2, Nombre = "Pizzero Idlewood"}
                local Informacion = {Modelo = 448, Matricula = matricula}
                local Estado = {Salud = 1000, Destruido = false, Bloqueo = false, Motor = true}

                exports["MR1_Inicio"]:setValue(MotoPizzaIdle, 'Job', Job)
                exports["MR1_Inicio"]:setValue(MotoPizzaIdle, 'Informacion', Informacion)
                exports["MR1_Inicio"]:setValue(MotoPizzaIdle, 'Estado', Estado)
                exports["MR1_Inicio"]:setValue(MotoPizzaIdle, 'Propietario', hitElement)

                MotosPizza[hitElement] = MotoPizzaIdle

                outputChatBox("#A03535Sube a tu moto o será eliminada en 15 segundos.", hitElement, 0, 0, 0, true)
                timers[hitElement].CancelJob = setTimer(function()
                    outputChatBox("#A03535No empezaste tu trabajo.", hitElement, 0, 0, 0, true)
                    clearJob(hitElement)
                end, 15000, 1)
        end
    end
    function PizzaVehicleGestion(player, seat)
        if (getElementModel(source) == 448) then
            if eventName == "onVehicleEnter" then
                if (seat == 0) then
                    if MotosPizza[player] == source then
                        if isTimer(timers[player].CancelJob) then
                            killTimer(timers[player].CancelJob)
                            outputChatBox("#9AA498[#FF7800Pizzero#9AA498] #53B440Tomaste la moto.", player, 0, 0, 0, true)
                            PizzaPrepararRuta(player)
                        end
                    else
                        outputChatBox("#9AA498[#FF7800Pizzero#9AA498] #A03535Esta no es tu moto. Usa la moto que se te asignó.", player, 0, 0, 0, true)
                        removePedFromVehicle(player)
                    end
                end
            else
                outputChatBox("#A03535Sube a tu moto o será eliminada en 15 segundos.", player, 0, 0, 0, true)
                timers[player].CancelJob = setTimer(function()
                    outputChatBox("#A03535Tu moto ha sido eliminada.", player, 0, 0, 0, true)
                    clearJob(player)
                end, 15000, 1)
            end
        end
    end
    function PizzaCrearCheckpoint(player)
        if not Rutas[player] or not Progreso[player] then
            return
        end
    
        -- Eliminar el checkpoint anterior si existe
        if Checkpoints[player] and isElement(Checkpoints[player]) then
            destroyElement(Checkpoints[player])
        end
        if Blips[player] and isElement(Blips[player]) then
            destroyElement(Blips[player])
        end

        local index = Progreso[player]
        if index > #Rutas[player] then
            outputChatBox("¡Gracias por tu trabajo! Puedes volver a empezar cuando quieras.", player, 0, 255, 0)
            JobPizzaPaga(player, #Rutas[player])
            clearJob(player)
            return
        end
    
        local punto = Rutas[player][index]
        local x, y, z = punto[1], punto[2], punto[3]
    
        -- Crear el nuevo checkpoint
        local checkpoint = createMarker(x, y, z, "checkpoint", 3, 255, 255, 0, 150, player)
        local blip = createBlipAttachedTo ( checkpoint, 0, 2, 255, 0, 0, 255, 0, 1000, resourceRoot)
        --setElementVisibleTo(checkpoint, player, true)
        setElementVisibleTo(blip, player, true)
        Checkpoints[player] = checkpoint
        Blips[player] = blip
    
        -- Agregar el evento de detección
        addEventHandler("onMarkerHit", checkpoint, function(hitElement)
            if hitElement == player and isPedInVehicle(player) then
                PizzaSiguienteCheckpoint(player)
            end
        end)
    end
    function PizzaSiguienteCheckpoint(player)
        if not Progreso[player] then
            return
        end
    
        -- Avanzar al siguiente punto
        Progreso[player] = Progreso[player] + 1
    
        -- Crear el siguiente checkpoint
        PizzaCrearCheckpoint(player)
    end
    function JobPizzaPaga(player, entregas)
        local Paga = 0;
        local valorEntrega = 0;
        if (entregas <= 5) then
            -- 5 entregas: Paga entre 80 y 290 unidades (16 a 58 unidades por minuto, aprox. 5 min por entrega)
            valorEntrega = math.random(80, 290)
        elseif (entregas > 5) and (entregas <= 10) then
            -- 6-10 entregas: Paga entre 290 y 500 unidades (manteniendo 16 a 58 unidades por minuto)
            valorEntrega = math.random(290, 500)
        elseif (entregas > 10) then
            -- 11-15 entregas: Paga entre 500 y 750 unidades (máximo para 16-58 unidades por minuto)
            valorEntrega = math.random(500, 750)
        end
        Paga = (valorEntrega)
    
        local varInfoClient = exports["MR1_Inicio"]:getValueOne(player)
        exports["MR6_Economia"]:SumarDinero(player, Paga, "MRJobs8_Pizzero")
    
        outputDebugString("[JOB - Pizzero] RECORRIDO TERMINADO user: "..getPlayerName(player).." pay: $"..Paga)
        outputChatBox("#9AA498[#FF7800Pizzero#9AA498] #53B440Terminaste tu recorrido, tu paga es de #FF7800$"..Paga, player, 0, 0, 0, true) 
            
    end
-- Eventos y Handlers
    -- EVENTOS
        addEventHandler("onResourceStart", resourceRoot, StartJobs2)
        addEventHandler("onPickupHit", PickUpsStartJob, IniciarJob2)
        addEventHandler("onPickupLeave", PickUpsStartJob, IniciarJob2)
        addEventHandler("onVehicleEnter", getRootElement(), PizzaVehicleGestion)
        addEventHandler("onVehicleExit", getRootElement(), PizzaVehicleGestion)
    -- COMANDOS
    -- TIMER