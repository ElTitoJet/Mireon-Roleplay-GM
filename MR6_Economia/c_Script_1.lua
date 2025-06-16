-- MR6_Economia
-- Gestiona el sistema de Economia
-- Autor: ElTitoJet
-- Fecha: 01/03/2024

-- Variables Globales y Configuración
    local screenW, screenH = guiGetScreenSize()
    PanelCajero = guiCreateWindow((screenW - 287) / 2, (screenH - 195) / 2, 287, 195, "Cajero Automatico", false)
        guiWindowSetMovable(PanelCajero, false)
        guiWindowSetSizable(PanelCajero, false)
        guiSetVisible(PanelCajero, false)

        BotonRetirar = guiCreateButton(184, 36, 93, 26, "Retirar", false, PanelCajero)
            guiSetProperty(BotonRetirar, "NormalTextColour", "FFAAAAAA")
        BotonDepositar = guiCreateButton(184, 72, 93, 26, "Depositar", false, PanelCajero)
            guiSetProperty(BotonDepositar, "NormalTextColour", "FFAAAAAA")
        BotonTransferir = guiCreateButton(184, 108, 93, 26, "Transferir", false, PanelCajero)
            guiSetProperty(BotonTransferir, "NormalTextColour", "FFAAAAAA")
        BotonCerrar = guiCreateButton(13, 144, 93, 26, "Cerrar", false, PanelCajero)
            guiSetProperty(BotonCerrar, "NormalTextColour", "FFAAAAAA") 
        Label = guiCreateLabel(13, 36, 137, 98, "Bienvenid@\n\nTienes:\n0 $", false, PanelCajero)
        BotonTest= guiCreateButton(184, 144, 93, 26, "......", false, PanelCajero)
            guiSetProperty(BotonTest, "NormalTextColour", "FFAAAAAA") 
    PanelRetiros = guiCreateWindow((screenW - 230) / 2, (screenH - 194) / 2, 230, 194, "Cajero Automatico - Retirar", false)
        guiWindowSetSizable(PanelRetiros, false)
        guiSetVisible(PanelRetiros, false)

        Boton1 = guiCreateButton(10, 24, 99, 32, "1", false, PanelRetiros)
            guiSetProperty(Boton1, "NormalTextColour", "FFAAAAAA")
        Boton10 = guiCreateButton(10, 66, 99, 32, "100", false, PanelRetiros)
            guiSetProperty(Boton10, "NormalTextColour", "FFAAAAAA")
        Boton100 = guiCreateButton(10, 108, 99, 32, "1.000", false, PanelRetiros)
            guiSetProperty(Boton100, "NormalTextColour", "FFAAAAAA")
        Boton1000 = guiCreateButton(119, 24, 99, 32, "10.000", false, PanelRetiros)
            guiSetProperty(Boton1000, "NormalTextColour", "FFAAAAAA")
        Boton10000 = guiCreateButton(119, 66, 99, 32, "100.000", false, PanelRetiros)
            guiSetProperty(Boton10000, "NormalTextColour", "FFAAAAAA")
        Boton100000 = guiCreateButton(119, 108, 99, 32, "Todo", false, PanelRetiros)
            guiSetProperty(Boton100000, "NormalTextColour", "FFAAAAAA")
        BotonAtras = guiCreateButton(63, 150, 99, 32, "Atras", false, PanelRetiros)
            guiSetProperty(BotonAtras, "NormalTextColour", "FFAAAAAA")

    PanelDeposito = guiCreateWindow((screenW - 230) / 2, (screenH - 194) / 2, 230, 194, "Cajero Automatico - Depositar", false)
        guiWindowSetSizable(PanelDeposito, false)
        guiSetVisible(PanelDeposito, false)

        Boton1d = guiCreateButton(10, 24, 99, 32, "1", false, PanelDeposito)
            guiSetProperty(Boton1d, "NormalTextColour", "FFAAAAAA")
        Boton10d = guiCreateButton(10, 66, 99, 32, "100", false, PanelDeposito)
            guiSetProperty(Boton10d, "NormalTextColour", "FFAAAAAA")
        Boton100d = guiCreateButton(10, 108, 99, 32, "1.000", false, PanelDeposito)
            guiSetProperty(Boton100d, "NormalTextColour", "FFAAAAAA")
        Boton1000d = guiCreateButton(119, 24, 99, 32, "10.000", false, PanelDeposito)
            guiSetProperty(Boton1000d, "NormalTextColour", "FFAAAAAA")
        Boton10000d = guiCreateButton(119, 66, 99, 32, "100.000", false, PanelDeposito)
            guiSetProperty(Boton10000d, "NormalTextColour", "FFAAAAAA")
        Boton100000d = guiCreateButton(119, 108, 99, 32, "Todo", false, PanelDeposito)
            guiSetProperty(Boton100000d, "NormalTextColour", "FFAAAAAA")
        BotonAtrasd = guiCreateButton(63, 150, 99, 32, "Atras", false, PanelDeposito)
            guiSetProperty(BotonAtrasd, "NormalTextColour", "FFAAAAAA") 
-- Funciones Auxiliares
    function formatNumber(n)
        local formatted = n
        while true do  
            formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
            if (k==0) then
                break
            end
        end
        return formatted
    end
-- Funciones Principales
    function PanelATM()
        if (guiGetVisible(PanelCajero)) then
            return
        end
        outputChatBox("#9AA498[#FF7800ATM#9AA498] #53B440Abriendo cajero.", 255, 255, 255, true )
        showCursor(true)
        guiSetVisible(PanelCajero, true)
        update = setTimer ( function()
            if not (guiGetVisible(Label)) then
                return
            end
            local informacion_localPlayer = exports["MR1_Inicio"]:getValueOne(localPlayer)
            if not (informacion_localPlayer) or not (informacion_localPlayer.Informacion) then
                showCursor(false)
                guiSetVisible(PanelCajero, false)
                return
            end
            guiSetText(Label, "Bienvenid@\n\nTienes:\n"..formatNumber(informacion_localPlayer.Informacion["Banco"]).." $")
        end, 100, 0 )
    end
-- Eventos y Handlers
    addEventHandler( "onClientGUIClick", getRootElement(),
        function(b,s)
            if not (b == 'left' and s == 'up') then
                return
            end
            
            if source == BotonCerrar then

                if update and isTimer( update ) then
                    killTimer( update )
                end

                guiSetVisible(PanelCajero, false)
                outputChatBox("#9AA498[#FF7800ATM#9AA498] #53B440Cerrando cajero.", 255, 255, 255, true )
                showCursor(false)

            elseif source == BotonRetirar then

                guiSetVisible(PanelCajero, false)
                guiSetVisible(PanelRetiros, true)

            elseif source == BotonAtras then

                guiSetVisible(PanelCajero, true)
                guiSetVisible(PanelRetiros, false)

            elseif source == BotonDepositar then

                guiSetVisible(PanelCajero, false)
                guiSetVisible(PanelDeposito, true)

            elseif source == BotonAtrasd then

                guiSetVisible(PanelCajero, true)
                guiSetVisible(PanelDeposito, false)

            elseif source == Boton1d then

                triggerServerEvent('GuardarDinero', localPlayer, 1)
            elseif source == Boton10d then

                triggerServerEvent('GuardarDinero', localPlayer, 100)
            elseif source == Boton100d then

                triggerServerEvent('GuardarDinero', localPlayer, 1000)
            elseif source == Boton1000d then

                triggerServerEvent('GuardarDinero', localPlayer, 10000)
            elseif source == Boton10000d then

                triggerServerEvent('GuardarDinero', localPlayer, 100000)
            elseif source == Boton100000d then

                triggerServerEvent('GuardarDinero', localPlayer, "Todo")
            elseif source == Boton1 then

                triggerServerEvent('SacarDinero', localPlayer, 1)
            elseif source == Boton10 then

                triggerServerEvent('SacarDinero', localPlayer, 100)
            elseif source == Boton100 then

                triggerServerEvent('SacarDinero', localPlayer, 1000)
            elseif source == Boton1000 then

                triggerServerEvent('SacarDinero', localPlayer, 10000)
            elseif source == Boton10000 then

                triggerServerEvent('SacarDinero', localPlayer, 100000)
            elseif source == Boton100000 then

                triggerServerEvent('SacarDinero', localPlayer, "Todo")
            end

        end
    )
    addEvent("abrirATM", true)
    addEventHandler("abrirATM", getRootElement(), PanelATM)