-- Tabla para almacenar los objetos creados por cada jugador
local objetosLSPD = {}
local cooldowns = {}
-- Función para colocar un objeto
function colocarObjetoLSPD(player, objetoID, x, y, z, rotX, rotY, rotZ, int, dim)
    if not objetosLSPD[player] then
        objetosLSPD[player] = {}
    end

    local obj = createObject(objetoID, x, y, z, rotX, rotY, rotZ)
    setElementDoubleSided(obj, true)
    setElementInterior(obj, int)
    setElementDimension(obj, dim)
    setObjectBreakable(obj, false)

    local colShape
    if objetoID == 2892 then  -- Pinchos
        colShape = createColSphere(x, y, z, 3)
        addEventHandler("onColShapeHit", colShape, function(hitElement)
            if getElementType(hitElement) == "vehicle" then
                pincharRuedas(hitElement)
            end
        end)
        setObjectScale(obj, 0.7) -- Escala de 0.7 para reducir el tamaño
    end

    table.insert(objetosLSPD[player], {obj = obj, colShape = colShape})
end
function pincharRuedas(vehicle)
    setVehicleWheelStates(vehicle, 1,1,1,1) -- 1 significa que la rueda está pinchada
end

function isOnCooldownn(player, command, cooldownTime)
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
-- Función para eliminar el último objeto creado por un jugador
function eliminarObjetoCercano(player)
    local x, y, z = getElementPosition(player)
    local closestObject = nil
    local closestDistance = 5 -- Rango máximo de búsqueda en unidades de juego

    -- Buscar el objeto más cercano
    for p, objects in pairs(objetosLSPD) do
        for _, data in ipairs(objects) do
            local obj = data.obj
            if isElement(obj) then
                local ox, oy, oz = getElementPosition(obj)
                local distance = getDistanceBetweenPoints3D(x, y, z, ox, oy, oz)
                if distance < closestDistance then
                    closestObject = data
                    closestDistance = distance
                end
            end
        end
    end
    if closestObject then
        if isElement(closestObject.obj) then
            destroyElement(closestObject.obj)
        end
        if isElement(closestObject.colShape) then
            destroyElement(closestObject.colShape)
        end
        outputChatBox("Has eliminado el objeto más cercano.", player, 0, 255, 0)
    else
        outputChatBox("No se encontró ningún objeto cercano.", player, 255, 0, 0)
    end
end

-- Comando para colocar conos
addCommandHandler("conos", function(source, command)
    local cooldownTime = 500 -- 5000 milisegundos = 0.5 segundos
    if isOnCooldownn(source, command, cooldownTime) then
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
    local x, y, z = getElementPosition(source)
    local rotX, rotY, rotZ = getElementRotation(source)
    local int = getElementInterior(source)
    local dim = getElementDimension(source)
    colocarObjetoLSPD(source, 1238, x, y, z-0.6, rotX, rotY, rotZ, int, dim)
end)

-- Comando para colocar barreras
addCommandHandler("barrera", function(source, command, tipo)
    local cooldownTime = 500 -- 5000 milisegundos = 5 segundos
    if isOnCooldownn(source, command, cooldownTime) then
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

        local barreras = {
            ["1"] = 1459,
            ["2"] = 1427,
            ["3"] = 1425,
            ["4"] = 1424,
            ["5"] = 1423,
            ["6"] = 1422,
            ["7"] = 1228,
            ["8"] = 3091,
        }
        local idBarrera = barreras[tipo]
        if idBarrera then
                    
            local x, y, z = getElementPosition(source)
            local rotX, rotY, rotZ = getElementRotation(source)
            local int = getElementInterior(source)
            local dim = getElementDimension(source)
            colocarObjetoLSPD(source, idBarrera, x, y, z-0.6, rotX, rotY, rotZ, int, dim)
        else
            outputChatBox("Tipo de barrera inválido. Usa: /barrera [1-8]", source, 255, 0, 0)
        end

end)

-- Comando para colocar pinchos
addCommandHandler("pinchos", function(source, command)
    local cooldownTime = 500 -- 5000 milisegundos = 5 segundos
    if isOnCooldownn(source, command, cooldownTime) then
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
    local x, y, z = getElementPosition(source)
    local rotX, rotY, rotZ = getElementRotation(source)
    
    local offset = -5 -- Distancia al frente del jugador
    local radRotZ = math.rad(rotZ) -- Convertir la rotación a radianes

    -- Ajustar la posición X e Y según la rotación
    local newX = x + math.sin(radRotZ) * offset
    local newY = y - math.cos(radRotZ) * offset
    
    local int = getElementInterior(source)
    local dim = getElementDimension(source)
    colocarObjetoLSPD(source, 2892, newX, newY, z-1.1, rotX, rotY, rotZ, int, dim)
end)

-- Comando para eliminar el último objeto colocado
addCommandHandler("eliminarobjeto", function(player)
    eliminarObjetoCercano(player)
end)

-- Eliminar objetos al desconectar el jugador
addEventHandler("onPlayerQuit", root, function()
    objetosLSPD[source] = nil  -- Borra la referencia del jugador
end)