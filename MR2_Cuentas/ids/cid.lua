-- MR2_Cuentas
-- Gestiona el sistema de ID´s de los jugadores
-- Autor: ElTitoJet
-- Fecha: 12/02/2024

-- Variables Globales y Configuración
    playerFromID = {}
    idFromPlayer = {}
-- Funciones Auxiliares
    function getPlayerFromID(id)
        return playerFromID[tonumber(id)]
    end

    function getIDTempFromPlayer(player)
        return idFromPlayer[player]
    end
-- Funciones Principales
-- Eventos y Handlers
    addEvent("syncIdTemps", true)
    addEventHandler("syncIdTemps", localPlayer, function(tabla1, tabla2)
        playerFromID = tabla1
        idFromPlayer = tabla2
    end)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.