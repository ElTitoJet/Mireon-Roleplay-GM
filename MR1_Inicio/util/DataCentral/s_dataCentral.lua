-- MR1_Inicio
-- Gestiona la tabla de datos central del servidor.
-- Autor: ElTitoJet
-- Fecha: 12/02/2024

-- Variables Globales y Configuración
    dataCentral = {}
    local access
-- Funciones Auxiliares
    function setValue(element, key, value, sync)
        --outputConsole(getResourceFromName(sourceResource), key, value)
        --outputConsole("Resource: "..getResourceName(sourceResource).. ", Elemento: "..tostring(element)..", Key: "..tostring(key) ..", Value: "..tostring(value))
        --iprint("--")
        --iprint(getResourceName(sourceResource))
        --iprint(tostring(element))
        --iprint(tostring(key))
        --iprint((value))
        --outputConsole("Resource: " ..getResourceFromName(sourceResource) .. ", Key: " .. tostring(key) .. ", Value: " .. tostring(value))
        if isElement( element ) then
            if key then

                dataCentral[element] = dataCentral[element] or {}

                dataCentral[element][key] = value

                if sync ~= false then
                    if access then
                        return triggerClientEvent('datasync', resourceRoot, 1, element, key, value)
                    end
                end

            end
        end
        return false
    end

    function getValue(element, key)
        return dataCentral[element] and dataCentral[element][key]
    end

    function getValueOne(element)
        return dataCentral[element]
    end
-- Funciones Principales
    local function LimpiarDataCentral()
        if dataCentral[source] then
            dataCentral[source] = nil
        end
    end
    function verData(player, command)
        iprint(getValueOne(triggerClientEvent and player or localPlayer))
    end
    function verAllData(player, command)
        iprint(dataCentral)
    end
-- Eventos y Handlers
    addEventHandler("onElementDestroy", getRootElement(), LimpiarDataCentral, true, 'low-10')
    addEventHandler("onPlayerQuit", getRootElement(), LimpiarDataCentral, true, 'low-10')
    addCommandHandler("verData", verData)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
    addEventHandler("onPlayerResourceStart", root, function(res)
        if res == resource then
            triggerClientEvent(source, 'datasync', source, 2, dataCentral)
            if not access then
                access = true
            end
        end
    end)

