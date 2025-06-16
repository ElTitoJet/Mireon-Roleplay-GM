--[[
    AJUSTES PRINCIPALES
]]
local dudas = {
    -- ["Nombre_Apellido"] = "Mi duda es", <--- [La tabla se forma de esta manera]
}

--[[
    COMANDOS
]]
function Crear_Duda(source, command, ...)
    local Informacion = exports["MR1_Inicio"]:getValue(source, 'Informacion')
    if not (Informacion) then
        return
    end
    local mensajeDuda = table.concat({...}, " ")
    if not (mensajeDuda) or not (#mensajeDuda > 0) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #ff9800/"..command.." [Texto]", source, 0, 0, 0, true)
    end
    if (dudas[getPlayerName(source)]) then
        return outputChatBox("#FF7800[Dudas] #e8ceb0Ya enviaste una duda, espera a que te respondan o usa #ff9800/cduda#e8ceb0.", source, 0, 0, 0, true)
    end
    dudas[getPlayerName(source)] = {}
    dudas[getPlayerName(source)] = mensajeDuda
    outputChatBox("#FF7800[Dudas] #e8ceb0Enviaste una duda, espera a que te respondan o puedes usar #ff9800/cduda #e8ceb0para cancelarla. \n#FF7800[Duda] #e8ceb0 "..mensajeDuda, source, 0, 0, 0, true)
    
    for i, player in ipairs(getElementsByType("player")) do                
        local rank = exports["MR1_Inicio"]:getValue(player, 'InfoCuenta')
        if rank and rank["Rango"] >= 3 then
            outputChatBox("#FF7800[Dudas] #e8ceb0Llego una duda de #24C5BE"..getPlayerName(source).." #e8ceb0usa #ff9800/rduda [#24C5BE"..getPlayerName(source).."#ff9800] [Respuesta#ff9800]\n#FF7800[Duda]: #e8ceb0"..mensajeDuda.."", player, 0, 0, 0, true)
        end
    end
    exports["MR15_Discord"]:sendDiscordDudaReport("Duda", getPlayerName(source), mensajeDuda)
end
addCommandHandler("duda", Crear_Duda)

function Cancelar_Duda(source, command)
    local Informacion = exports["MR1_Inicio"]:getValue(source, 'Informacion')
    if not (Informacion) then
        return
    end
    if not (dudas[getPlayerName(source)]) then
        return outputChatBox("#FF7800[Dudas] #e8ceb0No tienes ninguna duda creada.", source, 0, 0, 0, true)
    end
    
    exports["MR15_Discord"]:sendDiscordDudaReport("cDuda", getPlayerName(source), dudas[getPlayerName(source)])
    dudas[getPlayerName(source)] = nil
    if dudas[getPlayerName(source)] == nil then
        outputChatBox("#FF7800[Dudas] #e8ceb0Se canceló tu duda correctamente. ", source, 0, 0, 0, true)
        outputDebugString("#FF7800[Dudas] #e8ceb0La duda de #24C5BE"..getPlayerName(source).." #e8ceb0se canceló.")
    end
end
addCommandHandler("cduda", Cancelar_Duda)

function Ver_Dudas(source, command)
    local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
    if not (rank["Rango"] >= 3) then
        return
    end
    outputChatBox("#FF7800======[[ Dudas Pendientes ]]======", source, 0,0,0, true)
    for player, duda in pairs(dudas) do
        outputChatBox("#FF7800[#24C5BE"..player.."#FF7800] ~> #e8ceb0"..duda, source, 0, 0, 0, true)
    end
end
addCommandHandler("vdudas", Ver_Dudas)

function Responder_Duda(source, command, objetive, ...)
    local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
    if not (rank["Rango"] >= 3) then
        return
    end
    if not (objetive) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #ff9800/"..command.." [Usuario] [Texto]", source, 0, 0, 0, true)
    end
    local objetivo = getPlayerFromName(objetive)
    if not (isElement(objetivo)) then
        return outputChatBox("#A03535El jugador #24C5BE"..objetive.." #A03535no esta conectado.", source, 0,0,0, true)
    end
    if not (dudas[objetive]) then
        return outputChatBox("#A03535El jugador #24C5BE"..objetive.." #A03535no tiene ninguna duda.", source, 0,0,0, true)
    end
    local respuesta = table.concat({...}, " ")
    if not (respuesta) or not (#respuesta > 0) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #ff9800/"..command.." "..objetive.." [Texto]", source, 0, 0, 0, true)
    end
    local staff = getAccountName(getPlayerAccount(source))
    outputChatBox("#FF7800[Dudas]#e8ceb0 El staff #FF7800"..staff.."#e8ceb0 respondió tu duda. \n#FF7800[Respuesta]: #e8ceb0"..respuesta, objetivo, 0, 0, 0, true)
    outputChatBox("#FF7800[Dudas]#e8ceb0 Respondiste la duda de #24C5BE"..objetive.." \n#FF7800[Respondiste]: #e8ceb0"..respuesta, source, 0, 0, 0, true)
    --iprint(getPlayerName(objetivo), dudas[getPlayerName(objetivo)], staff, respuesta)
    exports["MR15_Discord"]:sendDiscordDudaReport("rDuda", getPlayerName(objetivo), dudas[getPlayerName(objetivo)], staff, respuesta)
    dudas[objetive] = nil
    for i, player in ipairs(getElementsByType("player")) do                
        local rank = exports["MR1_Inicio"]:getValue(player, 'InfoCuenta')
        if rank and rank["Rango"] >= 4 then
            outputChatBox("#FF7800[Dudas] #FF7800"..staff.." ["..getPlayerName(source).."]#e8ceb0 tomó la duda de "..objetive..".", player, 0, 0, 0, true)
        end
    end
end
addCommandHandler("rduda", Responder_Duda)

function eliminardudaTabla()
    if dudas[getPlayerName(source)] then
        dudas[getPlayerName(source)] = nil
    end
end
addEventHandler("onPlayerQuit", getRootElement(), eliminardudaTabla)