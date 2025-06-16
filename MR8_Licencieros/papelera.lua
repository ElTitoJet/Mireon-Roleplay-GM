-- MR8_Licencieros
-- Gestiona las licencias de conduccion del servidor
-- Autor: ElTitoJet
-- Fecha: 14/04/2024

-- Variables Globales y Configuración
local PickUps = {
    --[ID] = {x, y, z, tipo, interior, dimension} Entrada - Salida
    [1] = {-2031.935546875, -117.2626953125, 1035.171875, 3, 1239, 3, 1}, -- PickUp Examen
}
local screenW, screenH = guiGetScreenSize()
local varNumPregunta = 0;
local PrecioLicencia = 100
local Preguntas = {
    {"Estas conduciendo en una via donde el limite es 110 km/h. Todos van a 120 km/h, ¿A que velocidad debe ir?", "80", "110", "140", 3};
    {"En una autovía hay una persona haciendo autostop. ¿Está permitido recogerla?", "Si", "Sí, si está transitando por el arcén de la derecha.", "No", 4};
    {"Vas conduciendo y una patrulla enciende sus luces. ¿Que debes hacer?", "Apartarte a la derecha", "Apartarte a la izquierda", "Frenar en seco", 2};
    {"Vas conduciendo y una patrulla enciende sus luces y te dice que te detengas. ¿Que haces?", "Frenar en seco", "Salir corriendo", "Apartarte a la derecha y apagar el motor", 4};
    {"Si la luz del semaforo esta en Naranja. ¿Que debes hacer?", "Detenerte", "Cruzar rapido", "Detenerte si lo puedes hacer sin riesgo a un choque.", 4};
    {"Las luces, debes encenderlas...", "Cuando no tengas luz suficiente", "De noche", "Todo el dia", 2};
    {"¿Que nivel de alcohol en sangre se clasifica como conducir borracho?", "0.05", "0.18", "0.06", 2};
    {"¿Cuando puedes pasar un semaforo?", "Cuando no hay peatones", "Cuando tu quieras", "Cuando este en verde", 4};
    {"¿Que esta permitido en un adelantamiento?", "Acortar la distancia y adelantarle por la izquierda", "Salirte a la vereda", "Pitarle porque va muy lento el cabron", 2};
    {"Si no hay señal que diga la velocidad, ¿A cuanto debes ir?", "120", "30", "60", 3};
};
local LicenciaCursando = nil;
local Examen = {};
local index = 1;
local Resultado = 0;
local RutaLicencia ={
    [1]  = { ["x"] = 1109.3300781250, ["y"] = -1743.6093750000, ["z"] = 13.2232780456540, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [2]  = { ["x"] = 1172.3232421875, ["y"] = -1764.6484375000, ["z"] = 13.2228384017940, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [3]  = { ["x"] = 1131.5898437500, ["y"] = -1850.3212890625, ["z"] = 13.2077388763430, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [4]  = { ["x"] = 1054.5947265625, ["y"] = -1821.6103515625, ["z"] = 13.4428167343140, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [5]  = { ["x"] = 1040.3554687500, ["y"] = -1644.9462890625, ["z"] = 13.2078390121460, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [6]  = { ["x"] = 1019.3457031250, ["y"] = -1569.5605468750, ["z"] = 13.2115364074710, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [7]  = { ["x"] = 874.50292968750, ["y"] = -1574.9619140625, ["z"] = 13.2149600982670, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [8]  = { ["x"] = 809.30566406250, ["y"] = -1589.7060546875, ["z"] = 13.2069711685180, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [9]  = { ["x"] = 626.07812500000, ["y"] = -1616.7783203125, ["z"] = 16.0136280059810, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [10] = { ["x"] = 604.15136718750, ["y"] = -1723.5390625000, ["z"] = 13.5987710952760, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [11] = { ["x"] = 268.63671875000, ["y"] = -1679.5371093750, ["z"] = 8.33226203918460, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [12] = { ["x"] = 167.14355468750, ["y"] = -1572.4238281250, ["z"] = 12.2748870849610, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [13] = { ["x"] = 140.14648437500, ["y"] = -1559.7333984375, ["z"] = 9.88413715362550, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [14] = { ["x"] = 149.50097656250, ["y"] = -1582.2031250000, ["z"] = 11.9044446945190, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [15] = { ["x"] = 1018.0751953125, ["y"] = -1814.8837890625, ["z"] = 13.7951955795290, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [16] = { ["x"] = 1016.2158203125, ["y"] = -2215.2978515625, ["z"] = 12.7785949707030, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [17] = { ["x"] = 1379.7099609375, ["y"] = -2466.2441406250, ["z"] = 6.91333389282230, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [18] = { ["x"] = 1528.8466796875, ["y"] = -2289.9501953125, ["z"] = -3.1671977043152, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [19] = { ["x"] = 1618.8105468750, ["y"] = -2321.6875000000, ["z"] = -3.0271434783936, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [20] = { ["x"] = 1734.4072265625, ["y"] = -2276.8144531250, ["z"] = -3.0266585350037, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [21] = { ["x"] = 1764.1777343750, ["y"] = -2255.8623046875, ["z"] = 1.25884258747100, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [22] = { ["x"] = 1639.3378906250, ["y"] = -2316.4638671875, ["z"] = 13.2104301452640, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [23] = { ["x"] = 1535.0107421875, ["y"] = -2284.1406250000, ["z"] = 13.2082395553590, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [24] = { ["x"] = 1513.0839843750, ["y"] = -2250.6826171875, ["z"] = 13.2141876220700, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [25] = { ["x"] = 1439.6289062500, ["y"] = -2247.5068359375, ["z"] = 13.2066669464110, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [26] = { ["x"] = 1430.3291015625, ["y"] = -2312.9472656250, ["z"] = 13.2064199447630, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [27] = { ["x"] = 1513.3183593750, ["y"] = -2320.9697265625, ["z"] = 13.2070035934450, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [28] = { ["x"] = 1513.0839843750, ["y"] = -2250.6826171875, ["z"] = 13.2141876220700, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [29] = { ["x"] = 1439.6289062500, ["y"] = -2247.5068359375, ["z"] = 13.2066669464110, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [30] = { ["x"] = 1430.3291015625, ["y"] = -2312.9472656250, ["z"] = 13.2064199447630, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [31] = { ["x"] = 1513.3183593750, ["y"] = -2320.9697265625, ["z"] = 13.2070035934450, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [32] = { ["x"] = 1393.5351562500, ["y"] = -2283.8769531250, ["z"] = 13.1818370819090, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [33] = { ["x"] = 1349.7685546875, ["y"] = -2234.5996093750, ["z"] = 13.207772254944, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [34] = { ["x"] = 1613.3183593750, ["y"] = -1575.2568359375, ["z"] = 28.410863876343, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [35] = { ["x"] = 1666.4130859375, ["y"] = -1142.3916015625, ["z"] = 58.219890594482, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [36] = { ["x"] = 1661.9619140625, ["y"] = -1013.5644531250, ["z"] = 35.033344268799, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [37] = { ["x"] = 1438.5253906250, ["y"] = -940.62109375000, ["z"] = 35.909519195557, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [38] = { ["x"] = 1395.4824218750, ["y"] = -939.86718750000, ["z"] = 34.370346069336, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [39] = { ["x"] = 1362.7705078125, ["y"] = -968.94238281250, ["z"] = 32.849349975586, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [40] = { ["x"] = 1342.7109375000, ["y"] = -1100.9453125000, ["z"] = 23.679260253906, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [41] = { ["x"] = 1340.3378906250, ["y"] = -1352.0283203125, ["z"] = 13.207733154297, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [42] = { ["x"] = 1295.5800781250, ["y"] = -1672.6171875000, ["z"] = 13.206979751587, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [43] = { ["x"] = 1237.6855468750, ["y"] = -1709.6289062500, ["z"] = 13.207721710205, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [44] = { ["x"] = 1172.9550781250, ["y"] = -1724.8955078125, ["z"] = 13.425228118896, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [45] = { ["x"] = 1104.9384765625, ["y"] = -1738.2734375000, ["z"] = 13.337627410889, ["r"] = 0, ["g"] = 0, ["b"] = 0},
    [46] = { ["x"] = 1062.2021484375, ["y"] = -1775.4814453125, ["z"] = 13.170426368713, ["r"] = 0, ["g"] = 0, ["b"] = 0}
}
local indexLicencia = 0;
local statusLicencia = nil;
local varCrear_Marker_Ruta = nil;
local varCrear_Blip_Ruta = nil;
local timerSuspendLicencia = nil

local pickupsStreaming = {}
PanelLicencias = guiCreateWindow((screenW - 193) / 2, (screenH - 241) / 2, 193, 241, "LICENCIAS", false)
    guiWindowSetSizable(PanelLicencias, false)
    guiSetVisible(PanelLicencias, false)
    GridListLicencias = guiCreateGridList(10, 31, 168, 128, false, PanelLicencias)
        Licencia = guiGridListAddColumn(GridListLicencias, "Licencias", 0.9)
    BotonExamen = guiCreateButton(11, 169, 167, 28, "OBTENER LICENCIA", false, PanelLicencias)
        guiSetProperty(BotonExamen, "NormalTextColour", "FFAAAAAA")
    BotonCerrar = guiCreateButton(10, 203, 167, 28, "CERRAR PANEL", false, PanelLicencias)
        guiSetProperty(BotonCerrar, "NormalTextColour", "FFAAAAAA")

PanelTeorico = guiCreateWindow((screenW - 749) / 2, (screenH - 267) / 2, 749, 267, "", false)
    guiWindowSetSizable(PanelTeorico, false)
    guiSetVisible(PanelTeorico, false)
    Pregunta = guiCreateLabel(10, 25, 729, 34, varNumPregunta..". ", false, PanelTeorico)
        guiLabelSetHorizontalAlign(Pregunta, "center", false)
        guiLabelSetVerticalAlign(Pregunta, "center")
    Res1 = guiCreateRadioButton(20, 69, 709, 41, "", false, PanelTeorico)
    Res2 = guiCreateRadioButton(20, 120, 709, 41, "", false, PanelTeorico)
    Res3 = guiCreateRadioButton(20, 171, 709, 41, "", false, PanelTeorico)
    SiguientePregunta = guiCreateButton(322, 222, 108, 35, "SIGUIENTE PREGUNTA", false, PanelTeorico)
        guiSetProperty(SiguientePregunta, "NormalTextColour", "FFAAAAAA") 


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
addEventHandler( "onClientGUIClick", getRootElement(), function(b,s)
    if not (b == 'left' and s == 'up') then
        return
    end
    if source == BotonCerrar then
        guiSetVisible(PanelLicencias, false)
        showCursor(false)
    elseif source == BotonExamen then
        if not (LicenciaCursando == nil) then
            return outputChatBox("#9AA498[#FF7800Licencieros#9AA498] #A03535Estas cursando la licencia de #24C5BE"..LicenciaCursando..".", 255, 255, 255, true)
        end
        local NameLicencia = guiGridListGetItemText ( GridListLicencias, guiGridListGetSelectedItem ( GridListLicencias ), 1 )
        if not (#NameLicencia > 3) then
            return outputChatBox("#9AA498[#FF7800Licencieros#9AA498] #A03535Selecciona una Licencia", 255, 255, 255, true)
        end
        local varInfoClient = exports["MR1_Inicio"]:getValueOne(localPlayer)
        
        local inv = varInfoClient.Inventario
        if (inv.Licencias[NameLicencia] == 1) then
            return outputChatBox("#ffe100Ya tengo esta licencia...", 255, 255, 255, true) 
        end

        if not (varInfoClient.Inventario["Dinero"] >= PrecioLicencia) then
            return outputChatBox("#ffe100No tengo los "..formatNumber(PrecioLicencia).." dolares de la licencia...", 255, 255, 255, true) 
        end 

        LicenciaCursando = NameLicencia
        triggerServerEvent('Licencieros:Server:PagarExamenLicencia', getLocalPlayer(), PrecioLicencia, NameLicencia)
        
        Crear_Examen()
        guiSetVisible(PanelLicencias, false)
    elseif source == SiguientePregunta then
        --SUMAR RESULTADO
        if (guiRadioButtonGetSelected(Res1)) then
            varRespuesta = 2
        elseif (guiRadioButtonGetSelected(Res2)) then
            varRespuesta = 3
        elseif (guiRadioButtonGetSelected(Res3)) then
            varRespuesta = 4
        end
        if varRespuesta == Examen[index][5] then
            Resultado = Resultado +1
        end
        --SIGUIENTE PREGUNTA
        if (index >= 9) then
            index = index + 1;
            guiSetText(SiguientePregunta, "Finalizar Examen")
            guiSetText(Pregunta, index..". "..Examen[index][1])
            guiSetText(Res1, Examen[index][2])
            guiSetText(Res2, Examen[index][3])
            guiSetText(Res3, Examen[index][4])
            return
        else 
            index = index + 1;
            guiSetText(Pregunta, index..". "..Examen[index][1])
            guiSetText(Res1, Examen[index][2])
            guiSetText(Res2, Examen[index][3])
            guiSetText(Res3, Examen[index][4])
            return
        end

        -- CALCULAR RESULTADO
        if (Resultado <= 6) then
            outputChatBox("Resultado: "..Resultado.."/10 - SUSPENDISTE")
            LicenciaCursando = nil;
        else
            outputChatBox("#9AA498[#FF7800Licencieros#9AA498] #53B440Examen Teorico aprobado.", 255, 255, 255, true)
            setElementData(getLocalPlayer(), "Licencia", LicenciaCursando)
            outputChatBox("#9AA498[#FF7800Licencieros#9AA498] #53B440Sal afuera y agarra el vehiculo asignado para tu examen practico de "..LicenciaCursando..".", 255, 255, 255, true)
        end

        if (guiGetVisible(PanelTeorico)) then
            guiSetVisible(PanelTeorico, false)
        end
        if (isCursorShowing()) then
            showCursor(false)
        end

        Examen = {};
        index = 1;
        Resultado = 0;
    end
end)
function Crear_Examen()
    while ( #Examen < 10 ) do
        local i = math.random(#Preguntas)
        local check = true
        for _, value in ipairs(Examen) do
            if value[1] == Preguntas[i][1] then
                check = false
            end
        end 
        if check then
            table.insert(Examen, Preguntas[i])
        end
    end
    if not (guiGetVisible(PanelTeorico)) then
        guiSetVisible(PanelTeorico, true)
        guiSetText(Pregunta, index..". "..Examen[index][1])
        guiSetText(Res1, Examen[index][2])
        guiSetText(Res2, Examen[index][3])
        guiSetText(Res3, Examen[index][4])
        return 
    end
end
function Crear_Examen_Practico()
    if (indexLicencia == nil) or (indexLicencia == 0) then
        indexLicencia = 1;
        statusLicencia = true
    end

    if isElement(varCrear_Marker_Ruta) then
        destroyElement(varCrear_Marker_Ruta)
        destroyElement(varCrear_Blip_Ruta)
    end

    varCrear_Marker_Ruta = createMarker(RutaLicencia[indexLicencia]["x"], RutaLicencia[indexLicencia]["y"], RutaLicencia[indexLicencia]["z"], "checkpoint", 2, RutaLicencia[indexLicencia]["r"], RutaLicencia[indexLicencia]["g"], RutaLicencia[indexLicencia]["b"], 255)
    varCrear_Blip_Ruta = createBlipAttachedTo(varCrear_Marker_Ruta)
    addEventHandler("onClientMarkerHit", varCrear_Marker_Ruta, function(hitElement)
        if not (hitElement == localPlayer) then
            return
        end
        if not (getPedOccupiedVehicle(localPlayer)) then
            return
        end
        local vehicle = getPedOccupiedVehicle(localPlayer)
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(vehicle)
        if not (varDataVehicle) or not (varDataVehicle["Informacion"]["Licencia"]) or not (varDataVehicle["Informacion"]["Licencia"] == getElementData(localPlayer, "Licencia")) then
            return
        end

        if not (indexLicencia == 46) then
            if isElement(varCrear_Marker_Ruta) then
                destroyElement(varCrear_Marker_Ruta)
                destroyElement(varCrear_Blip_Ruta)
            end
            indexLicencia = indexLicencia + 1
            return Crear_Examen_Practico()
        end
        if isElement(varCrear_Marker_Ruta) then
            destroyElement(varCrear_Marker_Ruta)
            destroyElement(varCrear_Blip_Ruta)
        end
        indexLicencia = nil
        statusLicencia = "Finish"
        triggerServerEvent('Licencieros:Server:RespawnVeh', getRootElement(), getPedOccupiedVehicle(localPlayer), varDataVehicle["Informacion"].Matricula)
        local varDataClient = exports["MR1_Inicio"]:getValueOne(localPlayer)

        if not (varDataClient["Inventario"].Licencias[varDataVehicle["Informacion"].Licencia]) then
            triggerServerEvent('Licencieros:Server:setLicencia', getRootElement(), varDataVehicle["Informacion"].Licencia)
            outputChatBox("#ffe100He aprobado, ¡Yupi!...", 255, 255, 255, true) 
            indexLicencia = nil
            LicenciaCursando = nil
            setElementData(localPlayer, "Licencia", nil)
            return
        end
        setElementData(localPlayer, "Licencia", nil)
        outputChatBox("#ffe100Creo que ya tenia esta licencia...", 255, 255, 255, true) 
    end)
end
-- Funciones Principales
function Abrir_Lista_Licencias(Licencias)
    if not (guiGetVisible(PanelLicencias)) then
        showCursor(true)
        guiSetVisible(PanelLicencias, true)
        guiGridListClear(GridListLicencias)
    end
    for i, row in ipairs(Licencias) do
        fila = guiGridListAddRow(GridListLicencias)
        guiGridListSetItemText(GridListLicencias, fila, Licencia, row.Nombre, false, false)
    end
end
function elementStreamInOut()
    if getElementType(source) ~= "player" then
        if eventName:find("In") then
            if getElementType(source) == 'pickup' then
                local x,y,z = getElementPosition(source)
                for i, v in ipairs(PickUps) do
                    if getDistanceBetweenPoints3D(x,y,z, unpack(v)) <= 1 then
                        pickupsStreaming[source] = exports["MR1_Inicio"]:createText3D("#FFFFFF\n Presiona #24C5BEH #FFFFFFpara hacer el examen de conducir.", x, y, z+1, 2, "bankgothic", -1, false, false, true)
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
-- Eventos y Handlers
addEvent("Licencieros:Client:PanelLicencias:Abrir", true)
addEventHandler("Licencieros:Client:PanelLicencias:Abrir", getRootElement(), Abrir_Lista_Licencias)
addEvent("Licencieros:Server:Examen:Practico:Crear", true)
addEventHandler("Licencieros:Server:Examen:Practico:Crear", getRootElement(), Crear_Examen_Practico)
addEventHandler("onClientPlayerVehicleExit", localPlayer, function(Vehicle, Seat) 
    if (Seat ~= 0) then
        return
    end
    local varData_Vehicle = exports["MR1_Inicio"]:getValueOne(Vehicle)
    if not (varData_Vehicle) then
        return
    end
    if not (varData_Vehicle["Informacion"]["Tipo"] == "Licencieros") then
        return
    end

    if (indexLicencia == nil) then
        return
    end
    if not (indexLicencia >= 46) then
        if isTimer(timerSuspendLicencia) then
            killTimer(timerSuspendLicencia)
        end
        
        outputChatBox("#ffe100¡Debes subirte al vehículo en menos de #FF780015 segundos #ffe100o suspenderás!", 255, 255, 255, true)
        timerSuspendLicencia = setTimer(function()
            if isElement(Vehicle) then
                triggerServerEvent('Licencieros:Server:RespawnVeh', localPlayer, Vehicle, varData_Vehicle["Informacion"].Matricula)
            end
    
            if isElement(varCrear_Marker_Ruta) then
                destroyElement(varCrear_Marker_Ruta)
                destroyElement(varCrear_Blip_Ruta)
            end
    
            LicenciaCursando = nil
            indexLicencia = nil
            setElementData(localPlayer, "Licencia", nil)
            outputChatBox("#ffe100Creo que acabo de suspender...", 255, 255, 255, true)
        end, 15000, 1) -- 15 segundos
    end
end)
addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(Vehicle, Seat)
    if (Seat ~= 0) then
        return
    end

    local varData_Vehicle = exports["MR1_Inicio"]:getValueOne(Vehicle)
    if not (varData_Vehicle) then
        return
    end

    if not (varData_Vehicle["Informacion"]["Tipo"] == "Licencieros") then
        return
    end

    -- Si el jugador se sube al vehículo, se cancela el temporizador
    if isTimer(timerSuspendLicencia) then
        killTimer(timerSuspendLicencia)
        outputChatBox("#ffe100Has vuelto al vehículo a tiempo. Puedes continuar.", 255, 255, 255, true)
    end

end)

addEventHandler( "onClientElementStreamIn", getRootElement(), elementStreamInOut)
addEventHandler( "onClientElementStreamOut", getRootElement(), elementStreamInOut)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
