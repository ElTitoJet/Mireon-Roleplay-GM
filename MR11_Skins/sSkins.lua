-- MR11_Skins
-- Gestiona el sistema de SKins
-- Autor: ElTitoJet
-- Fecha: 25/03/2024

-- Variables Globales y Configuración
    local VENTAS = {
        -- {x, y, z, int, dim, tienda}
        [1] = {207.7177734375, -103.8505859375, 1005.2578125, 15, 0, "Binco"},
        [2] = {203.869140625, -44.6904296875, 1001.8046875, 1, 0, "SubUrban"},
        [3] = {207.4150390625, -130.658203125, 1003.5078125, 3, 0, "ProLabs"},
        [4] = {161.4697265625, -85.244140625, 1001.8046875, 18, 0, "Zip"},
        [5] = {210.9, -9.3, 1001.2, 5, 0, "Victim"},
        [6] = {204.3388671875, -160.30078125, 1000.5234375, 14, 0, "DidierShachs"},
    }

    local PickUpsSkinShop = createElement("SkinsShops")
    local coste = 30
-- Funciones Auxiliares

-- Funciones Principales

-- Eventos y Handlers
    addEventHandler("onPickupHit", PickUpsSkinShop, function(hitElement)
        local key = getElementID(source)
        local value = VENTAS[tonumber(key)]
        bindKey(hitElement, "H", "down", function(hitElement, m)
            triggerClientEvent(hitElement, "Abrir_GUI_SkinSelector", hitElement, value[6])
        end)
    end)
    addEventHandler("onPickupLeave", PickUpsSkinShop, function(hitElement, m)
        unbindKey(hitElement,"H")
    end)
    addEvent("SetSkinServer", true)
    addEventHandler("SetSkinServer", getRootElement(), function(cost, skin)
        local Inventario = exports["MR1_Inicio"]:getValue(client, 'Inventario')
        if not (Inventario.Dinero >= coste) then
            return outputChatBox("#ffe100No tengo los "..coste.." dolares de esta ropa...", client, 255, 255, 255, true) 
        end
        local newskin = nil
        local newSkinCustom = nil

        Inventario.Dinero = Inventario.Dinero - coste
        exports["MR1_Inicio"]:setValue(client, 'Inventario', Inventario)
        
        local Estado = exports["MR1_Inicio"]:getValue(client, 'Estado')
        if skin > 1000 then
            Estado.Skin = 3
            Estado.SkinCustom = skin
        else
            Estado.Skin = skin
            Estado.SkinCustom = 0
        end
        
        setElementModel(client, Estado.Skin)
        exports["MR1_Inicio"]:setValue(client, 'Estado', Estado)
    end)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
    function Iniciar_Recurso_Skins(resource)
        for i, Venta in ipairs (VENTAS) do
            local varPickupVenta = createPickup(Venta[1], Venta[2], Venta[3], 3, 1274, 0, 0)
            setElementInterior(varPickupVenta, Venta[4])
            setElementDimension(varPickupVenta, Venta[5])
            setElementParent( varPickupVenta, PickUpsSkinShop )
            setElementID(varPickupVenta, i)
        end
    end
    addEventHandler("onResourceStart", resourceRoot, Iniciar_Recurso_Skins)