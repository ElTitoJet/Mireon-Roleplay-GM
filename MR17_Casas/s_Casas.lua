-- MR17_Casas
-- Gestiona las casas
-- Autor: ElTitoJet
-- Fecha: 20/04/2024

-- Variables Globales y Configuración
    local EntradaPropiedad = createElement("EntradasPropiedades")
    local SalidaPropiedad = createElement("SalidasPropiedades")
    local MaxCasas = 1;
    local ContactoCasas = {};
    
    -- ESTADOS POSIBLES [En Venta, Comprada, Alquiler]
-- Funciones Auxiliares
    function crear_PickUp(ID, entrada, salida, Propiedad)
        local model = nil

        if Propiedad.Estado == "Comprada" then
            model = 1314
        elseif Propiedad.Estado == "En Venta" then
            model = 1273
        else
            model = 1272
        end
        
        local varPickUpEntradaPropiedad = createPickup(entrada.X, entrada.Y, entrada.Z, 3, model, 0, 0)
        setElementID(varPickUpEntradaPropiedad, ID)
        setElementParent( varPickUpEntradaPropiedad, EntradaPropiedad )
        setData(varPickUpEntradaPropiedad, entrada, Propiedad)
        
        local varPickUpSalidaPropiedad = createPickup(salida.X, salida.Y, salida.Z, 3, model, 0, 0)
        setElementParent( varPickUpSalidaPropiedad, SalidaPropiedad )
        setElementID(varPickUpSalidaPropiedad, ID)
        setData(varPickUpSalidaPropiedad, salida, Propiedad)

        setElementData(varPickUpEntradaPropiedad, "parent", varPickUpSalidaPropiedad, false)
        setElementData(varPickUpSalidaPropiedad, "parent", varPickUpEntradaPropiedad, false)
    end
    function setData(pickup, location, Propiedad)
        setElementInterior(pickup, location.INT)
        setElementDimension(pickup, location.DIM)

        exports["MR1_Inicio"]:setValue(pickup, 'ID', Propiedad.ID)
        exports["MR1_Inicio"]:setValue(pickup, 'Bloqueo', Propiedad.Bloqueo)
        exports["MR1_Inicio"]:setValue(pickup, 'Estado', Propiedad.Estado)
        exports["MR1_Inicio"]:setValue(pickup, 'Inquilino', Propiedad.IDInquilino)

        local PrecioData = fromJSON(Propiedad.Precio)

        if Propiedad.IDPropietario == 0 then
            exports["MR1_Inicio"]:setValue(pickup, 'IDPropietario', "Estado")
            exports["MR1_Inicio"]:setValue(pickup, 'Precio', tonumber(PrecioData.Estado))
        else
            local Propietario = exports["MR1_Inicio"]:query("SELECT Nombre FROM Personajes WHERE ID =?", Propiedad.IDPropietario)
            if #Propietario == 0 then
                exports["MR1_Inicio"]:setValue(pickup, 'IDPropietario', "Estado")
                exports["MR1_Inicio"]:setValue(pickup, 'Precio', tonumber(PrecioData.Estado))
            else
                exports["MR1_Inicio"]:setValue(pickup, 'IDPropietario', {Propiedad.IDPropietario, Propietario[1].Nombre})
                exports["MR1_Inicio"]:setValue(pickup, 'Precio', tonumber(PrecioData.Propietario))
            end
        end

        local Inquilino = exports["MR1_Inicio"]:query("SELECT Nombre FROM Personajes WHERE ID =?", Propiedad.IDInquilino)
        if #Inquilino == 0 then
            exports["MR1_Inicio"]:setValue(pickup, 'IDInquilino', "Estado")
        else
            exports["MR1_Inicio"]:setValue(pickup, 'IDInquilino', Inquilino[1].Nombre)
        end
        exports["MR1_Inicio"]:setValue(pickup, 'Ubicacion', Propiedad.Ubicacion)
        
    end
    
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
    function MR17_Start(resource)
        exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS Propiedades(ID INT NOT NULL AUTO_INCREMENT, IDPropietario INT NOT NULL, IDInquilino INT NOT NULL, Estado VARCHAR(255) NOT NULL, Precio VARCHAR(255) NOT NULL, Ubicacion VARCHAR(255) NOT NULL, Bloqueo VARCHAR(255) NOT NULL,PRIMARY KEY(ID));")
        
        setTimer(function()
            local Propiedades = exports["MR1_Inicio"]:query("SELECT * FROM Propiedades")
            for i, Propiedad in ipairs(Propiedades) do
                local ubicacionData = fromJSON(Propiedad.Ubicacion)
                crear_PickUp(Propiedad.ID, ubicacionData.Entrada, ubicacionData.Salida, Propiedad)
            end
        end, 10000, 1)
    end

    function comprarCasa(ID, Estado, Precio)
        local Precio = tonumber(Precio)
        iprint(Precio)
        if not Precio then return end
        local varDataPlayer = exports["MR1_Inicio"]:getValueOne(client)
        local Personaje = getPlayerName(client);
        local IDPersonaje = varDataPlayer.IDPersonaje
        local TotalCasas = exports["MR1_Inicio"]:query("SELECT * FROM Propiedades WHERE IDPropietario=?", IDPersonaje)

        if (#TotalCasas >= MaxCasas) then
            return outputChatBox("#ffe100Ya tengo 1 propiedad, no puedo comprar otra...", client, 255, 255, 255, true) 
        end 
        if not (varDataPlayer.Inventario["Dinero"] >= Precio) then
            return outputChatBox("#ffe100No tengo los "..formatNumber(Precio).." dolares de la casa...", 255, 255, 255, true) 
        end
        local pickup = ContactoCasas[client]

        if not isElement(pickup) then 
            return 
        end

        local varDataPropiedad = exports["MR1_Inicio"]:getValueOne(pickup)
        
        if varDataPropiedad and varDataPropiedad.ID == ID then

            --varDataPlayer.Inventario["Dinero"] = varDataPlayer.Inventario["Dinero"] - Precio
            exports["MR6_Economia"]:restarDinero(client, Precio, "MR17_Casas")
            
            --exports["MR1_Inicio"]:setValue(client, 'Inventario', varDataPlayer.Inventario)

            outputChatBox("#ffe100Acabo de comprar una propiedad por #FF7800"..formatNumber(Precio).." $#ffe100...", client, 255, 255, 255, true)   

            exports["MR1_Inicio"]:setValue(pickup, 'IDPropietario', {varDataPlayer.IDPersonaje, getPlayerName(client)})
            exports["MR1_Inicio"]:setValue(pickup, 'Bloqueo', true)
            exports["MR1_Inicio"]:setValue(pickup, 'Estado', "Comprada")

            local pickUpParent = getElementData(pickup, "parent")
            exports["MR1_Inicio"]:setValue(pickUpParent, 'IDPropietario', {varDataPlayer.IDPersonaje, getPlayerName(client)})
            exports["MR1_Inicio"]:setValue(pickUpParent, 'Bloqueo', true)
            exports["MR1_Inicio"]:setValue(pickUpParent, 'Estado', "Comprada")

            setPickupType ( pickup, 3, 1314 )
            setPickupType ( pickUpParent, 3, 1314 )

        end

    end
    --[[
        addCommandHandler("crearcasa", function(p, cmd, coste)
        
            local getX, getY, getZ = 140.2646484375, 1366.1875, 1083.859375
            local getInt = 5
        
            local test, last_insert_id = exports["MR1_Inicio"]:execute("INSERT INTO Propiedades (IDPropietario, IDInquilino, Estado, Precio, Ubicacion, Bloqueo) VALUES (0, 0, 'En Venta', '0', '0', 'true');")
            local posx, posy, posz = getElementPosition(p)
            local posint = getElementInterior(p)
            local posdim = getElementDimension(p)
        
            local Precio = toJSON({Estado = coste, Propietario = 0})
            local Ubicacion = toJSON({Entrada = {X=posx, Y=posy, Z=posz, INT=posint, DIM=posdim}, Salida = {X=getX, Y=getY, Z=getZ, INT=getInt, DIM=last_insert_id}})
            local test2, last_insert_id2 = exports["MR1_Inicio"]:execute("UPDATE Propiedades SET Precio=?, Ubicacion=? WHERE ID=?",Precio,Ubicacion,last_insert_id)
        
            local Propiedades = exports["MR1_Inicio"]:query("SELECT * FROM Propiedades WHERE ID=?", last_insert_id)
            for i, Propiedad in ipairs(Propiedades) do
            
                local ubicacionData = fromJSON(Propiedad.Ubicacion)
                crear_PickUp(ubicacionData.Entrada, ubicacionData.Salida, Propiedad)
            end
        end)
    ]]
    

-- Eventos y Handlers
    addEventHandler("onPickupHit", EntradaPropiedad, function(hitElement)
        local pickup = source;
        local varDataEntrada = exports["MR1_Inicio"]:getValueOne(source)
        if not (getElementType(hitElement) == "player") or isPedInVehicle(hitElement) then
            return
        end
        ContactoCasas[hitElement] = source


        bindKey(hitElement, "H", "down", function(hitElement, m)
            local ubicacionData = fromJSON(varDataEntrada.Ubicacion)
            local salida = ubicacionData.Salida
            
            unbindKey(hitElement,"H")
            
            if varDataEntrada.Estado ~= "Comprada" then
                exports["MR5_Interiores"]:Cambiar_De_Interior_A_Pie(hitElement, salida.INT, salida.DIM, salida.X, salida.Y, salida.Z, 0, 0, 0)
                return
            end

            if varDataEntrada.Bloqueo == "true" then
                return outputChatBox("#ffe100La puerta esta cerrada, no puedo entrar sin una llave...", hitElement, 255, 255, 255, true)
            end
            exports["MR5_Interiores"]:Cambiar_De_Interior_A_Pie(hitElement, salida.INT, salida.DIM, salida.X, salida.Y, salida.Z, 0, 0, 0)

        end)

        if varDataEntrada.Estado == "Comprada" then
            return
        end

        bindKey(hitElement, "J", "down", function(hitElement, m)
            --iprint(pickup)
            triggerClientEvent(hitElement, "Abrir_MenuCasa", hitElement, pickup)
            unbindKey(hitElement, "J")
        end)
        
    end)
    addEventHandler("onPickupLeave", EntradaPropiedad, function(hitElement, md)
        if ContactoCasas[hitElement] == source then
            ContactoCasas[hitElement] = nil;
        end
        unbindKey(hitElement,"H")
        unbindKey(hitElement, "J")
    end)
    addEventHandler("onPickupHit", SalidaPropiedad, function(hitElement, md)
        local varDataSalida = exports["MR1_Inicio"]:getValueOne(source)
        if not (getElementType(hitElement) == "player") or isPedInVehicle(hitElement) then
            return
        end
        ContactoCasas[hitElement] = source


        bindKey(hitElement, "H", "down", function(hitElement, m)
            local ubicacionData = fromJSON(varDataSalida.Ubicacion)
            local entrada = ubicacionData.Entrada
            local salida = ubicacionData.Salida
            if varDataSalida.Estado ~= "Comprada" then
                exports["MR5_Interiores"]:Cambiar_De_Interior_A_Pie(hitElement, entrada.INT, entrada.DIM, entrada.X, entrada.Y, entrada.Z, 0, 0, 0)
                return
            end

            exports["MR5_Interiores"]:Cambiar_De_Interior_A_Pie(hitElement, entrada.INT, entrada.DIM, entrada.X, entrada.Y, entrada.Z, 0, 0, 0)
            unbindKey(hitElement,"H")
        end)
        if varDataSalida.Estado == "Comprada" then
            return
        end
        bindKey(hitElement, "J", "down", function(hitElement, m)
            --iprint(varDataEntrada.ID)
            --exports["MR1_Inicio"]:setValue(pickup, 'ID', Propiedad.ID)
            --exports["MR1_Inicio"]:setValue(pickup, 'Bloqueo', Propiedad.Bloqueo)
            --exports["MR1_Inicio"]:setValue(pickup, 'Estado', Propiedad.Estado)
            --exports["MR1_Inicio"]:setValue(pickup, 'IDInquilino', Propiedad.IDInquilino)
            --exports["MR1_Inicio"]:setValue(pickup, 'IDPropietario', Propiedad.IDPropietario)
            --exports["MR1_Inicio"]:setValue(pickup, 'Precio', Propiedad.Precio)
            --exports["MR1_Inicio"]:setValue(pickup, 'Ubicacion', Propiedad.Ubicacion)
            --Propietario, Inquilino, Estado, Precio
            triggerClientEvent(hitElement, "Abrir_MenuCasa", hitElement, varDataEntrada.ID)
            unbindKey(hitElement, "J")
        end)
    end)
    addEventHandler("onPickupLeave", SalidaPropiedad, function(hitElement, md)
        if ContactoCasas[hitElement] == source then
            ContactoCasas[hitElement] = nil;
        end
        unbindKey(hitElement,"H")
        unbindKey(hitElement, "J")
    end)

    addEvent("Comprar_Casa", true)
    addEventHandler("Comprar_Casa", getRootElement(), comprarCasa)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
    addEventHandler("onResourceStart", resourceRoot, MR17_Start)