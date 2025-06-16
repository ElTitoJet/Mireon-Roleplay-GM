-- Tabla para almacenar los jugadores afectados por el taser
local taserEffectPlayers = {}

-- Función para aplicar el efecto del taser
function aplicarEfectoTaser(targetPlayer, attacker)
    -- Aplicar animación de caída o inmovilización
    setPedAnimation(targetPlayer, "ped", "KO_shot_face", 10000, false, true, false, true)

    -- Añadir al jugador a la lista de afectados
    taserEffectPlayers[targetPlayer] = true

    -- Deshabilitar controles del jugador
    toggleControl(targetPlayer, "fire", false)
    toggleControl(targetPlayer, "aim_weapon", false)
    toggleControl(targetPlayer, "jump", false)
    toggleControl(targetPlayer, "sprint", false)
    toggleControl(targetPlayer, "walk", false)

    -- Restaurar al jugador después de 10 segundos
    setTimer(function()
        if isElement(targetPlayer) then
            -- Eliminar animación y restaurar controles
            setPedAnimation(targetPlayer, false)
            toggleControl(targetPlayer, "fire", true)
            toggleControl(targetPlayer, "aim_weapon", true)
            toggleControl(targetPlayer, "jump", true)
            toggleControl(targetPlayer, "sprint", true)
            toggleControl(targetPlayer, "walk", true)

            -- Quitar al jugador de la lista de afectados
            taserEffectPlayers[targetPlayer] = nil
            
            local varDataSource = exports["MR1_Inicio"]:getValueOne(targetPlayer)
            varDataSource.Estado["Taseado"] = nil
            exports["MR1_Inicio"]:setValue(targetPlayer, 'Estado', varDataSource.Estado)
        end
    end, 10000, 1) -- 10 segundos de duración del efecto
end

-- Detectar cuando un jugador recibe daño
addEventHandler("onPlayerDamage", root, function(attacker, weapon, bodypart)
    -- Comprobar si el atacante es un jugador y si el arma es la pistola silenciada (ID 23)
    if attacker and weapon == 23 and getElementType(attacker) == "player" then
        -- Comprobar que el atacante pertenece a la LSPD y está de servicio
        local Trabajos = exports["MR1_Inicio"]:getValue(attacker, 'Trabajos')
        if Trabajos.Trabajo == "Los Santos Police Departament" and Trabajos.OnDuty == true then
            -- Aplicar el efecto taser al objetivo
            
            local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
            varDataSource.Estado["Taseado"] = true
            exports["MR1_Inicio"]:setValue(source, 'Estado', varDataSource.Estado)
            aplicarEfectoTaser(source, attacker)
        end
    end
end)
