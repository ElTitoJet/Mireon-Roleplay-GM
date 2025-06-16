-- MRJobs5_EmpDa_Silva
-- Script que gestiona el Mecanico Willowfield
-- Autor: ElTitoJet
-- Fecha: 30/10/2023

-- Variables Globales y Configuración
-- Funciones Auxiliares
-- Funciones Principales
function FuncionMecanica(player)
    triggerClientEvent(player, "PanelMecanico", player)
end
function MecanicosReparar()
    vehicle = getPedOccupiedVehicle(source)
	fixVehicle(vehicle)
    local DataVeh = exports["MR1_Inicio"]:getValueOne(vehicle)
    estado = DataVeh.Estado
    estado.Destruido = false
    estado.Motor = false
    estado.Salud = 1000
            
    exports["MR1_Inicio"]:setValue(vehicle, "Estado", estado)
end
function MecanicoAplicarUpgrade(seleccion)
    vehicle = getPedOccupiedVehicle(client)
	addVehicleUpgrade ( vehicle, seleccion )
end
function MecanicoQuitarUpgrade(seleccion)
    vehicle = getPedOccupiedVehicle(source)
    removeVehicleUpgrade(vehicle, seleccion)
end
function MecanicoAplicarPaintJob(paint)
    vehicle = getPedOccupiedVehicle(client)
    setVehiclePaintjob(vehicle, paint)
end
function FuncionPintura(player)
    triggerClientEvent(player, "PanelPintura", player)
end
function MecanicoAplicarColor(editingVehicle, r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4)
    setVehicleColor(editingVehicle, r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4)
end
function MecanicoAplicarLuces(editingVehicle, r, g, b)
    setVehicleHeadLightColor(editingVehicle, r, g, b)
end

local motosPermitidas = {
    [581] = true, -- BF-400
    [509] = true, -- Bike
    [481] = true, -- BMX
    [462] = true, -- Faggio
    [521] = true, -- FCR-900
    [463] = true, -- Freeway
    [510] = true, -- Mountain Bike
    [522] = true, -- NRG-500
    [461] = true, -- PCJ-600
    [448] = true, -- Pizzaboy
    [468] = true, -- Sanchez
    [586] = true  -- Wayfarer
}

local gruaMoto = {}

addCommandHandler("subirmoto", function(player)
    local veh = getPedOccupiedVehicle(player)
    if veh and getElementModel(veh) == 525 then 
        local x, y, z = getElementPosition(veh)
        
        local closestMoto = nil
        local closestDistance = 5

        for _, nearbyVeh in ipairs(getElementsByType("vehicle")) do
            local vehModel = getElementModel(nearbyVeh)
            if motosPermitidas[vehModel] then
                local motoX, motoY, motoZ = getElementPosition(nearbyVeh)
                local distance = getDistanceBetweenPoints3D(x, y, z, motoX, motoY, motoZ)
                if distance < closestDistance then
                    closestMoto = nearbyVeh
                    closestDistance = distance
                end
            end
        end

        if closestMoto then
            local gruaID = getElementData(veh, "gruaID") or getElementID(veh)
            local attachX, attachY, attachZ = 0, -1, 0.5
            attachElements(closestMoto, veh, attachX, attachY, attachZ, 0, 0, 90)

            gruaMoto[gruaID] = closestMoto

            outputChatBox("Moto ajustada en la grúa.", player, 0, 255, 0)
        else
            outputChatBox("No hay motos cercanas para subir.", player, 255, 0, 0)
        end
    else
        outputChatBox("Debes estar en una grúa para usar este comando.", player, 255, 0, 0)
    end
end)

addCommandHandler("bajarmoto", function(player)
    local veh = getPedOccupiedVehicle(player)
    if veh and getElementModel(veh) == 525 then
        local gruaID = getElementData(veh, "gruaID") or getElementID(veh)
        local moto = gruaMoto[gruaID]

        if moto then
            detachElements(moto)

            local x, y, z = getElementPosition(veh)
            setElementPosition(moto, x + 2, y, z)

            gruaMoto[gruaID] = nil
            outputChatBox("Moto bajada de la grúa.", player, 0, 255, 0)
        else
            outputChatBox("No hay ninguna moto subida a esta grúa.", player, 255, 0, 0)
        end
    else
        outputChatBox("Debes estar en una grúa para usar este comando.", player, 255, 0, 0)
    end
end)
-- Eventos y HandlersaddEvent("MecanicosReparar", true)
addEvent("MecanicosReparar", true)
addEventHandler("MecanicosReparar", getRootElement(), MecanicosReparar)
addEvent("MecanicoAplicarUpgrade", true)
addEventHandler("MecanicoAplicarUpgrade", getRootElement(), MecanicoAplicarUpgrade)
addEvent("MecanicoQuitarUpgrade", true)
addEventHandler("MecanicoQuitarUpgrade", getRootElement(), MecanicoQuitarUpgrade)
addEvent("MecanicoAplicarPaintJob", true)
addEventHandler("MecanicoAplicarPaintJob", getRootElement(), MecanicoAplicarPaintJob)
addEvent("MecanicoAplicarColor", true)
addEventHandler("MecanicoAplicarColor", getRootElement(), MecanicoAplicarColor)
addEvent("MecanicoAplicarLuces", true)
addEventHandler("MecanicoAplicarLuces", getRootElement(), MecanicoAplicarLuces)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
