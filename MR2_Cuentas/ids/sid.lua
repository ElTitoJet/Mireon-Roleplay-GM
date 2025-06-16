-- MR2_Cuentas
-- Gestiona el sistema de ID´s de los jugadores
-- Autor: ElTitoJet
-- Fecha: 12/02/2024

-- Variables Globales y Configuración
    playerFromID = {}
    idFromPlayer = {}
-- Funciones Auxiliares
    function getFreeTemporaryID()
        local count = 1
        while isElement(playerFromID[count]) do
            count = count + 1
        end
        return count
    end
    function getPlayerFromID(id)
        return playerFromID[tonumber(id)]
    end
    
    function getIDTempFromPlayer(player)
        return idFromPlayer[player]
    end
-- Funciones Principales

    function setTempIdToPlayer(who)
        local old_id = idFromPlayer[who]
        if old_id then
            playerFromID[old_id] = nil
        end
    
        local new_id = getFreeTemporaryID()
        playerFromID[new_id] = who
        idFromPlayer[who] = new_id
        exports["MR1_Inicio"]:setValue(who, 'TempID', new_id)
        --
        triggerClientEvent('syncIdTemps', resourceRoot, playerFromID, idFromPlayer)
    end
-- Eventos y Handlers
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.