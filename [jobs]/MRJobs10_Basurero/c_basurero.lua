-- MRJobs10_Basurero
-- Script Empresa publica Basurero
-- Autor: ElTitoJet
-- Fecha: 14/09/2024

-- Variables Globales y Configuración
    local PickUps = {
        -- {x, y, z, int, dim, tienda}
        [1] = {2440.884765625, -2122.8642578125, 13.546875},
    }
    local pickupsStreaming = {}

    local RutasBasurero = {
        [1] = {
            [1] = {2428.970703125, -2090.0732421875, 14.090637207031},
            [2] = {2416.82421875, -1991.955078125, 13.91362953186}, 
            [3] = {2343.0595703125, -1969.1083984375, 13.850716590881}, 
            [4] = {2314.2138671875, -1893.328125, 13.959687232971}, 
            [5] = {2123.583984375, -1890.7900390625, 13.867421150208}, 
            [6] = {2085.029296875, -1830.05078125, 13.926140785217}, 
            [7] = {2113.9990234375, -1692.8232421875, 13.921646118164},
            [8] = {2132.2626953125, -1439.599609375, 24.379539489746},
            [9] = {2170.5048828125, -1332.83203125, 24.37621307373},
            [10] = {2177.1015625, -1246.3681640625, 24.357290267944},
            [11] = {2367.3369140625, -1179.9541015625, 27.963354110718},
            [12] = {2409.201171875, -1260.0888671875, 24.39342880249},
            [13] = {2447.5859375, -1328.1181640625, 24.385776519775},
            [14] = {2427.4755859375, -1508.484375, 24.389205932617},
            [15] = {2410.484375, -1774.064453125, 13.925530433655},
            [16] = {2410.2490234375, -1900.5224609375, 13.931764602661},
            [17] = {2410.1728515625, -1986.7744140625, 13.90133190155},
            [18] = {2428.970703125, -2090.0732421875, 14.090637207031}
        },
        [2] = {}
    }
    local Ruta = nil
    
    local index = 1
    local varMarkerRuta;
    local varBlipRuta;
    local timers = {};
-- Funciones Auxiliares
    function table.find(t, i, f)
        --print(debug.traceback())
        if (not f) then
            f = i
            i = false
        end
        for k, v in pairs(t) do
            if i then
                if v[i] and (v[i] == f) then
                    return k, v, v[i]
                end
            elseif (v == f) then
                return k, v
            end
        end
        return false
    end

-- Funciones Principales
    function elementStreamInOut()
        if getElementType(source) ~= "player" then
            if eventName:find("In") then
                if getElementType(source) == 'pickup' then
                    local x,y,z = getElementPosition(source)
                    for i, v in ipairs(PickUps) do
                        if getDistanceBetweenPoints3D(x,y,z, unpack(v)) <= 5 then
                            pickupsStreaming[source] = exports["MR1_Inicio"]:createText3D("#FFFFFF\n Presiona #24C5BEH #FFFFFFpara empezar a trabajar", x, y, z+1, 2, "bankgothic", -1, false, false, true)
                        end
                    end
                end
            else
                if isElement(pickupsStreaming[source]) then
                    destroyElement(pickupsStreaming[source])
                end
            end
        end
    end
    function IniciarJob()
        Ruta = 1--math.random(1, 1)
        Ruta = Ruta
        varMarkerRuta = createMarker(RutasBasurero[Ruta][index][1], RutasBasurero[Ruta][index][2], RutasBasurero[Ruta][index][3], "checkpoint", 3.5, 0, 255, 0, 255)  
        varBlipRuta = createBlip(RutasBasurero[Ruta][index][1], RutasBasurero[Ruta][index][2], RutasBasurero[Ruta][index][3], 0, 2, 255, 125, 0, 255, 0, 99999)
        setElementParent(varBlipRuta, varMarkerRuta)
        addEventHandler("onClientMarkerHit", varMarkerRuta, NextPointBasurero)
    end
    function NextPointBasurero(hitElement)
        if hitElement ~= localPlayer then return end
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if not vehicle then return end
        if getElementModel(vehicle) ~= 408 then
            outputChatBox("#ffe100Creo que seria mejor un camion de basura...", 255, 255, 255, true)
            return
        end
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
        if not varDataVehicle or varDataVehicle["Personaje"] ~= "Basurero LS" then
            outputChatBox("#ffe100Creo que tendria que usar un vehiculo de trabajo...", 255, 255, 255, true)
            return 
        end
        destroyElement(source)
        if index >= #RutasBasurero[Ruta] then
            index = 1
            Ruta = nil
            triggerServerEvent("trabajo:BasureroLS:Paga", localPlayer, localPlayer)
            return
        else
            index = index + 1
            --iprint("tbl ", RutasBasurero[Ruta][index])
            varMarkerRuta = createMarker(RutasBasurero[Ruta][index][1], RutasBasurero[Ruta][index][2], RutasBasurero[Ruta][index][3], "checkpoint", 3.5, 0, 255, 0, 255)
            varBlipRuta = createBlip(RutasBasurero[Ruta][index][1], RutasBasurero[Ruta][index][2], RutasBasurero[Ruta][index][3], 0, 2, 255, 125, 0, 255, 0, 99999)
            setElementParent(varBlipRuta, varMarkerRuta)
        end
        
        addEventHandler("onClientMarkerHit", varMarkerRuta, NextPointBasurero)
    end
    function StartEnterVehicle(player, seat)
        if (seat == 0) and (getElementModel(source) == 408) and (player == localPlayer) then
            local dataVehicle = exports["MR1_Inicio"]:getValueOne(source)
            if not (dataVehicle.Personaje == "Basurero LS") then return cancelEvent() end
            if not (dataVehicle.Propietario == localPlayer) then
                outputChatBox("#ffe100Este no es mi camion...", 255, 255, 255, true) 

                return cancelEvent() 
            end
        end
    end
    function clearJob()
        if isElement(varMarkerRuta) then
            destroyElement(varMarkerRuta)
        end
        if isElement(varBlipRuta) then
            destroyElement(varBlipRuta)
        end
        index = 1
    end
    function EnterVehicle(player, seat)
        if (seat == 0) and (getElementModel(source) == 408) and (player == localPlayer) then
            if not (Ruta) then
                IniciarJob()
            else
                if isTimer(timers.CancelJob) then
                    killTimer(timers.CancelJob)
                    outputChatBox("#9AA498[#FF7800Basurero#9AA498] #53B440Tomaste el camion, ya puedes trabajar.", player, 0, 0, 0, true)
                end
            end
        end
    end
    function ExitVehicle(player, seat)
        if (seat == 0) and (getElementModel(source) == 408) and (player == localPlayer) then
            if not (Ruta) then 
                return
            end
            -- Notificar al jugador
            outputChatBox("#9AA498[#FF7800Basurero#9AA498] #FFE100Tienes 15 segundos para volver al camión o perderás el trabajo.", 255, 255, 255, true)
            -- Iniciar un temporizador de 15 segundos
            timers.CancelJob = setTimer(function()
                outputChatBox("#A03535No te subiste de vuelta a tu camion.", 0, 0, 0, true)
                clearJob(varMarkerRuta)
                triggerServerEvent("trabajo:BasureroLS:ClearJob", localPlayer, localPlayer)
            end, 15000, 1)
        end
    end
    function clearJob()
        if isElement(varMarkerRuta) then
            destroyElement(varMarkerRuta)
        end
        Ruta = nil
        index = 1
        varMarkerRuta = nil
        varBlipRuta = nil
    end
-- Eventos y Handlers

-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
addEventHandler( "onClientElementStreamIn", getRootElement(), elementStreamInOut)
addEventHandler( "onClientElementStreamOut", getRootElement(), elementStreamInOut)
addEvent("trabajo:BasureroLS:startJob", true)
addEventHandler("trabajo:BasureroLS:startJob", root, IniciarJob)

addEventHandler("onClientVehicleStartEnter", root, StartEnterVehicle)
addEventHandler("onClientVehicleEnter", root, EnterVehicle)
addEventHandler("onClientVehicleExit", root, ExitVehicle)

