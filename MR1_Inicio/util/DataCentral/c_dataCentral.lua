-- MR1_Inicio
-- Gestiona la tabla de datos central del servidor.
-- Autor: ElTitoJet
-- Fecha: 12/02/2024

-- Variables Globales y Configuración
    dataCentral = {}
-- Funciones Auxiliares
    function getValue(element, key)
        return dataCentral[element] and dataCentral[element][key]
    end

    function getValueOne(element)
        return dataCentral[element]
    end

    function getAllValue()
        return dataCentral
    end
-- Funciones Principales
    local function LimpiarDataCentral()
        if dataCentral[source] then
            dataCentral[source] = nil
        end
    end

-- Eventos y Handlers
    addEvent('datasync', true)
    addEventHandler('datasync', root,
        function(num, element, key, value, bool)
            --iprint("Syncronizando")
            --iprint(element)
            --iprint(key)
            --iprint(value)
            --iprint(bool)
            if num == 1 then
                dataCentral[element] = dataCentral[element] or {}
                dataCentral[element][key] = value
            else
                dataCentral = element
            end
        end
    )
        
    addEventHandler('onClientElementDestroy', getRootElement(), LimpiarDataCentral, true, 'low-10')
    addEventHandler('onClientPlayerQuit', getRootElement(), LimpiarDataCentral, true, 'low-10')
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.

--addEventHandler("onClientRender", root, function()
--    local vehicle = getPedOccupiedVehicle(localPlayer)
--    dxDrawText(inspect({dataCentral[vehicle], vehicle}), 450, 0)
--end)