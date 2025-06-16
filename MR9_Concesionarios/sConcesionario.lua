-- MR9_Concesionarios
-- Gestiona el sistema de compra y venta de vehiculos.
-- Autor: ElTitoJet
-- Fecha: 24/03/2024

-- Variables Globales y Configuración
    local letras = {}
    local MaxVeh = 2;
    local Concesionarios = {
        [1] = {2095.896484375, -1359.955078125, 23.984375, "Motorbike"},
        [2] = {2131.880859375, -1150.0107421875, 24.205026626587, "Baja"},
        [3] = {1009.0537109375, -1296.4638671875, 13.546875, "Media"},
        [4] = {552.5341796875, -1293.15234375, 17.248237609863, "Alta"},
        [5] = {2521.689453125, -1512.9921875, 24, "Desguace"},
        --[7] = {2312.2861328125, -2389.33203125, 3, "Boats"},
        --[8] = {1892.9384765625, -2244.1337890625, 13.546875, "Voladores"}
        --[1] = {1379.0244140625, -1753.189453125, 14.140625, "Bike"},
    }
    local VentaEstado = {
        [1] = {2118, -1167, 20, 5, "Baja"},
        [2] = {1027, -1253, 11, 5, "Media"},
        [3] = {571, -1309, 16, 5, "Alta"},
        --[4] = {2112, -1371, 23, 5, "Pepe"},
        --[4] = {2512.166015625, -2275.0576171875, -0.35615748167038, "Boats"},
        --[5] = {1870.818359375, -2286.7607421875, 14.872853279114, "Voladores"}
    }
    
    local SpawnConcesionario = {
        ["Bike"] = {
            {1381, -1756, 13, 0, 0, 272},
            {1381, -1758, 13, 0, 0, 272},
            {1381, -1760, 13, 0, 0, 272},
            {1381, -1762, 13, 0, 0, 272},
            {1381, -1764, 13, 0, 0, 272},
            {1381, -1766, 13, 0, 0, 272},
        },
        ["Motorbike"] = {
            {2093, -1362, 23, 0, 0, 268},
            {2093, -1364, 23, 0, 0, 268},
            {2093, -1366, 23, 0, 0, 268},
            {2093, -1368, 23, 0, 0, 268},
            {2093, -1370, 23, 0, 0, 268},
            {2093, -1372, 23, 0, 0, 268},
            {2099, -1362, 23, 0, 0, 90},
            {2099, -1364, 23, 0, 0, 90},
            {2099, -1366, 23, 0, 0, 90},
            {2099, -1368, 23, 0, 0, 90},
            {2099, -1370, 23, 0, 0, 90},
            {2099, -1372, 23, 0, 0, 90},
        },
        ["Baja"] = {
            {2135, -1126, 26, 0, 0, 86},
            {2135, -1132, 26, 0, 0, 86},
            {2135, -1138, 26, 0, 0, 86},
            {2120, -1126, 26, 0, 0, 263},
            {2120, -1132, 26, 0, 0, 263},
            {2120, -1138, 26, 0, 0, 263},
        },
        ["Media"] = {
            {1006, -1305, 13, 0, 0, 0},
            {1001, -1305, 13, 0, 0, 0},
            {996, -1305, 13, 0, 0, 0},
            {991, -1305, 13, 0, 0, 0},
            {986, -1305, 13, 0, 0, 0},
            {981, -1305, 13, 0, 0, 0},
        },
        ["Alta"] = {
            {528, -1284, 17, 0, 0, 219},
            {533, -1280, 17, 0, 0, 219},
            {538, -1276, 17, 0, 0, 219},
            {543, -1272, 17, 0, 0, 219},
            {548, -1268, 17, 0, 0, 219},
            {553, -1264, 17, 0, 0, 219},
        },
        ["Boats"] = {
            {2325, -2406, 1, 0, 0, 224},
            {2315, -2416, 1, 0, 0, 224},
            {2305, -2426, 1, 0, 0, 224},
            {2295, -2436, 1, 0, 0, 224},
        },
        ["Voladores"] = {
            {1922, -2253, 15, 0, 0, 180},
        },
        ["Desguace"] = {
            {2510, -1517, 25, 0, 0, -90},
            {2510, -1538, 25, 0, 0, -90},
            {2534, -1524, 25, 0, 0, 90},
            {2534, -1531, 25, 0, 0, 90},
            {2534, -1517, 25, 0, 0, 90},
            {2510, -1517, 25, 0, 0, -90},
            {2510, -1524, 25, 0, 0, -90},
            {2510, -1531, 25, 0, 0, -90},
            {2534, -1538, 25, 0, 0, 90},
        }
    }
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
    function insertarVehiculo(IDPersonaje, Informacion, Estado, Ubicacion, Tunning)
        local query = "INSERT INTO VehiculosUsuarios (IDPersonaje, Informacion, Estado, Ubicacion, Tunning) VALUES(?, ?, ?, ?, ?)"
        local num_affected_rows, last_insert_id = exports["MR1_Inicio"]:execute(query, IDPersonaje, Informacion, Estado, Ubicacion, Tunning)
        --iprint(num_affected_rows)
        --iprint(last_insert_id)
        return last_insert_id
    end
    function obtenerMatricula(id)
        id = id - 1
        local idNumerica = id % 9999
        local idLetra = (id - idNumerica) / 9999
        return secuenciaIdLetras(idLetra, 3) .. "-" .. string.format("%04d", idNumerica + 1)
    end
    function secuenciaIdLetras(id, longitud)
        local secuencia = {}
        for i = 1, longitud do
            -- Aqui, cogemos el codigo equivalente a la ID de la secuencia, y la insertamos al principio de la array
            table.insert(secuencia, letras[id % #letras + 1])
            -- "restamos" el codigo de la letra de la ID, para la siguiente
            id = math.floor(id / #letras)
        end
        return table.concat(secuencia)
    end
    function isVehicleExists(matricula)
        for i, v in ipairs(getElementsByType ('vehicle')) do
            local varInformacion_Vehicle = exports["MR1_Inicio"]:getValueOne(v)
            if varInformacion_Vehicle and varInformacion_Vehicle["Informacion"]["Matricula"] == matricula then
                return true
            end
        end
        return false
    end
    function StopConcesionarios()
        for i, Vehicle in ipairs(getElementsByType ('vehicle')) do
            local DataVeh = exports["MR1_Inicio"]:getValueOne(Vehicle)
            if (DataVeh) and (DataVeh["IDPersonaje"]) then
                --INFORMACION
                    --iprint(DataVeh["Informacion"])
                --ESTADO
                    --iprint(DataVeh["Estado"])
                    estado = DataVeh["Estado"]
                    estado.Salud = getElementHealth(Vehicle)
                    if (getElementHealth(Vehicle) <= 300) then
                        estado.Destruido = true
                    end
                --Ubicacion
                    local x, y, z = getElementPosition(Vehicle)
                    local rx, ry, rz = getElementRotation(Vehicle)
                    local Dim = getElementDimension(Vehicle)
                    local Int = getElementInterior(Vehicle)
                    local Ubicacion = { 
                        posX = x, posY = y, posZ = z, rotX = rx, rotY = ry, rotZ = rz, Dimension = Dim, Interior = Int
                    };

                --Tunning
                    local CR0, CG0, CB0, CR1, CG1, CB1, CR2, CG2, CB2, CR3, CG3, CB3 = getVehicleColor(Vehicle, true)
                    local LR, LG, LB = getVehicleHeadLightColor(Vehicle)
                    local Tunning = {Color = {
                        R0 = CR0, G0 = CG0, B0 = CB0, R1 = CR1, G1 = CG1, B1 = CB1, R2 = CR2, G2 = CG2, B2 = CB2, R3 = CR3, G3 = CG3, B3 = CB3
                    }, Luces = {
                        R = LR, G = LG, B = LB
                    }, Modificaciones = {
                        getVehicleUpgrades(Vehicle)
                    }, Paintjob = getVehiclePaintjob(Vehicle)
                    };
                --Inventario
                --iprint(DataVeh["Inventario"])
                    exports["MR1_Inicio"]:execute("UPDATE VehiculosUsuarios SET IDPersonaje="..DataVeh["IDPersonaje"]..", Estado='"..toJSON(DataVeh["Estado"]).."', Ubicacion='"..toJSON(Ubicacion).."', Tunning='"..toJSON(Tunning).."', Inventario='"..toJSON(DataVeh["Inventario"]).."' WHERE ID=?", DataVeh["ID"])
            end
        end
    end
-- Funciones Principales
        -- Informacion
            -- [ { "Matricula": "AAA-0004", "Modelo": 510 } ]
        -- ESTADO
            -- [ { "Salud": 1000, "Destruido": false, "Bloqueo": true, "Motor": false, "Luces": false } ]
        -- UBICACION
            -- [ { "posX": 528, "posY": -1284, "posZ": 17, "rotX": 0, "rotY": 0, "rotZ": 219, "Dimension": 0, "Interior": 0 } ]
        -- TUNNING
            -- [ { "Color": { "R0": 0, "G0": 0, "B0": 0, "R1": 0, "G1": 0, "B1": 0, "R2": 0, "G2": 0, "B2": 0, "R3": 0, "G3": 0, "B3": 0 }, "Luces": { "LR": 255, "LG": 255, "LB": 255 }, "Paintjob": [ 3 ], "Modificaciones": [ [ "Spoiler": false ,"Sideskirt": false ,"Roof": false ,"Nitro": false ,"Hydraulics": false ,"Stereo": false ,"Wheels": false ,"Exhaust": false ,"Front Bumper": false ,"Rear Bumper": false ] ] } ]


    function Comprar_Vehiculo(Vehiculo, Precio)
        local varDataPlayer = exports["MR1_Inicio"]:getValueOne(client)
        local IDPersonaje = varDataPlayer.IDPersonaje

        -- Comprobar si el jugador ya tiene el maximo de vehiculos
            local TotalVehs = exports["MR1_Inicio"]:query("SELECT * FROM VehiculosUsuarios WHERE IDPersonaje=?", IDPersonaje)
            if (#TotalVehs >= MaxVeh) then
                return outputChatBox("#ffe100Ya tengo 2 vehiculos, no puedo comprar otro...", client, 255, 255, 255, true) 
            end 

            local vehDB = exports["MR1_Inicio"]:query('SELECT * FROM VehiculosConcesionario WHERE Nombre = ?', Vehiculo)
            local SlotsVeh = vehDB[1].SLOTS
            local categoriaElegida = vehDB[1].CATEGORIA
            
            if varDataPlayer.Inventario["Dinero"] < vehDB[1].PRECIO then
                return outputChatBox("#ffe100No tengo los "..formatNumber(vehDB[1].PRECIO).." dolares del vehiculo...", client, 255, 255, 255, true) 
            end
        --iprint(SlotsVeh)
        
        for categoria, spawns in pairs(SpawnConcesionario) do
            if categoria == categoriaElegida then
                local spawnLibre = nil
                local vehiculos = getElementsByType("vehicle")
                -- Comprobamos si hay spawns libres
                    for _, spawn in ipairs(spawns) do
                        local spawnOcupado = false
                        -- Verificar si hay un vehículo en esta posición
                        for _, vehiculo in ipairs(vehiculos) do
                            local x, y, z = getElementPosition(vehiculo)
                            local posX, posY, posZ, rotX, rotY, rotZ = unpack(spawn)
                            -- Comprobar si el vehículo está lo suficientemente cerca
                            local distancia = getDistanceBetweenPoints3D(x, y, z, posX, posY, posZ)
                            if distancia < 1 then
                                spawnOcupado = true
                                break
                            end
                        end

                        if not spawnOcupado then
                            -- No hay vehículos en esta posición, es seguro usarla
                            spawnLibre = spawn
                            break
                        end
                    end

                --No existe spawn libre
                    if not (spawnLibre) then
                        -- No se encontraron spawns libres en esta categoría
                        return outputChatBox("No hay spawns libres en esta categoría.", client, 255, 0, 0, true)
                    end

                -- Existe Spawn Libre
                    --INFORMACION BASE GENERICA
                        local Informacion = {Matricula = false, Modelo = vehDB[1].MODELO}
                        local Estado = {Salud = 1000, Destruido = false, Bloqueo = true, Motor = false, Luces = false}
                        local Ubicacion = 0
                        local Tunning = {Color = {R0 = 0, G0 = 0, B0 = 0, R1 = 0, G1 = 0, B1 = 0, R2 = 0, G2 = 0, B2 = 0,  R3 = 0, G3 = 0, B3 = 0}, Luces = {R = 255, G = 255, B = 255}, Modificaciones = {}, Paintjob = 0};
                -- Preparamos el auto en la DB
                    local id = insertarVehiculo(IDPersonaje, toJSON(Informacion), toJSON(Estado), Ubicacion, toJSON(Tunning))
                    if not id then
                        return outputChatBox("Error al insertar el vehículo en la base de datos.", client, 255, 0, 0, true)
                    end


                    local matricula = obtenerMatricula(id)
                    Informacion.Matricula = matricula
                    exports["MR1_Inicio"]:execute("UPDATE VehiculosUsuarios SET INFORMACION='"..toJSON(Informacion).."' WHERE ID=?", id)
                -- Creamos el vehiculo
                    local posX, posY, posZ, rotX, rotY, rotZ = unpack(spawnLibre)
                    veh = createVehicle(vehDB[1].MODELO, posX, posY, posZ, rotX, rotY, rotZ, matricula)
                    setVehicleColor(veh, math.random(0, 255), math.random(0, 255), math.random(0, 255), 0, 0, 0, 0, 0, 0, 0, 0, 0)
                    setVehiclePlateText(veh, matricula)
                    setVehicleLocked(veh, true)
                    setVehicleEngineState(veh, false)
                    
                -- Actualizamos la nueva ubicacion del vehiculo
                    local Ubicacion = { 
                        posX = posX, posY = posY, posZ = posZ, rotX = rotX, rotY = rotY, rotZ = rotZ, Interior = 0, Dimension = 0
                    };
                    exports["MR1_Inicio"]:execute("UPDATE VehiculosUsuarios SET UBICACION='"..toJSON(Ubicacion).."' WHERE ID=?", id)

                -- Actualizamos el nuevo inventario del vehiculo
                    local Inventario = {}
                    for i = 1, SlotsVeh do
                        Inventario["Slot " .. i] = { ["Objeto"] = "Ninguno", ["Cantidad"] = 0 }
                    end
                    exports["MR1_Inicio"]:execute("UPDATE VehiculosUsuarios SET INVENTARIO='"..toJSON(Inventario).."' WHERE ID=?", id)

                -- Establecemos la informacion IG
                    exports["MR1_Inicio"]:setValue(veh, 'ID', id)
                    exports["MR1_Inicio"]:setValue(veh, 'IDPersonaje', IDPersonaje)
                    exports["MR1_Inicio"]:setValue(veh, 'Informacion', Informacion)
                    exports["MR1_Inicio"]:setValue(veh, 'Estado', Estado)
                    exports["MR1_Inicio"]:setValue(veh, 'Inventario', Inventario)
                -- Restamos el dinero al jugador
                    --varDataPlayer.Inventario["Dinero"] = varDataPlayer.Inventario["Dinero"] - Precio
                    
                    exports["MR6_Economia"]:restarDinero(client, Precio, "MR9_Concesionarios")
                    --exports["MR1_Inicio"]:setValue(client, 'Inventario', varDataPlayer.Inventario)
                    outputChatBox("#ffe100Acabo de comprar un #FF7800"..Vehiculo.." #ffe100por #FF7800"..formatNumber(Precio).." $#ffe100...", client, 255, 255, 255, true)     
                    
                    local result2 = exports["MR1_Inicio"]:query('SELECT STOCK FROM VehiculosConcesionario WHERE MODELO = ?', getVehicleModelFromName(Vehiculo))
                    local newStock = result2[1].STOCK - 1
                    exports["MR1_Inicio"]:execute("UPDATE VehiculosConcesionario SET STOCK='"..newStock.."' WHERE NOMBRE = ?", Vehiculo)
                    break
            end
        end
    end
    function Spawnear_Vehiculos_Player(player)
        setTimer(function()
            local varDataPlayer = exports["MR1_Inicio"]:getValueOne(player)
            if not varDataPlayer then
                return
            end
            local IDPersonaje = varDataPlayer.IDPersonaje
            local Vehiculos = exports["MR1_Inicio"]:query('SELECT * FROM VehiculosUsuarios WHERE IDPersonaje = ?', IDPersonaje)
            for i, Vehicle in ipairs(Vehiculos) do 
                local vehInformacion = fromJSON(Vehicle.INFORMACION)
                local vehEstado = fromJSON(Vehicle.ESTADO)
                local vehUbicacion = fromJSON(Vehicle.UBICACION)
                local vehTunning = fromJSON(Vehicle.TUNNING)
                local vehInventario = fromJSON(Vehicle.INVENTARIO)

                if (vehEstado.Destruido ~= true) then
                    if not isVehicleExists(vehInformacion["Matricula"]) then
                        local veh = createVehicle(vehInformacion["Modelo"], vehUbicacion["posX"], vehUbicacion["posY"], vehUbicacion["posZ"], vehUbicacion["rotX"], vehUbicacion["rotY"], vehUbicacion["rotZ"], vehInformacion["Matricula"])
                        setElementDimension(veh, vehUbicacion["Dimension"])
                        setElementInterior(veh, vehUbicacion["Interior"])

                        exports["MR1_Inicio"]:setValue(veh, 'ID', Vehicle.ID)
                        exports["MR1_Inicio"]:setValue(veh, 'IDPersonaje', Vehicle.IDPersonaje)
                        exports["MR1_Inicio"]:setValue(veh, 'Informacion', vehInformacion)
                        exports["MR1_Inicio"]:setValue(veh, 'Estado', vehEstado)
                        exports["MR1_Inicio"]:setValue(veh, 'Inventario', vehInventario)

                        setElementHealth( veh, tonumber(vehEstado["Salud"]))

                        setVehicleColor(veh, vehTunning.Color["R0"], vehTunning.Color["G0"], vehTunning.Color["B0"], vehTunning.Color["R1"], vehTunning.Color["G1"], vehTunning.Color["B1"], vehTunning.Color["R2"], vehTunning.Color["G2"], vehTunning.Color["B2"], vehTunning.Color["R3"], vehTunning.Color["G3"], vehTunning.Color["B3"])
                        setVehicleHeadLightColor(veh, vehTunning.Luces["R"], vehTunning.Luces["G"], vehTunning.Luces["B"])
                        setVehiclePaintjob(veh, vehTunning.Paintjob)

                        if vehTunning.Modificaciones then
                            for ii, Tablas in ipairs(vehTunning.Modificaciones) do 
                                for iii, v in ipairs(Tablas) do
                                    addVehicleUpgrade ( veh, v )
                                end
                            end
                        end
        
                        setVehicleLocked(veh, vehEstado["Bloqueo"])
                        setVehicleEngineState(veh, vehEstado["Motor"])
                        if (vehEstado["Luces"] == true) then
                            setVehicleOverrideLights(veh, 2)
                        else
                            setVehicleOverrideLights(veh, 1)
                        end
                    end
                end

            end
        end, 10000, 1)
    end
    function Recuperar_Veh(MatriculaVeh, PrecioDesguace, IdVeh)
        local varDataPlayer = exports["MR1_Inicio"]:getValueOne(client)

        if not (varDataPlayer.Inventario["Dinero"] >= PrecioDesguace) then
            return outputChatBox("#ffe100No tengo los "..formatNumber(PrecioDesguace).." dolares del vehiculo...", 255, 255, 255, true) 
        end 
        --varDataPlayer.Inventario["Dinero"] = varDataPlayer.Inventario["Dinero"] - PrecioDesguace
        
        exports["MR6_Economia"]:restarDinero(client, PrecioDesguace, "MR9_Concesionarios")
        --exports["MR1_Inicio"]:setValue(client, 'Inventario', varDataPlayer.Inventario)
        outputChatBox("#ffe100He recuperado el vehiculo #FF7800"..MatriculaVeh.." #ffe100por #FF7800"..formatNumber(PrecioDesguace).." $#ffe100...", client, 255, 255, 255, true)     

        if not isVehicleExists(MatriculaVeh) then
            for categoria, spawns in pairs(SpawnConcesionario) do
                if (categoria == "Desguace") then
                    local spawnLibre = nil
                    local vehiculos = getElementsByType("vehicle")
                    for _, spawn in ipairs(spawns) do
                        local posX, posY, posZ, rotX, rotY, rotZ = unpack(spawn)
                        local spawnOcupado = false
                        -- Verificar si hay un vehículo en esta posición
                        for _, vehiculo in ipairs(vehiculos) do
                            local x, y, z = getElementPosition(vehiculo)
                            -- Comprobar si el vehículo está lo suficientemente cerca
                            local distancia = getDistanceBetweenPoints3D(x, y, z, posX, posY, posZ)
                            if distancia < 3 then
                                spawnOcupado = true
                                break
                            end
                        end
                        if not spawnOcupado then
                            -- No hay vehículos en esta posición, es seguro usarla
                            spawnLibre = spawn
                            break
                        end
                    end
                    if spawnLibre then

                        local DataVeh = exports["MR1_Inicio"]:query("SELECT * FROM VehiculosUsuarios WHERE ID=?", IdVeh)
                        local newEstado = {Salud = 300, Destruido = "semi", Bloqueo = true, Motor = false, Luces = false}
                        exports["MR1_Inicio"]:execute("UPDATE VehiculosUsuarios SET Estado='"..toJSON(newEstado).."' WHERE ID=?", IdVeh)
                        for i, Data in ipairs(DataVeh) do 
                            local vehEstado = fromJSON(Data.ESTADO)
                            local vehInformacion = fromJSON(Data.INFORMACION)
                            local vehUbicacion = fromJSON(Data.UBICACION)
                            local vehTunning = fromJSON(Data.TUNNING)
                            local vehInventario = fromJSON(Data.INVENTARIO)

                            local posX, posY, posZ, rotX, rotY, rotZ = unpack(spawnLibre)

                            local veh = createVehicle(vehInformacion["Modelo"], posX, posY, posZ, rotX, rotY, rotZ, vehInformacion["Matricula"])

                            exports["MR1_Inicio"]:setValue(veh, 'ID', Data.ID)
                            exports["MR1_Inicio"]:setValue(veh, 'IDPersonaje', Data.IDPersonaje)
                            exports["MR1_Inicio"]:setValue(veh, 'Informacion', vehInformacion)
                            exports["MR1_Inicio"]:setValue(veh, 'Inventario', vehInventario)
                            vehEstado["Salud"] = 300
                            vehEstado["Destruido"] = "semi"
                            vehEstado["Motor"] = false
                            exports["MR1_Inicio"]:setValue(veh, 'Estado', vehEstado)
                            setElementHealth( veh, tonumber(vehEstado["Salud"]))
                            setVehicleColor(veh, vehTunning.Color["R0"], vehTunning.Color["G0"], vehTunning.Color["B0"], vehTunning.Color["R1"], vehTunning.Color["G1"], vehTunning.Color["B1"], vehTunning.Color["R2"], vehTunning.Color["G2"], vehTunning.Color["B2"], vehTunning.Color["R3"], vehTunning.Color["G3"], vehTunning.Color["B3"])
                            setVehicleHeadLightColor(veh, vehTunning.Luces["R"], vehTunning.Luces["G"], vehTunning.Luces["B"])
                            setVehiclePaintjob(veh, vehTunning.Paintjob)
                            if vehTunning.Modificaciones then
                                for ii, Tablas in ipairs(vehTunning.Modificaciones) do 
                                    for iii, v in ipairs(Tablas) do
                                        addVehicleUpgrade ( veh, v )
                                    end
                                end
                            end
                            setVehicleOverrideLights(veh, 1)
                            setVehicleLocked(veh, true)
                            setVehicleEngineState(veh, false)
                        end
                    else
                        -- No se encontraron spawns libres en esta categoría
                        return outputChatBox("No hay spawns libres en esta categoría.", client, 255, 0, 0, true)
                    end
                end
            end

        end
    end
    setTimer(function() 
        local VehiculosBorrados = 0;

        for i, Vehicle in ipairs(getElementsByType('vehicle')) do
            local DataVeh = exports["MR1_Inicio"]:getValueOne(Vehicle)
            
            if DataVeh and DataVeh["IDPersonaje"] then
                local ownerConnected = false
        
                for j, Personaje in ipairs(getElementsByType('player')) do
                    local varDataPlayer = exports["MR1_Inicio"]:getValueOne(Personaje)
        
                    if DataVeh["IDPersonaje"] == varDataPlayer["IDPersonaje"] then
                        -- El dueño está conectado
                        ownerConnected = true
                        break -- Salir del bucle de jugadores porque ya se encontró al dueño conectado
                    end
                end
                local vehicleOccupied = false
                for seat = 0, getVehicleMaxPassengers(Vehicle) do
                    if getVehicleOccupant(Vehicle, seat) then
                        vehicleOccupied = true
                        break -- Salir del bucle si se encuentra un ocupante
                    end
                end
                if not ownerConnected and not vehicleOccupied then
                    -- El dueño no está conectado, eliminar el vehículo
                    --INFORMACION
                        --iprint(DataVeh["Informacion"])
                    --ESTADO
                        --iprint(DataVeh["Estado"])
                        estado = DataVeh["Estado"]
                        estado.Salud = getElementHealth(Vehicle)
                        if (getElementHealth(Vehicle) <= 300) then
                            estado.Destruido = true
                        end
        
                    --Ubicacion
                        local x, y, z = getElementPosition(Vehicle)
                        local rx, ry, rz = getElementRotation(Vehicle)
                        local Dim = getElementDimension(Vehicle)
                        local Int = getElementInterior(Vehicle)
                        local Ubicacion = { 
                            posX = x, posY = y, posZ = z, rotX = rx, rotY = ry, rotZ = rz, Dimension = Dim, Interior = Int
                        };
        
                    --Tunning
                        local CR0, CG0, CB0, CR1, CG1, CB1, CR2, CG2, CB2, CR3, CG3, CB3 = getVehicleColor(Vehicle, true)
                        local LR, LG, LB = getVehicleHeadLightColor(Vehicle)
                        local Tunning = {Color = {
                            R0 = CR0, G0 = CG0, B0 = CB0, R1 = CR1, G1 = CG1, B1 = CB1, R2 = CR2, G2 = CG2, B2 = CB2, R3 = CR3, G3 = CG3, B3 = CB3
                        }, Luces = {
                            R = LR, G = LG, B = LB
                        }, Modificaciones = {
                            getVehicleUpgrades(Vehicle)
                        }, Paintjob = getVehiclePaintjob(Vehicle)
                        };


                    exports["MR1_Inicio"]:execute("UPDATE VehiculosUsuarios SET Estado='"..toJSON(DataVeh["Estado"]).."', Ubicacion='"..toJSON(Ubicacion).."', Tunning='"..toJSON(Tunning).."', Inventario='"..toJSON(DataVeh["Inventario"]).."' WHERE ID=?", DataVeh["ID"])
                    destroyElement(Vehicle)
                    VehiculosBorrados = VehiculosBorrados + 1
                end
            end
        end
        outputChatBox("Se han eliminado "..VehiculosBorrados.." vehiculos de jugadores desconectados.")
    end, 3600000, 0) --3600000 = 1 Hora
-- Eventos y Handlers
    addEvent("Comprar_Vehiculo", true)
    addEventHandler("Comprar_Vehiculo", getRootElement(), Comprar_Vehiculo)
    addEvent("Recuperar_Vehiculo", true)
    addEventHandler("Recuperar_Vehiculo", getRootElement(), Recuperar_Veh)
    addEventHandler("onResourceStop", resourceRoot, StopConcesionarios)

-- Inicialización
    function Iniciar_Recurso_Concesionario(resource)
        exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS VehiculosConcesionario (ID INT NOT NULL UNIQUE AUTO_INCREMENT, NOMBRE VARCHAR(255) NOT NULL, MODELO INT NOT NULL, PRECIO INT NOT NULL, CATEGORIA VARCHAR(255) NOT NULL, STOCK INT NOT NULL, PRIMARY KEY(ID));")
        exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS VehiculosUsuarios (ID INT NOT NULL UNIQUE AUTO_INCREMENT, IDPersonaje INT NOT NULL, INFORMACION VARCHAR(255) NOT NULL, ESTADO VARCHAR(255) NOT NULL, UBICACION VARCHAR(255) NOT NULL, TUNNING VARCHAR(255) NOT NULL, INVENTARIO VARCHAR(255) NOT NULL, PRIMARY KEY(ID));")

        for i = 65, 90 do
            table.insert(letras, string.char(i))
        end

        for i, Concesionario in ipairs (Concesionarios) do
            local varPickupConcesionario = createPickup(Concesionario[1], Concesionario[2], Concesionario[3], 3, 1274, 0, 0)
            local varBlipConcesionario = createBlipAttachedTo(varPickupConcesionario, 55, 255, 0, 0, 0, 255, 0, 200)
            addEventHandler("onPickupHit", varPickupConcesionario, function(source)
                bindKey(source, "H", "down", function(source, m)
                    triggerClientEvent(source, "Abrir_GUI_Concesionario", source, Concesionario[4])
                    local Vehiculos = nil;
                    local DataPJ = exports["MR1_Inicio"]:getValueOne(source)
                    local VehicleDestoyed = {}

                    if (Concesionario[4] == "Desguace") then
                        Vehiculos = exports["MR1_Inicio"]:query('SELECT * FROM VehiculosUsuarios WHERE IDPersonaje = ?', DataPJ.IDPersonaje)
                        for i, vehicle in ipairs(Vehiculos) do
                            local vehEstado = fromJSON(vehicle.ESTADO)
                            if vehEstado.Destruido == true then
                                local vehInformacion = fromJSON(vehicle.INFORMACION)
                                local vehUbicacion = fromJSON(vehicle.UBICACION)
                                local vehTunning = fromJSON(vehicle.TUNNING)
                                table.insert(VehicleDestoyed, {
                                    Vehiculo = vehInformacion.Matricula,
                                    Precio = 50,
                                    IDVehiculo = vehicle.ID
                                })
                            end
                        end
                        triggerClientEvent(source, "Actualizar_Desguace", source, VehicleDestoyed)
                    else
                        Vehiculos = exports["MR1_Inicio"]:query('SELECT * FROM VehiculosConcesionario WHERE Categoria = ?', Concesionario[4])
                        triggerClientEvent(source, "Actualizar_Lista", source, Vehiculos)
                    end
                    unbindKey(source,"H")
                end)
            end)
            addEventHandler("onPickupLeave", varPickupConcesionario, function(source, m)
                unbindKey(source,"H")
            end)
        end
        
        for i, Venta_Estado in ipairs (VentaEstado) do
            local varMarkerVenta = createMarker(Venta_Estado[1], Venta_Estado[2], Venta_Estado[3], "cylinder", Venta_Estado[4], 255, 255, 0, 170)
            local varBlipVenta = createBlipAttachedTo(varMarkerVenta, 36, 255, 0, 0, 0, 255, 0, 200)
            addEventHandler("onMarkerHit", varMarkerVenta, function(source)
                
                if (getElementType(source) == "vehicle") then
                    local Conductor = getVehicleController(source)
                    bindKey(Conductor, "H", "down", function(source, m)
                        --iprint(source)
                        local varInformacion_Vehicle = exports["MR1_Inicio"]:getValueOne(getPedOccupiedVehicle(Conductor))
                        if not (varInformacion_Vehicle) then
                            return
                        end
                        if string.find(varInformacion_Vehicle.Informacion["Matricula"], "Bike") then
                            outputChatBox("#FF0000No puedes vender una bicicleta de alquiler.", Conductor, 255, 255, 255, true)
                            unbindKey(Conductor, "H")
                            return
                        end
                        local varData_Source = exports["MR1_Inicio"]:getValueOne(Conductor) --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
                        if (varInformacion_Vehicle.IDPersonaje == varData_Source.IDPersonaje) then
                            local PrecioReal = exports["MR1_Inicio"]:query('SELECT PRECIO FROM VehiculosConcesionario WHERE MODELO = ?', getVehicleModelFromName(getVehicleName(getPedOccupiedVehicle(Conductor))))
                            unbindKey(Conductor,"H")
                            local newPrecio = PrecioReal[1].PRECIO * 0.7
                            
                            --varData_Source.Inventario["Dinero"] = varData_Source.Inventario["Dinero"] + math.floor(newPrecio)
                            --exports["MR1_Inicio"]:setValue(Conductor, 'Inventario', varData_Source.Inventario)
                            exports["MR6_Economia"]:SumarDinero(Conductor, math.floor(newPrecio), "MR9_Concesionarios")
                            exports["MR1_Inicio"]:execute("UPDATE VehiculosUsuarios SET IDPersonaje=0 WHERE ID=?", varInformacion_Vehicle.ID)

                            --exports["MR1_Inicio"]:execute("DELETE FROM VehiculosUsuarios WHERE ID=?", varInformacion_Vehicle.ID)
                            destroyElement(getPedOccupiedVehicle(Conductor))
                            outputChatBox("#ffe100Acabo de vender mi vehiculo por #FF7800"..math.floor(newPrecio).." $#ffe100...", Conductor, 255, 255, 255, true) 
                            return
                        end
                    end)
                end
            end)
            addEventHandler("onMarkerLeave", varMarkerVenta, function(source, m)
                if (getElementType(source) == "vehicle") then
                    local Conductor = getVehicleController(source)
                    unbindKey(Conductor,"H")
                end
            end)
        end
        
        for i, Player in ipairs (getElementsByType("player")) do
            Spawnear_Vehiculos_Player(Player)
        end
        -- JESTER
        setModelHandling(559, "driveType", "rwd" ) --awd
        setModelHandling(559, "engineInertia", 5 )
        setModelHandling(559, "tractionMultiplier", 0.65) --0.69999998807907
        setModelHandling(559, "tractionLoss", 0.9 ) --240
        setModelHandling(559, "suspensionDamping", 0.12) --12
        -- SUPER GT
	    setModelHandling(506, "tractionBias", 0.445)
        -- COMET
        setModelHandling(480, "driveType", "rwd" ) --awd
	    setModelHandling(480, "tractionBias", 0.485)
    end
    addEventHandler("onResourceStart", resourceRoot, Iniciar_Recurso_Concesionario)
