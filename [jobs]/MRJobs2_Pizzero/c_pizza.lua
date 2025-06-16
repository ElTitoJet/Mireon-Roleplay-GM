-- MRJobs2_Pizzero
-- Script que gestiona el job de Pizzero
-- Autor: ElTitoJet
-- Fecha: 25/11/2024

-- Variables Globales y Configuración
    local pickupsStreaming = {}
    local PickUps = {
        -- {x, y, z, int, dim, tienda}
        [1] = {2124.87109375, -1791.7001953125, 13.5546875},
    }
-- Funciones Auxiliares

-- Funciones Principales
    function elementStreamInOut()
        if getElementType(source) ~= "player" then
            if eventName:find("In") then
                if getElementType(source) == 'pickup' then
                    local x,y,z = getElementPosition(source)
                    for i, v in ipairs(PickUps) do
                        if getDistanceBetweenPoints3D(x,y,z, unpack(v)) <= 5 then
                            pickupsStreaming[source] = exports["MR1_Inicio"]:createText3D("#FFFFFF\n Presiona #24C5BEH #FFFFFFpara empezar a trabajar", x, y, z+1, 2, "bankgothic", -1, false, false, true)
                        end
                    end
                end
            else
                if isElement(pickupsStreaming[source]) then
                    destroyElement(pickupsStreaming[source])
                end
            end
        end
    end
-- Eventos y Handlers
    -- EVENTOS
        addEventHandler( "onClientElementStreamIn", getRootElement(), elementStreamInOut)
        addEventHandler( "onClientElementStreamOut", getRootElement(), elementStreamInOut)
    -- COMANDOS
    -- TIMER