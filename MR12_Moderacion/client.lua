--[[
    AJUSTES PRINCIPALES
]]
local nombreScript = "MRP11_Moderacion"
local screenW, screenH = guiGetScreenSize()

--[[
    SCRIPT START
]]
--[[
    SCRIPT EVENTS
]]
--[[
    SCRIPT FUNCTIONS
]]
function PanelDeModeracion(client)
    guiSetInputEnabled(true) -- Anula que podamos activar Binds o movernos.
    showCursor(true) -- Muestra el cursor en la pantalla.

    triggerServerEvent("PlayersBaneados", getLocalPlayer())

    -- PANEL EN GENERAL
    StaffPannel = guiCreateWindow((screenW - 440) / 2, (screenH - 439) / 2, 440, 439, "Staff Panel", false)
    guiWindowSetSizable(StaffPannel, false)
    StaffPanelButtomCerrar = guiCreateButton(131, 401, 178, 28, "Cerrar", false, StaffPannel)
    guiSetProperty(StaffPanelButtomCerrar, "NormalTextColour", "FFAAAAAA")  
    addEventHandler("onClientGUIClick", StaffPanelButtomCerrar, function()
        CerrarPanelDeModeracion()
    end, false)


    TABSStaff = guiCreateTabPanel(11, 28, 419, 366, false, StaffPannel)
    
        TabTP = guiCreateTab("TP", TABSStaff)
            TPUserList = guiCreateGridList(10, 10, 199, 322, false, TabTP)
            jugadoresTP = guiGridListAddColumn(TPUserList, "User", 0.9)

            TPUserTPLS = guiCreateButton(220, 12, 189, 44, "Llevar a LS", false, TabTP)
            guiSetProperty(TPUserList, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", TPUserTPLS, function()
                local seleccionado = guiGridListGetItemText ( TPUserList, guiGridListGetSelectedItem ( TPUserList ), 1 )
                if #seleccionado > 2 then
                    local x, y, z = 1481.22265625, -1751.8603515625, 15.4453125
                    local lugar = "Los Santos"
                    triggerServerEvent("GoToPannel", getLocalPlayer(), seleccionado, x, y, z, lugar)
                end
            end, false)

            TPUserTPSF = guiCreateButton(220, 66, 189, 44, "Llevar a SF", false, TabTP)
            guiSetProperty(TPUserTPSF, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", TPUserTPSF, function()
                local seleccionado = guiGridListGetItemText ( TPUserList, guiGridListGetSelectedItem ( TPUserList ), 1 )
                if #seleccionado > 2 then
                    local lugar = "San Fierro"
                    local x, y, z = -2764.7314453125, 375.599609375, 6.3420829772949
                    triggerServerEvent("GoToPannel", getLocalPlayer(), seleccionado, x, y, z, lugar)
                end
            end, false)

            TPUserTPLV = guiCreateButton(220, 120, 189, 44, "Llevar a LV", false, TabTP)
            guiSetProperty(TPUserTPLV, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", TPUserTPLV, function()
                local seleccionado = guiGridListGetItemText ( TPUserList, guiGridListGetSelectedItem ( TPUserList ), 1 )
                if #seleccionado > 2 then
                    local lugar = "Las Venturas"
                    local x, y, z = 2858.232421875, 1290.16015625, 11.390625
                    triggerServerEvent("GoToPannel", getLocalPlayer(), seleccionado, x, y, z, lugar)
                end
            end, false)

            TPUserTPBS = guiCreateButton(220, 174, 188, 43, "Llevar a BS", false, TabTP)
            guiSetProperty(TPUserTPBS, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", TPUserTPBS, function()
                local seleccionado = guiGridListGetItemText ( TPUserList, guiGridListGetSelectedItem ( TPUserList ), 1 )
                if #seleccionado > 2 then
                    local lugar = "Bayside"
                    local x, y, z = -2386.48828125, 2216.2529296875, 4.984375
                    triggerServerEvent("GoToPannel", getLocalPlayer(), seleccionado, x, y, z, lugar)
                end
            end, false)

            TPUserTPto = guiCreateButton(219, 227, 188, 43, "Ir usuario", false, TabTP)
            guiSetProperty(TPUserTPto, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", TPUserTPto, function()
                local seleccionado = guiGridListGetItemText ( TPUserList, guiGridListGetSelectedItem ( TPUserList ), 1 )
                if #seleccionado > 2 then
                    triggerServerEvent("GoToUserPannel", getLocalPlayer(), seleccionado, client)
                end
            end, false)

            TPUserTPhere = guiCreateButton(219, 280, 189, 44, "Traer Usuario", false, TabTP)
            guiSetProperty(TPUserTPhere, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", TPUserTPhere, function()
                local seleccionado = guiGridListGetItemText ( TPUserList, guiGridListGetSelectedItem ( TPUserList ), 1 )
                if #seleccionado > 2 then
                    triggerServerEvent("AttractTheUser", getLocalPlayer(), seleccionado, client)
                end
            end, false)

        TabMisc = guiCreateTab("Mislacenea", TABSStaff)
            MiscUserList = guiCreateGridList(10, 10, 199, 322, false, TabMisc)
            jugadoresMisc = guiGridListAddColumn(MiscUserList, "User", 0.9)
            MiscUserKillBoton = guiCreateButton(220, 12, 189, 44, "Matar user", false, TabMisc)
            guiSetProperty(MiscUserKillBoton, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", MiscUserKillBoton, function()
                local seleccionado = guiGridListGetItemText ( MiscUserList, guiGridListGetSelectedItem ( MiscUserList ), 1 )
                if #seleccionado > 2 then
                    triggerServerEvent("KillPannel", getLocalPlayer(), seleccionado)
                end
            end, false)

            MiscUserRevivirBoton = guiCreateButton(220, 66, 189, 44, "Revivir user", false, TabMisc)
            guiSetProperty(MiscUserRevivirBoton, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", MiscUserRevivirBoton, function()
                local seleccionado = guiGridListGetItemText ( MiscUserList, guiGridListGetSelectedItem ( MiscUserList ), 1 )
                if #seleccionado > 2 then
                    triggerServerEvent("RevivePannel", getLocalPlayer(), seleccionado)
                end
            end, false)

            MiscUserCurrarBoton = guiCreateButton(220, 120, 189, 44, "Curar user", false, TabMisc)
            guiSetProperty(MiscUserCurrarBoton, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", MiscUserCurrarBoton, function()
                local seleccionado = guiGridListGetItemText ( MiscUserList, guiGridListGetSelectedItem ( MiscUserList ), 1 )
                if #seleccionado > 2 then
                    triggerServerEvent("SetHealtPannel", getLocalPlayer(), seleccionado)
                end
            end, false)
            --[[
                MiscUserMotivoEdit = guiCreateEdit(220, 174, 188, 43, "Motivo", false, TabMisc)
                MiscUserDarPunto = guiCreateButton(219, 227, 188, 43, "Dar punto de rol", false, TabMisc)
                guiSetProperty(MiscUserDarPunto, "NormalTextColour", "FFAAAAAA")
                addEventHandler("onClientGUIClick", MiscUserDarPunto, function()
                    local seleccionado = guiGridListGetItemText ( MiscUserList, guiGridListGetSelectedItem ( MiscUserList ), 1 )
                    if #seleccionado > 2 then
                        local Motivo = guiGetText(MiscUserMotivoEdit)
                        if #Motivo > 2 then
                            triggerServerEvent("DarPuntoPannel", getLocalPlayer(), seleccionado, Motivo)
                        end
                    end
                end, false)

                MiscUserQuitarPunto = guiCreateButton(219, 280, 189, 44, "Quitar punto de rol", false, TabMisc)
                guiSetProperty(MiscUserQuitarPunto, "NormalTextColour", "FFAAAAAA")
                addEventHandler("onClientGUIClick", MiscUserQuitarPunto, function()
                    local seleccionado = guiGridListGetItemText ( MiscUserList, guiGridListGetSelectedItem ( MiscUserList ), 1 )
                    if #seleccionado > 2 then
                        local Motivo = guiGetText(MiscUserMotivoEdit)
                        if #Motivo > 2 then
                            triggerServerEvent("QuitarPuntoPannel", getLocalPlayer(), seleccionado, Motivo)
                        end
                    end
                end, false)
            ]]

        TabSanciones = guiCreateTab("Sanciones", TABSStaff)
            SancionesUserList = guiCreateGridList(10, 10, 199, 322, false, TabSanciones)
            jugadoresSanciones = guiGridListAddColumn(SancionesUserList, "User", 0.9)
            SancionesUserTimeEdit = guiCreateEdit(220, 12, 189, 44, "Minutos", false, TabSanciones)
            SancionesUserMotivoEdit = guiCreateEdit(220, 66, 189, 44, "Motivo", false, TabSanciones)

            SancionesUserJailOOCBoton = guiCreateButton(220, 120, 189, 44, "JailOOC User", false, TabSanciones)
            guiSetProperty(SancionesUserJailOOCBoton, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", SancionesUserJailOOCBoton, function()
                local seleccionado = guiGridListGetItemText ( SancionesUserList, guiGridListGetSelectedItem ( SancionesUserList ), 1 )
                if #seleccionado > 2 then
                    local Motivo = guiGetText(SancionesUserMotivoEdit)
                    if #Motivo > 2 then
                        local time = guiGetText(SancionesUserTimeEdit)
                        if time then
                            --local time = time * 60000
                            triggerServerEvent("JailPannel", getLocalPlayer(), seleccionado, Motivo, time)
                        end
                    end
                end
            end, false)

            SancionesUserBanBoton = guiCreateButton(220, 174, 188, 43, "BAN User \n0 = Permanente \nTiempo = Dias", false, TabSanciones)
            guiSetProperty(SancionesUserBanBoton, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", SancionesUserBanBoton, function()
                local seleccionado = guiGridListGetItemText ( SancionesUserList, guiGridListGetSelectedItem ( SancionesUserList ), 1 )
                if #seleccionado > 2 then
                    local Motivo = guiGetText(SancionesUserMotivoEdit)
                    if #Motivo > 2 then
                        local time = guiGetText(SancionesUserTimeEdit)
                        if time then
                            local time = time * 24 * 60 * 60
                            triggerServerEvent("BanPannel", getLocalPlayer(), seleccionado, Motivo, time)
                        end
                    end
                end
            end, false)

            SancionesUserKick = guiCreateButton(219, 227, 188, 43, "Kick", false, TabSanciones)
            addEventHandler("onClientGUIClick", SancionesUserKick, function()
                local seleccionado = guiGridListGetItemText ( SancionesUserList, guiGridListGetSelectedItem ( SancionesUserList ), 1 )
                if #seleccionado > 2 then
                    local Motivo = guiGetText(SancionesUserMotivoEdit)
                    if #Motivo > 2 then
                        triggerServerEvent("KickPannel", getLocalPlayer(), seleccionado, Motivo)
                    end
                end
            end, false)


            

        TabBans = guiCreateTab("Bans", TABSStaff)
            BansUserList = guiCreateGridList(10, 10, 399, 260, false, TabBans)
            BanUser = guiGridListAddColumn(BansUserList, "Account", 0.2)
            BanStaff = guiGridListAddColumn(BansUserList, "Staff", 0.2)
            BanUnTime = guiGridListAddColumn(BansUserList, "Tiempo UnBan", 0.2)
            BanMotivo = guiGridListAddColumn(BansUserList, "Motivo", 0.2)

            BansUserUnBanBoton = guiCreateButton(115, 280, 189, 44, "Desbanear User", false, TabBans)
            guiSetProperty(BansUserUnBanBoton, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", BansUserUnBanBoton, function()
                local seleccionado = guiGridListGetItemText ( BansUserList, guiGridListGetSelectedItem ( BansUserList ), 1 )
                if #seleccionado > 2 then
                    triggerServerEvent("UnBanPannel", getLocalPlayer(), seleccionado)
                end
            end, false)

        TabVehiculos = guiCreateTab("Vehiculos", TABSStaff)
            VehList = guiCreateGridList(10, 10, 399, 260, false, TabVehiculos)
            Matricula = guiGridListAddColumn(VehList, "Matricula", 0.2)
            Modelo = guiGridListAddColumn(VehList, "Modelo", 0.2)
            Salud = guiGridListAddColumn(VehList, "Salud", 0.2)
            Conductor = guiGridListAddColumn(VehList, "Conductor", 0.2)
            VehsReparar = guiCreateButton(10, 280, 126, 44, "RepararVeh", false, TabVehiculos)
            guiSetProperty(VehsReparar, "NormalTextColour", "FFAAAAAA")
            VehsTraer = guiCreateButton(147, 280, 126, 44, "Traer Veh", false, TabVehiculos)
            guiSetProperty(VehsTraer, "NormalTextColour", "FFAAAAAA")
            VehsDesaparecer = guiCreateButton(283, 280, 126, 44, "Desaparecer", false, TabVehiculos)
            guiSetProperty(VehsDesaparecer, "NormalTextColour", "FFAAAAAA")
            for index, veh in ipairs(getElementsByType("vehicle")) do
                data = getElementData(veh, "roleplay:vehiculo:dueño")
                if data and data ~= "Estado" then
                    row = guiGridListAddRow(VehList)
                    mat = getVehiclePlateText(veh)
                    mod = getVehicleNameFromModel(getElementModel(veh))
                    hp = getElementHealth(veh)
                    guiGridListSetItemText(VehList, row, 1, mat, false, false)
                    guiGridListSetItemText(VehList, row, 2, mod, false, false)
                    guiGridListSetItemText(VehList, row, 3, hp, false, false)
                    guiGridListSetItemText(VehList, row, 4, data, false, false)
                end
            end
            addEventHandler("onClientGUIClick", VehsReparar, function()
                local seleccionado = guiGridListGetItemText ( VehList, guiGridListGetSelectedItem ( VehList ), 1 )
                if #seleccionado > 2 then
                    triggerServerEvent("RepararVehiculo", getLocalPlayer(), seleccionado)
                end
            end, false)
            addEventHandler("onClientGUIClick", VehsTraer, function()
                local seleccionado = guiGridListGetItemText ( VehList, guiGridListGetSelectedItem ( VehList ), 1 )
                if #seleccionado > 2 then
                    triggerServerEvent("TraerVehiculo", getLocalPlayer(), seleccionado, Motivo)
                end
            end, false)
            addEventHandler("onClientGUIClick", VehsDesaparecer, function()
                local seleccionado = guiGridListGetItemText ( VehList, guiGridListGetSelectedItem ( VehList ), 1 )
                if #seleccionado > 2 then
                    triggerServerEvent("DesaparecerVehiculo", getLocalPlayer(), seleccionado, Motivo)
                end
            end, false)

    for players , player in ipairs(getElementsByType("player")) do -- Obtenemos una lista de TODOS los jugadores
        local fila = guiGridListAddRow(TPUserList)
        local fila2 = guiGridListAddRow(MiscUserList)
        local fila3 = guiGridListAddRow(SancionesUserList)
        local nombres = getPlayerName(player)
        guiGridListSetItemText(TPUserList, fila, jugadoresTP, nombres, false, false)
        guiGridListSetItemText(MiscUserList, fila2, jugadoresMisc, nombres, false, false)
        guiGridListSetItemText(SancionesUserList, fila3, jugadoresSanciones, nombres, false, false)
    end
end
addEvent("PanelStaff", true)
addEventHandler("PanelStaff", getLocalPlayer(), PanelDeModeracion)

function CerrarPanelDeModeracion()
    guiSetInputEnabled(false) -- Anula que podamos activar Binds o movernos.
    showCursor(false) -- Muestra el cursor en la pantalla.
    guiSetVisible(StaffPannel, false)
end

function ClientActualizarBans(nick, banner, reason, time)
    local fila = guiGridListAddRow(BansUserList)
    --local timed = time / 60
    guiGridListSetItemText(BansUserList, fila, BanUser, nick, false, false)
    guiGridListSetItemText(BansUserList, fila, BanStaff, banner, false, false)
    guiGridListSetItemText(BansUserList, fila, BanMotivo, reason, false, false)
    guiGridListSetItemText(BansUserList, fila, BanUnTime, time, false, false)
end
addEvent("ClientActualizarBans", true)
addEventHandler("ClientActualizarBans", getLocalPlayer(), ClientActualizarBans)

function ClientActualizarVehs(veh)
    placa = getVehiclePlateText(veh)
    model = getVehicleName(veh)
    heal = getElementHealth(veh)
    driver = getVehicleOccupant(veh, 0)

    local fila = guiGridListAddRow(VehList)
    guiGridListSetItemText(VehList, fila, Matricula, placa, false, false)
    guiGridListSetItemText(VehList, fila, Modelo, model, false, false)
    guiGridListSetItemText(VehList, fila, Salud, heal, false, false)
    guiGridListSetItemText(VehList, fila, Conductor, driver, false, false)
end

