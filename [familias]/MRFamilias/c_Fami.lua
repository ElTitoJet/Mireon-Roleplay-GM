-- MRFam0_Plantilla
-- Script que gestiona la familia.
-- Autor: ElTitoJet
-- Fecha: 27/09/2024

-- Variables Globales y Configuración
    --[[
        local Familias = {
            -- x, y, extenderEste, extenderNorte, R, G, B
            --["Ganton"] = {
            --    {2224, -1839, 200, 150, 155, 155, 155},
            --},
            ["GroveStreet"] = {
                {2228, -1690, 310, 100, 155, 155, 155},
                {2421, -1725, 116, 35, 155, 155, 155}
            },
            --["Seville"] = {
            --    {2620, -2042, 300, 150, 155, 155, 155}
            --},
            --["Willowfield"] = {
            --    {2406, -2058, 150, 200, 155, 155, 155}
            --},
            --["BarrioWillow"] = {
            --    {2204, -2003, 150, 150, 155, 155, 155}
            --},
            ["Corona"] = {
                {1658, -2156, 305, 150, 155, 155, 155},
                {1811, -2006, 150, 125, 155, 155, 155}
            },
            --["Las Flores"] = {
            --    {2559, -1453, 100, 270, 155, 155, 155 },
            --    {2659, -1390, 75, 207, 155, 155, 155 },
            --},
            --["Las colinas"] = {
            --    {1957, -1053, 122, 160, 155, 155, 155 },
            --    {2079, -1100, 188, 207, 155, 155, 155 },
            --    {2267, -1162, 600, 269, 155, 155, 155 },
            --    {2185, -1130, 82, 30, 155, 155, 155 },
            --},
            --["Jefferson"] = {
            --    {1980, -1471, 76, 120, 155, 155, 155 },
            --    {2056, -1475, 47, 255, 155, 155, 155 },
            --    {2103, -1551, 80, 331, 155, 155, 155 },
            --    {2183, -1550, 85, 420, 155, 155, 155 },
            --},
            --["GlenPark"] = {
            --    {1857, -1456, 125, 400, 155, 155, 155 },
            --    {1982, -1351, 75, 295, 155, 155, 155 },
            --    {2057, -1220, 125, 120, 155, 155, 155 },
            --},
            --["East Los Santos"] = {
            --    {2274, -1549, 280, 400, 155, 155, 155 }
            --},
            --["Idlewood"] = {
            --    {1827, -1882, 370, 325, 255, 0, 0 }
            --}
        }
        local Mafias = {
            -- x, y, extenderEste, extenderNorte, R, G, B
            --["Temple"] = {
            --    {970, -1150, 420, 275, 155, 155, 155 }
            --},
            --["Marina"] = {
            --    {634, -1800, 290, 400, 155, 155, 155 }
            --},
            --["East Beach"] = {
            --    {2660, -1900, 300, 500, 155, 155, 155 },
            --    {2735, -1400, 220, 220, 155, 155, 155 }
            --},
            --["Rich man"] = {
            --    {70, -1550, 100, 550, 155, 155, 155 },
            --    {170, -1480, 50, 480, 155, 155, 155 },
            --    {220, -1427, 50, 425, 155, 155, 155 },
            --    {270, -1381, 100, 380, 155, 155, 155 },
            --    {370, -1312, 100, 630, 155, 155, 155 },
            --    {470, -1250, 200, 570, 155, 155, 155 },
            --    {670, -1100, 120, 200, 155, 155, 155 },
            --},
            --["Mulholland"] = {
            --    {670, -900, 300, 250, 155, 155, 155 },
            --    {970, -875, 700, 400, 255, 0, 0 },
            --}
        }
    ]]
    local Familias = {}
    local screenW, screenH = guiGetScreenSize()
    -- PANELES
        -- Panel Faccion
            FamPannel = guiCreateWindow((screenW - 689) / 2, (screenH - 446) / 2, 689, 446, "Panel Faccion", false)
                guiWindowSetMovable(FamPannel, false)
                guiWindowSetSizable(FamPannel, false)
                guiSetVisible(FamPannel, false)
            
                BotonAscender = guiCreateButton(10, 105, 120, 33, "Ascender", false, FamPannel)
                    guiSetProperty(BotonAscender, "NormalTextColour", "FFAAAAAA")
                BotonDescender = guiCreateButton(10, 148, 120, 33, "Descender", false, FamPannel)
                    guiSetProperty(BotonDescender, "NormalTextColour", "FFAAAAAA")
                BotonExpulsar = guiCreateButton(10, 191, 120, 33, "Expulsar", false, FamPannel)
                    guiSetProperty(BotonExpulsar, "NormalTextColour", "FFAAAAAA")  
                BotonCerrarFamPannel = guiCreateButton(10, 403, 120, 33, "Cerrar Panel", false, FamPannel)
                    guiSetProperty(BotonCerrarFamPannel, "NormalTextColour", "FFAAAAAA")
                --labelInformacion = guiCreateLabel(140, 29, 539, 76, ""..Trabajos.Trabajo.."" , false, FamPannel)
                ListaMiembros = guiCreateGridList(140, 105, 539, 331, false, FamPannel)
                ColumnaMiembro = guiGridListAddColumn(ListaMiembros, "Miembro", 0.3)
                ColumnaRango = guiGridListAddColumn(ListaMiembros, "Rango", 0.3)
                ColumnaConectado = guiGridListAddColumn(ListaMiembros, "Conectado", 0.3)


-- Funciones Auxiliares
    function fromJSON(data)
        if data and data ~= "" then
            return fromJSON(data)
        end
        return nil
    end
    function limpiarTerritorios()
        local areas = getElementsByType("radararea")
        for _, area in ipairs(areas) do
            destroyElement(area)
        end
    end
-- Funciones Principales
    function solicitarTerritoriosFamilias()
        setTimer(function()
            -- Solicitar territorios al servidor
            triggerServerEvent("Familias::Territorios::SolicitarTerritorios", localPlayer)
        end, 1000, 1)
    end
    function dibujarTerritorios(varDataFamilias)
        -- Limpiar territorios previos
        limpiarTerritorios()
        
        --iprint(varDataFamilias)

        for i, FamiliaData in ipairs(varDataFamilias) do
            --iprint(i)
            local color = FamiliaData.Color
            local Territorios = FamiliaData.Territorio
            --iprint(Territorios)
            for i2, zone in pairs(Territorios) do
                --iprint(i, i2)
                --iprint(zone)
                -- Obtener coordenadas y dimensiones
                local x, y, ancho, alto = zone.x, zone.y, zone.ancho, zone.alto
    
                -- Verificar si los datos son válidos antes de dibujar
                if x and y and ancho and alto then
                    local r, g, b = color.R, color.G, color.B
                    createRadarArea(x, y, ancho, alto, r, g, b, 150) -- Dibujar la zona con el color
                    --iprint("Zona creadas")
                else
                    outputDebugString("Error en las coordenadas del territorio.", 2)
                end
            end
        end
    end 
    function AbrilPanelFamilia()
        local varDataSource = exports["MR1_Inicio"]:getValueOne(localPlayer)
        if varDataSource.Familia["Nombre"] ~= "Libre" then
            if not guiGetVisible(FamPannel) then
                guiSetVisible(FamPannel, true)
                guiSetInputEnabled(true) -- Anula que podamos activar Binds o movernos.
                showCursor(true) -- Muestra el cursor en la pantalla.
                guiSetText(FamPannel, " "..varDataSource.Familia["Nombre"].." ")
                triggerServerEvent("Familias::Miembros::Obtener", getLocalPlayer(), varDataSource.Familia["FamiliaID"])
            end
        end
    end
    function verPanelFamilia(Familia, IDFam)
        if not guiGetVisible(FamPannel) then
            guiSetVisible(FamPannel, true)
            guiSetInputEnabled(true) -- Anula que podamos activar Binds o movernos.
            showCursor(true) -- Muestra el cursor en la pantalla.
            guiSetText(FamPannel, " "..Familia.." ")
            triggerServerEvent("Familias::Miembros::Obtener", getLocalPlayer(), IDFam)
            guiSetVisible(BotonAscender, false)
            guiSetVisible(BotonDescender, false)
            guiSetVisible(BotonExpulsar, false)
        end
    end
    function ActualizarListaMiembros(combinedResults)
        guiGridListClear(ListaMiembros)
        for i, data in ipairs(combinedResults) do
            local newMember = guiGridListAddRow(ListaMiembros)
            guiGridListSetItemText(ListaMiembros, newMember, ColumnaRango, data.rank, false, false)
            guiGridListSetItemText(ListaMiembros, newMember, ColumnaMiembro, data.CharacterName, false, false)
            guiGridListSetItemText(ListaMiembros, newMember, ColumnaConectado, data.PlayerConectado, false, false)
        end
    end
    function BotonFamilias(b,s)
        if not (b == 'left' and s == 'up') then
            return
        end
        if source == BotonCerrarFamPannel then
            guiSetVisible(FamPannel, false)
            showCursor(false)
            guiSetInputEnabled(false)
        elseif source == BotonAscender then
            local seleccionado = guiGridListGetItemText ( ListaMiembros, guiGridListGetSelectedItem ( ListaMiembros ), 1 )
            if #seleccionado > 2 then
                triggerServerEvent("Familias::Miembros::Ascender", getLocalPlayer(), "Ascender", seleccionado)
            else
                outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Selecciona un personaje.", 255, 255, 255, true )
            end
        elseif source == BotonDescender then
            local seleccionado = guiGridListGetItemText ( ListaMiembros, guiGridListGetSelectedItem ( ListaMiembros ), 1 )
            if #seleccionado > 2 then
                triggerServerEvent("Familias::Miembros::Descender", getLocalPlayer(), "Descender", seleccionado)
            else
                outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Selecciona un personaje.", 255, 255, 255, true )
            end
        elseif source == BotonExpulsar then
            local seleccionado = guiGridListGetItemText ( ListaMiembros, guiGridListGetSelectedItem ( ListaMiembros ), 1 )
            if #seleccionado > 2 then
                triggerServerEvent("Familias::Miembros::Expulsar", getLocalPlayer(), "Expulsar", seleccionado)
            else
                outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Selecciona un personaje.", 255, 255, 255, true )
            end
        end
    end
-- Eventos y Handlers
    addEventHandler("onClientResourceStart", resourceRoot, solicitarTerritoriosFamilias)
    addEvent("Familias::Territorios::RecibirTerritorios", true)
    addEventHandler("Familias::Territorios::RecibirTerritorios", localPlayer, dibujarTerritorios)
    addEvent("Familias::Territorios::ActualizarTerritorios", true)
    addEventHandler("Familias::Territorios::ActualizarTerritorios", localPlayer, dibujarTerritorios)
    addEvent("Familias::PanelFaccion::AbrirMiPanel", true)
    addEventHandler("Familias::PanelFaccion::AbrirMiPanel", localPlayer, AbrilPanelFamilia)
    addEvent("Familias::Miembros::Entregar", true)
    addEventHandler("Familias::Miembros::Entregar", localPlayer, ActualizarListaMiembros)
    addEventHandler("onClientGUIClick", getRootElement(), BotonFamilias)
    addEvent("Familias::PanelFaccion::VerPanel", true)
    addEventHandler("Familias::PanelFaccion::VerPanel", localPlayer, verPanelFamilia)

-- Inicialización