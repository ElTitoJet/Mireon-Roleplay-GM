-- MR20_BikeRental
-- Gestiona el sistema de renta de biciss.
-- Autor: ElTitoJet
-- Fecha: 25/08/2024

-- Variables Globales y Configuración
    local Rentadores = {
        [1] = {1465.08984375, -1749.2724609375, 15.4453125, "Bike"},
        [2] = {1083.39453125, -1379.052734375, 13.78125, "Bike"},
        [3] = {1975.3125, -1446.71875, 13.487923622131, "Bike"},
        [4] = {442.4091796875, -1806.4248046875, 5.546875, "Bike"},
        [5] = {1697.8701171875, -1880.8427734375, 13.557719230652, "Bike"},
        [6] = {2402.2353515625, -1546.494140625, 23.992498397827, "Bike"},
        [7] = {1046.1220703125, -922.0693359375, 42.597030639648, "Bike"},
        [8] = {2275.0390625, 31.62890625, 26.434675216675, "Bike"},
        [9] = {1424.0712890625, 280.6923828125, 19.5546875, "Bike"},
        [10] = {-73.8662109375, -1182.9423828125, 1.75, "Bike"},
        [11] = {-2021.5458984375, -41.2470703125, 35.349983215332, "Bike"},
        [12] = {-2705.296875, 1308.7783203125, 7.0098571777344, "Bike"},
        [13] = {-2586.6806640625, 487.4052734375, 14.616756439209, "Bike"},
        [14] = {-2484.22265625, -167.9228515625, 25.6171875, "Bike"},
        [15] = {-2116.83984375, -2475.4296875, 30.625, "Bike"},
        [16] = {-2516.1396484375, 2352.6416015625, 4.983549118042, "Bike"},
        [17] = {-233.44140625, 2723.791015625, 62.6875 , "Bike"},
        [18] = {-1519.3857421875, 2585.25390625, 55.8359375, "Bike"},
        [19] = {536.7080078125, 2370.88671875, 30.603988647461, "Bike"},
        [20] = {2102.181640625, 2646.1884765625, 10.8203125, "Bike"},
        [21] = {2778.8271484375, 1974.216796875, 10.8203125, "Bike"},
        [22] = {1988.849609375, 2064.083984375, 10.8203125, "Bike"},
        [23] = {2106.625, 945.4697265625, 10.8203125, "Bike"},
        [24] = {1691.6240234375, 1743.5810546875, 10.824426651001, "Bike"},
        [25] = {-212.7265625, 1215.0146484375, 19.890625, "Bike"},
        [26] = {1088.22265625, -1801.7978515625, 13.602400779724, "Bike"},
        [27] = {2238.8154296875, -2190.564453125, 13.546875, "Bike"}
    }
    local playerBikes = {}
    local countBikes = 0
    local PickUpsRenta = createElement("PickUps")
    local PrecioRenta = 100
    local maxBikesPerPlayer = 10
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
    function RentalBike(player)
        if playerBikes[player] and #playerBikes[player] >= maxBikesPerPlayer then
            outputChatBox("#FF0000Ya has alquilado el máximo de bicicletas permitidas (" .. maxBikesPerPlayer .. ").", player, 255, 255, 255, true)
            return
        end
        local varDataPlayer = exports["MR1_Inicio"]:getValueOne(player)
        local varPosX, varPosY, varPosZ = getElementPosition(player)
        local varRotX, varRotY, varRotZ = getElementRotation(player)
        countBikes = countBikes + 1
        local varMatricula = "Bike-"..countBikes
        local bike = createVehicle(509, varPosX, varPosY, varPosZ, varRotX, varRotY, varRotZ, Matricula)
        exports["MR1_Inicio"]:setValue(bike, 'ID', countBikes)
        exports["MR1_Inicio"]:setValue(bike, 'IDPersonaje', varDataPlayer.IDPersonaje)
        local Informacion = {Matricula = varMatricula, Modelo = 509}
            exports["MR1_Inicio"]:setValue(bike, 'Informacion', Informacion)
        local Estado = {Salud = 1000, Destruido = false, Bloqueo = false, Motor = true, Luces = false}
            exports["MR1_Inicio"]:setValue(bike, 'Estado', Estado)

        if not playerBikes[player] then
            playerBikes[player] = {}
        end
        table.insert(playerBikes[player], bike)
        triggerClientEvent(player, "startBikeTimer", player, bike, countBikes)
        
        --varDataPlayer.Inventario["Dinero"] = varDataPlayer.Inventario["Dinero"] - PrecioRenta
        exports["MR6_Economia"]:restarDinero(player, PrecioRenta, "MR20_BikeRental")
        --exports["MR1_Inicio"]:setValue(player, 'Inventario', varDataPlayer.Inventario)
        outputChatBox("#ffe100Acabo de alquilar una #FF7800bicicleta #ffe100por #FF7800"..formatNumber(PrecioRenta).." $#ffe100, durante #FF78001 hora#ffe100...", player, 255, 255, 255, true)   
    end
    function HitRentalPickUpRental(hitElement)
        if not (getElementType(hitElement) == "player") or isPedInVehicle(hitElement) then
            return
        end
        bindKey(hitElement, "H", "down", function(hitElement, m)
            RentalBike(hitElement)
            unbindKey(hitElement,"H")
        end)
    end
    function LeavePickUpRental(hitElement, m)
        unbindKey(hitElement,"H")
    end
    function destroyBike(bikeID)
        for _, bike in ipairs(getElementsByType("vehicle")) do
            local bikeIDServer = exports["MR1_Inicio"]:getValue(bike, 'ID')
            if bikeIDServer == bikeID then
                destroyElement(bike)
                break
            end
        end
    end
-- Eventos y Handlers
    addEventHandler("onPickupHit", PickUpsRenta, HitRentalPickUpRental)
    addEventHandler("onPickupLeave", PickUpsRenta, LeavePickUpRental)
    addEvent("destroyServerBike", true)
    addEventHandler("destroyServerBike", root, function(bikeID)
        destroyBike(bikeID)
    end)
    addEventHandler("onPlayerQuit", root, function()
        local playerBikesList = playerBikes[source]
        if playerBikesList then
            for _, bike in ipairs(playerBikesList) do
                destroyElement(bike)
            end
            playerBikes[source] = nil
        end
    end)
-- Inicialización
    addEventHandler("onResourceStart", resourceRoot, function()
        for i, Concesionario in ipairs (Rentadores) do
            local varPickupRental = createPickup(Concesionario[1], Concesionario[2], Concesionario[3], 3, 1274, 0, 0)
            local varBlipRental = createBlipAttachedTo(varPickupRental, 19, 255, 0, 0, 0, 255, 0, 200)
            setElementParent( varPickupRental, PickUpsRenta )
            setElementID(varPickupRental, i)
        end
    end)
