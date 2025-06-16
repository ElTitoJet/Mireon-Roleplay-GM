-- MR18_247
-- Gestiona los 24/7
-- Autor: ElTitoJet
-- Fecha: 29/05/2024

-- Variables Globales y Configuración
    local pickupsStreaming = {}
    local stores = {
        --[] = {x, y, z, int}
        [1] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 0, ""},
        [2] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 1, ""},
        [3] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 2, ""},
        [4] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 3, ""},
        [5] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 4, ""},
        [6] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 5, ""},
        [7] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 6, ""},
        -- Int 18
        [8] = {-28.1416015625, -89.6513671875, 1003.546875, 18, 0},
        [9] = {-28.1416015625, -89.6513671875, 1003.546875, 18, 1},
        [10] = {-28.1416015625, -89.6513671875, 1003.546875, 18, 2},
        [11] = {-28.1416015625, -89.6513671875, 1003.546875, 18, 3},
        [12] = {-28.1416015625, -89.6513671875, 1003.546875, 18, 4},
        -- Int 4
        [13] = {-30.80859375, -28.80859375, 1003.5572509766, 4, 0},
        [14] = {-30.80859375, -28.80859375, 1003.5572509766, 4, 1},
        [15] = {-30.80859375, -28.80859375, 1003.5572509766, 4, 2},
        [16] = {-30.80859375, -28.80859375, 1003.5572509766, 4, 3}
    }
    local Items = {
        --[ID] = {"Nombre", Precio},
        [1] = {"Telefono", 0, 0, 150},
        [2] = {"Radio", 0, 0, 150},
        [3] = {"Encendedor", 0, 0, 20},
        [4] = {"Tabaco", 0, 0, 50},
        --[ID] = {"Nombre", Slot, ID, Precio, ammo},
        [5] = {"Camara", 9, 43, 100, 36},
        [6] = {"Lata de Spray", 9, 41, 100, 500},
        [7] = {"Ramo de Flores", 10, 14, 100, 1}
    }
    local screenW, screenH = guiGetScreenSize()
    Panel247 = guiCreateWindow((screenW - 233) / 2, (screenH - 275) / 2, 233, 275, "24/7", false)
        guiWindowSetSizable(Panel247, false)
        guiSetVisible(Panel247, false)
        buttonComprar = guiCreateButton(10, 235, 93, 30, "Comprar", false, Panel247)
        guiSetProperty(buttonComprar, "NormalTextColour", "FFAAAAAA")
        buttonSalir = guiCreateButton(131, 235, 92, 30, "Salir", false, Panel247)
        guiSetProperty(buttonSalir, "NormalTextColour", "FFAAAAAA")
        gridlist247 = guiCreateGridList(10, 28, 213, 197, false, Panel247)
            Objeto = guiGridListAddColumn(gridlist247, "Objeto", 0.5)
            Precio = guiGridListAddColumn(gridlist247, "Precio", 0.5)   
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
    function elementStreamInOut()
        if getElementType(source) ~= "player" then
            if eventName:find("In") then
                if getElementType(source) == 'pickup' then
                    local x,y,z = getElementPosition(source)
                    for i, v in ipairs(stores) do
                        if getDistanceBetweenPoints3D(x,y,z, unpack(v)) <= 1 then
                            pickupsStreaming[source] = exports["MR1_Inicio"]:createText3D("#FFFFFF\n Presiona #24C5BEH #FFFFFFpara abrir la tienda", x, y, z+1, 2, "bankgothic", -1, false, false, true)
                        end
                    end
                end
            else
                if isElement(pickupsStreaming[source]) then
                    destroyElement(pickupsStreaming[source])
                end
            end
        end

    end
    function PressPannel(b,s)
        if not (b == 'left' and s == 'up') then
            return
        end
        if source == buttonSalir then
            guiSetVisible(Panel247, false)
            showCursor(false)
        elseif source == buttonComprar then
            local DataPJ = exports["MR1_Inicio"]:getValueOne(localPlayer)
            local inv = DataPJ.Inventario

            local ItemName = guiGridListGetItemText ( gridlist247, guiGridListGetSelectedItem ( gridlist247 ), 1 )
            local PrecioItem = tonumber(guiGridListGetItemText ( gridlist247, guiGridListGetSelectedItem ( gridlist247 ), 2 ))
            if not (#ItemName > 1) then
                return outputChatBox ( "#9AA498[#FF7800AmmuNation#9AA498] #A03535Selecciona un arma.", 255, 255, 255, true )
            end
            Money = exports["MR1_Inicio"]:getValue(localPlayer, 'Inventario')
            if not (Money.Dinero >= PrecioItem) then
                return outputChatBox("#ffe100No tengo los "..PrecioItem.." dolares del arma...", 255, 255, 255, true) 
            end
            triggerServerEvent('247:Server:PannelShop:BuyItem', getLocalPlayer(), ItemName, PrecioItem)

        end
    end
    function PannelShopOpen()
        if not guiGetVisible(Panel247) then
            showCursor(true)
            guiSetVisible(Panel247, true)
            guiGridListClear(gridlist247)
            
            for i, row in ipairs(Items) do
                fila = guiGridListAddRow(gridlist247)
                guiGridListSetItemText(gridlist247, fila, Objeto, row[1], false, false)
                guiGridListSetItemText(gridlist247, fila, Precio, row[4], false, false)
            end
        end 
    end
-- Eventos y Handlers
    addEventHandler( "onClientElementStreamIn", getRootElement(), elementStreamInOut)
    addEventHandler( "onClientElementStreamOut", getRootElement(), elementStreamInOut)
    addEventHandler( "onClientGUIClick", getRootElement(), PressPannel)
    addEvent( "247:Client:PannelShop:Open", true)
    addEventHandler( "247:Client:PannelShop:Open", getRootElement(), PannelShopOpen)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
