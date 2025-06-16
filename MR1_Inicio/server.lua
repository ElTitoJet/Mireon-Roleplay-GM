-- MR1_Inicio
-- Gestiona el inicio de la GM
-- Autor: ElTitoJet
-- Fecha: 11/02/2024

-- Variables Globales y Configuración
-- Funciones Auxiliares
-- Funciones Principales
    function RestartServer()
        outputServerLog("Reinicio en 24 Horas")
        exports["MR15_Discord"]:sendDiscordLogStatusServer(':blue_square: **Reinicio en 24 horas**')

        setTimer(function() -- 23:30 Avisa del reinicio en los ultimos 30 minutos.
            outputChatBox ("Reinicio en 30 minutos") 
            outputServerLog ("Reinicio en 30 minutos")
            exports["MR15_Discord"]:sendDiscordLogStatusServer(':blue_square: **Reinicio en 30 minutos**')
        end, 84600000 , 1)
        
        setTimer(function() -- 23:50
            outputChatBox ("Reinicio en 10 minutos") 
            outputServerLog ("Reinicio en 10 minutos")
            exports["MR15_Discord"]:sendDiscordLogStatusServer(':blue_square: **Reinicio en 10 minutos**')
            -- LLAMADAS A LOS STOPS
        end, 85800000 , 1)

        setTimer(function() -- 23:55
            setServerPassword("ReiniciandoMireon") -- check whether changing password worked
            setGameType("REINICIO")
            local objetives = getElementsByType("player") -- Coge todos los Elementos tipo Jugador
            for i,v in pairs(objetives) do -- Hace una lista de todos los jugadores
                kickPlayer(v, "Reinicio, Volvemos en 5 minutos") -- Da Kick a todos los jugadores de la lista
            end
            exports["MR9_Concesionarios"]:StopConcesionarios()



            exports["MR15_Discord"]:sendDiscordLogStatusServer(':orange_square: **SERVIDOR REINICIANDOSE**')
        end, 86100000 , 1)

        setTimer(function() -- 24:00
            exports["MR15_Discord"]:sendDiscordLogStatusServer(':red_square: **SERVIDOR CERRADO**')
            shutdown() -- Apaga el servidor
        end, 86400000, 1)

    end
    function RestartManualServer(source, command)
        local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
        if not (rank["Rango"] == 10) then
            return
        end

        setServerPassword("ReiniciandoMireon") -- check whether changing password worked
        setGameType("REINICIO")
        local objetives = getElementsByType("player") -- Coge todos los Elementos tipo Jugador
        for i,v in pairs(objetives) do -- Hace una lista de todos los jugadores
            kickPlayer(v, "Reinicio, Volvemos en 5 minutos") -- Da Kick a todos los jugadores de la lista
        end
        exports["MR9_Concesionarios"]:StopConcesionarios()
        exports["MRFamilias"]:StopFamilias()
        exports["MR15_Discord"]:sendDiscordLogStatusServer(':orange_square: **SERVIDOR REINICIANDOSE**')


        setTimer(function() -- 24:00
            exports["MR15_Discord"]:sendDiscordLogStatusServer(':red_square: **SERVIDOR CERRADO**')
            shutdown() -- Apaga el servidor
        end, 300000, 1)
    end
-- Eventos y Handlers
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
    addEventHandler("onResourceStart", resourceRoot, function(resource)
        exports["MR15_Discord"]:sendDiscordLogStatusServer(':green_square: **SERVIDOR ABIERTO**')
        setGameType("Roleplay")
        local varRealTime = getRealTime()
        setTime(varRealTime.hour, varRealTime.minute )
        setMinuteDuration(15000)
        setFPSLimit(100)
        RestartServer()
        setServerPassword(nil)
    end)
    addCommandHandler("reinicio", RestartManualServer)
