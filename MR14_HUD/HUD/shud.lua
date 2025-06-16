-- MR14_HUD
-- Gestiona el HUD del servidor
-- Autor: ElTitoJet
-- Fecha: 25/03/2024

-- Variables Globales y Configuración
-- Funciones Auxiliares
-- Funciones Principales
    function onPlayerStartRunning(originalStyle)
        setPedWalkingStyle(source, 118) -- Estilo de correr
    end
    function onPlayerStopRunning(originalStyle)
        setPedWalkingStyle(source, originalStyle) -- Restaurar estilo original
    end
    function EstaminaCansado(client)
        toggleControl ( client, "sprint", false )
        toggleControl ( client, "jump", false )
        setTimer(function()
            if isElement(client) then -- Verifica si el jugador todavía está conectado
                triggerEvent("Estamina:Recuperado", root, client)
                toggleControl ( client, "sprint", true )
                toggleControl ( client, "jump", true )
            end
        end, 10000, 1)
    end

    function EnviarTiempoServidorUTC(jugador)
        local tiempoUTC = getRealTime(nil, false)  -- Obtener UTC 0
        triggerClientEvent(jugador, "RecibirTiempoServidor", resourceRoot, tiempoUTC)
    end
-- Eventos y Handlers
    addEvent("Estamina:Cansado", true)
    addEventHandler("Estamina:Cansado", root, EstaminaCansado)
    --addEvent("TimeIRL::Pedir", true)
    --addEventHandler("TimeIRL::Pedir", root, enviarHoraServidor)
    addEvent("onPlayerStartRunning", true)
    addEventHandler("onPlayerStartRunning", root, onPlayerStartRunning)
    addEvent("onPlayerStopRunning", true)
    addEventHandler("onPlayerStopRunning", root, onPlayerStopRunning)
    addEventHandler("onPlayerJoin", root, function()
        EnviarTiempoServidorUTC(source)  -- Envía el tiempo UTC al jugador que se conecta
    end)
    addEventHandler("onResourceStart", resourceRoot, function()
        for _, jugador in ipairs(getElementsByType("player")) do
            EnviarTiempoServidorUTC(jugador)  -- Envía el tiempo UTC a todos los jugadores cuando el recurso inicia
        end
    end)
    
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
