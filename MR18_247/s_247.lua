-- MR18_247
-- Gestiona los 24/7
-- Autor: ElTitoJet
-- Fecha: 29/05/2024

-- Variables Globales y Configuración
    local stores = {
        --[] = {x, y, z, int}
        [1] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 0},
        [2] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 1},
        [3] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 2},
        [4] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 3},
        [5] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 4},
        [6] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 5},
        [7] = {-23.5478515625, -55.2138671875, 1003.546875, 6, 6},
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
    local PickUps247 = createElement("PickUps")
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
-- Funciones Auxiliares

-- Funciones Principales
    function MR18_Start()
        for i, Tienda in ipairs(stores) do
            local varPickUpTienda = createPickup(Tienda[1], Tienda[2], Tienda[3], 3, 1239, 0, 0)
            setElementInterior(varPickUpTienda, Tienda[4])
            setElementDimension(varPickUpTienda, Tienda[5])
            setElementParent(varPickUpTienda, PickUps247)
        end
    end
    -- Comprar armas
        function BuyItem(ItemName, Price)
            local text = nil;
            local DataPJ = exports["MR1_Inicio"]:getValueOne(client)
            local Inventario = DataPJ.Inventario
            Inventario.Items = Inventario.Items or {}

            for i, Item in ipairs(Items) do

                if Item[1] == ItemName then
                    if not (Inventario.Dinero >= Item[4]) then
                        return outputChatBox("#ffe100No tengo los "..Item[4].." dolares del objeto...", 255, 255, 255, true) 
                    end

                    if i>=5 then
                        -- Gestion de armas
                        exports["weapon_system"]:give(client, tonumber(Item[3]), tonumber(Item[5]), true)
                        exports["MR15_Discord"]:sendDiscordArmasStaff("Dar", client, tonumber(Item[5]), tonumber(Item[3]), "MR18_247(Comprar)")
                    else
                        -- ITEMS NORMALES
                        if i == 4 then
                            -- TABACO
                            Inventario.Items[Item[1]] = (Inventario.Items[Item[1]] or 0) + 10
                        else
                            -- Asegurarse de que los ítems 1, 2 y 3 solo existan una vez
                            if Inventario.Items[Item[1]] then
                                return outputChatBox("#ffe100Ya tengo un "..Item[1]..".", source, 255, 255, 255, true)
                            end
                            Inventario.Items[Item[1]] = 1
                        end
                        if i == 3 then
                            --outputChatBox("Telefono")
                        end
                    end

                    --Inventario.Dinero = Inventario.Dinero - Item[4]
                    --exports["MR1_Inicio"]:setValue(client, 'Inventario', Inventario)
                    exports["MR6_Economia"]:restarDinero(source, Item[4], "MR18_247")
                    outputChatBox("#ffe100Acabo de comprar "..Item[1].." por "..Item[4].." $...", source, 255, 255, 255, true)

                    break

                end

            end

        end
-- Eventos y Handlers
    -- TIENDAS
    addEventHandler("onPickupHit", PickUps247, function(hitElement, md)
        if not (getElementType(hitElement) == "player") or isPedInVehicle(hitElement) then
            return
        end
        bindKey(hitElement, "H", "down", function(hitElement, m)
            triggerClientEvent(hitElement, "247:Client:PannelShop:Open", hitElement)
            unbindKey(hitElement,"H")
        end)
    end)
    addEventHandler("onPickupLeave", PickUps247, function(hitElement, md)
        unbindKey(hitElement,"H")
    end)
    
    addEvent("247:Server:PannelShop:BuyItem", true)
    addEventHandler("247:Server:PannelShop:BuyItem", getRootElement(), BuyItem)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
addEventHandler("onResourceStart", resourceRoot, MR18_Start)