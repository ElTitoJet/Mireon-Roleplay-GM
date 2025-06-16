-- MR24_LevelSystem
-- Script que gestiona el sistema de niveles.
-- Autor: ElTitoJet
-- Fecha: 16/09/2024

-- Variables Globales y Configuración
    local NivelesXP = {}
-- Funciones Auxiliares

-- Funciones Principales
    function definirTablaNiveles()
        local nivelActual = 1
        local xpBase = 5 -- XP base del primer nivel
        local incrementoXP = 5 -- Incremento dentro del grupo
        local incrementoGrupo = 20 -- Incremento en el primer nivel de cada grupo de 10 niveles
    
        for grupo = 1, 10 do
            for nivel = 1, 10 do
                if nivel == 1 and grupo > 1 then
                    -- Aplicar incremento gradual al inicio de cada nuevo grupo
                    NivelesXP[nivelActual] = NivelesXP[nivelActual - 1] + incrementoGrupo
                else
                    -- Incremento dentro del grupo (sumando 5 XP)
                    if nivelActual == 1 then
                        NivelesXP[nivelActual] = xpBase
                    else
                        NivelesXP[nivelActual] = NivelesXP[nivelActual - 1] + incrementoXP
                    end
                end
                nivelActual = nivelActual + 1
            end
        end
        
        -- Depurar tabla de niveles para verificar
        for i, xp in ipairs(NivelesXP) do
            outputChatBox("Nivel " .. i .. ": " .. xp .. " XP")
        end
    end
-- Eventos y Handlers
    
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
    addEventHandler("onResourceStart", resourceRoot, definirTablaNiveles)

