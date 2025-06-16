-- MRJobs16_Armas
-- Script que gestiona todas las armas del servidor
-- Autor: ElTitoJet
-- Fecha: 11/01/2024

-- Variables Globales y Configuración
    local screenW, screenH = guiGetScreenSize();
    local pickupsStreaming = {}
    local Tiendas = {
        --[ID] = {x, y, z, int, dim}
        [1] = {296.5, -37.5,  1001.5, 1, 0}, -- Market
        [2] = {312.5, -165.5,  999.5, 6, 0}, -- Willow
        [3] = {290.5, -109.5, 1001.5, 6, 0}, -- Palomino
        [4] = {291.5, -83.5,  1001.5, 4, 0},
    }
    local Armamento = {
        --[ID] = {"Nombre", Slot, ID, Precio, Municion},
        [1] = {"Cuchillo", 1, 4, 100, 1},
        [2] = {"Bate", 1, 5, 550, 1},
        [3] = {"Colt 45", 2, 22, 6500, 17},
        [4] = {"Desert Eagle", 2, 24, 7500, 7},
        [5] = {"Paracaidas", 11, 46, 10000, 1},
        [6] = {"Chaleco", 0, 0, 5000},
        --[7] = {"Rocket Launcher", 7, 35, 1000, 1},
        --[7] = {"Uzi", 4, 28, 50, 50},
        --[8] = {"Tec", 4, 32, 50, 50},
        --[9] = {"Minigun", 7, 38, 50, 1000},
        --[7] = {"Taser", 2, 23, 2000, 5},
        --[8] = {"Escopeta", 3, 25, 10000, 1},
        --[9] = {"Escopeta de combate", 3, 27, 10000, 7},
        --[10] = {"MP5", 4, 29, 10000, 30},
        --[7] = {"M4", 5, 31, 10000, 50},
        --[12] = {"Rifle", 6, 33, 10000, 1},
        --[13] = {"Francotirador", 6, 34, 10000, 1},
    }

    --PANELES
        WeaponPannel = guiCreateWindow((screenW - 313) / 2, (screenH - 243) / 2, 313, 243, "Tienda de armas", false)
            guiWindowSetSizable(WeaponPannel, false)
            guiSetVisible(WeaponPannel, false)

            BuyButtom = guiCreateButton(10, 193, 122, 40, "Comprar", false, WeaponPannel)
            guiSetProperty(BuyButtom, "NormalTextColour", "FFAAAAAA")
            ExitButtom = guiCreateButton(181, 193, 122, 40, "Salir", false, WeaponPannel)
            guiSetProperty(ExitButtom, "NormalTextColour", "FFAAAAAA")
            GridList = guiCreateGridList(10, 29, 293, 154, false, WeaponPannel)
            Arma = guiGridListAddColumn(GridList, "Arma", 0.7)
            Precio = guiGridListAddColumn(GridList, "Precio", 0.3)  
-- Funciones Auxiliares

    addEventHandler( "onClientGUIClick", getRootElement(),
        function(b,s)
            if not (b == 'left' and s == 'up') then
                return
            end
            if source == BuyButtom then
                local DataPJ = exports["MR1_Inicio"]:getValueOne(localPlayer)
                local inv = DataPJ.Inventario
                if (inv.Licencias.LincArmas == nil) then
                    return outputChatBox("#9AA498[#FF7800AmmuNation#9AA498] #A03535Necesitas la licencia de armas.", 255, 255, 255, true )
                end

                local WeaponName = guiGridListGetItemText ( GridList, guiGridListGetSelectedItem ( GridList ), 1 )
                local PrecioWeapon = tonumber(guiGridListGetItemText ( GridList, guiGridListGetSelectedItem ( GridList ), 2 ))
                if not (#WeaponName > 1) then
                    return outputChatBox ( "#9AA498[#FF7800AmmuNation#9AA498] #A03535Selecciona un arma.", 255, 255, 255, true )
                end
                Money = exports["MR1_Inicio"]:getValue(localPlayer, 'Inventario')
                if not (Money.Dinero >= PrecioWeapon) then
                    return outputChatBox("#ffe100No tengo los "..PrecioWeapon.." dolares del arma...", 255, 255, 255, true) 
                end
                triggerServerEvent('WeaponSystem:Server:PannelShop:BuyWeapon', getLocalPlayer(), WeaponName, PrecioWeapon)
            elseif source == ExitButtom then
                showCursor(false)
                guiSetVisible(WeaponPannel, false)
            end
        end
    )
-- Funciones Principales
    function elementStreamInOut()
        if not (getElementType(source) ~= "player") then
            return
        end
        if eventName:find("In") then
            if getElementType(source) == 'pickup' then
                local x,y,z = getElementPosition(source)
                for i, v in ipairs(Tiendas) do
                    if getDistanceBetweenPoints3D(x,y,z, unpack(v)) <= 1 then
                        pickupsStreaming[source] = exports["MR1_Inicio"]:createText3D("#FFFFFF\n Presiona #24C5BEH #FFFFFFpara comprar", x, y, z+1, 2, "bankgothic", -1, false, false, true)
                    end
                end
            end
        else
            if isElement(pickupsStreaming[source]) then
                destroyElement(pickupsStreaming[source])
            end
        end
    end
    function PannelShopOpen(categoria)
        if not guiGetVisible(WeaponPannel) then
            showCursor(true)
            guiSetVisible(WeaponPannel, true)
            guiGridListClear(GridList)
            
            for i, row in ipairs(Armamento) do
                fila = guiGridListAddRow(GridList)
                guiGridListSetItemText(GridList, fila, Arma, row[1], false, false)
                guiGridListSetItemText(GridList, fila, Precio, row[4], false, false)
            end
        end 
    end
-- Eventos y Handlers
    addEventHandler( "onClientElementStreamIn", getRootElement(), elementStreamInOut)
    addEventHandler( "onClientElementStreamOut", getRootElement(), elementStreamInOut)
    addEvent( "WeaponSystem:Client:PannelShop:Open", true)
    addEventHandler( "WeaponSystem:Client:PannelShop:Open", getRootElement(), PannelShopOpen)
    
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
