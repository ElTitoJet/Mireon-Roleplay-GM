
local nombreScript = "MRP10_Trabajos"

local VehsGarajeLSPD = {
    [1] = {497, 1565, -1703, 28, 0, 0, 90, "AIR-01"},
    [2] = {497, 1566, -1648, 28, 0, 0, 90, "AIR-02"},
    [3] = {598, 1601.8857421875, -1683.9794921875, 6, 0, 0, 90, "CHAR-01"},
    [4] = {598, 1601.8857421875, -1687.9794921875, 6, 0, 0, 90, "CHAR-02"},
    [5] = {598, 1601.8857421875, -1691.9794921875, 6, 0, 0, 90, "CHAR-03"},
    [6] = {598, 1601.8857421875, -1695.9794921875, 6, 0, 0, 90, "CHAR-04"},
    [7] = {598, 1601.8857421875, -1699.9794921875, 6, 0, 0, 90, "CHAR-05"},
    [8] = {598, 1601.8857421875, -1703.9794921875, 6, 0, 0, 90, "CHAR-06"},
    [9] = {525, 1585.7285156250, -1667.4892578125, 6.5, 0, 0, 269, "JOHN-01"},
    [10] = {525, 1585.7285156250, -1671.4892578125, 6.5, 0, 0, 269, "JOHN-02"},
    [11] = {596, 1595.5, -1710, 6, 0, 0, 0, "ADAM-01"},
    [12] = {596, 1591.5, -1710, 6, 0, 0, 0, "ADAM-02"},
    [13] = {596, 1587.5, -1710, 6, 0, 0, 0, "ADAM-03"},
    [14] = {596, 1583.5, -1710, 6, 0, 0, 0, "ADAM-04"},
    [15] = {596, 1578.5, -1710, 6, 0, 0, 0, "ADAM-05"},
    [16] = {596, 1574.5, -1710, 6, 0, 0, 0, "ADAM-06"},
    [17] = {596, 1570.5, -1710, 6, 0, 0, 0, "ADAM-07"},
    [18] = {596, 1558.9, -1710, 6, 0, 0, 0, "ADAM-08"},
    [19] = {523, 1566.431640625, -1711.337890625, 5.4605770111084, 0, 0, 360, "MARY-01"},
    [20] = {523, 1564.431640625, -1711.337890625, 5.4605770111084, 0, 0, 360, "MARY-02"},
    [21] = {523, 1562.431640625, -1711.337890625, 5.4605770111084, 0, 0, 360, "MARY-03"},
    [22] = {523, 1566.431640625, -1708.337890625, 5.4605770111084, 0, 0, 360, "MARY-04"},
    [23] = {523, 1564.431640625, -1708.337890625, 5.4605770111084, 0, 0, 360, "MARY-05"},
    [24] = {523, 1562.431640625, -1708.337890625, 5.4605770111084, 0, 0, 360, "MARY-06"},
    [25] = {427, 1526.6025390625, -1645.1826171875, 6.0224657058716, 0, 0, 179, "FORCE-01"},
    [26] = {427, 1530.6025390625, -1645.1826171875, 6.0224657058716, 0, 0, 179, "FORCE-02"},
    [27] = {490, 1534.6025390625, -1645.1826171875, 6.0224657058716, 0, 0, 179, "FBI-01"},
    [28] = {490, 1538.6025390625, -1645.1826171875, 6.0224657058716, 0, 0, 179, "FBI-02"},
    [29] = {528, 1529.2929687500, -1687.9423828125, 5.5703291893005, 0, 0, 270, "S.W.A.T-01"},
    [30] = {528, 1529.2929687500, -1683.9423828125, 5.5703291893005, 0, 0, 270, "S.W.A.T-02"},
    [31] = {601, 1529.7978515625, -1677.775390625, 5.90076732635, 0, 0, 270, "RESCUE-01"},
    [32] = {599, 1544.82421875, -1684.4517578125, 6.0785984992981, 0, 0, 90, "RANGER-01"},
    [33] = {599, 1544.82421875, -1680.3517578125, 6.0785984992981, 0, 0, 90, "RANGER-02"},
    [34] = {599, 1544.82421875, -1676.3517578125, 6.0785984992981, 0, 0, 90, "RANGER-03"},
    [35] = {560, 1544.82421875, -1671.9517578125, 6.0785984992981, 0, 0, 90, "LAB-0025"},
    [36] = {560, 1544.82421875, -1667.9517578125, 6.0785984992981, 0, 0, 90, "LAB-0045"},
    [37] = {560, 1544.82421875, -1663.3517578125, 6.0785984992981, 0, 0, 90, "LAB-0050"},
    [38] = {596, 1544.82421875, -1659.3517578125, 6.0785984992981, 0, 0, 90, "ADAM-09"},
    [39] = {596, 1544.82421875, -1655.3517578125, 6.0785984992981, 0, 0, 90, "ADAM-10"},
    [40] = {596, 1544.82421875, -1651.3517578125, 6.0785984992981, 0, 0, 90, "ADAM-11"},
    --riot agua
}

local CosteLicencia = 10000
local cooldowns = {}
controles = {"fire", "aim_weapon", "next_weapon", "previous_weapon", "zoom_in", "zoom_out", "action", "vehicle_fire", "vehicle_secondary_fire", "vehicle_left", "vehicle_right", "steer_forward", "steer_back", "radio_next", "radio_previous", "radio_user_track_skip", "horn", "handbrake"}

local Tassers = {}
local cooldowns = {}
--[[
    SCRIPT START
]]

-- METODOS
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

function Start(resource)
    exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS MultasIC (ID INT NOT NULL UNIQUE AUTO_INCREMENT, IDPersonaje INT NOT NULL, IDLSPD INT NOT NULL, PRECIO INT NOT NULL, MOTIVO VARCHAR(255) NOT NULL, PRIMARY KEY(ID));")

    -- Stats
        setModelHandling(598, "numberOfGears", 5 )
        setModelHandling(598, "maxVelocity", 190 ) --240
        setModelHandling(598, "engineAcceleration", 11.4) --12
        setModelHandling(598, "engineInertia", 5 )
        setModelHandling(598, "driveType", "rwd" ) --awd
        setModelHandling(598, "engineType", "petrol" )
        setModelHandling(598, "steeringLock", 30 ) --30
        setModelHandling(598, "collisionDamageMultiplier", 0.5 )

        setModelHandling(598, "mass", 1800 )
        setModelHandling(598, "turnMass", 4000 )
        setModelHandling(598, "dragCoeff", 1.44 )
        setModelHandling(598, "centerOfMass", {0, 0, -0.1} )
        setModelHandling(598, "percentSubmerged", 85 )
        setModelHandling(598, "animGroup", 0 )
        setModelHandling(598, "seatOffsetDistance", 0.25 )

        setModelHandling(598, "tractionMultiplier",  0.7) --0.69999998807907
        setModelHandling(598, "tractionLoss", 0.9 )
        setModelHandling(598, "tractionBias", 0.47 ) --0.5
        setModelHandling(598, "brakeDeceleration", 11 )
        setModelHandling(598, "brakeBias", 0.45 )
        setModelHandling(598, "suspensionForceLevel", 1 )
        setModelHandling(598, "suspensionDamping", 0.12 )
        setModelHandling(598, "suspensionHighSpeedDamping", 0 )
        setModelHandling(598, "suspensionUpperLimit", 0.24 )
        setModelHandling(598, "suspensionLowerLimit", -0.15 )
        setModelHandling(598, "suspensionAntiDiveMultiplier", 0.4 )
        setModelHandling(598, "suspensionFrontRearBias", 0.5 )

        setWeaponProperty("combat shotgun", "pro", "weapon_range", 45.0)
        setWeaponProperty("combat shotgun", "pro", "maximum_clip_ammo", 200)
        setWeaponProperty("combat shotgun", "pro", "damage", 1)

        setWeaponProperty("combat shotgun", "std", "weapon_range", 45.0)
        setWeaponProperty("combat shotgun", "std", "maximum_clip_ammo", 200)
        setWeaponProperty("combat shotgun", "std", "damage", 1)

        setWeaponProperty("combat shotgun", "poor", "weapon_range", 45.0)
        setWeaponProperty("combat shotgun", "poor", "maximum_clip_ammo", 200)
        setWeaponProperty("combat shotgun", "poor", "damage", 1)
    -- Vehiculos
        setTimer(function()
            for i, v in ipairs(VehsGarajeLSPD) do
                local VehGarajeLSPD = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8])
                
                local Personaje = "Los Santos Police Departament";
                local Informacion = {Modelo = v[1], Matricula = v[8]}
                local Estado = {Salud = 1000, Destruido = false, Bloqueo = true, Motor = false}
                
                exports["MR1_Inicio"]:setValue(VehGarajeLSPD, 'Personaje', Personaje)
                exports["MR1_Inicio"]:setValue(VehGarajeLSPD, 'Informacion', Informacion)
                exports["MR1_Inicio"]:setValue(VehGarajeLSPD, 'Estado', Estado)
                
                if (v[8] == "CHAR-01") then
                    setVehicleColor(VehGarajeLSPD, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255 )
                elseif (v[8] == "CHAR-02") then
                    setVehicleColor(VehGarajeLSPD, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255 )
                elseif (v[8] == "CHAR-03") then
                    setVehicleColor(VehGarajeLSPD, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255 )
                elseif (v[8] == "CHAR-04") then
                    setVehicleColor(VehGarajeLSPD, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255 )
                elseif (v[8] == "CHAR-05") then
                    setVehicleColor(VehGarajeLSPD, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
                elseif (v[8] == "CHAR-06") then
                    setVehicleColor(VehGarajeLSPD, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
                end
                --setVehicleColor(VehGarajeLSPD, math.random(0, 255), math.random(0, 255), math.random(0, 255), 255, 255, 255, 255, 255, 255, 255, 255, 255 )
                local Inventario = {}
                for i = 1, 10 do
                    Inventario["Slot " .. i] = { ["Objeto"] = "Ninguno", ["Cantidad"] = 0 }
                end
                
                exports["MR1_Inicio"]:setValue(VehGarajeLSPD, 'Inventario', Inventario)
            end
        end, 10000, 1)
    StartPD()
    local PickUpGarajeEntradaComisaria = createPickup(1568.5458984375, -1690.9716796875, 5.890625, 3, 1318, 0, 0)
	addEventHandler("onPickupHit", PickUpGarajeEntradaComisaria, function(source)
        local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
        if Trabajos.Trabajo == "Los Santos Police Departament" then
            bindKey(source, "H", "down", function(source, m)
                setElementInterior(source, 6)
                setElementDimension(source, 0)
                setElementPosition(source, 242.8427734375, 66.3857421875, 1003.640625)
                unbindKey(source,"H")
            end)
        end
	end)
    addEventHandler("onPickupLeave", PickUpGarajeEntradaComisaria, function(source, m)
        unbindKey(source,"H")
    end)

    local PickUpGarajeSalidaComisaria = createPickup(242.8427734375, 66.3857421875, 1003.640625, 3, 1318, 0, 0)
    local DimPickUpGarajeSalidaComisaria = setElementDimension(PickUpGarajeSalidaComisaria, 0)
    local IntPickUpGarajeSalidaComisaria = setElementInterior(PickUpGarajeSalidaComisaria, 6)
    addEventHandler("onPickupHit", PickUpGarajeSalidaComisaria, function(source)
        local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
        if Trabajos.Trabajo == "Los Santos Police Departament" then
            bindKey(source, "H", "down", function(source, m)
                setElementInterior(source, 0)
                setElementDimension(source, 0)
                setElementPosition(source, 1568.5458984375, -1690.9716796875, 5.890625)
                unbindKey(source,"H")
            end)
        end
    end)
    addEventHandler("onPickupLeave", PickUpGarajeSalidaComisaria, function(source, m)
        unbindKey(source,"H")
    end)

    local PickUpHelipuertoEntradaComisaria = createPickup(1565.044921875, -1684.5419921875, 28.395587921143, 3, 1318, 0, 0)
	addEventHandler("onPickupHit", PickUpHelipuertoEntradaComisaria, function(source)
        local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
        if Trabajos.Trabajo == "Los Santos Police Departament" then
            bindKey(source, "H", "down", function(source, m)
                setElementInterior(source, 6)
                setElementDimension(source, 0)
                setElementPosition(source, 246.4248046875, 87.6640625, 1003.640625)
                unbindKey(source,"H")
            end)
        end
	end)
    addEventHandler("onPickupLeave", PickUpHelipuertoEntradaComisaria, function(source, m)
        unbindKey(source,"H")
    end)

    local PickUpHelipuertoSalidaComisaria = createPickup(246.4248046875, 87.6640625, 1003.640625, 3, 1318, 0, 0)
    local DimPickUpHelipuertoSalidaComisaria = setElementDimension(PickUpHelipuertoSalidaComisaria, 0)
    local IntPickUpHelipuertoSalidaComisaria = setElementInterior(PickUpHelipuertoSalidaComisaria, 6)
    addEventHandler("onPickupHit", PickUpHelipuertoSalidaComisaria, function(source)

        local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
        if Trabajos.Trabajo == "Los Santos Police Departament" then
            bindKey(source, "H", "down", function(source, m)

                setElementInterior(source, 0)
                setElementDimension(source, 0)
                setElementPosition(source, 1565.044921875, -1684.5419921875, 28.395587921143)
                unbindKey(source,"H")
            end)
        end
    end)
    addEventHandler("onPickupLeave", PickUpHelipuertoSalidaComisaria, function(source, m)
        unbindKey(source,"H")
    end)

    local PuertaLSPD1 = createObject(3089, 245.8, 72.57, 1003.8, 0, 0, 0)
    local IntPuertaLSPD1 = setElementInterior(PuertaLSPD1, 6)
    local colisionPuertaLSPD1 = createColSphere(246.5, 72.57, 1002.6, 1.5)
    addEventHandler("onColShapeHit", colisionPuertaLSPD1, function(source)

        local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
        
        if Trabajos.Trabajo == "Los Santos Police Departament" then
            bindKey(source, "H", "down", function(source)
                moveObject ( PuertaLSPD1, 1000, 244, 72.6, 1003.8, 0, 0, 0 )
                unbindKey(source, "H")
                
                setTimer(function()
                    moveObject ( PuertaLSPD1, 1000, 245.8, 72.57, 1003.8, 0, 0, 0 )
                end, 4000, 1)
                
            end)
        end

    end)

    local PuertaLSPD2 = createObject(3089, 245.8, 72.6, 1003.8, 0, 0, 180)
    local IntPuertaLSPD2 = setElementInterior(PuertaLSPD2, 6)

    --BARRERA EXTERIOR
    local PuertaLSPD3 = createObject(980, 1539.5, -1628.5, 15.3, 0, 0, 90)
    local colisionPuertaLSPD3 = createColSphere(1539.5, -1628.5, 10, 10)
    addEventHandler("onColShapeHit", colisionPuertaLSPD3, function(hitElement)

        if getElementType(hitElement) == "vehicle" then
            local vehicleDriver = getVehicleController(hitElement)

            local Trabajos = exports["MR1_Inicio"]:getValue(vehicleDriver, 'Trabajos')
            if Trabajos.Trabajo == "Los Santos Police Departament" then
                bindKey(vehicleDriver, "H", "down", function(vehicleDriver)
                    moveObject ( PuertaLSPD3, 1000, 1539.5, -1617.1, 15.3, 0, 0, 0 )
                    unbindKey(vehicleDriver, "H")
                    
                    
                    setTimer(function()
                        moveObject ( PuertaLSPD3, 1000, 1539.5, -1628.5, 15.3, 0, 0, 0 )
                    end, 4000, 1)
                    
                end)
            end
        elseif getElementType(hitElement) == "player" then

            local Trabajos = exports["MR1_Inicio"]:getValue(hitElement, 'Trabajos')
            if Trabajos.Trabajo == "Los Santos Police Departament" then
                bindKey(hitElement, "H", "down", function(vehicleDriver)
                    moveObject ( PuertaLSPD3, 1000, 1539.5, -1617.1, 15.3, 0, 0, 0 )
                    unbindKey(hitElement, "H")
                    
                    
                    setTimer(function()
                        moveObject ( PuertaLSPD3, 1000, 1539.5, -1628.5, 15.3, 0, 0, 0 )
                    end, 4000, 1)
                    
                end)
            end
        end


    end)
    --PUERTA GARAJE
    local PuertaLSPD4 = createObject(3037, 1589.4004, -1638.3, 14.6, 0, 0, 90)
    local colisionPuertaLSPD4 = createColSphere(1589.4004, -1638.3, 10, 10)
    addEventHandler("onColShapeHit", colisionPuertaLSPD4, function(hitElement)

        if getElementType(hitElement) == "vehicle" then
            
            local vehicleDriver = getVehicleController(hitElement)

            local Trabajos = exports["MR1_Inicio"]:getValue(vehicleDriver, 'Trabajos')
            if Trabajos.Trabajo == "Los Santos Police Departament" then

                bindKey(vehicleDriver, "H", "down", function(vehicleDriver)
                    moveObject ( PuertaLSPD4, 1000, 1589.4004, -1638.0996, 20.6, 0, 0, 0 )
                    unbindKey(vehicleDriver, "H")
                    
                    
                    setTimer(function()
                        moveObject ( PuertaLSPD4, 1000, 1589.4004, -1638.3, 14.6, 0, 0, 0 )
                    end, 4000, 1)
                    
                end)
            end
        
        elseif getElementType(hitElement) == "player" then

            local Trabajos = exports["MR1_Inicio"]:getValue(hitElement, 'Trabajos')
            if Trabajos.Trabajo == "Los Santos Police Departament" then
                bindKey(hitElement, "H", "down", function(vehicleDriver)
                    moveObject ( PuertaLSPD4, 1000, 1598.4004, -1638.3, 14.6, 0, 0, 0 )
                    unbindKey(hitElement, "H")
                    
                    
                    setTimer(function()
                        moveObject ( PuertaLSPD4, 1000, 1589.4004, -1638.3, 14.6, 0, 0, 0 )
                    end, 4000, 1)
                    
                end)
            end
        end


    end)

    --PickUp BasuraPD
    local PickUpBasuraPD = createPickup(261.6337890625, 71.0888671875, 1003.2421875, 3, 1247, 0, 0)
    setElementInterior(PickUpBasuraPD, 6)
    addEventHandler("onPickupHit", PickUpBasuraPD, function(source)

        local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
        if Trabajos.Trabajo == "Los Santos Police Departament" then
            bindKey(source, "H", "down", function(source, m)
                exports["weapon_system"]:takeAll(source)
                unbindKey(source,"H")
            end)
        end
    end)
    addEventHandler("onPickupLeave", PickUpBasuraPD, function(source, m)
        unbindKey(source,"H")
    end)
end
addEventHandler("onResourceStart", resourceRoot, Start)

function isOnCooldown(player, command, cooldownTime)
    if not cooldowns[player] then
        cooldowns[player] = {}
    end

    local lastUsed = cooldowns[player][command] or 0
    local currentTime = getTickCount()

    if currentTime - lastUsed < cooldownTime then
        return true -- El jugador está en cooldown
    else
        cooldowns[player][command] = currentTime
        return false -- El jugador no está en cooldown
    end
end
function StartPD()
    --Vestuario
        local PickUpVestuario = createPickup(258.2626953125, 78.451171875, 1003.640625, 3, 1275, 0, 0)
        local IntPickUpVestuario = setElementInterior(PickUpVestuario, 6)
        addEventHandler("onPickupHit", PickUpVestuario, function(source)

            local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
            
            if Trabajos.Trabajo == "Los Santos Police Departament" then

                bindKey(source, "H", "down", function(source, m)
                    
                    Informacion = exports["MR1_Inicio"]:getValue(source, 'Informacion')
                    if Informacion.Sexo == "Masculino" then
                        if getElementModel(source) == 280 then
                            Estado = exports["MR1_Inicio"]:getValue(source, 'Estado')
                            setElementModel(source, Estado.Skin)
                            unbindKey(source,"H")

                        else
                            setElementModel(source, 280)
                            unbindKey(source,"H")
                        end
                    elseif Informacion.Sexo == "Femenino" then
                        if getElementModel(source) == 281 then
                            Estado = exports["MR1_Inicio"]:getValue(source, 'Estado')
                            setElementModel(source, Estado.Skin)
                            unbindKey(source,"H")

                        else
                            setElementModel(source, 281)
                            unbindKey(source,"H")
                        end
                    end
                end)
            end
        end)
        addEventHandler("onPickupLeave", PickUpVestuario, function(source, m)
            local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
            if Trabajos.Trabajo == "Los Santos Police Departament" then
                unbindKey(source,"H")
            end
        end)

    --Armeria
        local PickUpArmeria = createPickup(224, 76, 1005, 3, 1242, 0, 0)
        local IntPickUpArmeria = setElementInterior(PickUpArmeria, 6)
        addEventHandler("onPickupHit", PickUpArmeria, function(source)
            local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
            if Trabajos.Trabajo == "Los Santos Police Departament" then
                if Trabajos.OnDuty == true then
                    bindKey(source, "H", "down", function(source)
                        triggerClientEvent(source, "PanelArmeriaLSPD", source)
                        unbindKey(source,"H")
                    end)
                end
            end
        end)
        addEventHandler("onPickupLeave", PickUpArmeria, function(source, m)
            local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
            if Trabajos.Trabajo == "Los Santos Police Departament" then
                unbindKey(source, "H")
            end
        end)
    -- DuttyLSPD
        local pickupOnDutyLSPD = createPickup( 253.583984375, 77.0927734375, 1003.640625, 3, 1210, 0, 0)
        local IntPickUpOnDutyLSPD = setElementInterior(pickupOnDutyLSPD, 6)
        addEventHandler("onPickupHit", pickupOnDutyLSPD, function(source)
            local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
            
            if Trabajos.Trabajo == "Los Santos Police Departament" then

                bindKey(source, "H", "down", function(source, m)
                    
                    if Trabajos.OnDuty == false or Trabajos.OnDuty == nil then

                        Trabajos.OnDuty = true
                        exports["MR1_Inicio"]:setValue(source, 'Trabajos', Trabajos)
                        outputChatBox("#9AA498[#FF7800LSPD#9AA498] #53B440Te has puesto de servicio.", source, 255, 255, 255, true) 

                        Tassers[getPlayerName(source)] = {}
                        
                        setPedStat(source, 69, 40) -- 9mm
                        setPedStat(source, 70, 500) -- Taser
                        setPedStat(source, 71, 200) -- DK
                        setPedStat(source, 72, 200) -- Escopeta
                        setPedStat(source, 73, 200) -- Escopeta de combate
                        setPedStat(source, 74, 200) -- Recortada
                        setPedStat(source, 75, 50) -- Uzi
                        setPedStat(source, 76, 250) -- MP5
                        setPedStat(source, 77, 200) -- AK
                        setPedStat(source, 78, 200) -- M4
                        setPedStat(source, 79, 300) -- Sniper

                    elseif Trabajos.OnDuty == true then

                        Trabajos.OnDuty = false
                        exports["MR1_Inicio"]:setValue(source, 'Trabajos', Trabajos)
                        outputChatBox("#9AA498[#FF7800LSPD#9AA498] #53B440Te has salido de servico.", source, 255, 255, 255, true) 
                            
                        Tassers[getPlayerName(source)] = {}
                        Tassers[getPlayerName(source)][1] = false
                        Tassers[getPlayerName(source)][2] = nil
                        Tassers[getPlayerName(source)][3] = nil

                    end

                end)

            end
        end)
        addEventHandler("onPickupLeave", pickupOnDutyLSPD, function(source, m)
            triggerClientEvent(source, "CloseGUIArmeria", source)
            unbindKey(source,"H")
        end)
    -- Panel Comi
        local pickupPanelInfoCommi = createPickup( 249.5, 67.5, 1003.5, 3, 1239, 0, 0)
        local IntPickUpPanelInfoCommi = setElementInterior(pickupPanelInfoCommi, 6)
        addEventHandler("onPickupHit", pickupPanelInfoCommi, function(source)
            bindKey(source, "H", "down", function(source, m)
                triggerClientEvent(source, "Panel::LSPD::Comisaria::Informacion::Abrir", source)
                unbindKey(source,"H")
            end)
        end)
        addEventHandler("onPickupLeave", pickupPanelInfoCommi, function(source, m)
            unbindKey(source,"H")
        end)
end

function PlayerDead(source)
    
    local Estado = exports["MR1_Inicio"]:getValue(source, 'Estado')
    if Estado.Muerto == true then
        return true
    else
        return false
    end
end
--[[
function RadioFaccionariaLSPD(source, command, ...)
    if PlayerDead(source) then
        cancelEvent()
    else
        local message = table.concat({...}, " ")
        if #message >= 2 then
            if not exports["MR12_Moderacion"]:isPlayerJailed(source) then --Carcel OOC
                if not exports["MRJobs2_FaccLSPD"]:isPlayerJailedIC(source) then --Carcel IC
                    local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
                    if Trabajos.Trabajo == "Los Santos Police Departament" then
                        local togrf = exports["MR1_Inicio"]:getValue(source, 'togrf')
                        if togrf == nil or togrf == false then


                            local RankName = exports["MR1_Inicio"]:query('SELECT Nombre FROM TrabajosRangos WHERE Trabajo=? AND Rango=?', Trabajos.Trabajo, Trabajos.Rango)
                            for _, player in ipairs(getElementsByType("player")) do -- Obtenemos una lista de TODOS los jugadores
                                local Trabajos2 = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
                                if Trabajos2 and Trabajos2.Trabajo == "Los Santos Police Departament" then
                                    outputChatBox("#9AA498[#3556CCLSPD-Radio#9AA498] #9AA498[#3556CC"..RankName[1].Nombre.."#9AA498] #24C5BE"..getPlayerName(source).." dice:#FFFFFF "..message, player, 255,255,255, true)
                                end
                            end
                        else
                            outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Tienes la radio Faccionaria apagada. Usa /togrf para activarla.", source, 255, 255, 255, true) 
                            return false
                        end
                    end
                end
            end
        else
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/rf [Mensaje]", source, 255, 255, 255, true)
            return false
        end
    end
end
addCommandHandler("rf", RadioFaccionariaLSPD)
]]
function WeaponLSPD(weapon, ammo)

    local cooldownTime = 0 -- 300000 milisegundos = 5 minutos
    if isOnCooldown(client, weapon, cooldownTime) then
        outputChatBox("Debes esperar antes de volver a usar este comando.", client)
        return
    end
    
    exports["weapon_system"]:give(client, weapon, ammo, true)
    exports["MR15_Discord"]:sendDiscordArmasStaff("Dar", client, ammo, weapon, "MRJobs2_FaccLSPD(Armeria)")
end
addEvent("WeaponLSPD", true)
addEventHandler("WeaponLSPD", getRootElement(), WeaponLSPD)

function ChalecoLSPD(weapon, ammo)
    setPedArmor(client, 100)
end
addEvent("ChalecoLSPD", true)
addEventHandler("ChalecoLSPD", getRootElement(), ChalecoLSPD)

addCommandHandler("taser", function(p, command)
    local pd = getPlayerName(p)
    local Trabajos = exports["MR1_Inicio"]:getValue(p, 'Trabajos')

    -- Comprobar si es policía y está de servicio
    if Trabajos.Trabajo == "Los Santos Police Departament" and Trabajos.OnDuty == true then
        -- Inicializar la tabla si no existe
        if not Tassers[pd] or Tassers[pd][1] == false then
            Tassers[pd] = {}
            Tassers[pd][1] = true

            -- Obtener todas las armas del jugador
            local playerWeapons = exports["weapon_system"]:getAllFromPed(p)
            local hasWeapon = false -- Controla si se encontró un arma válida

            for i, weapon in ipairs(playerWeapons) do
                -- Si es una 9mm o Desert Eagle, almacenarla y dar el taser
                if (weapon.id == 22) or (weapon.id == 24) then
                    local fullammo = weapon.ammo + weapon.clip
                    Tassers[pd][2] = weapon.id
                    Tassers[pd][3] = fullammo
                    exports["weapon_system"]:give(p, 23, 5, true) -- Dar taser
                    exports["MR15_Discord"]:sendDiscordArmasStaff("Dar", p, 5, 23, "MRJobs2_FaccLSPD(taser)")
                    hasWeapon = true
                    break
                end
            end

            -- Si no tenía pistola, dar el taser igual
            if not hasWeapon then
                exports["weapon_system"]:give(p, 23, 5, true)
                exports["MR15_Discord"]:sendDiscordArmasStaff("Dar", p, 5, 23, "MRJobs2_FaccLSPD(taser)")
            end
        else
            -- Si ya tiene taser, devolver el arma anterior
            if Tassers[pd][2] ~= nil then
                exports["weapon_system"]:take(p, 23) -- Quitar taser
                exports["MR15_Discord"]:sendDiscordArmasStaff("Quitar", p, 0, 23, "MRJobs2_FaccLSPD(taser)")

                -- Devolver el arma original (guardada previamente)
                exports["weapon_system"]:give(p, Tassers[pd][2], Tassers[pd][3], true) -- Devolver arma con munición
                exports["MR15_Discord"]:sendDiscordArmasStaff("Dar", p, Tassers[pd][3], Tassers[pd][2], "MRJobs2_FaccLSPD(taser)")

                -- Limpiar datos de la tabla
                Tassers[pd][1] = false
                Tassers[pd][2] = nil
                Tassers[pd][3] = nil
            else
                -- Si no había un arma guardada, solo quitar el taser
                exports["weapon_system"]:take(p, 23)
                exports["MR15_Discord"]:sendDiscordArmasStaff("Quitar", p, 0, 23, "MRJobs2_FaccLSPD(taser)")
                Tassers[pd][1] = false
            end
        end
    end
end)



function Esposas(source, command, objetive)
    local funcion = "esposar"
    local pd = getPlayerName(source)
    local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
    if Trabajos.Trabajo == "Los Santos Police Departament" then
        if Trabajos.OnDuty == true then

            if not (objetive) then
                return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario]", source, 0, 0, 0, true)
            end

            objetivo = nil;
            if tonumber(objetive) then
                objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
            elseif (isElement(getPlayerFromName(objetive))) then
                objetivo = getPlayerFromName(objetive)
            else
                return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
            end
            if not (isElement(objetivo)) then
                return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
            end
        
            local posX1, posY1, posZ1= getElementPosition(source) -- Obtenemos la posicion del sujeto que esta ejecutando el comando.
            local posX2, posY2, posZ2 = getElementPosition(objetivo) -- Obtenemos la posicion del objetivo.
            if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) < 2 then -- Comprobamos si la distancia del que habla y los jugadores es menor o igual a VozNormal
                if objetive ~= getPlayerName(source) then
                    local Estado = exports["MR1_Inicio"]:getValue(objetivo, 'Estado')
                    if Estado.Esposado == nil or Estado.Esposado == false then
                        
                        for i, v in ipairs(controles) do
                            toggleControl(objetivo, v, false)
                            --(v)
                        end
                        --FUNCION DE ESPOSAR
                        outputChatBox("#9AA498[#0058ffLSPD#9AA498] #53B440Has esposado a #24C5BE"..getPlayerName(objetivo), source, 255, 255, 255, true) -- STAFF
                        outputChatBox("#9AA498[#0058ffLSPD#9AA498] #FF7800"..pd.." #53B440te ha esposado.", objetivo, 255, 255, 255, true) -- USER
                        Estado.Esposado = true
                        local newEstado = exports["MR1_Inicio"]:setValue(objetivo, 'Estado', Estado)
                    else
                            for i, v in ipairs(controles) do
                                toggleControl(objetivo, v, true)
                            end
                        --FUNCION DE des ESPOSAR
                        outputChatBox("#9AA498[#0058ffLSPD#9AA498] #53B440Has retirado las esposas a #24C5BE"..getPlayerName(objetivo), source, 255, 255, 255, true) -- STAFF
                        outputChatBox("#9AA498[#0058ffLSPD#9AA498] #FF7800"..pd.." #53B440te ha quitado las esposas.", objetivo, 255, 255, 255, true) -- USER
                        Estado.Esposado = false
                        local newEstado = exports["MR1_Inicio"]:setValue(objetivo, 'Estado', Estado)
                    end
                end
            end
        end
    end
end
addCommandHandler("esposar", Esposas)

addEventHandler ("onPlayerWeaponFire", root, function (weapon, endX, endY, endZ, hitElement, startX, startY, startZ)
    if weapon == 0 then
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        --iprint(varDataSource)
        if varDataSource and varDataSource.Estado["Esposado"] then
            cancelEvent()
        end
    end
end)
function MultasLSPD(source, command, objetive, cantidad, ...)
    local cooldownTime = 5000 -- 5000 milisegundos = 5 segundos
    if isOnCooldown(source, command, cooldownTime) then
        outputChatBox("Debes esperar antes de volver a usar este comando.", source)
        return
    end
    local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
    if not (varDataSource) or not (varDataSource.Informacion) or not (varDataSource.Inventario) then
        return
    end
    if not varDataSource.Trabajos["Trabajo"] == "Los Santos Police Departament" then
        return
    end
    if not varDataSource.Trabajos["OnDuty"] == true then
        return
    end
    if not (objetive) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/multar [Jugador] [Cantidad] [Motivo]", source, 255, 255, 255, true)
    end
    objetivo = nil;
    if tonumber(objetive) then
        objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
    elseif (isElement(getPlayerFromName(objetive))) then
        objetivo = getPlayerFromName(objetive)
    else
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
    end
    if not (isElement(objetivo)) then
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
    end
    local varDataObjetivo = exports["MR1_Inicio"]:getValueOne(objetivo)
    --if not (getPlayerName(source) ~= objetive) then
    --    return outputChatBox("#ffe100Creo que merezco un ascenso, o la muerte...", source, 255, 255, 255, true)
    --end
    if not (varDataObjetivo) or not (varDataObjetivo.Informacion) or not (varDataObjetivo.Inventario) then
        return outputChatBox("#ffe100No puedo pasarle dinero a un fantasma...", source, 255, 255, 255, true)
    end
    if not (cantidad) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/multar [Jugador] [Cantidad] [Motivo]", source, 255, 255, 255, true)
    end
    if tonumber(cantidad) < 0 then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/multar [Jugador] [Cantidad] [Motivo]", source, 255, 255, 255, true)
    end
    if tonumber(cantidad) > 1000000 then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/multar [Jugador] [Cantidad] [Motivo]", source, 255, 255, 255, true)
    end
	local Motivo = table.concat({...}, " ") --Concatenamos la razon en una sola variable.
    if not (#Motivo > 1) then 
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/multar [Jugador] [Cantidad] [Motivo]", source, 0, 0, 0, true) --RETORNAMOS LA SYNTAXIS CORRECTA
    end
    local posX1, posY1, posZ1= getElementPosition(source) -- Obtenemos la posicion del sujeto que esta ejecutando el comando.
    local posX2, posY2, posZ2 = getElementPosition(objetivo) -- Obtenemos la posicion del objetivo.
    local distance = getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2)
    if distance > 5 then
        return outputChatBox("#ffe100Tengo que acercarme mas...", source, 255, 255, 255, true)
    end

    local query = "INSERT INTO MultasIC (IDPersonaje, IDLSPD, PRECIO, MOTIVO) VALUES(?, ?, ?, ?)"
    exports["MR1_Inicio"]:execute(query, varDataObjetivo.IDPersonaje, varDataSource.IDPersonaje, tonumber(cantidad), Motivo)

    local cantidadFormateada = formatNumber(math.abs(math.floor(tonumber(cantidad))))
    outputChatBox("#9AA498[#0058ffLSPD#9AA498] #53B440Has multado a #24C5BE"..getPlayerName(objetivo).."#53B440 con #24C5BE"..cantidadFormateada.."$#53B440.", source, 255, 255, 255, true) -- STAFF
    outputChatBox("#9AA498[#0058ffLSPD#9AA498] #53B440Motivos: #FF7800"..Motivo.."#53B440.", source, 255, 255, 255, true) -- USER
    outputChatBox("#9AA498[#0058ffLSPD#9AA498] #FF7800"..getPlayerName(source).." #53B440te ha multado con #FF7800"..cantidadFormateada.."$#53B440.", objetivo, 255, 255, 255, true) -- USER
    outputChatBox("#9AA498[#0058ffLSPD#9AA498] #53B440Motivos: #FF7800"..Motivo.."#53B440.", objetivo, 255, 255, 255, true) -- USER

    outputChatBox("#ffe100Genial, ahora tengo que ir a comisaria a pagarla, que pereza...", objetivo, 255, 255, 255, true)
end
addCommandHandler("multar", MultasLSPD)

function vehicleExplode()
    local veh = source
    local infoVeh = exports["MR1_Inicio"]:getValueOne(source)
    if infoVeh then
        if infoVeh.Personaje == "Los Santos Police Departament" then
            local newInfo = infoVeh.Informacion["Matricula"]
            setTimer(function(veh)
                destroyElement(veh)
            end, 3000, 1, veh)
            setTimer(function()
                for i, v in ipairs(VehsGarajeLSPD) do
                    if newInfo == v[8] then
                        local VehGarajeLSPD = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8])

                        local Personaje = "Los Santos Police Departament";
                        local Informacion = {Modelo = v[1], Matricula = v[8]}
                        local Estado = {Salud = 1000, Destruido = false, Bloqueo = true, Motor = false}
                        
                        exports["MR1_Inicio"]:setValue(VehGarajeLSPD, 'Personaje', Personaje)
                        exports["MR1_Inicio"]:setValue(VehGarajeLSPD, 'Informacion', Informacion)
                        exports["MR1_Inicio"]:setValue(VehGarajeLSPD, 'Estado', Estado)
                        
                        if (v[8] == "CHAR-01") then
                            setVehicleColor(VehGarajeLSPD, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255 )
                        elseif (v[8] == "CHAR-02") then
                            setVehicleColor(VehGarajeLSPD, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255 )
                        elseif (v[8] == "CHAR-03") then
                            setVehicleColor(VehGarajeLSPD, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
                        elseif (v[8] == "CHAR-04") then
                            setVehicleColor(VehGarajeLSPD, 9, 33, 67, 255, 255, 255, 255, 255, 255, 255, 255, 255 )
                        elseif (v[8] == "CHAR-05") then
                            setVehicleColor(VehGarajeLSPD, 145, 69, 40, 255, 255, 255, 255, 255, 255, 255, 255, 255 )
                        elseif (v[8] == "CHAR-06") then
                            setVehicleColor(VehGarajeLSPD, 13, 97, 30, 255, 255, 255, 255, 255, 255, 255, 255, 255 )
                        end
                    end
                end
            end, 60000, 1) --60000
        end
    end
end
addEventHandler("onVehicleExplode", getRootElement(), vehicleExplode)

function Sirenas(source, command)
    local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
    if Trabajos.Trabajo == "Los Santos Police Departament" then
        if Trabajos.OnDuty == true then
            local vehicle = getPedOccupiedVehicle(source)
            if not vehicle then
                return
            end

            addVehicleSirens(vehicle, 1, 1)

            local sirensOn = getVehicleSirensOn(vehicle)

            if sirensOn then
                setVehicleSirensOn(vehicle, not sirensOn)
                removeVehicleSirens(vehicle)
            else 
                setVehicleSirensOn(vehicle, not sirensOn)
            end
        end
    end
end
addCommandHandler("balizas", Sirenas)
addCommandHandler("sirenas", Sirenas)

function CargarMultas(source, Objetivo)
    local varDataClient = exports["MR1_Inicio"]:getValueOne(Objetivo)
    if not (varDataClient) then
        return
    end
    local Multas = exports["MR1_Inicio"]:query("SELECT * FROM MultasIC WHERE IDPersonaje=?", varDataClient.IDPersonaje)

    for _, multa in ipairs(Multas) do
        local personajeData = exports["MR1_Inicio"]:query("SELECT Nombre FROM Personajes WHERE ID=?", multa.IDLSPD)
        if personajeData and personajeData[1] then
            multa.IDLSPD = personajeData[1].Nombre  -- Reemplazar el ID con el nombre del personaje
        end
    end

    triggerClientEvent(source, "Panel::LSPD::Comisaria::Multas::Listar", source, Multas)
end

function verMultas(source, command, objetive)
    local cooldownTime = 5000 -- 5000 milisegundos = 5 segundos
    if isOnCooldown(source, command, cooldownTime) then
        outputChatBox("Debes esperar antes de volver a usar este comando.", source)
        return
    end
    local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
    if not (varDataSource) then
        return
    end
    if not varDataSource.Trabajos["Trabajo"] == "Los Santos Police Departament" then
        return
    end
    if not varDataSource.Trabajos["OnDuty"] == true then
        return
    end
    if not (objetive) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/vermultas [Jugador]", source, 255, 255, 255, true)
    end
    objetivo = nil;
    if tonumber(objetive) then
        objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
    elseif (isElement(getPlayerFromName(objetive))) then
        objetivo = getPlayerFromName(objetive)
    else
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
    end
    if not (isElement(objetivo)) then
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
    end
    local varDataObjetivo = exports["MR1_Inicio"]:getValueOne(objetivo)
    if not (varDataObjetivo) or not (varDataObjetivo.Informacion) or not (varDataObjetivo.Inventario) then
        return outputChatBox("#ffe100No puedo ver las multas de un fantasma...", source, 255, 255, 255, true)
    end
    CargarMultas(source, objetivo)
    triggerClientEvent(source, "Panel::LSPD::Comisaria::Multas::Ver", source, getPlayerName(objetivo))
end
addCommandHandler("vermultas", verMultas)


-- LICENCIAS
    function ComprarLicencia()
        local varDataClient = exports["MR1_Inicio"]:getValueOne(client)
        if not (varDataClient) then
            return
        end
        varDataClient.Inventario["Licencias"] = varDataClient.Inventario["Licencias"] or {DNI = 1}
        if (varDataClient.Inventario["Licencias"].LincArmas == 1) then
            outputChatBox("#9AA498[#0058ffLSPD#9AA498] #53B440Ya dispones de una licencia, lo siento.", client, 255, 255, 255, true) -- STAFF
            return
        end
        if (varDataClient.Inventario["Dinero"] < CosteLicencia) then
            outputChatBox("#9AA498[#0058ffLSPD#9AA498] #53B440No dispones del dinero suficiente, la licencia vale 10.000$.", client, 255, 255, 255, true) -- STAFF
            return
        end
        exports["MR6_Economia"]:restarDinero(client, CosteLicencia, "MRJobs2_FaccLSPD")
        --varDataClient.Inventario["Dinero"] = varDataClient.Inventario["Dinero"] - CosteLicencia
        varDataClient = exports["MR1_Inicio"]:getValueOne(client)
        varDataClient.Inventario["Licencias"].LincArmas = 1
        exports["MR1_Inicio"]:setValue(client, 'Inventario', varDataClient.Inventario)
        outputChatBox("#ffe100Acabo de comprar la #FF7800Licencia de Armas #ffe100por #FF7800"..formatNumber(CosteLicencia).." $#ffe100...", client, 255, 255, 255, true)
    end
    addEvent("Panel::LSPD::Comisaria::Informacion::Licencia", true)
    addEventHandler("Panel::LSPD::Comisaria::Informacion::Licencia", getRootElement(), ComprarLicencia)
-- MULTAS PANEL
    function PanelMultas()
        local varDataClient = exports["MR1_Inicio"]:getValueOne(client)
        if not (varDataClient) then
            return
        end
        local Multas = exports["MR1_Inicio"]:query("SELECT * FROM MultasIC WHERE IDPersonaje=?", varDataClient.IDPersonaje)

        for _, multa in ipairs(Multas) do
            local personajeData = exports["MR1_Inicio"]:query("SELECT Nombre FROM Personajes WHERE ID=?", multa.IDLSPD)
            if personajeData and personajeData[1] then
                multa.IDLSPD = personajeData[1].Nombre  -- Reemplazar el ID con el nombre del personaje
            end
        end

        triggerClientEvent(client, "Panel::LSPD::Comisaria::Multas::Listar", client, Multas)
    end
    addEvent("Panel::LSPD::Comisaria::Multas::Abrir", true)
    addEventHandler("Panel::LSPD::Comisaria::Multas::Abrir", getRootElement(), PanelMultas)

    function PanelMultas(Multa)
        -- Obtener los datos del personaje del cliente
        local varDataClient = exports["MR1_Inicio"]:getValueOne(client)
        if not varDataClient then
            return
        end

        -- Comprobar si la multa existe y pertenece al personaje
        local multa = exports["MR1_Inicio"]:query("SELECT * FROM MultasIC WHERE ID = ? AND IDPersonaje = ?", Multa, varDataClient.IDPersonaje)
        
        if multa and multa[1] then
            --varDataClient.Inventario["Dinero"] = varDataClient.Inventario["Dinero"] - multa[1].PRECIO
            
            exports["MR6_Economia"]:restarDinero(client, multa[1].PRECIO, "MRJobs2_FaccLSPD")
            --exports["MR1_Inicio"]:setValue(client, 'Inventario', varDataClient.Inventario)
            outputChatBox("#ffe100Acabo de pagar la #FF7800multa #"..Multa.." #ffe100por #FF7800"..formatNumber(multa[1].PRECIO).." $#ffe100...", client, 255, 255, 255, true)
            exports["MR1_Inicio"]:execute("DELETE FROM MultasIC WHERE ID = ?", Multa)

        else
            -- Notificar al cliente que la multa no existe o no pertenece al personaje
            outputChatBox("#9AA498[#0058ffLSPD#9AA498] #FF0000No se pudo procesar el pago. Multa no encontrada o no te pertenece.", client, 255, 255, 255, true)
        end
    end
    addEvent("Panel::LSPD::Comisaria::Multas::Pagar", true)
    addEventHandler("Panel::LSPD::Comisaria::Multas::Pagar", getRootElement(), PanelMultas)