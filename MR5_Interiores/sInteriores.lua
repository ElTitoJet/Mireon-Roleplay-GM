-- MR5_Interiores
-- Gestiona el sistema de TP de interiores
-- Autor: ElTitoJet
-- Fecha: 01/03/2024

-- Variables Globales y Configuración
    --[[
            -- DONAS
            {377.126953125, -192.74609375, 1000.6401367188, 17, 0, 16},
            -- Gimnasion
            {772.265625, -4.70703125, 1000.7288208008, 5, 0, 54}, -- GYM Ganton
        }
    ]]
    local Interiores = {}
    local PickUpsEnterInts = createElement("PickUps")
    local PickUpsLeaveInts = createElement("PickUps")
-- Funciones Auxiliares
    function Cambiar_De_Interior_A_Pie(source, int, dim, x, y, z, rx, ry, rz)
        if isPedInVehicle(source) then
            return outputChatBox("#ffe100No seria buena idea meter un vehiculo aqui...", source, 255, 255, 255, true)
        end

        local varRotacion_X = rx or 0
        local varRotacion_Y = ry or 0
        local varRotacion_Z = rz or 0

        setElementInterior(source, int)
        setElementDimension(source, dim or 0)
        setElementPosition(source, x, y, z)
        setElementRotation(source, varRotacion_X, varRotacion_Y, varRotacion_Z)

        setElementFrozen(source, true)
        setTimer(function()
            setElementFrozen(source, false)
        end, 1500, 1)
    end
-- Funciones Principales
    function crearPickUp(x, y, z, int, dim, blipID, parentElement, tipo, index, crearBlip)
        local pickup = createPickup(x, y, z, 3, 1318, 0, 0) -- Crear el pickup
        if crearBlip then
            createBlipAttachedTo(pickup, blipID, 255, 0, 0, 0, 255, 0, 200) -- Crear el blip solo si se indica
        end
        setElementInterior(pickup, int) -- Establecer interior
        setElementDimension(pickup, dim) -- Establecer dimensión
        setElementParent(pickup, parentElement) -- Agrupar el pickup
        setElementID(pickup, tipo .. "_" .. index) -- Asignar un ID único
    end
    function Start(resource)
        -- Consultar todos los interiores desde la base de datos
        local varListaInteriores = exports["MR1_Inicio"]:query("SELECT * FROM Interiores")
        if not varListaInteriores then return end
        
        -- Iterar sobre cada interior y crear los pickups de entrada y salida
        for i, Interior in ipairs(varListaInteriores) do
            -- Llenar la tabla Interiores con los datos de la base de datos
            Interiores[i] = {
                entrada_x = Interior.entrada_x,
                entrada_y = Interior.entrada_y,
                entrada_z = Interior.entrada_z,
                entrada_int = Interior.entrada_int,
                entrada_dim = Interior.entrada_dim,
                salida_x = Interior.salida_x,
                salida_y = Interior.salida_y,
                salida_z = Interior.salida_z,
                salida_int = Interior.salida_int,
                salida_dim = Interior.salida_dim,
                blip = Interior.blip,
                descripcion = Interior.descripcion
            }
    
            -- Crear Pickup de Entrada con Blip
            crearPickUp(Interiores[i].entrada_x, Interiores[i].entrada_y, Interiores[i].entrada_z, Interiores[i].entrada_int, Interiores[i].entrada_dim, Interiores[i].blip, PickUpsEnterInts, "Entrada", i, true)
            
            -- Crear Pickup de Salida sin Blip
            crearPickUp(Interiores[i].salida_x, Interiores[i].salida_y, Interiores[i].salida_z, Interiores[i].salida_int, Interiores[i].salida_dim, Interiores[i].blip, PickUpsLeaveInts, "Salida", i, false)
        end
    end
    function enviarDatosInteriores(player)
        local entradas = {}
        local salidas = {}
        
        for i, interior in ipairs(Interiores) do
            -- Guardar las coordenadas de entrada y descripción
            table.insert(entradas, {
                interior.entrada_x, 
                interior.entrada_y, 
                interior.entrada_z, 
                interior.entrada_int, 
                interior.entrada_dim, 
                interior.descripcion
            })
            
            -- Guardar las coordenadas de salida
            table.insert(salidas, {
                interior.salida_x, 
                interior.salida_y, 
                interior.salida_z, 
                interior.salida_int, 
                interior.salida_dim,
                interior.descripcion
            })
        end
        
        triggerClientEvent(player, "Interiores::RecibirInts", resourceRoot, entradas, salidas)
    end
        --[[
                for i, Interior in ipairs(Interiores) do
            local varPickUpEntrada = createPickup(Interior[1], Interior[2], Interior[3], 3, 1318, 0, 0)
            local varBlipEntradas = createBlipAttachedTo(varPickUpEntrada, Interior[11], 255, 0, 0, 0, 255, 0, 200)
            setElementInterior(varPickUpEntrada, Interior[4])
            setElementDimension(varPickUpEntrada, Interior[5])
            setElementParent( varPickUpEntrada, PickUpsEnterInts )
            setElementID(varPickUpEntrada, i)

            local varPickUpSalida = createPickup(Interior[6], Interior[7], Interior[8], 3, 1318, 0, 0)
            setElementInterior(varPickUpSalida, Interior[9])
            setElementDimension(varPickUpSalida, Interior[10])
            setElementParent( varPickUpSalida, PickUpsLeaveInts )
            setElementID(varPickUpSalida, i)
        end
        ]]
-- Eventos y Handlers
    addEventHandler("onResourceStart", resourceRoot, Start)
    addEventHandler("onPickupHit", PickUpsEnterInts, function(hitElement)
        if getElementType(hitElement) == "player" then
            local key = getElementID(source):match("Entrada_(%d+)")
            local value = Interiores[tonumber(key)] -- Obtener datos del interior
            
            -- Asignar la tecla H para cambiar de interior
            bindKey(hitElement, "H", "down", function()
                Cambiar_De_Interior_A_Pie(hitElement, value.salida_int, value.salida_dim, value.salida_x, value.salida_y, value.salida_z, 0, 0, 179.30786132812)
                unbindKey(hitElement, "H") -- Desvincular la tecla después del uso
            end)
        end
    end)
    addEventHandler("onPickupLeave", PickUpsEnterInts, function(hitElement, m)
        if getElementType(hitElement) == "player" then
            unbindKey(hitElement, "H") -- Asegurar que la tecla H se desvincula al salir
        end
    end)
    addEventHandler("onPickupHit", PickUpsLeaveInts, function(hitElement)
        if getElementType(hitElement) == "player" then
            local key = getElementID(source):match("Salida_(%d+)")
            local value = Interiores[tonumber(key)] -- Obtener datos del interior
            
            -- Asignar la tecla H para salir del interior
            bindKey(hitElement, "H", "down", function()
                Cambiar_De_Interior_A_Pie(hitElement, value.entrada_int, value.entrada_dim, value.entrada_x, value.entrada_y, value.entrada_z, 0, 0, 179.30786132812)
                unbindKey(hitElement, "H") -- Desvincular la tecla después del uso
            end)
        end
    end)
    addEventHandler("onPickupLeave", PickUpsLeaveInts, function(hitElement, m)
        if getElementType(hitElement) == "player" then
            unbindKey(hitElement, "H") -- Asegurar que la tecla H se desvincula al salir
        end
    end)
    addEvent("Interiores::SolicitarInts", true)
    addEventHandler("Interiores::SolicitarInts", root, function()
        enviarDatosInteriores(source)
    end)