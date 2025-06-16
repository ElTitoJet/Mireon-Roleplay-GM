local screenW, screenH = guiGetScreenSize()
-- PANEL ARMERIA
    PannelLSPDArmeria = guiCreateWindow((screenW - 435) / 2, (screenH - 227) / 2, 435, 227, "ARMERIA", false)
        guiWindowSetSizable(PannelLSPDArmeria, false)
        guiWindowSetMovable(PannelLSPDArmeria, false)
        guiSetVisible(PannelLSPDArmeria, false)
        BotonLSPDPorra = guiCreateButton(10, 30, 95, 39, "Porra", false, PannelLSPDArmeria)
            guiSetProperty(BotonLSPDPorra, "NormalTextColour", "FFAAAAAA")
        BotonLSPD9mm = guiCreateButton(115, 30, 95, 39, "9mm", false, PannelLSPDArmeria)
            guiSetProperty(BotonLSPD9mm, "NormalTextColour", "FFAAAAAA")
        BotonLSPDDK = guiCreateButton(220, 30, 95, 39, "Deagle", false, PannelLSPDArmeria)
            guiSetProperty(BotonLSPDDK, "NormalTextColour", "FFAAAAAA")
        --BotonLSPDTaser = guiCreateButton(325, 30, 95, 39, "Taser", false, PannelLSPDArmeria)
        --    guiSetProperty(BotonLSPDTaser, "NormalTextColour", "FFAAAAAA")
        BotonLSPDEscopeta = guiCreateButton(10, 79, 95, 39, "Escopeta", false, PannelLSPDArmeria)
            guiSetProperty(BotonLSPDEscopeta, "NormalTextColour", "FFAAAAAA")
        BotonLSPDEscopetaCombate = guiCreateButton(115, 79, 95, 39, "Escopeta de combate", false, PannelLSPDArmeria)
            guiSetProperty(BotonLSPDEscopetaCombate, "NormalTextColour", "FFAAAAAA")
        BotonLSPDMP5 = guiCreateButton(220, 79, 95, 39, "MP5", false, PannelLSPDArmeria)
            guiSetProperty(BotonLSPDMP5, "NormalTextColour", "FFAAAAAA")
        BotonLSPDM4 = guiCreateButton(325, 79, 95, 39, "M4", false, PannelLSPDArmeria)
            guiSetProperty(BotonLSPDM4, "NormalTextColour", "FFAAAAAA")
        BotonLSPDSniper = guiCreateButton(10, 128, 95, 39, "Sniper", false, PannelLSPDArmeria)
            guiSetProperty(BotonLSPDSniper, "NormalTextColour", "FFAAAAAA")
        BotonLSPDGas = guiCreateButton(115, 128, 95, 39, "Granada de Gas", false, PannelLSPDArmeria)
            guiSetProperty(BotonLSPDGas, "NormalTextColour", "FFAAAAAA")
        BotonLSPDChaleco = guiCreateButton(220, 128, 95, 39, "Chaleco", false, PannelLSPDArmeria)
            guiSetProperty(BotonLSPDChaleco, "NormalTextColour", "FFAAAAAA")
            Paracaidas = guiCreateButton(325, 128, 95, 39, "Paracaidas", false, PannelLSPDArmeria)
            guiSetProperty(Paracaidas, "NormalTextColour", "FFAAAAAA")
        BotonLSPDCerrar = guiCreateButton(168, 177, 95, 39, "Cerrar", false, PannelLSPDArmeria)
            guiSetProperty(BotonLSPDCerrar, "NormalTextColour", "FFAAAAAA")   

-- PANEL COMISARIA
    PannelLSPDComi = guiCreateWindow((screenW - 382) / 2, (screenH - 514) / 2, 382, 514, "Comisaria de Los Santos", false)
        guiWindowSetSizable(PannelLSPDComi, false)
        guiWindowSetMovable(PannelLSPDComi, false)
        guiSetVisible(PannelLSPDComi, false)
            
        ListaOpciones = guiCreateGridList(10, 26, 361, 411, false, PannelLSPDComi)
            guiGridListAddColumn(ListaOpciones, "¿En que podemos ayudarte?", 0.9)
                guiGridListAddRow(ListaOpciones)
                guiGridListSetItemText(ListaOpciones, 0, 1, "¿Como me uno a la LSPD?", false, false)
                guiGridListAddRow(ListaOpciones)
                guiGridListSetItemText(ListaOpciones, 1, 1, "Quiero sacar la licencia de armas. (10.000$)", false, false)
                guiGridListAddRow(ListaOpciones)
                guiGridListSetItemText(ListaOpciones, 2, 1, "Quiero pagar una multa.", false, false)
        ComiBotonAccion = guiCreateButton(10, 452, 137, 43, "Accionar", false, PannelLSPDComi)
            guiSetProperty(ComiBotonAccion, "NormalTextColour", "FFAAAAAA")
        ComiBotonCerrar = guiCreateButton(234, 452, 137, 43, "Cerrar", false, PannelLSPDComi)
            guiSetProperty(ComiBotonCerrar, "NormalTextColour", "FFAAAAAA")    
-- PANEL MULTAS
    LSPDPanelMultas = guiCreateWindow((screenW - 487) / 2, (screenH - 694) / 2, 487, 694, "Multas", false)
        guiWindowSetSizable(LSPDPanelMultas, false)
        guiWindowSetMovable(LSPDPanelMultas, false)
        guiSetVisible(LSPDPanelMultas, false)
        LSPDPanelMultasLista = guiCreateGridList(11, 28, 466, 576, false, LSPDPanelMultas)
            guiGridListAddColumn(LSPDPanelMultasLista, "ID", 0.1)
            guiGridListAddColumn(LSPDPanelMultasLista, "LSPD", 0.3)
            guiGridListAddColumn(LSPDPanelMultasLista, "Multa", 0.2)
            guiGridListAddColumn(LSPDPanelMultasLista, "Motivos", 0.2)
        LSPDPanelMultasBotonPagar = guiCreateButton(10, 620, 167, 51, "Pagar Multa", false, LSPDPanelMultas)
            guiSetProperty(LSPDPanelMultasBotonPagar, "NormalTextColour", "FFAAAAAA")
        LSPDPanelMultasBotonCerrar = guiCreateButton(310, 620, 167, 51, "Cerrar Panel", false, LSPDPanelMultas)
            guiSetProperty(LSPDPanelMultasBotonCerrar, "NormalTextColour", "FFAAAAAA")    


        
-- TABLAS
local Licenciero = {
    [1] = {249.5, 67.5, 1003.5, 6, 0}
}
local pickupsStreaming = {}
addEventHandler( "onClientGUIClick", getRootElement(), function(b,s)
    if not (b == 'left' and s == 'up') then
        return
    end
    
    local varTrabajoClient = exports["MR1_Inicio"]:getValue(localPlayer, 'Trabajos')
    -- PANEL ARMERIA
    if source == BotonLSPDCerrar then
        guiSetVisible(PannelLSPDArmeria, false)
        showCursor(false)
    elseif source == BotonLSPDPorra then
        if varTrabajoClient.Rango >= 1 then
            triggerServerEvent("WeaponLSPD", localPlayer, 3, 1)
        end
    elseif source == BotonLSPD9mm then
        if varTrabajoClient.Rango >= 1 then
            triggerServerEvent("WeaponLSPD", localPlayer, 22, 51)
        end
    elseif source == BotonLSPDDK then
        if varTrabajoClient.Rango >= 1 then
            triggerServerEvent("WeaponLSPD", localPlayer, 24, 21)
        end
    elseif source == BotonLSPDTaser then
        if varTrabajoClient.Rango >= 1 then
            triggerServerEvent("WeaponLSPD", localPlayer, 23, 5)
        end
    elseif source == BotonLSPDEscopeta then
        if varTrabajoClient.Rango >= 2 then
            triggerServerEvent("WeaponLSPD", localPlayer, 25, 20)
        end
    elseif source == BotonLSPDEscopetaCombate then
        if varTrabajoClient.Rango >= 8 then
            triggerServerEvent("WeaponLSPD", localPlayer, 27, 21)
        end
    elseif source == BotonLSPDMP5 then
        if varTrabajoClient.Rango >= 3 then
            triggerServerEvent("WeaponLSPD", localPlayer, 29, 90)
        end
    elseif source == BotonLSPDM4 then
        if varTrabajoClient.Rango >= 4 then
            triggerServerEvent("WeaponLSPD", localPlayer, 31, 150)
        end
    elseif source == BotonLSPDSniper then
        if varTrabajoClient.Rango >= 5 then
            triggerServerEvent("WeaponLSPD", localPlayer, 34, 20)
        end
    elseif source == BotonLSPDGas then
        if varTrabajoClient.Rango >= 4 then
            triggerServerEvent("WeaponLSPD", localPlayer, 17, 10)
        end
    elseif source == BotonLSPDChaleco then
        if varTrabajoClient.Rango >= 1 then
            triggerServerEvent("ChalecoLSPD", localPlayer)
        end
    elseif source == Paracaidas then
        if varTrabajoClient.Rango >= 1 then
            triggerServerEvent("WeaponLSPD", localPlayer, 46, 1)
        end
    -- PANEL COMI
    elseif source == ComiBotonAccion then
        local selectedRow = guiGridListGetSelectedItem(ListaOpciones)
        local seleccionado = guiGridListGetItemText ( ListaOpciones, guiGridListGetSelectedItem ( ListaOpciones ), 1 )
        if selectedRow ~= -1 then
            -- Obtener el texto de la fila seleccionada
            local selectedText = guiGridListGetItemText(ListaOpciones, selectedRow, 1)
            
            -- Responder en función de la fila seleccionada
            if selectedText == "¿Como me uno a la LSPD?" then
                outputChatBox("#9AA498[#0058ffLSPD#9AA498] #53B440Visita nuestra web para poder postular al cuerpo.", 255, 255, 255, true)
                outputChatBox("#00BFFF((OOC)) "..getPlayerName(localPlayer).."#00BFFF: https://foros.mireonroleplay.site/",255,255,255, true)
        
            elseif selectedText == "Quiero sacar la licencia de armas. (10.000$)" then
                local informacion_localPlayer = exports["MR1_Inicio"]:getValueOne(localPlayer)

                if not (informacion_localPlayer.Inventario["Dinero"] >= 10000) then
                    return outputChatBox("#ffe100No tengo los "..formatNumber(PrecioVeh).." dolares de la licencia...", 255, 255, 255, true) 
                end 
                triggerServerEvent("Panel::LSPD::Comisaria::Informacion::Licencia", localPlayer)
            elseif selectedText == "Quiero pagar una multa." then
                guiSetVisible(PannelLSPDComi, false)
                guiSetVisible(LSPDPanelMultas, true)
                
                triggerServerEvent("Panel::LSPD::Comisaria::Multas::Abrir", localPlayer)
            else
                outputChatBox("Opción no reconocida.")
            end
        else
            -- Si no hay fila seleccionada, mostrar un mensaje de error
            outputChatBox("Por favor, selecciona una opción antes de presionar 'Accionar'.")
        end
    elseif source == ComiBotonCerrar then
        guiSetVisible(PannelLSPDComi, false)
        showCursor(false)
    -- PANEL MULTAS
    elseif source == LSPDPanelMultasBotonPagar then
        local seleccionado = guiGridListGetItemText ( LSPDPanelMultasLista, guiGridListGetSelectedItem ( LSPDPanelMultasLista ), 1 )
        if not (#seleccionado >= 1) then
            return outputChatBox ( "#9AA498[#0058ffLSPD#9AA498] #53B440Selecciona una multa.", 255, 255, 255, true )
        end
        triggerServerEvent("Panel::LSPD::Comisaria::Multas::Pagar", localPlayer, seleccionado)
        
        triggerServerEvent("Panel::LSPD::Comisaria::Multas::Abrir", localPlayer)
    elseif source == LSPDPanelMultasBotonCerrar then
        guiSetVisible(LSPDPanelMultas, false)
        showCursor(false)
    end
end)

function VestuarioLSPD()

    local x, y, z = 258.2626953125, 78.451171875, 1003.640625
    local x2, y2, z2 = getCameraMatrix()
    local distance = 8
    local height = 0.5
    local size = 2
    local text = "#53B440[Vestuario] #FFFFFF\n Pulsa #24C5BEH #FFFFFFpara cambiarte la ropa."
    if (isLineOfSightClear(x, y, z+2, x2, y2, z2)) then
        local sx, sy = getScreenFromWorldPosition(x, y, z+height)
        if(sx) and (sy) then
            local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
            if(distanceBetweenPoints < distance) then
                dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center", false, false, false, true)
            end
        end
    end
end
addEventHandler("onClientRender", root, VestuarioLSPD)

function ArmeriaLSPD()
    local x, y, z = 224, 76, 1005
    local x2, y2, z2 = getCameraMatrix()
    local distance = 8
    local height = 0.5
    local size = 2
    local text = "#53B440[Armeria] #FFFFFF\n Pulsa #24C5BEH #FFFFFFpara obtener tus armas reglamentarias."
    if (isLineOfSightClear(x, y, z+2, x2, y2, z2)) then
        local sx, sy = getScreenFromWorldPosition(x, y, z+height)
        if(sx) and (sy) then
            local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
            if(distanceBetweenPoints < distance) then
                dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center", false, false, false, true)
            end
        end
    end
end
addEventHandler("onClientRender", root, ArmeriaLSPD)

function OnDutyLSPD()
    local x, y, z = 253.583984375, 77.0927734375, 1003.640625
    local x2, y2, z2 = getCameraMatrix()
    local distance = 8
    local height = 0.5
    local size = 2
    local text = "#53B440[Trabajar] #FFFFFF\n Pulsa #24C5BEH #FFFFFFpara ponerte de servicio."
    if (isLineOfSightClear(x, y, z+2, x2, y2, z2)) then
        local sx, sy = getScreenFromWorldPosition(x, y, z+height)
        if(sx) and (sy) then
            local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
            if(distanceBetweenPoints < distance) then
                dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center", false, false, false, true)
            end
        end
    end
end
addEventHandler("onClientRender", root, OnDutyLSPD)

function PanelArmeriaLSPD()
    --print("Abriendo armeria")
    if not guiGetVisible(PannelLSPDArmeria) then
        outputChatBox("#9AA498[#0058ffLSPD#9AA498] #53B440Abriendo armeria.", 255, 255, 255, true )
        showCursor(true)
        guiSetVisible(PannelLSPDArmeria, true)
    end
end
addEvent("PanelArmeriaLSPD", true)
addEventHandler("PanelArmeriaLSPD", localPlayer, PanelArmeriaLSPD)

addEvent("CloseGUIArmeria", true)
addEventHandler("CloseGUIArmeria", localPlayer, function()   
    if ( guiGetVisible ( PannelLSPDArmeria ) == true ) then
        destroyElement(PannelLSPDArmeria)
    end
end)

addEvent("llamadoEmergencia:LSPD", true)
addEventHandler("llamadoEmergencia:LSPD", localPlayer, function(x, y, z)   
    local blip = createBlip(x, y, z, 58, 2, 255, 0, 0, 255, 0, 65535)
	setTimer ( function()
        destroyElement(blip)
	end, 60000, 1 )
end)

function BasuraLSPD()
    local x, y, z = 261.6337890625, 71.0888671875, 1003.2421875
    local x2, y2, z2 = getCameraMatrix()
    local distance = 8
    local height = 0.5
    local size = 2
    local text = "#53B440[BasuraPD] #FFFFFF\n Pulsa #24C5BEH #FFFFFFpara tirar TODAS las armas."
    if (isLineOfSightClear(x, y, z+2, x2, y2, z2)) then
        local sx, sy = getScreenFromWorldPosition(x, y, z+height)
        if(sx) and (sy) then
            local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
            if(distanceBetweenPoints < distance) then
                dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center", false, false, false, true)
            end
        end
    end
end
addEventHandler("onClientRender", root, BasuraLSPD)

function elementStreamInOut()
    if not (getElementType(source) ~= "player") then
        return
    end
    if eventName:find("In") then
        if getElementType(source) == 'pickup' then
            local x,y,z = getElementPosition(source)
            for i, v in ipairs(Licenciero) do
                if getDistanceBetweenPoints3D(x,y,z, unpack(v)) <= 1 then
                    pickupsStreaming[source] = exports["MR1_Inicio"]:createText3D("#FFFFFF\n Presiona #24C5BEH #FFFFFFpara ver la informacion.", x, y, z+1, 2, "bankgothic", -1, false, false, true)
                end
            end
        end
    else
        if isElement(pickupsStreaming[source]) then
            destroyElement(pickupsStreaming[source])
        end
    end
end
addEventHandler( "onClientElementStreamIn", getRootElement(), elementStreamInOut)
addEventHandler( "onClientElementStreamOut", getRootElement(), elementStreamInOut)

function PanelInfoOpen()
    if not guiGetVisible(PannelLSPDComi) then
        outputChatBox("#9AA498[#0058ffLSPD#9AA498] #53B440Abriendo informacion.", 255, 255, 255, true )
        showCursor(true)
        guiSetVisible(PannelLSPDComi, true)
    end
end
addEvent("Panel::LSPD::Comisaria::Informacion::Abrir", true)
addEventHandler("Panel::LSPD::Comisaria::Informacion::Abrir", localPlayer, PanelInfoOpen)

function ListarMultas(Multas)
    guiGridListClear(LSPDPanelMultasLista)
    for _, multa in ipairs(Multas) do
        local row = guiGridListAddRow(LSPDPanelMultasLista)
        guiGridListSetItemText(LSPDPanelMultasLista, row, 1, tostring(multa.ID), false, false)
        guiGridListSetItemText(LSPDPanelMultasLista, row, 2, tostring(multa.IDLSPD), false, false)
        guiGridListSetItemText(LSPDPanelMultasLista, row, 3, tostring(multa.PRECIO), false, false)
        guiGridListSetItemText(LSPDPanelMultasLista, row, 4, multa.MOTIVO, false, false)
    end
end
addEvent("Panel::LSPD::Comisaria::Multas::Listar", true)
addEventHandler("Panel::LSPD::Comisaria::Multas::Listar", localPlayer, ListarMultas)


function verMultas(Nombre)
    if not guiGetVisible(LSPDPanelMultas) then
        outputChatBox("#9AA498[#0058ffLSPD#9AA498] #53B440Viendo multas acumuladas.", 255, 255, 255, true )
        showCursor(true)
        guiSetVisible(LSPDPanelMultas, true)
        guiSetText(LSPDPanelMultas, "Multas de "..Nombre.."")
        guiSetVisible(LSPDPanelMultasBotonPagar, false)
    end
end
addEvent("Panel::LSPD::Comisaria::Multas::Ver", true)
addEventHandler("Panel::LSPD::Comisaria::Multas::Ver", localPlayer, verMultas)