-- MRJobs3_FaccLSES
-- Script que gestiona las funciones de la faccion de medicos del servidor.
-- Autor: ElTitoJet
-- Fecha: 30/10/2023

-- Variables Globales y Configuración
local VehsGarajeLSES = {
    -- AMBULANCIAS
    [1] = {416, -1720.17285, 999.9, 17.73468, 0, 0, 90, "RA-001"},
    [2] = {416, -1720.17285, 1003.9, 17.73468, 0, 0, 90, "RA-002"},
    [3] = {416, -1720.17285, 1007.9, 17.73468, 0, 0, 90, "RA-003"},
    [4] = {416, -1720.17285, 1011.9, 17.73468, 0, 0, 90, "RA-004"},
    [5] = {416, -1720.17285, 1024.3, 17.73468, 0, 0, 90, "RA-005"},
    [6] = {416, -1720.17285, 1028.3, 17.73468, 0, 0, 90, "RA-006"},
    [7] = {416, -1720.17285, 1032.3, 17.73468, 0, 0, 90, "RA-007"},
    [8] = {416, -1720.17285, 1036.3, 17.73468, 0, 0, 90, "RA-008"},
    -- UNIDADES SUPERVISORAS
    [9] = {422, -1736.17285, 1007.9, 17.73468, 0, 0, -90, "VTM-009"},
    [10] = {422, -1736.17285, 1011.9, 17.73468, 0, 0, -90, "VTM-010"},
    [11] = {422, -1736.17285, 1015.9, 17.73468, 0, 0, -90, "VTM-011"},
    [12] = {422, -1736.17285, 1019.9, 17.73468, 0, 0, -90, "VTM-012"},
    -- HELICOPTEROS
    [13] = {497, 1160.8212890625, -1300.9033203125, 31.674663543701, 0, 0, 270, "AIR-01"},
    [14] = {497, 1160.755859375, -1317.390625, 31.672132492065, 0, 0, 270, "AIR-02"},
}
local controlTable = { "fire", "aim_weapon", "next_weapon", "previous_weapon", "forwards", "backwards", "left", "right", "zoom_in", "zoom_out",
    "change_camera", "jump", "sprint", "look_behind", "crouch", "action", "walk", "conversation_yes", "conversation_no",
    "group_control_forwards", "group_control_back", "enter_exit", "vehicle_fire", "vehicle_secondary_fire", "vehicle_left", "vehicle_right",
    "steer_forward", "steer_back", "accelerate", "brake_reverse", "radio_next", "radio_previous", "radio_user_track_skip", "horn", "sub_mission",
    "handbrake", "vehicle_look_left", "vehicle_look_right", "vehicle_look_behind", "vehicle_mouse_look", "special_control_left", "special_control_right",
    "special_control_down", "special_control_up" 
}
local LSESConectados = 0

local varPickUpEmergencias = {1172.490234375, -1321.486328125, 15.398905754089, 3, 1240, 0, 0}
local varPickUpDuty = {1870.2041015625, -1740.7197265625, 1111.3000488281, 3, 1210, 0, 0}
local varPickUpVestuario = {1838.447265625, -1743.48828125, 1112.3000488281, 3, 1275, 0, 0}
local varPickUpEnterGaraje = {1177.7314453125, -1339.19921875, 13.919888496399, 3, 1318, 0, 0}
local varPickUpExitGaraje = {-1743, 988, 18, 3, 1318, 0, 0}
local varPickUpGarajeEdificio = {-1716.845703125, 1018.1806640625, 17.5859375, 3, 1318, 0, 0}
local varPickUpEdificioGaraje = {1811.521484375, -1733.265625, 1112.3000488281, 3, 1318, 0, 0}
local varPickUpTejadoEdificio = {1161.7158203125, -1329.677734375, 31.493850708008, 3, 1318, 0, 0}
local varPickUpEdificioTejado = {1820.4970703125, -1732.150390625, 1112.3000488281, 3, 1318, 0, 0}


-- Funciones Auxiliares
function PlayerDead(source)
    local Estado = exports["MR1_Inicio"]:getValue(source, 'Estado')
    if Estado.Muerto == true then
        return true
    else
        return false
    end
end
function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end
function checkAllDuty()
    LSESConectados = 0
    for _, Jugador in ipairs(getElementsByType("player")) do
        local Trabajos = exports["MR1_Inicio"]:getValue(Jugador, 'Trabajos')
        if Trabajos ~= nil then 
            if Trabajos["Trabajo"] == "Los Santos Emergency Services" then
                if Trabajos["OnDuty"] == true then
                    LSESConectados = LSESConectados+1;
                end
            end
        end
    end
    return true
end

-- Funciones Principales
function vehicleExplodeLSES()
    local infoVeh = exports["MR1_Inicio"]:getValueOne(source)
    if not (infoVeh and infoVeh.Personaje == "Los Santos Emergency Services") then
        return
    end
    setTimer(function(source)
        destroyElement(source)
    end, 3000, 1, source)
    setTimer(function()
        for i, v in ipairs(VehsGarajeLSES) do
            if infoVeh.Informacion["Matricula"] == v[8] then
                local VehGarajeLSES = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8])
                setElementDimension(VehGarajeLSES, 1)
                setVehicleColor(VehGarajeLSES, 159,16,16, 159,16,16, 159,16,16, 159,16,16)
        
                local Personaje = "Los Santos Emergency Services";
                local Informacion = {Modelo = v[1], Matricula = v[8]}
                local Estado = {Salud = 1000, Destruido = false, Bloqueo = true, Motor = false}
                
                exports["MR1_Inicio"]:setValue(VehGarajeLSES, 'Personaje', Personaje)
                exports["MR1_Inicio"]:setValue(VehGarajeLSES, 'Informacion', Informacion)
                exports["MR1_Inicio"]:setValue(VehGarajeLSES, 'Estado', Estado)
            end
        end
    end, 60000, 1)
end

function Reanimar(p, commandname, objetive)
    local Trabajos = exports["MR1_Inicio"]:getValue(p, 'Trabajos')
    if not (Trabajos.Trabajo == "Los Santos Emergency Services") then return end
    if not (objetive) then 
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/reanimar [Usuario]", p, 0, 0, 0, true) 
    end
    if (objetive == getPlayerName(p)) then
        return outputChatBox("#ffe100Aun siento mi corazon latir, no necesito una RCP...", p, 255, 255, 255, true) 
    end
    local objetivo = getPlayerFromName(objetive)
    if not (objetivo) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/reanimar [Usuario]", p, 0, 0, 0, true) 
    end
    local posX1, posY1, posZ1 = getElementPosition(p) -- Obtenemos la posicion del sujeto que esta ejecutando el comando.
    local posX2, posY2, posZ2 = getElementPosition(objetivo) -- Obtenemos la posicion del objetivo.
    if not (getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) <= 2) then
        return outputChatBox("#ffe100Tengo que acercarme mas...", p, 255, 255, 255, true) 
    end
    local Estado = exports["MR1_Inicio"]:getValue(objetivo, 'Estado')
    if not (Estado.Muerto == true) then
        return outputChatBox("#ffe100No necesita una RCP...", p, 255, 255, 255, true) 
    end
    local xRevive, yRevive, zRevive = getElementPosition(objetivo)
    local intRevive = getElementInterior(objetivo)
    local dimRevive = getElementDimension(objetivo)
    local SkinActual = getElementModel(objetivo)
    
    outputChatBox("#9AA498[#a03535LSES#9AA498] #53B440Reanimando a #24C5BE"..objetive, p, 255, 255, 255, true) -- STAFF
    outputChatBox("#9AA498[#a03535LSES#9AA498] #FF7800"..getPlayerName(p).." #53B440te esta reanimando.", objetivo, 255, 255, 255, true) -- USER
    setTimer(function()
        local revivePlayer = spawnPlayer(objetivo, xRevive, yRevive, zRevive, 0, SkinActual, 0, 0)
        local reviveDim = setElementInterior(objetivo, intRevive)
        local reviveInt = setElementDimension(objetivo, dimRevive)
        if revivePlayer then
            for i, v in ipairs(controlTable) do
                toggleControl(objetivo, v, true)
            end
            if isEventHandlerAdded("onClientRender", objetivo) then
                removeEventHandler("onClientRender", objetivo)
            end
            Estado.Muerto = false
            local Estado = exports["MR1_Inicio"]:setValue(objetivo, 'Estado', Estado)
            local Resucitar = exports["MR3_Muertes"]:resucitar(objetivo)

            outputChatBox("#9AA498[#a03535LSES#9AA498] #53B440Has reanimado a #24C5BE"..objetive, p, 255, 255, 255, true) -- STAFF
            outputChatBox("#9AA498[#a03535LSES#9AA498] #FF7800"..getPlayerName(p).." #53B440te ha reanimado.", objetivo, 255, 255, 255, true) -- USER
        end
    end, 5000, 1)

end
function CurarLSES(p, commandname, objetive)
    local Trabajos = exports["MR1_Inicio"]:getValue(p, 'Trabajos')
    if not (Trabajos.Trabajo == "Los Santos Emergency Services") then return end
    if not (Trabajos.OnDuty == true) then
        return outputChatBox("#ffe100No tengo los materiales necesarios aqui...", p, 255, 255, 255, true) 
    end
    if not (objetive) then 
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/atender [Usuario]", p, 0, 0, 0, true) 
    end
    if (objetive == getPlayerName(p)) then
        return outputChatBox("#ffe100Mejor voy con un compañero...", p, 255, 255, 255, true) 
    end
    local objetivo = getPlayerFromName(objetive)
    if not (objetivo) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/atender [Usuario]", p, 0, 0, 0, true) 
    end
    local posX1, posY1, posZ1 = getElementPosition(p) -- Obtenemos la posicion del sujeto que esta ejecutando el comando.
    local posX2, posY2, posZ2 = getElementPosition(objetivo) -- Obtenemos la posicion del objetivo.
    if not (getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) <= 2) then
        return outputChatBox("#ffe100Tengo que acercarme mas...", p, 255, 255, 255, true) 
    end
    if (getElementHealth(objetivo) == 100) then
        return outputChatBox("#ffe100Lo veo muy sano, no creo que necesite atencion medica...", p, 255, 255, 255, true) 
    end
    setElementHealth(objetivo, 100)
    outputChatBox("#9AA498[#a03535LSES#9AA498] #53B440Has curado a #24C5BE"..objetive, p, 255, 255, 255, true) -- STAFF
    outputChatBox("#9AA498[#a03535LSES#9AA498] #FF7800"..getPlayerName(p).." #53B440te ha curado.", objetivo, 255, 255, 255, true) -- USER
end

-- Eventos y Handlers
addEventHandler("onVehicleExplode", getRootElement(), vehicleExplodeLSES)

addCommandHandler("reanimar", Reanimar)
addCommandHandler("atender", CurarLSES)

-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
addEventHandler("onResourceStart", resourceRoot, function()
    local PickUpEmergencias = createPickup(varPickUpEmergencias[1], varPickUpEmergencias[2], varPickUpEmergencias[3], varPickUpEmergencias[4], varPickUpEmergencias[5], varPickUpEmergencias[6], varPickUpEmergencias[7])
    local PickUpDuty = createPickup(varPickUpDuty[1], varPickUpDuty[2], varPickUpDuty[3], varPickUpDuty[4], varPickUpDuty[5], varPickUpDuty[6], varPickUpDuty[7])
    local IntPickUpDuty = setElementInterior(PickUpDuty, 9)
    local PickUpVestuario = createPickup(varPickUpVestuario[1], varPickUpVestuario[2], varPickUpVestuario[3], varPickUpVestuario[4], varPickUpVestuario[5], varPickUpVestuario[6], varPickUpVestuario[7])
    local IntPickUpVestuario = setElementInterior(PickUpVestuario, 9)
    local PickUpEnterGaraje = createPickup(varPickUpEnterGaraje[1], varPickUpEnterGaraje[2], varPickUpEnterGaraje[3], varPickUpEnterGaraje[4], varPickUpEnterGaraje[5], varPickUpEnterGaraje[6], varPickUpEnterGaraje[7])
    local PickUpExitGaraje = createPickup(varPickUpExitGaraje[1], varPickUpExitGaraje[2], varPickUpExitGaraje[3], varPickUpExitGaraje[4], varPickUpExitGaraje[5], varPickUpExitGaraje[6], varPickUpExitGaraje[7])
    setElementDimension(PickUpExitGaraje, 1)
    local PickUpGarajeEdificio = createPickup(varPickUpGarajeEdificio[1], varPickUpGarajeEdificio[2], varPickUpGarajeEdificio[3], varPickUpGarajeEdificio[4], varPickUpGarajeEdificio[5], varPickUpGarajeEdificio[6], varPickUpGarajeEdificio[7])
    setElementDimension(PickUpGarajeEdificio, 1)
    local PickUpEdificioGaraje = createPickup(varPickUpEdificioGaraje[1], varPickUpEdificioGaraje[2], varPickUpEdificioGaraje[3], varPickUpEdificioGaraje[4], varPickUpEdificioGaraje[5], varPickUpEdificioGaraje[6], varPickUpEdificioGaraje[7])
    setElementInterior(PickUpEdificioGaraje, 9)
    local PickUpTejadoEdificio = createPickup(varPickUpTejadoEdificio[1], varPickUpTejadoEdificio[2], varPickUpTejadoEdificio[3], varPickUpTejadoEdificio[4], varPickUpTejadoEdificio[5], varPickUpTejadoEdificio[6], varPickUpTejadoEdificio[7])
    local PickUpEdificioTejado = createPickup(varPickUpEdificioTejado[1], varPickUpEdificioTejado[2], varPickUpEdificioTejado[3], varPickUpEdificioTejado[4], varPickUpEdificioTejado[5], varPickUpEdificioTejado[6], varPickUpEdificioTejado[7])
    setElementInterior(PickUpEdificioTejado, 9)

    setTimer(function()
        for i, v in ipairs(VehsGarajeLSES) do
            VehGarajeLSES = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8])
            setElementDimension(VehGarajeLSES, 1)
            if v[1] == 497 then
                setElementDimension(VehGarajeLSES, 0)
            end
            setVehicleColor(VehGarajeLSES, 159,16,16, 255,255,255, 159,16,16, 159,16,16)
            local Personaje = "Los Santos Emergency Services";
            local Informacion = {Modelo = v[1], Matricula = v[8]}
            local Estado = {Salud = 1000, Destruido = false, Bloqueo = true, Motor = false}
            
            exports["MR1_Inicio"]:setValue(VehGarajeLSES, 'Personaje', Personaje)
            exports["MR1_Inicio"]:setValue(VehGarajeLSES, 'Informacion', Informacion)
            exports["MR1_Inicio"]:setValue(VehGarajeLSES, 'Estado', Estado)
        end
    end, 10000, 1)

    --EMERGENCIAS
        addEventHandler("onPickupHit", PickUpEmergencias, function(player)
            if not (getElementType(player) == "player") then return end
            bindKey(player, "H", "down", function(player, m)
                unbindKey(player,"H")

                if isPedInVehicle(player) then
                    return outputChatBox("#ffe100No es buena idea meter el vehiculo aqui...", player, 255, 255, 255, true) 
                end
                local checkOnDuty = checkAllDuty()
                if (checkOnDuty) then
                    --if not (LSESConectados > 0) then 
                        outputChatBox("#ffe100Me siento mucho mejor de salud...", player, 255, 255, 255, true) 
                        setElementHealth(player, 100)
                        return  
                    --end
                    --return outputChatBox("#ffe100La sala de emergencias esta llena, mejor llamo un medico...", player, 255, 255, 255, true) 
                end
            end)
        end)
        addEventHandler("onPickupLeave", PickUpEmergencias, function(player, m)
            unbindKey(player,"H")
        end)
    --DUTY
        addEventHandler("onPickupHit", PickUpDuty, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Los Santos Emergency Services") then return end
            bindKey(player, "H", "down", function()
                unbindKey(player,"H")
                if (Trabajos.OnDuty == false) or (Trabajos.OnDuty == nil) then
                    Trabajos.OnDuty = true
                    exports["MR1_Inicio"]:setValue(player, 'Trabajos', Trabajos)
                    return outputChatBox("#9AA498[#FF7800LSES#9AA498] #53B440Te has puesto de servico.", player, 255, 255, 255, true) 
                end
                if (Trabajos.OnDuty == true) then
                    Trabajos.OnDuty = false
                    exports["MR1_Inicio"]:setValue(player, 'Trabajos', Trabajos)
                    return outputChatBox("#9AA498[#FF7800LSES#9AA498] #53B440Te has salido de servico.", player, 255, 255, 255, true) 
                end
            end)
        end)
        addEventHandler("onPickupLeave", PickUpDuty, function(player, m)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Los Santos Emergency Services") then return end
            unbindKey(player,"H")
        end)
    --VESTUARIO
        addEventHandler("onPickupHit", PickUpVestuario, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Los Santos Emergency Services") then return end
            bindKey(player, "H", "down", function()
                unbindKey(player,"H")
                if not (Trabajos.OnDuty == true) then 
                    return outputChatBox("#ffe100Deberia ponerme de servicio primero...", player, 255, 255, 255, true) 
                end
                Informacion = exports["MR1_Inicio"]:getValue(player, 'Informacion')
                Estado = exports["MR1_Inicio"]:getValue(player, 'Estado')
                if Informacion.Sexo == "Masculino" then
                    if not (getElementModel(player) == 276) then
                        return setElementModel(player, 276)
                    end
                    setElementModel(player, Estado.Skin)
                elseif Informacion.Sexo == "Femenino" then
                    if not (getElementModel(player) == 275) then
                        return setElementModel(player, 275)
                    end
                    setElementModel(player, Estado.Skin)
                end
            end)
        end)
        addEventHandler("onPickupLeave", PickUpDuty, function(player, m)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Los Santos Emergency Services") then return end
            unbindKey(player,"H")
        end)
    --ENTRADA GARAJE
        addEventHandler("onPickupHit", PickUpEnterGaraje, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Los Santos Emergency Services") then return end
            if not (getElementType(player) == "player") then return end
            bindKey(player, "H", "down", function(player, m)
                unbindKey(player,"H")
                if not (isPedInVehicle(player)) then
                    setElementPosition(player, -1743.0869140625, 982.162109375, 17.660655975342)
                    setElementRotation(player, 0, 0, 269.49450683594)
                    setElementDimension(player, 1)
                    return
                end
                local veh = getPedOccupiedVehicle(player)
                setElementPosition(veh, -1743.0869140625, 982.162109375, 17.660655975342)
                setElementRotation(veh, 0, 0, 269.49450683594)
                setElementDimension(veh, 1)
            end)
        end)
        addEventHandler("onPickupLeave", PickUpEnterGaraje, function(player, m)
            unbindKey(player,"H")
        end)
    --SALIDA GARAJE
        addEventHandler("onPickupHit", PickUpExitGaraje, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Los Santos Emergency Services") then return end
            if not (getElementType(player) == "player") then return end
            bindKey(player, "H", "down", function(player, m)
                unbindKey(player,"H")
                if not (isPedInVehicle(player)) then
                    setElementPosition(player, 1178.16796875, -1308.7783203125, 13.994688034058)
                    setElementRotation(player, 0, 0, 269.05493164062)
                    setElementDimension(player, 0)
                    return
                end
                local veh = getPedOccupiedVehicle(player)
                setElementPosition(veh, 1178.16796875, -1308.7783203125, 13.994688034058)
                setElementRotation(veh, 0, 0, 269.05493164062)
                setElementDimension(veh, 0)
            end)
        end)
        addEventHandler("onPickupLeave", PickUpExitGaraje, function(player, m)
            unbindKey(player,"H")
        end)
    --ENTRADA GARAJE EDIFICIO
        addEventHandler("onPickupHit", PickUpGarajeEdificio, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Los Santos Emergency Services") then return end
            if not (getElementType(player) == "player") then return end
            bindKey(player, "H", "down", function(player, m)
                unbindKey(player,"H")
                setElementPosition(player, varPickUpEdificioGaraje[1], varPickUpEdificioGaraje[2], varPickUpEdificioGaraje[3])
                setElementRotation(player, 0, 0, 270.61660766602)
                setElementDimension(player, 0)
                setElementInterior(player, 9)
            end)
        end)
        addEventHandler("onPickupLeave", PickUpGarajeEdificio, function(player, m)
            unbindKey(player,"H")
        end)
    --SALIDA EDIFICIO GARAJE
        addEventHandler("onPickupHit", PickUpEdificioGaraje, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Los Santos Emergency Services") then return end
            if not (getElementType(player) == "player") then return end
            bindKey(player, "H", "down", function(player, m)
                unbindKey(player,"H")
                setElementPosition(player, varPickUpGarajeEdificio[1], varPickUpGarajeEdificio[2], varPickUpGarajeEdificio[3])
                setElementRotation(player, 0, 0, 90.61660766602)
                setElementDimension(player, 1)
                setElementInterior(player, 0)
            end)
        end)
        addEventHandler("onPickupLeave", PickUpEdificioGaraje, function(player, m)
            unbindKey(player,"H")
        end)
    --ENTRADA Tejado EDIFICIO
        addEventHandler("onPickupHit", PickUpTejadoEdificio, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Los Santos Emergency Services") then return end
            if not (getElementType(player) == "player") then return end
            bindKey(player, "H", "down", function(player, m)
                unbindKey(player,"H")
                setElementPosition(player, varPickUpEdificioTejado[1], varPickUpEdificioTejado[2], varPickUpEdificioTejado[3])
                setElementRotation(player, 0, 0, 181)
                setElementDimension(player, 0)
                setElementInterior(player, 9)
            end)
        end)
        addEventHandler("onPickupLeave", PickUpTejadoEdificio, function(player, m)
            unbindKey(player,"H")
        end)
    --SALIDA EDIFICIO Tejado
        addEventHandler("onPickupHit", PickUpEdificioTejado, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Los Santos Emergency Services") then return end
            if not (getElementType(player) == "player") then return end
            bindKey(player, "H", "down", function(player, m)
                unbindKey(player,"H")
                setElementRotation(player, 0, 0, 358)
                setElementDimension(player, 0)
                setElementInterior(player, 0)
                setElementPosition(player, varPickUpTejadoEdificio[1], varPickUpTejadoEdificio[2], varPickUpTejadoEdificio[3])
            end)
        end)
        addEventHandler("onPickupLeave", PickUpEdificioTejado, function(player, m)
            unbindKey(player,"H")
        end)
end)