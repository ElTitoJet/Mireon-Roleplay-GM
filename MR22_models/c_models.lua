-- MR22_models
-- Script que gestiona las funciones de la faccion de medicos del servidor.
-- Autor: ElTitoJet
-- Fecha: 30/10/2023

-- Variables Globales y Configuración
    local shader = dxCreateShader("vehiculo_shader.fx")
    local customTexture = dxCreateTexture("imagenes/saes.png") -- Cambia la ruta según tu archivo

-- Funciones Auxiliares
    function obtenerMavericks()
        local todosVehiculos = getElementsByType("vehicle")  -- Obtener todos los vehículos
        local mavericks = {}  -- Tabla para almacenar los vehículos que sean Maverick

        for _, vehiculo in ipairs(todosVehiculos) do
            if getElementModel(vehiculo) == 497 then  -- Verificar si el modelo es 497 (Maverick)
                table.insert(mavericks, vehiculo)  -- Añadir a la lista de Mavericks
            end
        end
        
        return mavericks  -- Devolver la tabla con todos los Mavericks encontrados
    end

-- Funciones Principales
    function aplicarShaderMaverick(maverick)
        if shader and customTexture then
            dxSetShaderValue(shader, "gTexture", customTexture)  -- Asignar la textura al shader
            local varDataVehicle = exports["MR1_Inicio"]:getValueOne(maverick)
            if varDataVehicle.Personaje == "Los Santos Emergency Services" then
                engineApplyShaderToWorldTexture(shader, "vehiclepoldecals128", maverick)  -- Aplica el shader a la textura específica del Maverick
            end  
        end
    end

-- Eventos y Handlers
    addEventHandler("onClientElementStreamIn", root, function()
        if getElementType(source) == "vehicle" and getElementModel(source) == 497 then
            -- Si el vehículo es un Maverick (modelo 497), aplicamos el shader
            aplicarShaderMaverick(source)
        end
        if getElementType(source) == "player" and getElementModel(source) == 3 then    
            aplicarSkinsCustom(source)
        end
    end)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
    addEventHandler ( "onClientResourceStart", resourceRoot, function ()
        -- SHADERS
            local mavericks = obtenerMavericks()

            if shader and customTexture then
                dxSetShaderValue(shader, "gTexture", customTexture)  -- Asignar la textura al shader
                for _, maverick in ipairs(mavericks) do
                    local varDataVehicle = exports["MR1_Inicio"]:getValueOne(maverick)
                    if varDataVehicle.Personaje == "Los Santos Emergency Services" then
                        engineApplyShaderToWorldTexture(shader, "vehiclepoldecals128", maverick)  -- Aplica el shader a la textura específica del Maverick
                    end    
                end
            end
    end);