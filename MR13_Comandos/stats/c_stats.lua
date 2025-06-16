-- MR13_Comandos > Stats
-- Gestiona el sistema de stats del usuario
-- Autor: ElTitoJet
-- Fecha: 08/09/2024

-- Variables Globales y Configuración
    local screenW, screenH = guiGetScreenSize();
    local accountName = "Pendiente";
    local accountID = "Pendiente";
    local accountLevel = "Pendiente";
    local accountTime = "Pendiente";
    local accountRankID = "Pendiente";
    local accountRank = "Pendiente";
    local accountVIP = "Pendiente";
--PANELES
    -- Stats Selector
        PanelSelectStats = guiCreateWindow((screenW - 227) / 2, (screenH - 173) / 2, 227, 173, "stats", false)
            guiWindowSetSizable(PanelSelectStats, false)
            guiSetVisible(PanelSelectStats, false)
            BotonStatsCuenta = guiCreateButton(10, 26, 207, 36, "Stats de la cuenta", false, PanelSelectStats)
            guiSetProperty(BotonStatsCuenta, "NormalTextColour", "FFAAAAAA")
            BotonStatsPJ = guiCreateButton(11, 72, 206, 36, "Stats del Personaje", false, PanelSelectStats)
            guiSetProperty(BotonStatsPJ, "NormalTextColour", "FFAAAAAA")
            BotonStatsSalir = guiCreateButton(10, 118, 206, 36, "Cerrar Panel", false, PanelSelectStats)
            guiSetProperty(BotonStatsSalir, "NormalTextColour", "FFAAAAAA")   
    -- Stats Cuenta
        PanelStatsCuenta = guiCreateWindow((screenW - 700) / 2, (screenH - 471) / 2, 700, 471, "Stats Cuenta", false)
            guiWindowSetSizable(PanelStatsCuenta, false)
            guiSetVisible(PanelStatsCuenta, false)
            StatsCuentaTab = guiCreateTabPanel(10, 22, 680, 396, false, PanelStatsCuenta)

            StatsCuentaTab1 = guiCreateTab("Informacion general", StatsCuentaTab)

            StatsCuentalabel1 = guiCreateLabel(10, 10, 314, 107, "Informacion de la cuenta\n\n- Cuenta :: "..accountName.." (#"..accountID..")\n- Nivel :: "..accountLevel.."\n- Tiempo de juego :: "..accountTime.."\n- PDR :: ..pdr.. (+0 | -0)", false, StatsCuentaTab1)
            StatsCuentalabel2 = guiCreateLabel(356, 10, 314, 107, "Estado Cuenta\n\n- Rango :: "..accountRank.."(#"..accountRankID..")\n- VIP :: "..accountVIP.."", false, StatsCuentaTab1)
            StatsCuentalabel3 = guiCreateLabel(10, 117, 314, 107, "Personajes\n\n- PJ 1 :: ..PJ1Name..\n- PJ 2 :: ..PJ2Name..", false, StatsCuentaTab1)
            StatsCuentalabel4 = guiCreateLabel(356, 117, 314, 107, "Info generica Personajes\n\n- Dinero total :: ..playerMoney..", false, StatsCuentaTab1)

            StatsCuentaTab2 = guiCreateTab("Sanciones", StatsCuentaTab)

            StatsCuentagridlist1 = guiCreateGridList(10, 10, 660, 352, false, StatsCuentaTab2)
            guiGridListAddColumn(StatsCuentagridlist1, "Personaje", 0.2)
            guiGridListAddColumn(StatsCuentagridlist1, "Staff", 0.2)
            guiGridListAddColumn(StatsCuentagridlist1, "Fecha", 0.2)
            guiGridListAddColumn(StatsCuentagridlist1, "Motivo", 0.2)


            StatsCuentaCerrar = guiCreateButton(10, 428, 680, 33, "CERRAR PANEL", false, PanelStatsCuenta)
            guiSetProperty(StatsCuentaCerrar, "NormalTextColour", "FFAAAAAA")  
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
    function AbrirSelectorStats()
        if not guiGetVisible(PanelSelectStats) then
            showCursor(true)
            guiSetVisible(PanelSelectStats, true)
        end 
    end
    function ActualizarStatsCuenta(datosCuenta)
        -- Actualizar la información general de la cuenta
            guiSetText(StatsCuentalabel1, "Informacion de la cuenta\n\n- Cuenta :: "..datosCuenta.Nombre.." (#"..datosCuenta.ID..")\n- Nivel :: Pendiente\n- Tiempo de juego :: "..datosCuenta.TiempoJugado.." horas\n- PDR :: N/A (+0 | -0)")
            guiSetText(StatsCuentalabel2, "Estado Cuenta\n\n- Rango :: "..datosCuenta.Rank.." (#"..datosCuenta.ID..")\n- VIP :: "..datosCuenta.VIP)

        -- Actualizar la información de personajes
            local personajesText = "Personajes\n\n"
            local dineroTotal = 0
            for i, personaje in ipairs(datosCuenta.Personajes) do
                personajesText = personajesText .. "- PJ " .. i .. " :: " .. personaje.Nombre .. " (#"..personaje.ID..")\n"
                dineroTotal = dineroTotal + personaje.Dinero + personaje.Banco
            end
            guiSetText(StatsCuentalabel3, personajesText)
            guiSetText(StatsCuentalabel4, "Info generica Personajes\n\n- Dinero total :: $"..formatNumber(dineroTotal))

        -- Limpiar la gridlist de sanciones
            guiGridListClear(StatsCuentagridlist1)

        -- Actualizar las sanciones en la gridlist
            for _, sancion in ipairs(datosCuenta.Sanciones) do
                local row = guiGridListAddRow(StatsCuentagridlist1)
                guiGridListSetItemText(StatsCuentagridlist1, row, 1, sancion.Personaje, false, false)
                guiGridListSetItemText(StatsCuentagridlist1, row, 2, sancion.Staff, false, false)
                guiGridListSetItemText(StatsCuentagridlist1, row, 3, sancion.Fecha, false, false)
                guiGridListSetItemText(StatsCuentagridlist1, row, 4, sancion.Motivo, false, false)
            end

        -- Mostrar el panel con los datos actualizados
            guiSetVisible(PanelStatsCuenta, true)
    end
-- Eventos y Handlers    
    addEvent( "Stats::Selector::Open", true)
    addEventHandler( "Stats::Selector::Open", getRootElement(), AbrirSelectorStats)
    addEventHandler( "onClientGUIClick", getRootElement(),function(b,s)
        if not (b == 'left' and s == 'up') then
            return
        end
        if source == BotonStatsCuenta then
            if not guiGetVisible(PanelStatsCuenta) then
                showCursor(true)
                guiSetVisible(PanelSelectStats, false)
                triggerServerEvent("Stats::Cuenta::solicitarData", getRootElement()) -- Pedir al servidor los datos de los NPC
                guiSetVisible(PanelStatsCuenta, true)
            end 
        elseif source == BotonStatsSalir or source == StatsCuentaCerrar then
            guiSetVisible(PanelSelectStats, false)
            guiSetVisible(PanelStatsCuenta, false)
            showCursor(false)
        end
    end)
    addEvent("Stats::Cuenta::RecibirData", true)
    addEventHandler("Stats::Cuenta::RecibirData", getRootElement(), ActualizarStatsCuenta)
-- Inicialización