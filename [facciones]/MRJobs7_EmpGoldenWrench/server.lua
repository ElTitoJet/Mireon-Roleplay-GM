-- MRJobs5_EmpDa_Silva
-- Script que gestiona el Mecanico Willowfield
-- Autor: ElTitoJet
-- Fecha: 30/10/2023

-- Variables Globales y Configuración
local GruasSanct = {
    -- Grua
    [1] = {525, 118.5986328125, -172.158203125, 1.46067070961, 0, 0, 89.714294433594, "Gold-01"},
    [2] = {525, 2314.25390625, -1464.328125, 23.557001113892, 0, 0, 270.28570556641, "Gold-02"},
}
local LSESConectados = 0

local varPickUpDuty = {119.4326171875, -198.3935546875, 1.8841308355331, 3, 1210, 0, 0}
local varPickUpDuty2 = {2315.42578125, -1408.1943359375, 29.754472732544, 3, 1210, 0, 0}
local varPickUpVestuario = {120.9814453125, -191.4033203125, 1.8841308355331, 3, 1275, 0, 0}
local varPickUpVestuario2 = {2307.576171875, -1410.04296875, 29.754472732544, 3, 1275, 0, 0}
local varColShapeTunning1 = {111, -190, 1}
local varColShapeTunning2 = {92, -189, 1}
local varColShapeTunning3 = {2298.7021484375, -1402.576171875, 23.975234985352}
local varColShapeTunning4 = {2307.8349609375, -1402.576171875, 23.975234985352}
local varColShapeTunning5 = {2314.4853515625, -1402.576171875, 23.975234985352}
local varColShapeTunning6 = {2327.451171875, -1399.060546875, 25.231163024902}
local varColShapePintura = {83.470703125, -189.86328125, 1.6195359230042}
local varColShapePintura2 = {2305.494140625, -1464.2646484375, 23.65195274353}

-- Funciones Auxiliares

-- Funciones Principales
function vehicleExplodeGold()
    local infoVeh = exports["MR1_Inicio"]:getValueOne(source)
    if not (infoVeh and infoVeh.Personaje == "GoldenWrench") then
        return
    end
    setTimer(function(source)
        destroyElement(source)
    end, 3000, 1, source)
    setTimer(function()
        for i, v in ipairs(GruasSanct) do
            if infoVeh.Informacion["Matricula"] == v[8] then
                local VehGarajeSanct = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8])
                setVehicleColor(VehGarajeSanct, 239,184,16, 0,0,0)
        
                local Personaje = "GoldenWrench";
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
addEventHandler("onVehicleExplode", getRootElement(), vehicleExplodeGold)

-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
addEventHandler("onResourceStart", resourceRoot, function()
    -- Taller 1
        local Blip = createBlip( varPickUpDuty[1], varPickUpDuty[2], varPickUpDuty[3], 27, 255, 0, 0, 0, 255, 0, 200)
        local PickUpDuty = createPickup(varPickUpDuty[1], varPickUpDuty[2], varPickUpDuty[3], varPickUpDuty[4], varPickUpDuty[5], varPickUpDuty[6], varPickUpDuty[7])
        local PickUpVestuario = createPickup(varPickUpVestuario[1], varPickUpVestuario[2], varPickUpVestuario[3], varPickUpVestuario[4], varPickUpVestuario[5], varPickUpVestuario[6], varPickUpVestuario[7])
        local ColSphereTunning1 = createColSphere(varColShapeTunning1[1], varColShapeTunning1[2], varColShapeTunning1[3], 3)
        local ColSphereTunning2 = createColSphere(varColShapeTunning2[1], varColShapeTunning2[2], varColShapeTunning2[3], 3)
        local ColSpherePintura = createColSphere(varColShapePintura[1], varColShapePintura[2], varColShapePintura[3], 3)
        
    -- TALLER 2
        local Blip2 = createBlip( varPickUpDuty2[1], varPickUpDuty2[2], varPickUpDuty2[3], 27, 255, 0, 0, 0, 255, 0, 200)
        local PickUpDuty2 = createPickup(varPickUpDuty2[1], varPickUpDuty2[2], varPickUpDuty2[3], varPickUpDuty2[4], varPickUpDuty2[5], varPickUpDuty2[6], varPickUpDuty2[7])
        local PickUpVestuario2 = createPickup(varPickUpVestuario2[1], varPickUpVestuario2[2], varPickUpVestuario2[3], varPickUpVestuario2[4], varPickUpVestuario2[5], varPickUpVestuario2[6], varPickUpVestuario2[7])

        local ColSphereTunning3 = createColSphere(varColShapeTunning3[1], varColShapeTunning3[2], varColShapeTunning3[3], 3)
        local ColSphereTunning4 = createColSphere(varColShapeTunning4[1], varColShapeTunning4[2], varColShapeTunning4[3], 3)
        local ColSphereTunning5 = createColSphere(varColShapeTunning5[1], varColShapeTunning5[2], varColShapeTunning5[3], 3)
        local ColSphereTunning6 = createColSphere(varColShapeTunning6[1], varColShapeTunning6[2], varColShapeTunning6[3], 3)
        local ColSpherePintura2 = createColSphere(varColShapePintura2[1], varColShapePintura2[2], varColShapePintura2[3], 3)
    
    -- GRUAS
        setTimer(function()
            for i, v in ipairs(GruasSanct) do
                VehGarajeSanct = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8])
                setVehicleColor(VehGarajeSanct, 239,184,16, 0,0,0)
                local Personaje = "GoldenWrench";
                local Informacion = {Modelo = v[1], Matricula = v[8]}
                local Estado = {Salud = 1000, Destruido = false, Bloqueo = true, Motor = false}
                
                exports["MR1_Inicio"]:setValue(VehGarajeSanct, 'Personaje', Personaje)
                exports["MR1_Inicio"]:setValue(VehGarajeSanct, 'Informacion', Informacion)
                exports["MR1_Inicio"]:setValue(VehGarajeSanct, 'Estado', Estado)
            end
        end, 3000, 1)
    
    
    


    -- DUTY
        addEventHandler("onPickupHit", PickUpDuty, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
            bindKey(player, "H", "down", function()
                unbindKey(player,"H")
                if (Trabajos.OnDuty == false) or (Trabajos.OnDuty == nil) then
                    Trabajos.OnDuty = true
                    exports["MR1_Inicio"]:setValue(player, 'Trabajos', Trabajos)
                    exports["MRJobs1_Agencia"]:PointMecanico()
                    return outputChatBox("#9AA498[#FF0000Golden#9AA498] #53B440Te has puesto de servico.", player, 255, 255, 255, true) 
                end
                if (Trabajos.OnDuty == true) then
                    Trabajos.OnDuty = false
                    exports["MR1_Inicio"]:setValue(player, 'Trabajos', Trabajos)
                    exports["MRJobs1_Agencia"]:PointMecanico()
                    return outputChatBox("#9AA498[#FF0000Golden#9AA498] #53B440Te has salido de servico.", player, 255, 255, 255, true) 
                end
            end)
        end)
        addEventHandler("onPickupLeave", PickUpDuty, function(player, m)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
            unbindKey(player,"H")
        end)
        addEventHandler("onPickupHit", PickUpDuty2, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
            bindKey(player, "H", "down", function()
                unbindKey(player,"H")
                if (Trabajos.OnDuty == false) or (Trabajos.OnDuty == nil) then
                    Trabajos.OnDuty = true
                    exports["MR1_Inicio"]:setValue(player, 'Trabajos', Trabajos)
                    exports["MRJobs1_Agencia"]:PointMecanico()
                    return outputChatBox("#9AA498[#FF0000Golden#9AA498] #53B440Te has puesto de servico.", player, 255, 255, 255, true) 
                end
                if (Trabajos.OnDuty == true) then
                    Trabajos.OnDuty = false
                    exports["MR1_Inicio"]:setValue(player, 'Trabajos', Trabajos)
                    exports["MRJobs1_Agencia"]:PointMecanico()
                    return outputChatBox("#9AA498[#FF0000Golden#9AA498] #53B440Te has salido de servico.", player, 255, 255, 255, true) 
                end
            end)
        end)
        addEventHandler("onPickupLeave", PickUpDuty2, function(player, m)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
            unbindKey(player,"H")
        end)
    -- VESTUARIO
        addEventHandler("onPickupHit", PickUpVestuario, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
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
        addEventHandler("onPickupLeave", PickUpVestuario, function(player, m)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
            unbindKey(player,"H")
        end)
        addEventHandler("onPickupHit", PickUpVestuario2, function(player)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
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
        addEventHandler("onPickupLeave", PickUpVestuario2, function(player, m)
            Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
            unbindKey(player,"H")
        end)
    --REPARAR/TUNNING
        -- TALLER1
            addEventHandler("onColShapeHit", ColSphereTunning1, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
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
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
                unbindKey(player,"H")
            end)
            addEventHandler("onColShapeHit", ColSphereTunning2, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
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
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
                unbindKey(player,"H")
            end)
        -- TALLER2 
            addEventHandler("onColShapeHit", ColSphereTunning3, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
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
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
                unbindKey(player,"H")
            end)
            addEventHandler("onColShapeHit", ColSphereTunning4, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
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
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
                unbindKey(player,"H")
            end)
            addEventHandler("onColShapeHit", ColSphereTunning5, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
                if not (Trabajos.OnDuty == true) then 
                    return outputChatBox("#ffe100Deberia ponerme de servicio primero...", player, 255, 255, 255, true) 
                end
                bindKey(player, "H", "down", function(player)
                    --triggerClientEvent(player, "PannelLSC", player)
                    exports["MRJobs1_Agencia"]:FuncionMecanica(player)
                    --unbindKey(player,"H")
                end)
            end)
            addEventHandler("onColShapeLeave", ColSphereTunning5, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
                unbindKey(player,"H")
            end)
            addEventHandler("onColShapeHit", ColSphereTunning6, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
                if not (Trabajos.OnDuty == true) then 
                    return outputChatBox("#ffe100Deberia ponerme de servicio primero...", player, 255, 255, 255, true) 
                end
                bindKey(player, "H", "down", function(player)
                    --triggerClientEvent(player, "PannelLSC", player)
                    exports["MRJobs1_Agencia"]:FuncionMecanica(player)
                    --unbindKey(player,"H")
                end)
            end)
            addEventHandler("onColShapeLeave", ColSphereTunning6, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
                unbindKey(player,"H")
            end)
    --PINTURA  
        -- TALLER 1
            addEventHandler("onColShapeHit", ColSpherePintura, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
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
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
                unbindKey(player,"H")
            end)
        -- TALLER 2
            addEventHandler("onColShapeHit", ColSpherePintura2, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
                if not (Trabajos.OnDuty == true) then 
                    return outputChatBox("#ffe100Deberia ponerme de servicio primero...", player, 255, 255, 255, true) 
                end
                bindKey(player, "H", "down", function(player)
                    --triggerClientEvent(player, "PannelLSC", player)
                    exports["MRJobs1_Agencia"]:FuncionPintura(player)
                    --unbindKey(player,"H")
                end)
            end)
            addEventHandler("onColShapeLeave", ColSpherePintura2, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "GoldenWrench") then return end
                unbindKey(player,"H")
            end)

    -- PUERTAS
        local Puerta1 = createObject(13188, 101, -169.619140625, 2.9000000953674, 0, 0, 0)
        local colPuerta1 = createColSphere(101, -169.619140625, 2.9000000953674, 5)
        addEventHandler("onColShapeHit", colPuerta1, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            local Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if Trabajos.Trabajo == "GoldenWrench" then
                bindKey(element, "H", "down", function(element)
                    moveObject ( Puerta1, 1000, 101, -169.619140625, 5.5, 0, 0, 0 )
                    unbindKey(element, "H")
                    
                    setTimer(function()
                        moveObject ( Puerta1, 1000, 101, -169.619140625, 2.9000000953674, 0, 0, 0 )
                    end, 4000, 1)
                end)
            end
        end)
        addEventHandler("onColShapeLeave", colPuerta1, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
            unbindKey(element,"H")
        end)
        local Puerta2 = createObject(13188, 101,-163.400390625, 2.9000000953674, 0, 0, 0)
        local colPuerta2 = createColSphere(101,-163.400390625, 2.9000000953674, 5)
        addEventHandler("onColShapeHit", colPuerta2, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            local Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if Trabajos.Trabajo == "GoldenWrench" then
                bindKey(element, "H", "down", function(element)
                    moveObject ( Puerta2, 1000, 101, -163.400390625, 5.5, 0, 0, 0 )
                    unbindKey(element, "H")
                    
                    setTimer(function()
                        moveObject ( Puerta2, 1000, 101,-163.400390625, 2.9000000953674, 0, 0, 0 )
                    end, 4000, 1)
                end)
            end
        end)
        addEventHandler("onColShapeLeave", colPuerta2, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
            unbindKey(element,"H")
        end)
        local Puerta3 = createObject(13188, 101, -157.400390625, 2.9000000953674, 0, 0, 0)
        local colPuerta3 = createColSphere(101, -157.400390625, 2.9000000953674, 5)
        addEventHandler("onColShapeHit", colPuerta3, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            local Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if Trabajos.Trabajo == "GoldenWrench" then
                bindKey(element, "H", "down", function(element)
                    moveObject ( Puerta3, 1000, 101, -157.400390625, 5.5, 0, 0, 0 )
                    unbindKey(element, "H")
                    
                    setTimer(function()
                        moveObject ( Puerta3, 1000, 101, -157.400390625, 2.9000000953674, 0, 0, 0 )
                    end, 4000, 1)
                end)
            end
        end)
        addEventHandler("onColShapeLeave", colPuerta3, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
            unbindKey(element,"H")
        end)
        local Puerta4 = createObject(13188, 101, -151.35546875, 2.9000000953674, 0, 0, 0)
        local colPuerta4 = createColSphere(101, -151.35546875, 2.9000000953674, 5)
        addEventHandler("onColShapeHit", colPuerta4, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            local Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if Trabajos.Trabajo == "GoldenWrench" then
                bindKey(element, "H", "down", function(element)
                    moveObject ( Puerta4, 1000, 101, -151.35546875, 5.5, 0, 0, 0 )
                    unbindKey(element, "H")
                    
                    setTimer(function()
                        moveObject ( Puerta4, 1000, 101, -151.35546875, 2.9000000953674, 0, 0, 0 )
                    end, 4000, 1)
                end)
            end
        end)
        addEventHandler("onColShapeLeave", colPuerta4, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
            unbindKey(element,"H")
        end)
        local Puerta5 = createObject(989, 122.900390625, -155.1904296875, 2.4000000953674, 0, 0, 16.792602539062)
        local Puerta6 = createObject(989, 122.900390625, -149.7001953125, 2.4000000953674, 0, 0, 16.792602539062)

        local colPuerta6 = createColSphere(122.5009765625, -152.509765625, 1.578125, 7)
        addEventHandler("onColShapeHit", colPuerta6, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            local Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if Trabajos.Trabajo == "GoldenWrench" then
                bindKey(element, "H", "down", function(element)
                    iprint(1)
                    moveObject ( Puerta5, 1000, 122.900390625, -159.99899291992, 2.4000000953674, 0, 0, 0 )
                    moveObject ( Puerta6, 1000, 122.900390625, -144.74000549316, 2.4000000953674, 0, 0, 0 )
                    unbindKey(element, "H")
                    
                    setTimer(function()
                        moveObject ( Puerta5, 1000, 122.900390625, -155.1904296875, 2.4000000953674, 0, 0, 0 )
                        moveObject ( Puerta6, 1000, 122.900390625, -149.7001953125, 2.4000000953674, 0, 0, 0 )
                    end, 4000, 1)
                end)
            end
        end)
        addEventHandler("onColShapeLeave", colPuerta6, function(hitElement)
            local element = nil;
            if (getElementType(hitElement) == "player") then
                element = hitElement 
            elseif (getElementType(hitElement) == "vehicle") then
                element = getVehicleController(hitElement)
                if (element == false) then return end
            end
            Trabajos = exports["MR1_Inicio"]:getValue(element, 'Trabajos')
            if not (Trabajos.Trabajo == "GoldenWrench") then return end
            unbindKey(element,"H")
        end)
end)

