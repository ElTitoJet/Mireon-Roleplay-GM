-- MRJobs9_Camionero
-- Script que gestiona el job de Camionero LS
-- Autor: ElTitoJet
-- Fecha: 15/01/2024

-- Variables Globales y Configuración
local PosEntregas = {
}
local Ruta = {}
local index = 0;

local MotosPizzaIdle = {};
local StartJob;
local timers = {};
local pickupsStreaming = {}
local PickUps = {
    -- {x, y, z, int, dim, tienda}
    [1] = {2183.0595703125, -2253.09375, 14.772862434387},
}

local marker;
local distanciaTotal = 0;
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

    function clearJob(marker)
        if isElement(marker) then
            destroyElement(marker)
        end
        index = 0
        StartJob = nil
    end

    function agregarPosicion(x, y, z)
        table.insert(PosEntregas, {x, y, z})
    end

    function calcularDistancia(x1, y1, z1, x2, y2, z2)
        local dx = x2 - x1
        local dy = y2 - y1
        local dz = z2 - z1
        return math.sqrt(dx * dx + dy * dy + dz * dz)
    end

    function calcularDistanciaTotal(ruta)
        local distanciaTotal = 0
        for i = 1, #ruta - 1 do
            local puntoActual = ruta[i]
            local puntoSiguiente = ruta[i + 1]
            distanciaTotal = distanciaTotal + calcularDistancia(puntoActual[1], puntoActual[2], puntoActual[3], puntoSiguiente[1], puntoSiguiente[2], puntoSiguiente[3])
        end
        return math.floor(distanciaTotal)
    end    
    
-- Funciones Principales
    function StartEnterVehicle(player, seat)
        if (seat == 0) and (getElementModel(source) == 456) and (player == localPlayer) then
            local dataVehicle = exports["MR1_Inicio"]:getValueOne(source)
            if not (dataVehicle.Personaje == "Camionero LS") then return cancelEvent() end
            if not (dataVehicle.Propietario == localPlayer) then
                outputChatBox("#ffe100Este no es mi camion...", 255, 255, 255, true) 

                return cancelEvent() 
            end
        end
    end

    function EnterVehicle(player, seat)
        if (seat == 0) and (getElementModel(source) == 456) and (player == localPlayer) then
            if not (StartJob) then 
                StartJob = true;
                PrepararRuta()
            else
                if isTimer(timers.CancelJob) then
                    killTimer(timers.CancelJob)
                    outputChatBox("#9AA498[#FF7800Camionero#9AA498] #53B440Regresaste al camion, continua tu recorrido.", 0, 0, 0, true)
                end
            end
        end
    end
    
    function ExitVehicle(player, seat)
        if (seat == 0) and (getElementModel(source) == 456) and (player == localPlayer) then
            if not (StartJob) then 
                return
            end
            outputChatBox("#A03535Vuelve a tu camion o será eliminado en 15 segundos.", 0, 0, 0, true)
            timers.CancelJob = setTimer(function()
                outputChatBox("#A03535Tu camion fue eliminado pasado los 15 segundos.", 0, 0, 0, true)
                clearJob(marker)
                triggerServerEvent("trabajo:CamioneroLS:ClearJob", localPlayer, localPlayer)
            end, 15000, 1)
        end
    end

    function PrepararRuta()
        Ruta = {}
        distanciaTotal = 0;
        local maxEntregas = 3
        table.insert(Ruta, {2764.462890625, -2444.685546875, 13.667456626892})
        while ( #Ruta < maxEntregas - 1 ) do
            local i = math.random(#PosEntregas)
            local check = table.find(Ruta, 1, PosEntregas[i][1])

            if not (check) then
                table.insert(Ruta, PosEntregas[i])
            end
        end
        table.insert(Ruta, {2181.916015625, -2298.654296875, 13.697174072266})
        Recorrido()
        distanciaTotal = calcularDistanciaTotal(Ruta)
        
        outputChatBox("Distancia total: " ..distanciaTotal, 255, 255, 255, true) 
    end

    function Recorrido()
        index = index + 1
        outputChatBox(index.."/"..#Ruta)
        if (index == #Ruta) then
            local infoEntrega = Ruta[index]
            local x, y, z = unpack(infoEntrega)
            marker = createMarker(x, y, z, "checkpoint", 3.5, 0, 255, 0, 255)
            blip = createBlip(x, y, z, 0, 2, 255, 125, 0, 255, 0, 99999)
            setElementParent(blip, marker)
            addEventHandler("onClientMarkerHit", marker, function(hitElement, md)
                if (hitElement == localPlayer) and isPedInVehicle(localPlayer) and md then
                    local vehicle = getPedOccupiedVehicle(localPlayer)
                    local dataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
                    if not (dataVehicle.Personaje == "Camionero LS") then return cancelEvent() end
                    if not (dataVehicle.Propietario == localPlayer) then return cancelEvent() end
                    destroyElement(source)
                    triggerServerEvent("trabajo:CamioneroLS:Paga", localPlayer, localPlayer, index, distanciaTotal)
                    clearJob(marker)
                end
            end)
        else
            local infoEntrega = Ruta[index]
            local x, y, z = unpack(infoEntrega)
            marker = createMarker(x, y, z, "checkpoint", 3.5, 0, 255, 0, 255)
            blip = createBlip(x, y, z, 0, 2, 255, 125, 0, 255, 0, 99999)
            setElementParent(blip, marker)
            addEventHandler("onClientMarkerHit", marker, function(hitElement, md)
                if (hitElement == localPlayer) and isPedInVehicle(localPlayer) and md then
                    local vehicle = getPedOccupiedVehicle(localPlayer)
                    local dataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
                    if not (dataVehicle.Personaje == "Camionero LS") then return cancelEvent() end
                    if not (dataVehicle.Propietario == localPlayer) then return cancelEvent() end
                    destroyElement(source)
                    Recorrido()
                end
            end)
        end
    end

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
    addEventHandler( "onClientElementStreamIn", getRootElement(), elementStreamInOut)
    addEventHandler( "onClientElementStreamOut", getRootElement(), elementStreamInOut)
    
-- Eventos y Handlers
    addEventHandler("onClientVehicleStartEnter", root, StartEnterVehicle)
    addEventHandler("onClientVehicleEnter", root, EnterVehicle)
    addEventHandler("onClientVehicleExit", root, ExitVehicle)

-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
    agregarPosicion(1951.70703125, -2120.0625, 13.272727012634)
    agregarPosicion(1942.90625, -2088.53125, 13.281257629395)
    agregarPosicion(1971.7314453125, -2038.1708984375, 13.273953437805)
    agregarPosicion(1955.724609375, -1988.1025390625, 13.234721183777)
    agregarPosicion(2086.4521484375, -1929.578125, 13.120313644409)
    agregarPosicion(2085.2822265625, -1806.05859375, 13.109893798828)
    agregarPosicion(2080.337890625, -1780.970703125, 13.189797401428)
    agregarPosicion(2245.6767578125, -1660.2255859375, 15.101168632507)
    agregarPosicion(2418.5205078125, -1743.82421875, 13.189019203186)
    agregarPosicion(2396.552734375, -1894.765625, 13.109887123108)
    agregarPosicion(2397.0078125, -1976.0634765625, 13.110022544861)
    agregarPosicion(2346.3623046875, -1464.0654296875, 23.555208206177)
    agregarPosicion(2427.205078125, -1508.14453125, 23.565328598022)
    agregarPosicion(2501.5439453125, -1500.576171875, 23.555194854736)
    agregarPosicion(2554.814453125, -1483.6826171875, 23.595235824585)
    agregarPosicion(2554.22265625, -1468.8896484375, 23.577289581299)
    agregarPosicion(2574.6650390625, -1398.3203125, 26.904104232788)
    agregarPosicion(2567.3037109375, -1359.0224609375, 34.008869171143)
    agregarPosicion(2663.89453125, -1090.078125, 69.014549255371)
    agregarPosicion(2659.3359375, -1089.9599609375, 69.086486816406)
    agregarPosicion(2704.7646484375, -1088.029296875, 68.940254211426)
    agregarPosicion(2719.1513671875, -1108.4677734375, 69.135604858398)
    agregarPosicion(2719.0732421875, -1115.5625, 69.141151428223)
    agregarPosicion(2092.8828125, -981.8671875, 52.041194915771)
    agregarPosicion(2158.828125, -1009.89453125, 62.516395568848)
    agregarPosicion(1316.953125, -869.609375, 39.305202484131)
    agregarPosicion(1194.21484375, -923.861328125, 43.254783630371)
    agregarPosicion(1082.9775390625, -929.080078125, 43.319164276123)
    agregarPosicion(993.8974609375, -922.2177734375, 42.352909088135)
    agregarPosicion(875.69921875, -986.4326171875, 35.764255523682)
    agregarPosicion(810.3857421875, -1055.396484375, 25.018043518066)
    agregarPosicion(778.857421875, -1042.4736328125, 24.456981658936)
    agregarPosicion(485.9140625, -1281.84375, 15.67747592926)
    agregarPosicion(365.375, -1363.904296875, 14.562361717224)
    agregarPosicion(274.6279296875, -1425.7763671875, 13.849457740784)
    agregarPosicion(507.9013671875, -1358.0439453125, 16.133962631226)
    agregarPosicion(367.8095703125, -1594.37109375, 31.759136199951)
    agregarPosicion(484.7109375, -1532.5546875, 19.646772384644)
    agregarPosicion(507.3173828125, -1413.4921875, 16.155504226685)
    agregarPosicion(495.4853515625, -1418.1328125, 16.31750869751)
    agregarPosicion(486.0107421875, -1422.248046875, 16.869924545288)
    agregarPosicion(448.240234375, -1479.7626953125, 30.796905517578)
    agregarPosicion(452.25390625, -1500.564453125, 31.059188842773)
    agregarPosicion(424.47265625, -1652.7294921875, 26.281667709351)
    agregarPosicion(367.0888671875, -2031.888671875, 7.8450140953064)
    agregarPosicion(366.9892578125, -2043.26953125, 7.8448286056519)
    agregarPosicion(372.9423828125, -1921.4755859375, 7.8446855545044)
    agregarPosicion(372.9619140625, -1906.455078125, 7.8451471328735)
    agregarPosicion(372.787109375, -1885.25, 7.8391995429993)
    agregarPosicion(371.4248046875, -1814.525390625, 7.8435926437378)
    agregarPosicion(617.640625, -1746.6494140625, 13.487324714661)
    agregarPosicion(667.673828125, -1757.18359375, 13.617034912109)
    agregarPosicion(688.5673828125, -1763.0673828125, 13.469755172729)
    agregarPosicion(708.6962890625, -1769.79296875, 14.054346084595)
    agregarPosicion(722.634765625, -1774.5341796875, 14.018547058105)
    agregarPosicion(749.123046875, -1781.0263671875, 13.004453659058)
    agregarPosicion(771.4775390625, -1785.28515625, 13.109083175659)
    agregarPosicion(815, -1764.2158203125, 13.570549964905)
    agregarPosicion(829.828125, -1601.7373046875, 13.556087493896)
    agregarPosicion(821.9267578125, -1595.3525390625, 13.555654525757)
    agregarPosicion(795.052734375, -1584.3046875, 13.559846878052)
    agregarPosicion(821.791015625, -1625.806640625, 13.556047439575)
    agregarPosicion(816.8505859375, -1392.576171875, 13.571947097778)
    agregarPosicion(869.9462890625, -1392.611328125, 13.462502479553)
    agregarPosicion(876.8369140625, -1392.5390625, 13.441226005554)
    agregarPosicion(882.4443359375, -1392.4189453125, 13.443556785583)
    agregarPosicion(888.3544921875, -1392.314453125, 13.435793876648)
    agregarPosicion(894.4091796875, -1392.3916015625, 13.421772956848)
    agregarPosicion(900.0595703125, -1392.36328125, 13.404226303101)
    agregarPosicion(906.791015625, -1392.34375, 13.408316612244)
    agregarPosicion(920.82421875, -1352.3681640625, 13.376491546631)
    agregarPosicion(957.396484375, -1329.857421875, 13.547776222229)
    agregarPosicion(977.8427734375, -1330.369140625, 13.547457695007)
    agregarPosicion(1038.720703125, -1330.9765625, 13.565766334534)
    agregarPosicion(1105.6611328125, -1434.3125, 15.970520973206)
    agregarPosicion(1105.787109375, -1452.7451171875, 15.969934463501)
    agregarPosicion(1103.0146484375, -1474.38671875, 15.969828605652)
    agregarPosicion(1103.20703125, -1504.1435546875, 15.970844268799)
    agregarPosicion(1116.3115234375, -1517.9248046875, 15.970257759094)
    agregarPosicion(1141.6396484375, -1517.7568359375, 15.969547271729)
    agregarPosicion(1154.16015625, -1504.26171875, 15.969434738159)
    agregarPosicion(1154.0732421875, -1474.5830078125, 15.973061561584)
    agregarPosicion(1149.9619140625, -1457.20703125, 15.970456123352)
    agregarPosicion(920.56640625, -1555.7900390625, 13.556219100952)
    agregarPosicion(880.01953125, -1571.8671875, 13.562447547913)
    agregarPosicion(855.388671875, -1590.6083984375, 13.559184074402)
    agregarPosicion(1057.4462890625, -1575.05859375, 13.55711555481)
    agregarPosicion(1135.1142578125, -1574.6796875, 13.483256340027)
    agregarPosicion(1315.5224609375, -1838.626953125, 13.556203842163)
    agregarPosicion(1315.3427734375, -1819.1943359375, 13.556660652161)
    agregarPosicion(1315.1591796875, -1810.2626953125, 13.556230545044)
    agregarPosicion(1314.9052734375, -1787.0703125, 13.556672096252)
    agregarPosicion(1314.7998046875, -1782.2490234375, 13.556337356567)
    agregarPosicion(1315.6142578125, -1746.7822265625, 13.555923461914)
    agregarPosicion(1314.99609375, -1710.615234375, 13.556212425232)
    agregarPosicion(1315.1591796875, -1680.88671875, 13.556445121765)
    agregarPosicion(1315.44140625, -1666.103515625, 13.55687046051)
    agregarPosicion(1315.478515625, -1645.189453125, 13.556843757629)
    agregarPosicion(1315.494140625, -1635.71484375, 13.556746482849)
    agregarPosicion(1332.1201171875, -1512.4873046875, 13.555736541748)
    agregarPosicion(1336.6240234375, -1505.669921875, 13.5565366745)
    agregarPosicion(1341.0458984375, -1498.65234375, 13.562355041504)
    agregarPosicion(1353.220703125, -1469.9287109375, 13.556462287903)
    agregarPosicion(1357.130859375, -1454.2529296875, 13.556035041809)
    agregarPosicion(1359.4951171875, -1438.6005859375, 13.559380531311)
    agregarPosicion(1360.623046875, -1384.673828125, 13.678406715393)
    agregarPosicion(1360.9775390625, -1280.080078125, 13.548773765564)
    agregarPosicion(1306.259765625, -1138.482421875, 23.829616546631)
    agregarPosicion(1224.55859375, -1138.224609375, 23.810857772827)
    agregarPosicion(1244.5751953125, -1138.62890625, 23.791137695312)
    agregarPosicion(1202.8681640625, -1138.4033203125, 23.896635055542)
    agregarPosicion(1147.2861328125, -1138.693359375, 23.829967498779)
    agregarPosicion(1125.08203125, -1138.8671875, 23.829187393188)
    agregarPosicion(1047.1083984375, -1138.244140625, 23.829727172852)
    agregarPosicion(1000.6982421875, -1137.8798828125, 23.858478546143)
    agregarPosicion(945.98046875, -1297.0654296875, 14.210953712463)
    agregarPosicion(946.0205078125, -1290.4267578125, 14.536516189575)
    agregarPosicion(946.111328125, -1280.6103515625, 15.018458366394)
    agregarPosicion(1014.12109375, -1223.5693359375, 16.938199996948)
    agregarPosicion(1019.625, -1223.6181640625, 16.93913269043)
    agregarPosicion(1025.375, -1223.6689453125, 16.937463760376)
    agregarPosicion(1029.314453125, -1223.7734375, 16.929471969604)
    agregarPosicion(1050.98828125, -1273.220703125, 13.704936027527)
    agregarPosicion(1050.9833984375, -1283.5849609375, 13.69056320190)
    agregarPosicion(1050.900390625, -1292.7578125, 13.652039527893)
    agregarPosicion(1050.759765625, -1306.5166015625, 13.557656288147)
    agregarPosicion(1065.3154296875, -1383.7431640625, 13.755558013916)
    agregarPosicion(1065.580078125, -1363.5751953125, 13.555890083313)
    agregarPosicion(1065.541015625, -1354.4794921875, 13.556028366089)
    agregarPosicion(1065.4775390625, -1315.830078125, 13.556179046631)
    agregarPosicion(1065.5087890625, -1295.2412109375, 13.635579109192)
    agregarPosicion(1065.298828125, -1267.6611328125, 13.96261882782)
    agregarPosicion(1065.1142578125, -1260.1083984375, 14.516592025757)
    agregarPosicion(1064.9990234375, -1253.1826171875, 14.953116416931)
    agregarPosicion(1064.95703125, -1245.455078125, 15.557068824768)
    agregarPosicion(1064.9814453125, -1239.1279296875, 16.130783081055)
    agregarPosicion(1065.1103515625, -1233.91796875, 16.615734100342)
    agregarPosicion(1065.32421875, -1222.9228515625, 17.007841110229)
    agregarPosicion(1065.3466796875, -1201.60546875, 18.732997894287)
    agregarPosicion(1065.4326171875, -1194.1435546875, 20.038366317749)
    agregarPosicion(1065.4970703125, -1186.8642578125, 21.262535095215)
    agregarPosicion(1085.87890625, -1277.5654296875, 13.579927444458)
    agregarPosicion(1093.4306640625, -1277.4375, 13.611413955688)
    agregarPosicion(1108.1962890625, -1277.705078125, 13.628383636475)
    agregarPosicion(1116.8173828125, -1277.669921875, 13.626818656921)
    agregarPosicion(1127.8662109375, -1277.6923828125, 13.633423805237)
    agregarPosicion(1133.42578125, -1277.6201171875, 13.640357971191)
    agregarPosicion(1462.98046875, -1136.8701171875, 24.234643936157)
    agregarPosicion(1528.607421875, -1164.474609375, 24.079767227173)
    agregarPosicion(1544.06640625, -1164.603515625, 24.079845428467)
    agregarPosicion(1565.09375, -1164.568359375, 24.079023361206)
    agregarPosicion(1628.615234375, -1164.40234375, 24.068693161011)
    agregarPosicion(1671.8232421875, -1164.73046875, 23.871116638184)
    agregarPosicion(1698.5986328125, -1164.0537109375, 23.829614639282)
    agregarPosicion(1788.8720703125, -1169.4765625, 23.826494216919)
    agregarPosicion(1843.7001953125, -1415.296875, 13.563642501831)
    agregarPosicion(1843.904296875, -1442.0947265625, 13.574012756348)
    agregarPosicion(1825.0498046875, -1839.2548828125, 13.587388038635)
    agregarPosicion(1924.4755859375, -1859.5126953125, 13.735075950623)
    agregarPosicion(1934.02734375, -1774.1728515625, 13.555685043335)
    agregarPosicion(1977.65234375, -1755.2568359375, 13.555362701416)
    agregarPosicion(1984.3359375, -1755.3232421875, 13.556248664856)
    agregarPosicion(1991.435546875, -1755.3779296875, 13.5560131073)
    agregarPosicion(1999.6494140625, -1755.4765625, 13.556136131287)
    agregarPosicion(2128.28515625, -1755.4375, 13.577180862427)
    agregarPosicion(2181.912109375, -1768.865234375, 13.545922279358)
    agregarPosicion(2290.2548828125, -1729.3984375, 13.556250572205)
    agregarPosicion(2170.09765625, -1334.6875, 24.001472473145)
    agregarPosicion(2126.3759765625, -1217.57421875, 23.988708496094)
    agregarPosicion(2115.3310546875, -1217.5107421875, 23.977445602417)
    agregarPosicion(2096.4130859375, -1218.236328125, 23.977277755737)
    agregarPosicion(2074.51953125, -1204.935546875, 23.943958282471)
    agregarPosicion(2001.501953125, -1278.2919921875, 23.993545532227)
    agregarPosicion(1989.7080078125, -1278.283203125, 23.993961334229)
    agregarPosicion(1884.20703125, -1262.5703125, 13.563254356384)
