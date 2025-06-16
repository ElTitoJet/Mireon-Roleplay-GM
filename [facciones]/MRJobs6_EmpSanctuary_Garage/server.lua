-- MRJobs5_EmpDa_Silva
-- Script que gestiona el Mecanico Willowfield
-- Autor: ElTitoJet
-- Fecha: 30/10/2023

-- Variables Globales y Configuración
local GruasSanct = {
    -- Grua
    [1] = {525, 1114.369140625, -1247.2783203125, 15.707184791565, 0, 0, 0.3956298828125, "Sanct-01"},
}
local LSESConectados = 0

local varPickUpDuty = {1109.1806640625, -1187.16015625, 22.858749389648, 3, 1210, 0, 0}
local varPickUpVestuario = {1108.1484375, -1181.4072265625, 22.858749389648, 3, 1275, 0, 0}
local varColShapeTunning1 = {1090.2685546875, -1238.58984375, 15.8203125}
local varColShapeTunning2 = {1090.2490234375, -1232.939453125, 15.8203125}
local varColShapeTunning3 = {1090.4013671875, -1227.4296875, 15.8203125}
local varColShapeTunning4 = {1107.81640625, -1228.0927734375, 15.8203125}
local varColShapePintura = {1091.2138671875, -1248.1044921875, 15.827150344849}

-- Funciones Auxiliares

-- Funciones Principales
function vehicleExplodeDaSil()
    local infoVeh = exports["MR1_Inicio"]:getValueOne(source)
    if not (infoVeh and infoVeh.Personaje == "Sanctuary Garage") then
        return
    end
    setTimer(function(source)
        destroyElement(source)
    end, 3000, 1, source)
    setTimer(function()
        for i, v in ipairs(GruasSanct) do
            if infoVeh.Informacion["Matricula"] == v[8] then
                local VehGarajeSanct = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8])
                setVehicleColor(VehGarajeSanct, 84,243,224, 21,21,21)
        
                local Personaje = "Sanctuary Garage";
                local Informacion = {Modelo = v[1], Matricula = v[8]}
                local Estado = {Salud = 1000, Destruido = false, Bloqueo = true, Motor = false}
                
                exports["MR1_Inicio"]:setValue(VehGarajeSanct, 'Personaje', Personaje)
                exports["MR1_Inicio"]:setValue(VehGarajeSanct, 'Informacion', Informacion)
                exports["MR1_Inicio"]:setValue(VehGarajeSanct, 'Estado', Estado)
            end
        end
    end, 5000, 1)
end

-- Eventos y Handlers
addEventHandler("onVehicleExplode", getRootElement(), vehicleExplodeDaSil)

-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
addEventHandler("onResourceStart", resourceRoot, function()
    local Blip = createBlip( varPickUpDuty[1], varPickUpDuty[2], varPickUpDuty[3], 27, 255, 0, 0, 0, 255, 0, 200)
    local PickUpDuty = createPickup(varPickUpDuty[1], varPickUpDuty[2], varPickUpDuty[3], varPickUpDuty[4], varPickUpDuty[5], varPickUpDuty[6], varPickUpDuty[7])
    local PickUpVestuario = createPickup(varPickUpVestuario[1], varPickUpVestuario[2], varPickUpVestuario[3], varPickUpVestuario[4], varPickUpVestuario[5], varPickUpVestuario[6], varPickUpVestuario[7])
    local ColSphereTunning1 = createColSphere(varColShapeTunning1[1], varColShapeTunning1[2], varColShapeTunning1[3], 3)
    local ColSphereTunning2 = createColSphere(varColShapeTunning2[1], varColShapeTunning2[2], varColShapeTunning2[3], 3)
    local ColSphereTunning3 = createColSphere(varColShapeTunning3[1], varColShapeTunning3[2], varColShapeTunning3[3], 3)
    local ColSphereTunning4 = createColSphere(varColShapeTunning4[1], varColShapeTunning4[2], varColShapeTunning4[3], 3)
    local ColSpherePintura = createColSphere(varColShapePintura[1], varColShapePintura[2], varColShapePintura[3], 3)
    
    --local PuertaExterior = createObject()
    local PuertaGarajeExterior = createObject(10150, 1112.1201171875, -1203.2353515625, 19.319999694824, 0, 180, 90)
    local colPuertaGarajeExterior = createColSphere(1112.1142578125, -1205.9833984375, 17.791347503662, 2)
    local colPuertaGarajeInterior = createColSphere(1112.2119140625, -1201.265625, 18.324750900269, 2)

    local PuertaPersonajeExterior = createObject(3089, 1107.099609375, -1203.2197265625, 18.5, 0, 0, 0)
    local colPersonajeExterior = createColSphere( 1107.8873291016, -1203.2126464844, 18.324863433838, 1)
    
    
    for i, v in ipairs(GruasSanct) do
        VehGarajeSanct = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8])
        setVehicleColor(VehGarajeSanct, 84,243,224, 21,21,21)
        local Personaje = "Sanctuary Garage";
        local Informacion = {Modelo = v[1], Matricula = v[8]}
        local Estado = {Salud = 1000, Destruido = false, Bloqueo = true, Motor = false}
        
        exports["MR1_Inicio"]:setValue(VehGarajeSanct, 'Personaje', Personaje)
        exports["MR1_Inicio"]:setValue(VehGarajeSanct, 'Informacion', Informacion)
        exports["MR1_Inicio"]:setValue(VehGarajeSanct, 'Estado', Estado)
    end

    --DUTY
        addEventHandler("onPickupHit", PickUpDuty, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            bindKey(player, "H", "down", function()
                unbindKey(player,"H")
                if (Trabajos.OnDuty == false) or (Trabajos.OnDuty == nil) then
                    Trabajos.OnDuty = true
                    exports["MR1_Inicio"]:setValue(player, 'Trabajos', Trabajos)
                    exports["MRJobs1_Agencia"]:PointMecanico()
                    return outputChatBox("#9AA498[#54F3E0Sanct#9AA498] #53B440Te has puesto de servico.", player, 255, 255, 255, true) 
                end
                if (Trabajos.OnDuty == true) then
                    Trabajos.OnDuty = false
                    exports["MR1_Inicio"]:setValue(player, 'Trabajos', Trabajos)
                    exports["MRJobs1_Agencia"]:PointMecanico()
                    return outputChatBox("#9AA498[#54F3E0Sanct#9AA498] #53B440Te has salido de servico.", player, 255, 255, 255, true) 
                end
            end)
        end)
        addEventHandler("onPickupLeave", PickUpDuty, function(player, m)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            unbindKey(player,"H")
        end)
    --VESTUARIO
        addEventHandler("onPickupHit", PickUpVestuario, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            bindKey(player, "H", "down", function()
                unbindKey(player,"H")
                if not (Trabajos.OnDuty == true) then 
                    return outputChatBox("#ffe100Deberia ponerme de servicio primero...", player, 255, 255, 255, true) 
                end
                Informacion = exports["MR1_Inicio"]:getValue(player, 'Informacion')
                Estado = exports["MR1_Inicio"]:getValue(player, 'Estado')
                if Informacion.Sexo == "Masculino" then
                    if not (getElementModel(player) == 50) then
                        return setElementModel(player, 50)
                    end
                    setElementModel(player, Estado.Skin)
                elseif Informacion.Sexo == "Femenino" then
                    if not (getElementModel(player) == 191) then
                        return setElementModel(player, 191)
                    end
                    setElementModel(player, Estado.Skin)
                end
            end)
        end)
        addEventHandler("onPickupLeave", PickUpDuty, function(player, m)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            unbindKey(player,"H")
        end)
    --REPARAR/TUNNING
        addEventHandler("onColShapeHit", ColSphereTunning1, function(hitElement)
            if not (getElementType(hitElement) == "vehicle") then return end
            if not (getElementDimension(hitElement) == 0) then return end
            local player = getVehicleController(hitElement)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            if not (Trabajos.OnDuty == true) then 
                return outputChatBox("#ffe100Deberia ponerme de servicio primero...", player, 255, 255, 255, true) 
            end
            bindKey(player, "H", "down", function(player)
                --triggerClientEvent(player, "PannelLSC", player)
                exports["MRJobs1_Agencia"]:FuncionMecanica(player)
                --unbindKey(player,"H")
            end)
        end)
        addEventHandler("onColShapeLeave", ColSphereTunning1, function(hitElement)
            if not (getElementType(hitElement) == "vehicle") then return end
            if not (getElementDimension(hitElement) == 0) then return end
            local player = getVehicleController(hitElement)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            unbindKey(player,"H")
        end)
        addEventHandler("onColShapeHit", ColSphereTunning2, function(hitElement)
            if not (getElementType(hitElement) == "vehicle") then return end
            if not (getElementDimension(hitElement) == 0) then return end
            local player = getVehicleController(hitElement)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            if not (Trabajos.OnDuty == true) then 
                return outputChatBox("#ffe100Deberia ponerme de servicio primero...", player, 255, 255, 255, true) 
            end
            bindKey(player, "H", "down", function(player)
                --triggerClientEvent(player, "PannelLSC", player)
                exports["MRJobs1_Agencia"]:FuncionMecanica(player)
                --unbindKey(player,"H")
            end)
        end)
        addEventHandler("onColShapeLeave", ColSphereTunning2, function(hitElement)
            if not (getElementType(hitElement) == "vehicle") then return end
            if not (getElementDimension(hitElement) == 0) then return end
            local player = getVehicleController(hitElement)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            unbindKey(player,"H")
        end)
        addEventHandler("onColShapeHit", ColSphereTunning3, function(hitElement)
            if not (getElementType(hitElement) == "vehicle") then return end
            if not (getElementDimension(hitElement) == 0) then return end
            local player = getVehicleController(hitElement)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            if not (Trabajos.OnDuty == true) then 
                return outputChatBox("#ffe100Deberia ponerme de servicio primero...", player, 255, 255, 255, true) 
            end
            bindKey(player, "H", "down", function(player)
                --triggerClientEvent(player, "PannelLSC", player)
                exports["MRJobs1_Agencia"]:FuncionMecanica(player)
                --unbindKey(player,"H")
            end)
        end)
        addEventHandler("onColShapeLeave", ColSphereTunning3, function(hitElement)
            if not (getElementType(hitElement) == "vehicle") then return end
            if not (getElementDimension(hitElement) == 0) then return end
            local player = getVehicleController(hitElement)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            unbindKey(player,"H")
        end)
        addEventHandler("onColShapeHit", ColSphereTunning4, function(hitElement)
            if not (getElementType(hitElement) == "vehicle") then return end
            if not (getElementDimension(hitElement) == 0) then return end
            local player = getVehicleController(hitElement)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo) or not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            if not (Trabajos.OnDuty == true) then 
                return outputChatBox("#ffe100Deberia ponerme de servicio primero...", player, 255, 255, 255, true) 
            end
            bindKey(player, "H", "down", function(player)
                --triggerClientEvent(player, "PannelLSC", player)
                exports["MRJobs1_Agencia"]:FuncionMecanica(player)
                --unbindKey(player,"H")
            end)
        end)
        addEventHandler("onColShapeLeave", ColSphereTunning4, function(hitElement)
            if not (getElementType(hitElement) == "vehicle") then return end
            if not (getElementDimension(hitElement) == 0) then return end
            local player = getVehicleController(hitElement)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            unbindKey(player,"H")
        end)
    --PINTURA    
        addEventHandler("onColShapeHit", ColSpherePintura, function(hitElement)
            if not (getElementType(hitElement) == "vehicle") then return end
            if not (getElementDimension(hitElement) == 0) then return end
            local player = getVehicleController(hitElement)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            if not (Trabajos.OnDuty == true) then 
                return outputChatBox("#ffe100Deberia ponerme de servicio primero...", player, 255, 255, 255, true) 
            end
            bindKey(player, "H", "down", function(player)
                --triggerClientEvent(player, "PannelLSC", player)
                exports["MRJobs1_Agencia"]:FuncionPintura(player)
                --unbindKey(player,"H")
            end)
        end)
        addEventHandler("onColShapeLeave", ColSpherePintura, function(hitElement)
            if not (getElementType(hitElement) == "vehicle") then return end
            if not (getElementDimension(hitElement) == 0) then return end
            local player = getVehicleController(hitElement)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            unbindKey(player,"H")
        end)
    --PUERTA GARAJE
        local movimientopuertaGarajeExterior = false
        local movimientoPersonajeExterior = false
        addEventHandler("onColShapeHit", colPuertaGarajeExterior, function(hitElement)
            
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            local Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if Trabajos.Trabajo == "Sanctuary Garage" then
                bindKey(element, "H", "down", function(element)
                    if not movimientopuertaGarajeExterior then
                        moveObject ( PuertaGarajeExterior, 1000, 1112.0999755859, -1201.9799804688, 22.799999237061, 0, 35, 0)
                        unbindKey(element, "H")
                        movimientopuertaGarajeExterior = true
                        setTimer(function()
                            moveObject(PuertaGarajeExterior, 1000, 1112.1201171875, -1203.2353515625, 19.319999694824, 0, -35, 0)
                            setTimer(function()
                                movimientopuertaGarajeExterior = false
                            end, 1000, 1)
                        end, 4000, 1)
                    end
                end)
            end
        end)
        addEventHandler("onColShapeLeave", colPuertaGarajeExterior, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            unbindKey(element,"H")
        end)
        addEventHandler("onColShapeHit", colPuertaGarajeInterior, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            local Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if Trabajos.Trabajo == "Sanctuary Garage" then
                bindKey(element, "H", "down", function(element)
                    
                    if not movimientopuertaGarajeExterior then
                        moveObject ( PuertaGarajeExterior, 1000, 1112.0999755859, -1201.9799804688, 22.799999237061, 0, 35, 0)
                        unbindKey(element, "H")
                        movimientopuertaGarajeExterior = true
                        
                        setTimer(function()
                            moveObject(PuertaGarajeExterior, 1000, 1112.1201171875, -1203.2353515625, 19.319999694824, 0, -35, 0)
                            setTimer(function()
                                movimientopuertaGarajeExterior = false
                            end, 1000, 1)
                        end, 4000, 1)
                    end
                end)
            end
        end)
        addEventHandler("onColShapeLeave", colPuertaGarajeInterior, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            unbindKey(element,"H")
        end)
        addEventHandler("onColShapeHit", colPersonajeExterior, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            local Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if Trabajos.Trabajo == "Sanctuary Garage" then
                bindKey(element, "H", "down", function(element)
                    if not movimientoPersonajeExterior then
                        moveObject ( PuertaPersonajeExterior, 1000, 1107.099609375, -1203.2197265625, 18.5, 0, 0, 140)
                        unbindKey(element, "H")
                        movimientoPersonajeExterior = true
                        
                        setTimer(function()
                            moveObject(PuertaPersonajeExterior, 1000, 1107.099609375, -1203.2197265625, 18.5, 0, 0, -140)
                            setTimer(function()
                                movimientoPersonajeExterior = false
                            end, 1000, 1)
                        end, 4000, 1)
                    end
                end)
            end
        end)
        addEventHandler("onColShapeLeave", colPersonajeExterior, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if not (Trabajos.Trabajo == "Sanctuary Garage") then return end
            unbindKey(element,"H")
        end)
end)
