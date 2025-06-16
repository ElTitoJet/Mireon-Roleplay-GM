-- MR17_Casas
-- Gestiona las casas
-- Autor: ElTitoJet
-- Fecha: 20/04/2024

-- Variables Globales y Configuración

    local varID
    local varPropietario
    local varInquilino
    local varEstado
    local varPrecio

    local screenW, screenH = guiGetScreenSize()
    housePanel = guiCreateWindow((screenW - 300) / 2, (screenH - 300) / 2, 300, 300, "Casa #ID", false)
        guiWindowSetSizable(housePanel, false)
        guiSetVisible(housePanel, false)
        -- Etiquetas de información
        labelOwner = guiCreateLabel(10, 30, 280, 20, "Propietario: Nombre_Apellidos", false, housePanel)
        labelTenant = guiCreateLabel(10, 55, 280, 20, "Inquilino: Nombre_Apellidos", false, housePanel)
        labelStatus = guiCreateLabel(10, 80, 280, 20, "Estado: En Venta / Compra / En Alquiler", false, housePanel)
        labelPrice = guiCreateLabel(10, 105, 280, 20, "Precio: Valor", false, housePanel)
        
        -- Botones
        buttonBuy = guiCreateButton(10, 180, 135, 30, "Comprar", false, housePanel)
        guiSetEnabled(buttonBuy, false)
        buttonRent = guiCreateButton(155, 180, 135, 30, "Alquilar", false, housePanel)
        guiSetEnabled(buttonRent, false)
        buttonClose = guiCreateButton(90, 220, 120, 30, "Cerrar", false, housePanel)
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
    function PressPannel(b,s)
        if not (b == 'left' and s == 'up') then
            return
        end
        if source == buttonClose then
            guiSetVisible(housePanel, false)
            showCursor(false)
            varID = nil
            varPropietario = nil
            varInquilino = nil
            varEstado = nil
            varPrecio = nil
        elseif source == buttonBuy then
            local informacion_localPlayer = exports["MR1_Inicio"]:getValueOne(localPlayer)
            if not (informacion_localPlayer.Inventario["Dinero"] >= varPrecio) then
                return outputChatBox("#ffe100No tengo los "..formatNumber(varPrecio).." dolares de la casa...", 255, 255, 255, true) 
            end 
            triggerServerEvent('Comprar_Casa', getLocalPlayer(), varID, varEstado, varPrecio)
            --showCursor(false) 
        elseif source == buttonRent then

        end
    end

    function Abrir_MenuCasa(PickUp)
        local varDataEntrada = exports["MR1_Inicio"]:getValueOne(PickUp)
        --iprint(varDataEntrada)
        guiSetText(housePanel, "Casa #"..varDataEntrada.ID)
        guiSetText(labelOwner, "Propietario: "..varDataEntrada.IDPropietario)
        guiSetText(labelTenant, "Inquilino: "..varDataEntrada.IDInquilino)
        guiSetText(labelStatus, "Estado: "..varDataEntrada.Estado)
        guiSetText(labelPrice, "Precio: "..formatNumber(varDataEntrada.Precio))
        varID = varDataEntrada.ID
        varEstado = varDataEntrada.Estado
        varPrecio = varDataEntrada.Precio
        
        if not (guiGetVisible(housePanel)) then
            showCursor(true)
            guiSetVisible(housePanel, true)

            guiSetEnabled(buttonBuy, false)
            guiSetEnabled(buttonRent, false)
            if varDataEntrada.Estado == "En Venta" then
                guiSetEnabled(buttonBuy, true)
            end
            if varDataEntrada.Estado == "Alquiler" then
                guiSetEnabled(buttonRent, true)
            end
        end
    end
-- Eventos y Handlers
    addEvent("Abrir_MenuCasa", true)
    addEventHandler("Abrir_MenuCasa", getRootElement(), Abrir_MenuCasa)
    addEventHandler( "onClientGUIClick", getRootElement(), PressPannel)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
    addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function()
            local dff = engineLoadDFF("test/19522.dff")  -- asegúrate de que la ruta es correcta
            if dff then
                engineReplaceModel(dff, 1314)
            else
                outputChatBox("Failed to load DFF")
            end

            local col = engineLoadCOL("test/19522.col")
            if col then
                engineReplaceCOL(col, 1314)
            else
                outputChatBox("Failed to load COL")
            end
            
            local txd = engineLoadTXD("test/19522.txd")
            if txd then
                engineImportTXD(txd, 1314)
            else
                outputChatBox("Failed to load txd")
            end
    end)