local TopDay = 0  -- Máximo de jugadores en un día
local count = 0  -- Contador de jugadores actuales

function ContarJugadores()
    local varPlayersON = getElementsByType("player")
    count = 0 -- Reiniciar el contador para evitar acumulación

    for _, player in ipairs(varPlayersON) do
        local varDataPlayer = exports["MR1_Inicio"]:getValueOne(player)
        if varDataPlayer and varDataPlayer.Informacion then
            count = count + 1
        end
    end

    -- Comprobar si ya existe un registro para el día
    local fechaActual = os.date("%Y-%m-%d")
    local resultado = exports["MR1_Inicio"]:query("SELECT * FROM UsersTop WHERE Fecha = ?", fechaActual)

    -- Si no hay registro, insertar uno nuevo y establecer TopDay
    if not resultado or #resultado == 0 then
        exports["MR1_Inicio"]:execute("INSERT INTO UsersTop (Fecha, MaximoJugadores) VALUES (?, ?)", fechaActual, count)
        TopDay = count  -- Actualizar TopDay en caso de ser el primer registro del día
    else
        -- Actualizar el máximo si es mayor que el registrado
        if count > resultado[1].MaximoJugadores then
            exports["MR1_Inicio"]:execute("UPDATE UsersTop SET MaximoJugadores = ? WHERE Fecha = ?", count, fechaActual)
            TopDay = count  -- Actualizar TopDay con el nuevo máximo
        else
            TopDay = resultado[1].MaximoJugadores  -- Mantener el máximo registrado
        end
    end
end

function mostrarJugadoresConectados()
    ContarJugadores()  -- Asegurarse de contar antes de mostrar

    -- Obtener el máximo histórico de la tabla UsersTop
    local resultadoHistorico = exports["MR1_Inicio"]:query("SELECT MAX(MaximoJugadores) as MaximoHistorico FROM UsersTop")
    local maximoHistorico = 0

    if resultadoHistorico and resultadoHistorico[1].MaximoHistorico then
        maximoHistorico = resultadoHistorico[1].MaximoHistorico
    end

    -- Mostrar en el chat la cantidad de jugadores actuales, el máximo del día y el máximo histórico
    outputChatBox("[Servidor] Jugadores conectados: " .. count, root, 255, 255, 255, true)
    outputChatBox("[Servidor] Máximo de jugadores conectados hoy: " .. TopDay, root, 255, 255, 255, true)
    outputChatBox("[Servidor] Máximo histórico de jugadores conectados: " .. maximoHistorico, root, 255, 255, 255, true)
    
    exports["MR15_Discord"]:sendDiscordTopPlayers(count, TopDay, maximoHistorico)
end


-- Establecer un temporizador para que se ejecute cada hora (3600000 ms = 1 hora)
setTimer(mostrarJugadoresConectados, 3600000, 0)

-- También mostrar el mensaje inmediatamente al iniciar el recurso
addEventHandler("onResourceStart", resourceRoot, mostrarJugadoresConectados)
addEventHandler("onPlayerJoin", root, ContarJugadores)

addCommandHandler("usersTop", function(source, command) 
    ContarJugadores()  -- Asegurarse de contar antes de mostrar

    -- Obtener el máximo histórico de la tabla UsersTop
    local resultadoHistorico = exports["MR1_Inicio"]:query("SELECT MAX(MaximoJugadores) as MaximoHistorico FROM UsersTop")
    local maximoHistorico = 0

    if resultadoHistorico and resultadoHistorico[1].MaximoHistorico then
        maximoHistorico = resultadoHistorico[1].MaximoHistorico
    end

    -- Mostrar en el chat la cantidad de jugadores actuales, el máximo del día y el máximo histórico
    outputChatBox("[Servidor] Jugadores conectados: " .. count, source, 255, 255, 255, true)
    outputChatBox("[Servidor] Máximo de jugadores conectados hoy: " .. TopDay, source, 255, 255, 255, true)
    outputChatBox("[Servidor] Máximo histórico de jugadores conectados: " .. maximoHistorico, source, 255, 255, 255, true)
    exports["MR15_Discord"]:sendDiscordTopPlayers(count, TopDay, maximoHistorico)
end)