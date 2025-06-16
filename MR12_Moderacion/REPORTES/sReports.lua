--[[
    AJUSTES PRINCIPALES
]]
local reportes = {
    -- ["Nombre_Apellido"] = "Mi reporte es", <--- [La tabla se forma de esta manera]
}

--[[
    COMANDOS
]]
function Crear_Reporte(source, command, ...)
    local Informacion = exports["MR1_Inicio"]:getValue(source, 'Informacion')
    if not (Informacion) then
        return
    end
    local mensajeReporte = table.concat({...}, " ")
    if not (mensajeReporte) or not (#mensajeReporte > 0) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Texto]", source, 0, 0, 0, true)
    end
    if (reportes[getPlayerName(source)]) then
        return outputChatBox("#A03535[Reportes] #e8ceb0Ya enviaste un reporte, espera a que te respondan o usa #ff9800/creport#e8ceb0.", source, 0, 0, 0, true)
    end
    reportes[getPlayerName(source)] = {}
    reportes[getPlayerName(source)] = mensajeReporte
    outputChatBox("#A03535[Reportes] #e8ceb0Enviaste un reporte, espera a que te respondan o puedes usar #ff9800/creport #e8ceb0para cancelarlo. \n#A03535[Reporte]#e8ceb0 "..mensajeReporte, source, 0, 0, 0, true)
    for i, player in ipairs(getElementsByType("player")) do                
        local rank = exports["MR1_Inicio"]:getValue(player, 'InfoCuenta')
        if rank and rank["Rango"] >=3 then
            outputChatBox("#A03535[Reportes] #e8ceb0Llegó un reporte de #24C5BE"..getPlayerName(source).." #e8ceb0usa #ff9800/treport [#24C5BE"..getPlayerName(source).."#ff9800]\n#A03535[Reporte]: #e8ceb0"..mensajeReporte.."", player, 0, 0, 0, true)
        end
    end
    exports["MR15_Discord"]:sendDiscordDudaReport("Reporte", getPlayerName(source), mensajeReporte)
end
addCommandHandler("reporte", Crear_Reporte)
addCommandHandler("re", Crear_Reporte)
addCommandHandler("report", Crear_Reporte)

function Cancelar_Reporte(source, command)
    local Informacion = exports["MR1_Inicio"]:getValue(source, 'Informacion')
    if not (Informacion) then
        return
    end
    if not (reportes[getPlayerName(source)]) then
        return outputChatBox("#A03535[Reportes] #e8ceb0No tienes ningun reporte creado.", source, 0, 0, 0, true)
    end
    exports["MR15_Discord"]:sendDiscordDudaReport("cReporte", getPlayerName(source), reportes[getPlayerName(source)])

    reportes[getPlayerName(source)] = nil
    if reportes[getPlayerName(source)] == nil then
        outputChatBox("#A03535[Reportes] #e8ceb0Se canceló tu reporte correctamente. ", source, 0, 0, 0, true)
    end
end
addCommandHandler("creporte", Cancelar_Reporte)
addCommandHandler("cre", Cancelar_Reporte)
addCommandHandler("creport", Cancelar_Reporte)

function Ver_Reportes(source, command)
    local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
    if not (rank["Rango"] >=3) then
        return
    end
    outputChatBox("#A03535======[[ Reportes Pendientes ]]======", source, 0,0,0, true)
    for player, reporte in pairs(reportes) do
        outputChatBox("#A03535[#24C5BE"..player.."#A03535] ~> #e8ceb0"..reporte, source, 0, 0, 0, true)
    end
end
addCommandHandler("vreporte", Ver_Reportes)
addCommandHandler("vre", Ver_Reportes)
addCommandHandler("vreport", Ver_Reportes)

function Responder_Report(source, command, objetive)
    local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
    if not (rank["Rango"] >=3) then
        return
    end
    if not (objetive) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario]", source, 0, 0, 0, true)
    end
    local objetivo = getPlayerFromName(objetive)
    if not (isElement(objetivo)) then
        return outputChatBox("#A03535El jugador #24C5BE"..objetive.." #A03535no esta conectado.", source, 0,0,0, true)
    end
    if not (reportes[objetive]) then
        return outputChatBox("#A03535El jugador #24C5BE"..objetive.." #A03535no tiene ningun reporte.", source, 0,0,0, true)
    end
    local staff = getAccountName(getPlayerAccount(source))
    outputChatBox("#A03535[Reportes]#e8ceb0 El staff #FF7800"..staff.." ["..getPlayerName(source).."]#e8ceb0 tomo tu reporte.", objetivo, 0, 0, 0, true)
    outputChatBox("#A03535[Reportes] #e8ceb0Tomaste el reporte de #24C5BE"..objetive, source, 0, 0, 0, true)
    exports["MR15_Discord"]:sendDiscordDudaReport("rReporte", getPlayerName(objetivo), reportes[getPlayerName(objetivo)], staff)
    reportes[objetive] = nil
    for i, player in ipairs(getElementsByType("player")) do                
        local rank = exports["MR1_Inicio"]:getValue(player, 'InfoCuenta')
        if rank and rank["Rango"] >=3 then
            outputChatBox("#A03535[Reportes] #FF7800"..staff.." ["..getPlayerName(source).."]#e8ceb0 tomó el reporte de "..objetive..".", player, 0, 0, 0, true)
        end
    end
end
addCommandHandler("treport", Responder_Report)
addCommandHandler("treporte", Responder_Report)
addCommandHandler("tre", Responder_Report)

function eliminarreporteTabla()
    if reportes[getPlayerName(source)] then
        reportes[getPlayerName(source)] = nil
        if reportes[getPlayerName(source)] == nil then
			outputDebugString("[Reportes] El reporte de "..getPlayerName(source).." cancelada [JUGADOR DESCONECTADO]")
        end
    end
end
addEventHandler("onPlayerQuit", getRootElement(), eliminarreporteTabla)