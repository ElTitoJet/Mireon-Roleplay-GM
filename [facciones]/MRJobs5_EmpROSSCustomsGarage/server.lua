-- MRJobs5_EmpDa_Silva
-- Script que gestiona el Mecanico Willowfield
-- Autor: ElTitoJet
-- Fecha: 30/10/2023

-- Variables Globales y Configuración
local varGruas = {
    -- Grua
    [1] = {525, 2095.75390625, -1939.64453125, 13.411264419556, 0, 0, 271.16485595703, "ROSS-01"},
}
local LSESConectados = 0

local varPickUpDuty = {2097.3583984375, -1920.5390625, 17.038471221924, 3, 1210, 0, 0}
local varPickUpVestuario = {2097, -1907, 17, 3, 1275, 0, 0}
local varColShapeTunning1 = {2124.6, -1940, 13}
local varColShapeTunning2 = {2115.7, -1940, 13}
local varColShapeTunning3 = {2107.5, -1940, 13}
local varColShapePintura = {2134.1, -1937, 13}

-- Funciones Auxiliares

-- Funciones Principales
    function vehicleExplodeDaSil()
        local infoVeh = exports["MR1_Inicio"]:getValueOne(source)
        if not (infoVeh and infoVeh.Personaje == "ROSS Custom Garage") then
            return
        end
        setTimer(function(source)
            destroyElement(source)
        end, 3000, 1, source)
        setTimer(function()
            for i, v in ipairs(varGruas) do
                if infoVeh.Informacion["Matricula"] == v[8] then
                    local VehGarajeROSS = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8])
                    setVehicleColor(VehGarajeROSS, 0,0,0, 0,0,0, 0,0,0, 0,0,0)
            
                    local Personaje = "ROSS Custom Garage";
                    local Informacion = {Modelo = v[1], Matricula = v[8]}
                    local Estado = {Salud = 1000, Destruido = false, Bloqueo = true, Motor = false}
                    
                    exports["MR1_Inicio"]:setValue(VehGarajeROSS, 'Personaje', Personaje)
                    exports["MR1_Inicio"]:setValue(VehGarajeROSS, 'Informacion', Informacion)
                    exports["MR1_Inicio"]:setValue(VehGarajeROSS, 'Estado', Estado)
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
        local ColSpherePintura = createColSphere(varColShapePintura[1], varColShapePintura[2], varColShapePintura[3], 3)
        for i, v in ipairs(varGruas) do
            VehGarajeROSS = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8])
            setVehicleColor(VehGarajeROSS, 0, 0, 0)
            local Personaje = "ROSS Custom Garage";
            local Informacion = {Modelo = v[1], Matricula = v[8]}
            local Estado = {Salud = 1000, Destruido = false, Bloqueo = true, Motor = false}
            
            exports["MR1_Inicio"]:setValue(VehGarajeROSS, 'Personaje', Personaje)
            exports["MR1_Inicio"]:setValue(VehGarajeROSS, 'Informacion', Informacion)
            exports["MR1_Inicio"]:setValue(VehGarajeROSS, 'Estado', Estado)
        end

        --DUTY
            addEventHandler("onPickupHit", PickUpDuty, function(player)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "ROSS Custom Garage") then return end
                bindKey(player, "H", "down", function()
                    unbindKey(player,"H")
                    if (Trabajos.OnDuty == false) or (Trabajos.OnDuty == nil) then
                        Trabajos.OnDuty = true
                        exports["MR1_Inicio"]:setValue(player, 'Trabajos', Trabajos)
                        exports["MRJobs1_Agencia"]:PointMecanico()
                        return outputChatBox("#9AA498[#353535ROSS#9AA498] #53B440Te has puesto de servicio.", player, 255, 255, 255, true) 
                    end
                    if (Trabajos.OnDuty == true) then
                        Trabajos.OnDuty = false
                        exports["MR1_Inicio"]:setValue(player, 'Trabajos', Trabajos)
                        exports["MRJobs1_Agencia"]:PointMecanico()
                        return outputChatBox("#9AA498[#353535ROSS#9AA498] #53B440Te has salido de servicio.", player, 255, 255, 255, true) 
                    end
                end)
            end)
            addEventHandler("onPickupLeave", PickUpDuty, function(player, m)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "ROSS Custom Garage") then return end
                unbindKey(player,"H")
            end)
        --VESTUARIO
            addEventHandler("onPickupHit", PickUpVestuario, function(player)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "ROSS Custom Garage") then return end
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
                if not (Trabajos.Trabajo == "ROSS Custom Garage") then return end
                unbindKey(player,"H")
            end)
        --REPARAR/TUNNING
            addEventHandler("onColShapeHit", ColSphereTunning1, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "ROSS Custom Garage") then return end
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
                if not (Trabajos.Trabajo == "ROSS Custom Garage") then return end
                unbindKey(player,"H")
            end)
            addEventHandler("onColShapeHit", ColSphereTunning2, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "ROSS Custom Garage") then return end
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
                if not (Trabajos.Trabajo == "ROSS Custom Garage") then return end
                unbindKey(player,"H")
            end)
            addEventHandler("onColShapeHit", ColSphereTunning3, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "ROSS Custom Garage") then return end
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
                if not (Trabajos.Trabajo == "ROSS Custom Garage") then return end
                unbindKey(player,"H")
            end)
        --PINTURA    
            addEventHandler("onColShapeHit", ColSpherePintura, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "ROSS Custom Garage") then return end
                if not (Trabajos.OnDuty == true) then 
                    return outputChatBox("#ffe100Deberia ponerme de servicio primero...", player, 255, 255, 255, true) 
                end
                bindKey(player, "H", "down", function(player)
                    --triggerClientEvent(player, "PannelLSC", player)
                    exports["MRJobs1_Agencia"]:FuncionPintura(player)
                    unbindKey(player,"H")
                end)
            end)
            addEventHandler("onColShapeLeave", ColSpherePintura, function(hitElement)
                if not (getElementType(hitElement) == "vehicle") then return end
                if not (getElementDimension(hitElement) == 0) then return end
                local player = getVehicleController(hitElement)
                Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                if not (Trabajos.Trabajo == "ROSS Custom Garage") then return end
                unbindKey(player,"H")
            end)
    end)

