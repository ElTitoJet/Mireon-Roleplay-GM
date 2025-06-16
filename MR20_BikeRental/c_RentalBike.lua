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
        [5] = {1698.9306640625, -1880.80078125, 13.561605453491, "Bike"},
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
    local bikeTimers = {}
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
    function Icono_RentaBici()
        for i, Concesionario in ipairs (Rentadores) do
            local x, y, z = Concesionario[1], Concesionario[2], Concesionario[3]
            local x2, y2, z2 = getCameraMatrix()
            local distance = 8
            local height = 0.5
            local size = 2
            local text = "#53B440["..Concesionario[4].."] #FFFFFF\n Pulsa #24C5BEH #FFFFFFpara rentar una Bici por 100 dolares, una hora."
            if (isLineOfSightClear(x, y, z+2, x2, y2, z2)) then
                local sx, sy = getScreenFromWorldPosition(x, y, z+height)
                if(sx) and (sy) then
                    local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
                    if(distanceBetweenPoints < distance) then
                        dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center", false, false, false, true)
                    end
                end
            end
        end
    end
    function startBikeTimer(bike, bikeID)
        -- Configurar el temporizador de advertencia (50 minutos)
        local warningTimer = setTimer(function()
            outputChatBox("Tu bicicleta será destruida en 10 minutos.")
        end, 50 * 60000, 1)
        
        -- Configurar el temporizador de destrucción (1 hora)
        local destroyTimer = setTimer(function()
            triggerServerEvent("destroyServerBike", resourceRoot, bikeID)
            outputChatBox("Tu bicicleta ha sido destruida.")
        end, 60 * 60000, 1)  -- 60 minutos
        
        -- Almacenar los temporizadores para cancelarlos si es necesario
        bikeTimers[bikeID] = {warningTimer = warningTimer, destroyTimer = destroyTimer}
    end

-- Eventos y Handlers
    addEventHandler("onClientRender", root, Icono_RentaBici)
    addEvent("startBikeTimer", true)
    addEventHandler("startBikeTimer", root, startBikeTimer)
-- Inicialización
