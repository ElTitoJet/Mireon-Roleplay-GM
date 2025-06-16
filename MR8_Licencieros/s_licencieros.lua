-- MR8_Licencieros
-- Gestiona las licencias de conduccion del servidor
-- Autor: ElTitoJet
-- Fecha: 14/04/2024

-- Variables Globales y Configuración
    local PickUps = {
        --[ID] = {x, y, z, tipo, interior, dimension} Entrada - Salida
        [1] = {-2031.935546875, -117.2626953125, 1035.171875, 3, 1239, 3, 1}, -- PickUp Examen
    }
    local VehsLicencieros = {
        --[ID] = {Modelo, x, y, z, rx, ry, rz, matricula, licencia}
        [1] = {507, 1083.9316406250, -1772.5917968750, 13.176582336426, 0, 0, 270.31448364258, "DRIVE 1", "Licencia Coche"},
        [2] = {507, 1084.0683593750, -1766.6972656250, 13.185859680176, 0, 0, 270.31448364258, "DRIVE 2", "Licencia Coche"},
        [3] = {507, 1083.9873046875, -1760.8339843750, 13.200069427490, 0, 0, 270.31448364258, "DRIVE 3", "Licencia Coche"},
        [4] = {507, 1083.9482421875, -1754.8740234375, 13.213576316833, 0, 0, 270.31448364258, "DRIVE 4", "Licencia Coche"},
    
        [5] = {581, 1077.6738281250, -1775.5205078125, 12.939540863037, 0, 0, 90.505493164062, "DRIVE 5", "Licencia Moto"},
        [6] = {581, 1077.7763671875, -1769.7441406250, 12.954962730408, 0, 0, 90.505493164062, "DRIVE 6", "Licencia Moto"},
        [7] = {581, 1077.7285156250, -1763.7138671875, 12.964943885803, 0, 0, 90.505493164062, "DRIVE 7", "Licencia Moto"},
        [8] = {581, 1077.8798828125, -1757.9042968750, 12.982247352600, 0, 0, 90.505493164062, "DRIVE 8", "Licencia Moto"},
    
        [9] = {499, 1098.455078125, -1775.5302734375, 13.337270736694, 0, 0, 87.795837402344, "DRIVE 9", "Licencia Camion"},
        [10] = {499, 1098.755859375, -1769.3291015625, 13.486667633057, 0, 0, 91.014892578125, "DRIVE 10", "Licencia Camion"},
        [11] = {499, 1098.474609375, -1763.8232421875, 13.447001457214, 0, 0, 89.317443847656, "DRIVE 11", "Licencia Camion"},  
    }
    local varPickUps = createElement("PickUps")
    local PrecioLicencia = 100;

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
    function Iniciar_Recurso(resource)
        exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS Licencias ( ID INT NOT NULL AUTO_INCREMENT, Nombre VARCHAR(255) NOT NULL, Tipo VARCHAR(255) NOT NULL, PRIMARY KEY (ID));")
        for i, PickUp in ipairs(PickUps) do
            --local varPickUp = createPickup(1082.0068359375, -1787.1494140625, 13.651255607605, 3, 1239, 0, 0)
            local varPickUp = createPickup(PickUp[1], PickUp[2], PickUp[3], PickUp[4], PickUp[5], 0, 0)
            setElementInterior(varPickUp, PickUp[6])
            setElementDimension(varPickUp, PickUp[7])
            setElementParent( varPickUp, varPickUps )
            setElementID(varPickUp, i)
        end
        setTimer(function()
            for i, vehicle in ipairs(VehsLicencieros) do
                local varVehiculo = createVehicle(vehicle[1], vehicle[2], vehicle[3], vehicle[4], vehicle[5], vehicle[6], vehicle[7], vehicle[8])
                --iprint(varVehiculo, "Test")
                setVehicleColor(varVehiculo, 255, 120, 0)
                setElementFrozen(varVehiculo, true)
                exports["MR1_Inicio"]:setValue(varVehiculo, 'Personaje', "Server")
                local varNewInformacion = {Matricula = vehicle[8], Modelo = vehicle[1], Licencia = vehicle[9], Tipo = "Licencieros"}
                exports["MR1_Inicio"]:setValue(varVehiculo, 'Informacion', varNewInformacion)
                local varNewEstado = {Bloqueo = false, Motor = false, Destruido = false, Salud = 1000}
                exports["MR1_Inicio"]:setValue(varVehiculo, 'Estado', varNewEstado)
            end
        end, 10000, 1)
    end
    function PickUp_Licencieros_Tocar(hitElement)
        local key = getElementID(source)
        local value = PickUps[tonumber(key)]
        bindKey(hitElement, "H", "down", function(hitElement, m)
            local Licencias = exports["MR1_Inicio"]:query('SELECT * FROM Licencias WHERE Tipo = "Vehiculo"')
            triggerClientEvent(hitElement, "Licencieros:Client:PanelLicencias:Abrir", hitElement, Licencias)
            unbindKey(hitElement,"H")
        end)
    end
    function PickUp_Licencieros_Salir(hitElement, m)
        unbindKey(hitElement,"H")
    end
    function PagarExamenLicencia(Precio, Licencia)
        local varInfoClient = exports["MR1_Inicio"]:getValueOne(client)
        --varInfoClient.Inventario["Dinero"] = varInfoClient.Inventario["Dinero"] - PrecioLicencia
        
        exports["MR6_Economia"]:restarDinero(source, PrecioLicencia, "MR8_Licencieros")
        --exports["MR1_Inicio"]:setValue(client, 'Inventario', varInfoClient.Inventario)
        outputChatBox("#ffe100Acabo de pagar el examen de #FF7800"..Licencia.." #ffe100por #FF7800"..formatNumber(PrecioLicencia).." $#ffe100...", client, 255, 255, 255, true)     
    end
    function IniciarExamenPractico(player, seat)
        --iprint(source)
        local varInfoVehicle = exports["MR1_Inicio"]:getValueOne(source)
        --iprint(varInfoVehicle)
        if not varInfoVehicle or not varInfoVehicle["Informacion"] or varInfoVehicle["Informacion"]["Tipo"] ~= "Licencieros" then
            return
        end

        if not getElementData(player, "Licencia") or getElementData(player, "Licencia") ~= varInfoVehicle["Informacion"].Licencia then 
            outputChatBox("#ffe100No estudiaste para esta licencia de " .. varInfoVehicle["Informacion"].Licencia .. "...", player, 255, 255, 255, true) 
            return cancelEvent()
        end

        if seat == 0 and getVehicleOccupant(source, 0) == player then
            setElementFrozen(source, false)  -- Descongelar el vehículo para que se pueda mover
            triggerClientEvent(player, "Licencieros:Server:Examen:Practico:Crear", player)  -- Activar evento para iniciar el examen
        end
        
    end
    function RespawnVeh(Vehicle, Matricula)
        --iprint(Vehicle, Matricula)
        if (Vehicle == getPedOccupiedVehicle(client)) then
            removePedFromVehicle(client)
        end
        for i, v in ipairs(VehsLicencieros) do
            if Matricula == v[8] then
                fixVehicle(Vehicle)
                setElementPosition(Vehicle, v[2], v[3], v[4])
                setElementRotation(Vehicle, v[5], v[6], v[7])
                setElementFrozen(Vehicle, true)
                setVehicleEngineState(Vehicle, false)
            end
        end
    end
    function DarLicencia(licencia)
        local varDataClient = exports["MR1_Inicio"]:getValueOne(client)
        if not (varDataClient) then
            return
        end
        local inventario = varDataClient.Inventario
        --iprint(inventario.Licencias[""..licencia..""])
        varDataClient.Inventario["Licencias"] = varDataClient.Inventario["Licencias"] or {DNI = 1}
        if inventario.Licencias[""..licencia..""] == 1 then
            return outputChatBox("#ffe100Ya tengo esta licencia...", 255, 255, 255, client, true) 
        end
        inventario.Licencias[""..licencia..""] = 1
        exports["MR1_Inicio"]:setValue(client, 'Inventario', varDataClient.Inventario)
        outputChatBox("#ffe100Acabo de conseguir la #FF7800"..licencia.." #ffe100...", client, 255, 255, 255, true)
    end
-- Eventos y Handlers
    addEventHandler("onResourceStart", resourceRoot, Iniciar_Recurso)
    addEventHandler("onPickupHit", varPickUps, PickUp_Licencieros_Tocar)
    addEventHandler("onPickupLeave", varPickUps, PickUp_Licencieros_Salir)
    addEvent("Licencieros:Server:PagarExamenLicencia", true)
    addEventHandler("Licencieros:Server:PagarExamenLicencia", getRootElement(), PagarExamenLicencia)
    addEventHandler("onVehicleStartEnter", getRootElement(), IniciarExamenPractico)
    addEvent('Licencieros:Server:RespawnVeh', true)
    addEventHandler('Licencieros:Server:RespawnVeh', resourceRoot, RespawnVeh)
    addEvent("Licencieros:Server:setLicencia", true)
    addEventHandler("Licencieros:Server:setLicencia", getRootElement(), DarLicencia)
    -- Respawnear veh si no hay nadie
    setTimer ( function()
        for i, Vehicle in ipairs(getElementsByType ('vehicle')) do
            local varData_Vehicle = exports["MR1_Inicio"]:getValueOne(Vehicle)
            if (varData_Vehicle) and (varData_Vehicle["Informacion"]["Tipo"] == "Licencieros") then
                if not (getVehicleController(Vehicle)) then
                    for i, v in ipairs(VehsLicencieros) do
                        if varData_Vehicle["Informacion"].Matricula == v[8] then
                            fixVehicle(Vehicle)
                            setElementPosition(Vehicle, v[2], v[3], v[4])
                            setElementRotation(Vehicle, v[5], v[6], v[7])
                            setElementFrozen(Vehicle, true)
                            setVehicleEngineState(Vehicle, false)
                        end
                    end
                end
            end
        end
    end, 600000, 0 ) -- 600000