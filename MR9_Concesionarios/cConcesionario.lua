-- MR9_Concesionarios
-- Gestiona el sistema de compra y venta de vehiculos.
-- Autor: ElTitoJet
-- Fecha: 24/03/2024

-- Variables Globales y Configuración
    local Concesionarios = {
        [1] = {1379.0244140625, -1753.189453125, 14.140625, "Bike"},
        [2] = {2095.896484375, -1359.955078125, 23.984375, "Motorbike"},
        [3] = {2131.880859375, -1150.0107421875, 24.205026626587, "Baja"},
        [4] = {1009.0537109375, -1296.4638671875, 13.546875, "Media"},
        [5] = {552.5341796875, -1293.15234375, 17.248237609863, "Alta"},
        [6] = {2521.689453125, -1512.9921875, 24, "Desguace"},
        --[7] = {2312.2861328125, -2389.33203125, 3, "Boats"},
        --[8] = {1892.9384765625, -2244.1337890625, 13.546875, "Voladores"}
    }
    local VentaEstado = {
        [1] = {2118, -1167, 24, 5, "Baja"},
        [2] = {1027, -1253, 15, 5, "Media"},
        [3] = {571, -1309, 16, 5, "Alta"},
        --[4] = {2512.166015625, -2275.0576171875, -0.35615748167038, "Boats"},
        --[5] = {1870.818359375, -2286.7607421875, 14.872853279114, "Voladores"}
    }
    Conce1 = guiCreateWindow(0.34, 0.28, 0.37, 0.41, "Concesionario", true)
        guiWindowSetSizable(Conce1, false)
        guiSetVisible(Conce1, false)

        BotonSalir = guiCreateButton(0.03, 0.83, 0.29, 0.13, "Salir", true, Conce1)
            guiSetProperty(BotonSalir, "NormalTextColour", "FFAAAAAA")
        BotonComprar = guiCreateButton(0.68, 0.83, 0.29, 0.13, "Comprar", true, Conce1)
            guiSetProperty(BotonComprar, "NormalTextColour", "FFAAAAAA")
        ListVehiculos = guiCreateGridList(0.03, 0.09, 0.93, 0.70, true, Conce1)
        Vehiculo = guiGridListAddColumn(ListVehiculos, "Vehiculo", 0.5)
        Precio = guiGridListAddColumn(ListVehiculos, "Precio", 0.1)  
        Stock = guiGridListAddColumn(ListVehiculos, "Stock", 0.1)  
    ConceDesguace = guiCreateWindow(0.34, 0.28, 0.37, 0.41, "Concesionario", true)
        guiWindowSetSizable(ConceDesguace, false)
        guiSetVisible(ConceDesguace, false)

        BotonSalir2 = guiCreateButton(0.03, 0.83, 0.29, 0.13, "Salir", true, ConceDesguace)
            guiSetProperty(BotonSalir2, "NormalTextColour", "FFAAAAAA")
        BotonComprar2 = guiCreateButton(0.68, 0.83, 0.29, 0.13, "Recuperar", true, ConceDesguace)
            guiSetProperty(BotonComprar2, "NormalTextColour", "FFAAAAAA")
        ListVehiculos2 = guiCreateGridList(0.03, 0.09, 0.93, 0.70, true, ConceDesguace)
        Vehiculo2 = guiGridListAddColumn(ListVehiculos2, "Modelo", 0.5)
        Precio2 = guiGridListAddColumn(ListVehiculos2, "Precio", 0.1)  
        IDVehiculo2 = guiGridListAddColumn(ListVehiculos2, "ID", 0.1)  



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
    function Icono_Concesionario()
        for i, Concesionario in ipairs (Concesionarios) do
            local x, y, z = Concesionario[1], Concesionario[2], Concesionario[3]
            local x2, y2, z2 = getCameraMatrix()
            local distance = 8
            local height = 0.5
            local size = 2
            local text = ""
            if (Concesionario[4] == "Desguace") then
                text = "#53B440["..Concesionario[4].."] #FFFFFF\n Pulsa #24C5BEH #FFFFFFpara recuperar un vehiculo."
            else
                text = "#53B440["..Concesionario[4].."] #FFFFFF\n Pulsa #24C5BEH #FFFFFFpara comprar un vehiculo."
            end
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
    end
    function Icono_Venta_Estado()
        for i, Venta in ipairs (VentaEstado) do
            local x, y, z = Venta[1], Venta[2], Venta[3]
            local x2, y2, z2 = getCameraMatrix()
            local distance = 8
            local height = 0.5
            local size = 2
            local text = "#53B440[VENTA ESTADO] #FFFFFF\n Pulsa #24C5BEH #FFFFFFpara vender un vehiculo al estado."
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
    end
-- Eventos y Handlers
    addEventHandler( "onClientGUIClick", getRootElement(), function(b,s)
        if not (b == 'left' and s == 'up') then
            return
        end
        if source == BotonSalir then
            guiSetVisible(Conce1, false)
            showCursor(false)
        elseif source == BotonSalir2 then
            guiSetVisible(ConceDesguace, false)
            showCursor(false)
        elseif source == BotonComprar then
            local NameVeh = guiGridListGetItemText ( ListVehiculos, guiGridListGetSelectedItem ( ListVehiculos ), 1 )
            local PrecioVeh = tonumber(guiGridListGetItemText ( ListVehiculos, guiGridListGetSelectedItem ( ListVehiculos ), 2 ))
            if not (#NameVeh > 1) then
                return outputChatBox ( "#9AA498[#FF7800Concesionario#9AA498] #A03535Selecciona un vehiculo.", 255, 255, 255, true )
            end

            local informacion_localPlayer = exports["MR1_Inicio"]:getValueOne(localPlayer)

            if not (informacion_localPlayer.Inventario["Dinero"] >= PrecioVeh) then
                return outputChatBox("#ffe100No tengo los "..formatNumber(PrecioVeh).." dolares del vehiculo...", 255, 255, 255, true) 
            end 
            triggerServerEvent('Comprar_Vehiculo', getLocalPlayer(), NameVeh, PrecioVeh)
            guiSetVisible(Conce1, false)
            showCursor(false) 
        elseif source == BotonComprar2 then
            local MatriculaVeh = guiGridListGetItemText ( ListVehiculos2, guiGridListGetSelectedItem ( ListVehiculos2 ), 1 )
            local PrecioDesguace = tonumber(guiGridListGetItemText ( ListVehiculos2, guiGridListGetSelectedItem ( ListVehiculos2 ), 2 ))
            local IdVeh = tonumber(guiGridListGetItemText ( ListVehiculos2, guiGridListGetSelectedItem ( ListVehiculos2 ), 3 ))
            if not (#MatriculaVeh > 1) then
                return outputChatBox ( "#9AA498[#FF7800Concesionario#9AA498] #A03535Selecciona un vehiculo.", 255, 255, 255, true )
            end

            local informacion_localPlayer = exports["MR1_Inicio"]:getValueOne(localPlayer)

            if not (informacion_localPlayer.Inventario["Dinero"] >= PrecioDesguace) then
                return outputChatBox("#ffe100No tengo los "..formatNumber(PrecioDesguace).." dolares del vehiculo...", 255, 255, 255, true) 
            end 
            triggerServerEvent('Recuperar_Vehiculo', getLocalPlayer(), MatriculaVeh, PrecioDesguace, IdVeh)
            guiSetVisible(ConceDesguace, false)
            showCursor(false) 
        end
    end)
    addEventHandler("onClientRender", root, Icono_Concesionario)
    addEventHandler("onClientRender", root, Icono_Venta_Estado)
    addEvent("Abrir_GUI_Concesionario", true)
    addEventHandler("Abrir_GUI_Concesionario", getRootElement(), function(categoria)
        if (categoria == "Desguace") then
            if not guiGetVisible(ConceDesguace) then
                guiSetText( Conce1, categoria )
                showCursor(true)
                guiSetVisible(ConceDesguace, true)
                guiGridListClear(ListVehiculos)
            end 
            return
        end

        if not guiGetVisible(Conce1) then
            guiSetText( Conce1, categoria )
            showCursor(true)
            guiSetVisible(Conce1, true)
            guiGridListClear(ListVehiculos)
        end 
    end)
    addEvent("Actualizar_Lista", true)
    addEventHandler("Actualizar_Lista", getRootElement(), function(Vehiculos)
        guiGridListClear(ListVehiculos)
        for i, row in ipairs(Vehiculos) do
            fila = guiGridListAddRow(ListVehiculos)
            guiGridListSetItemText(ListVehiculos, fila, Vehiculo, row.NOMBRE, false, false)
            guiGridListSetItemText(ListVehiculos, fila, Precio, row.PRECIO, false, false)
            guiGridListSetItemText(ListVehiculos, fila, Stock, row.STOCK, false, false)
        end
    end)
    addEvent("Actualizar_Desguace", true)
    addEventHandler("Actualizar_Desguace", getRootElement(), function(Vehiculos)
        guiGridListClear(ListVehiculos2)
        for i, row in ipairs(Vehiculos) do
            fila2 = guiGridListAddRow(ListVehiculos2)
            guiGridListSetItemText(ListVehiculos2, fila2, Vehiculo2, row.Vehiculo, false, false)
            guiGridListSetItemText(ListVehiculos2, fila2, Precio2, row.Precio, false, false)
            guiGridListSetItemText(ListVehiculos2, fila2, IDVehiculo2, row.IDVehiculo, false, false)
        end
    end)
-- Inicialización
