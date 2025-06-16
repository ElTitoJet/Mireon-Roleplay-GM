-- MRFam0_Plantilla
-- Script que gestiona la familia.
-- Autor: ElTitoJet
-- Fecha: 27/09/2024

-- Variables Globales y Configuración
local ComandosFam = {
    "/verfacciones",
    "/faccestado",
    "/faccnombre",
    "/facccolor",
    "/faccverrangos",
    "/facceditarrangos ",
    "/faccasignar",
    "/faccquitar",
    "/faccver",
    "/faccinvite"
}
local Hoods = {}
local PickUpsEnterHoods = createElement("PickUps")
local PickUpsLeaveHoods = createElement("PickUps")

-- Funciones Auxiliares
function FaccCheckRank(player)
    local varDataSource = exports["MR1_Inicio"]:getValueOne(player)
    if not (varDataSource.InfoCuenta["Rango"] == 8 or varDataSource.InfoCuenta["Rango"] == 10) then
        return false
    end
    return true
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
function crearPickUp(x, y, z, int, dim, parentElement, tipo, index)
    local pickup = createPickup(x, y, z, 3, 1318, 0, 0) -- Crear el pickup
    setElementInterior(pickup, int) -- Establecer interior
    setElementDimension(pickup, dim) -- Establecer dimensión
    setElementParent(pickup, parentElement) -- Agrupar el pickup
    setElementID(pickup, tipo .. "_" .. index) -- Asignar un ID único
end
-- Funciones Principales
function FaccCommands(source, command)
    local Permiso = FaccCheckRank(source)
    if not Permiso then
        return
    end
    outputChatBox("#9AA498==== [#A03535Lista de Comandos Facciones#9AA498] ====", source, 255, 255, 255, true)
    local filaComandos = "" -- Variable para almacenar los comandos por fila
    local contador = 0      -- Contador para controlar los comandos en cada fila
    for _, comando in ipairs(ComandosFam) do
        filaComandos = filaComandos .. comando .. ", "
        contador = contador + 1

        -- Cuando hay 4 comandos en la fila o es el último comando, mostrar la fila
        if contador == 4 or _ == #ComandosFam then
            outputChatBox("#9AA498" .. filaComandos, source, 255, 255, 255, true)
            filaComandos = ""  -- Reiniciar la fila
            contador = 0       -- Reiniciar el contador
        end
    end
end
function FaccStart()
    local players = getElementsByType("player") -- Coge todos los Elementos tipo Jugador
    for _, player in ipairs(players) do
        bindKey(player, "f4", "down", function(source, m)
            local varDatasource = exports["MR1_Inicio"]:getValueOne(source) 
            if varDatasource.Familia and varDatasource.Familia["Nombre"] ~= "Libre" then
                triggerClientEvent(source, "Facciones::PanelFaccion::AbrirMiPanel", source)
            end
        end)
    end 
    setTimer(function()
        local varDataFacciones = exports["MR1_Inicio"]:query('SELECT * FROM Facciones WHERE Activo = "true";')
        for i, Familia in ipairs(varDataFacciones) do
            -- VEHICULOS
                local colorJSON = fromJSON(Familia.Color)
                local varDataVehiculosFamilias = exports["MR1_Inicio"]:query('SELECT * FROM FamiliasVehiculos WHERE IDFamilia = ?', Familia.ID)
                for i2, Vehiculo in ipairs(varDataVehiculosFamilias) do
                    local vehInformacion = fromJSON(Vehiculo.INFORMACION)
                    local vehEstado = fromJSON(Vehiculo.ESTADO)
                    local vehUbicacion = fromJSON(Vehiculo.UBICACION)
                    local vehTunning = fromJSON(Vehiculo.TUNNING)
                    local vehInventario = fromJSON(Vehiculo.INVENTARIO)

                    if not isVehicleExists(vehInformacion["Matricula"]) then
                        --iprint(vehInformacion["Matricula"])
                        local veh = createVehicle(vehInformacion["Modelo"], vehUbicacion["posX"], vehUbicacion["posY"], vehUbicacion["posZ"], vehUbicacion["rotX"], vehUbicacion["rotY"], vehUbicacion["rotZ"], vehInformacion["Matricula"])
                        setElementDimension(veh, vehUbicacion["Dimension"])
                        setElementInterior(veh, vehUbicacion["Interior"])

                        exports["MR1_Inicio"]:setValue(veh, 'IDVeh', Vehiculo.ID)
                        exports["MR1_Inicio"]:setValue(veh, 'IDFamilia', Familia.ID)
                        exports["MR1_Inicio"]:setValue(veh, 'Personaje', Familia.Nombre)
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
            -- HOODS
                local varDataHoodsFamilias = exports["MR1_Inicio"]:query('SELECT * FROM FamiliasInteriores WHERE IDFam = ?', Familia.ID)
                for i2, Hood in ipairs(varDataHoodsFamilias) do
                    Hoods[i] = {
                        id_fam = Hood.IDFam,
                        entrada_x = Hood.entrada_x,
                        entrada_y = Hood.entrada_y,
                        entrada_z = Hood.entrada_z,
                        entrada_int = Hood.entrada_int,
                        entrada_dim = Hood.entrada_dim,
                        salida_x = Hood.salida_x,
                        salida_y = Hood.salida_y,
                        salida_z = Hood.salida_z,
                        salida_int = Hood.salida_int,
                        salida_dim = Hood.salida_dim
                    }
                    -- Crear Pickup de Entrada con Blip
                    crearPickUp(Hoods[i].entrada_x, Hoods[i].entrada_y, Hoods[i].entrada_z, Hoods[i].entrada_int, Hoods[i].entrada_dim, PickUpsEnterHoods, "Entrada", i)
                    
                    -- Crear Pickup de Salida sin Blip
                    crearPickUp(Hoods[i].salida_x, Hoods[i].salida_y, Hoods[i].salida_z, Hoods[i].salida_int, Hoods[i].salida_dim, PickUpsLeaveHoods, "Salida", i)
                end
        end
    end, 3000, 1)
end
function setFamUser(client)
    local varDataClient = exports["MR1_Inicio"]:getValueOne(client)
    local varFamiliasUsers = exports["MR1_Inicio"]:query('SELECT * FROM FamiliasUsers WHERE Personajes = ?', varDataClient.IDPersonaje)

    if varFamiliasUsers and #varFamiliasUsers >= 1 then
        local varDataFacciones = exports["MR1_Inicio"]:query('SELECT * FROM Familias WHERE ID = ?', varFamiliasUsers[1].Familia)
        Familia = {
            FamiliaID = varFamiliasUsers[1].Familia,
            Nombre = varDataFacciones[1].Nombre,
            Rango = varFamiliasUsers[1].Rango
        }
        exports["MR1_Inicio"]:setValue(client, 'Familia', Familia)
        famplayerON(client)
    else
        exports["MR1_Inicio"]:execute("INSERT INTO FamiliasUsers(Personajes, Familia, Rango) VALUES(?,?,?)", varDataClient.IDPersonaje, 1, 1)
        Familia = {
            FamiliaID = 1,
            Nombre = "Libre",
            Rango = 1
        }
        exports["MR1_Inicio"]:setValue(client, 'Familia', Familia)
    end
end
function verFamilias(source, cmd, filtro)
    local Permiso = FaccCheckRank(source)
    if not Permiso then
        return
    end
    local consulta = ""
    
    -- Definir la consulta según el filtro recibido
    if filtro == "activas" then
        consulta = 'SELECT * FROM Familias WHERE Activo = "true";'
    elseif filtro == "inactivas" then
        consulta = 'SELECT * FROM Familias WHERE Activo = "false";'
    elseif filtro == "todas" then
        consulta = 'SELECT * FROM Familias;'
    else
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/verfamilias [todas/activas/inactivas]", source, 255, 255, 255, true)
    end
    
    -- Consultar la base de datos
    local Familias = exports["MR1_Inicio"]:query(consulta)

    if Familias and #Familias > 0 then
        outputChatBox("==== Familias (" .. filtro .. ") ====", source, 255, 255, 0)

        for _, familia in ipairs(Familias) do
            -- Intentar extraer los valores RGB del campo 'Color'
            local colorJSON = fromJSON(familia.Color)
            
            -- Verificar que el JSON de color sea válido y tenga las claves R, G, B
            if colorJSON and colorJSON.R and colorJSON.G and colorJSON.B then
                local r, g, b = colorJSON.R, colorJSON.G, colorJSON.B
                
                -- Definir el color del estado (verde si está activa, rojo si no)
                local estado = familia.Activo == "true" and "#00FF00Activa" or "#FF0000Inactiva"
                
                -- Añadir la columna 'Ubicacion' en color azul (#0000FF)
                local ubicacion = familia.Ubicacion or "Desconocida"
                
                -- Mostrar el ID en blanco, nombre (en su color), ubicación (azul) y estado
                local mensaje = string.format(
                    "#FFFFFFID: %d - Nombre: #%.2X%.2X%.2X%s#FFFFFF - Ubicación: #c06500%s#FFFFFF - Estado: %s",
                    familia.ID, r, g, b, familia.Nombre, ubicacion, estado
                )
                outputChatBox(mensaje, source, 255, 255, 255, true)
            else
                -- Si el color no es válido, mostrar el nombre sin color y ubicación en azul
                local ubicacion = familia.Ubicacion or "Desconocida"
                outputChatBox(
                    string.format(
                        "#FFFFFFID: %d - Nombre: %s - Ubicación: #c06500%s#FFFFFF - Estado: %s",
                        familia.ID, familia.Nombre, ubicacion,
                        (familia.Activo == "true" and "#00FF00Activa" or "#FF0000Inactiva")
                    ),
                    source, 255, 255, 255, true
                )
            end
        end
    else
        outputChatBox("No se encontraron familias " .. filtro, source, 255, 0, 0)
    end
end
function cambiarEstadoFamilia(source, cmd, accion, idFamilia)
    local Permiso = FaccCheckRank(source)
    if not Permiso then
        return
    end
    -- Validar que se pasaron ambos parámetros
    if not accion or not idFamilia or not tonumber(idFamilia) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/famestado [activar/desactivar] [ID]", source, 255, 255, 255, true)
    end
    -- Validar la acción
    if accion ~= "activar" and accion ~= "desactivar" then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/famestado [activar/desactivar] [ID]", source, 255, 255, 255, true)
    end
    -- Determinar el estado según la acción
    local nuevoEstado = accion == "activar" and "true" or "false"
    -- Comprobar si la familia existe en la base de datos
    local idFamiliaNum = tonumber(idFamilia)
    local consulta = exports["MR1_Inicio"]:query("SELECT * FROM Familias WHERE ID = ?", idFamiliaNum)

    if not consulta or #consulta == 0 then
        return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFLa familia con ID " .. idFamilia .. " no existe.", source, 255, 0, 0, true)
    end
    if consulta[1].Activo == nuevoEstado then
        local mensajeEstado = accion == "activar" and "activada" or "desactivada"
        return outputChatBox("#9AA498[#A03535Info#9AA498] #FFFFFFLa familia con ID " .. idFamilia .. " ya estaba " .. mensajeEstado .. ".", source, 0, 255, 0, true)
    end
    -- Actualizar el estado de la familia en la base de datos
    local resultado = exports["MR1_Inicio"]:execute("UPDATE Familias SET Activo = ? WHERE ID = ?", nuevoEstado, idFamiliaNum)
    
    -- Comprobar si la actualización fue exitosa
    if resultado then
        local mensajeEstado = accion == "activar" and "activada" or "desactivada"
        outputChatBox("#9AA498[#A03535Info#9AA498] #FFFFFFLa familia con ID " .. idFamilia .. " ha sido " .. mensajeEstado .. " correctamente.", source, 0, 255, 0, true)
    else
        outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFHubo un problema al actualizar el estado de la familia.", source, 255, 0, 0, true)
    end
    
    -- ACTUALIZAR CLIENTES
        local varDataFacciones = exports["MR1_Inicio"]:query('SELECT * FROM Familias WHERE Activo = "true"')
        local familiasProcesadas = {}
        for i, Familia in ipairs(varDataFacciones) do 
            local famTerritorio = fromJSON(Familia.Territorio)
            local famColor = fromJSON(Familia.Color)
            if famTerritorio and famColor then
                table.insert(familiasProcesadas, {
                    Territorio = famTerritorio,
                    Color = famColor
                })
            end
        end

        if #familiasProcesadas > 0 then
            local objetives = getElementsByType("player") -- Coge todos los Elementos tipo Jugador
            for i,v in pairs(objetives) do -- Hace una lista de todos los jugadores
                triggerClientEvent(v, "Familias::Territorios::ActualizarTerritorios", v, familiasProcesadas)
            end
            
        else
            outputDebugString("No hay familias activas para enviar.")
        end
end
function cambiarNombreFamilia(source, cmd, id, ...)
    local Permiso = FaccCheckRank(source)
    if not Permiso then
        return
    end
    -- Verificar que se hayan proporcionado los argumentos necesarios
    if not id or ... == "" then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFUso: /famnombre [ID] [NuevoNombre]", source, 255, 255, 255, true)
    end

    -- Convertir el ID en un número
    local idFamilia = tonumber(id)
    
    if not idFamilia then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFEl ID debe ser un número válido.", source, 255, 255, 255, true)
    end

    -- Juntar todos los argumentos del nombre en una cadena de texto
    local nuevoNombre = table.concat({...}, " ")

    -- Revisar si el nuevo nombre tiene una longitud válida
    if #nuevoNombre < 3 or #nuevoNombre > 50 then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFEl nombre debe tener entre 3 y 50 caracteres.", source, 255, 255, 255, true)
    end

    -- Realizar la actualización en la base de datos
    local resultado = exports["MR1_Inicio"]:query("UPDATE Familias SET Nombre = ? WHERE ID = ?", nuevoNombre, idFamilia)

    -- Verificar si la actualización fue exitosa
    if resultado then
        outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFNombre de la familia con ID " .. idFamilia .. " actualizado a: " .. nuevoNombre, source, 255, 255, 255, true)
    else
        outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FF0000Error: No se pudo actualizar el nombre. Revisa el ID.", source, 255, 0, 0, true)
    end
end
function cambiarColorFamilia(source, cmd, id, r, g, b)
    local Permiso = FaccCheckRank(source)
    if not Permiso then
        return
    end
    -- Verificar que se hayan proporcionado los argumentos necesarios
    if not id or not r or not g or not b then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFUso: /famcolor [ID] [R] [G] [B]", source, 255, 255, 255, true)
    end

    -- Convertir el ID y los valores de color en números
    local idFamilia = tonumber(id)
    local red = tonumber(r)
    local green = tonumber(g)
    local blue = tonumber(b)

    -- Verificar que los valores sean válidos
    if not idFamilia then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFEl ID debe ser un número válido.", source, 255, 255, 255, true)
    end

    if not red or not green or not blue or red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFLos valores de R, G y B deben ser números entre 0 y 255.", source, 255, 255, 255, true)
    end

    -- Crear el JSON del color
    local colorJSON = toJSON({R = red, G = green, B = blue})

    -- Actualizar la base de datos
    local resultado = exports["MR1_Inicio"]:query("UPDATE Familias SET Color = ? WHERE ID = ?", colorJSON, idFamilia)

    -- Verificar si la actualización fue exitosa
    if resultado then
        outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFEl color de la familia con ID " .. idFamilia .. " ha sido actualizado a R: " .. red .. " G: " .. green .. " B: " .. blue, source, 255, 255, 255, true)
    else
        outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FF0000Error: No se pudo actualizar el color. Revisa el ID.", source, 255, 0, 0, true)
    end
end
function famverrangos(source, cmd, IDFam)
    local Permiso = FaccCheckRank(source)
    if not Permiso then
        return
    end
    -- Verificar que se ingrese el ID de la familia
    if not IDFam or tonumber(IDFam) == nil then
        return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFPor favor, proporciona un ID de familia válido.", source, 255, 255, 255, true)
    end

    -- Realizar la consulta para obtener los rangos de la familia
    local consulta = 'SELECT * FROM FamiliasRangos WHERE IDFam = ? ORDER BY IDRango DESC'
    local rangos = exports["MR1_Inicio"]:query(consulta, tonumber(IDFam))

    -- Verificar si se encontraron rangos para la familia
    if rangos and #rangos > 0 then
        outputChatBox("==== Rangos de la Familia ID: " .. IDFam .. " ====", source, 255, 255, 0)
        for _, rango in ipairs(rangos) do
            outputChatBox("Rango ID: " .. rango.IDRango .. " - Nombre: " .. rango.Nombre, source, 255, 255, 255)
        end
    else
        outputChatBox("No se encontraron rangos para la familia con ID " .. IDFam, source, 255, 0, 0)
    end
end
function fameditarrangos(source, cmd, IDFam, IDRango, ...)
    local Permiso = FaccCheckRank(source)
    if not Permiso then
        return
    end
    -- Verificar que se proporcionen todos los argumentos necesarios
    if not IDFam or not IDRango or not ... then
        return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFUso: /fameditarrangos [IDFam] [IDRango] [Nuevo Nombre]", source, 255, 255, 255, true)
    end

    -- Convertir a números para asegurarnos de que son válidos
    IDFam = tonumber(IDFam)
    IDRango = tonumber(IDRango)

    if not IDFam or not IDRango then
        return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFEl ID de familia y el ID de rango deben ser números válidos.", source, 255, 255, 255, true)
    end

    -- Obtener el nuevo nombre (todas las palabras que se pasen después del ID de rango)
    local nuevoNombre = table.concat({...}, " ")

    -- Ejecutar la consulta para actualizar el nombre del rango
    local resultado = exports["MR1_Inicio"]:execute('UPDATE FamiliasRangos SET Nombre = ? WHERE IDFam = ? AND IDRango = ?', nuevoNombre, IDFam, IDRango)

    if resultado then
        outputChatBox("#9AA498[#A03535Éxito#9AA498] #FFFFFFEl rango con ID " .. IDRango .. " de la familia con ID " .. IDFam .. " ha sido renombrado a '" .. nuevoNombre .. "'.", source, 0, 255, 0, true)
    else
        outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFNo se pudo actualizar el nombre del rango. Verifica que los IDs sean correctos.", source, 255, 0, 0, true)
    end
end
function famasignar(source, cmd, objetivoID, IDFam, IDRango)
    -- Comprobar si soy ADM. Familias
        local Permiso = FaccCheckRank(source)
        if not Permiso then
            return
        end
    -- Verificar que se proporcionen todos los argumentos necesarios
        if not objetivoID or not IDFam or not IDRango then
            return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFUso: /famasignar [IDUser] [IDFam] [IDRango]", source, 255, 255, 255, true)
        end

    -- Convertir a números para asegurarnos de que son válidos
        IDFam = tonumber(IDFam)
        IDRango = tonumber(IDRango)
        if not IDFam or not IDRango then
            return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFEl ID de familia y el ID de rango deben ser números válidos.", source, 255, 255, 255, true)
        end
    -- Comprobar que el rango sea entre 1 y 7
        if IDRango > 7 or IDRango < 1 then
            return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFEl ID de rango deben ser entre 1 y 7.", source, 255, 255, 255, true)
        end
    -- Seleccion de objetivo
        local objetivo = nil
        if tonumber(objetivoID) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetivoID)
        elseif isElement(getPlayerFromName(objetivoID)) then
            objetivo = getPlayerFromName(objetivoID)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no está conectado.", source, 255, 255, 255, true)
        end
        if not isElement(objetivo) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no está conectado.", source, 255, 255, 255, true)
        end
    -- Obtener datos de la familia
        local resultadoFamilia = exports["MR1_Inicio"]:query("SELECT * FROM Familias WHERE ID = ?", IDFam)
        if not resultadoFamilia or #resultadoFamilia == 0 then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535No se encontró la familia con ID " .. IDFam .. ".", source, 255, 255, 255, true)
        end

    -- Actualizar los datos del jugador objetivo en la data interna
        local varDataUser = exports["MR1_Inicio"]:getValueOne(objetivo)
        if not varDataUser.Familia then
            varDataUser.Familia = {
                FamiliaID = IDFam,
                Nombre = resultadoFamilia[1].Nombre,
                Rango = IDRango
            }
            exports["MR1_Inicio"]:setValue(objetivo, "Familia", varDataUser.Familia)
        else
            -- Si ya tiene familia, actualizar los datos
            varDataUser.Familia["FamiliaID"] = IDFam
            varDataUser.Familia["Nombre"] = resultadoFamilia[1].Nombre
            varDataUser.Familia["Rango"] = IDRango
            exports["MR1_Inicio"]:setValue(objetivo, "Familia", varDataUser.Familia)
        end

    -- Actualizar los datos del jugador objetivo en la DB
        local varDataFacciones = exports["MR1_Inicio"]:query("SELECT * FROM FamiliasUsers WHERE Personajes=?", varDataUser.IDPersonaje)
        if varDataFacciones and #varDataFacciones == 1 then
            exports["MR1_Inicio"]:execute("UPDATE FamiliasUsers SET Familia="..IDFam..", Rango="..IDRango.." WHERE Personajes=?", varDataUser.IDPersonaje)
        else
            exports["MR1_Inicio"]:execute("INSERT INTO FamiliasUsers(Personajes, Familia, Rango) VALUES(?,?,?)", varDataUser.IDPersonaje, IDFam, IDRango)
        end

    -- Confirmación al jugador
        outputChatBox("#9AA498[#A03535Éxito#9AA498] #FFFFFFHas asignado al jugador " .. getPlayerName(objetivo) .. " al rango " .. IDRango .. " de la familia con ID " .. IDFam .. ".", source, 0, 255, 0, true)

    -- Notificación al jugador objetivo
        outputChatBox("#9AA498[#A03535Éxito#9AA498] #FFFFFFHas sido asignado al rango " .. IDRango .. " de la familia " .. varDataUser.Familia.Nombre .. ".", objetivo, 0, 255, 0, true)
end
function famquitar(source, cmd, objetivoID)
    -- Comprobar si soy ADM. Familias
        local Permiso = FaccCheckRank(source)
        if not Permiso then
            return
        end
    -- Verificar que se proporcione el ID del jugador objetivo
        if not objetivoID then
            return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFUso: /famquitar [IDUser]", source, 255, 255, 255, true)
        end

    -- Buscar el jugador objetivo
        local objetivo = nil
        if tonumber(objetivoID) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(tonumber(objetivoID))
        elseif isElement(getPlayerFromName(objetivoID)) then
            objetivo = getPlayerFromName(objetivoID)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no está conectado.", source, 255, 255, 255, true)
        end
        if not isElement(objetivo) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no está conectado.", source, 255, 255, 255, true)
        end
    -- Actualizar la data interna
        local varDataUser = exports["MR1_Inicio"]:getValueOne(objetivo)
        if not varDataUser.Familia then
            varDataUser.Familia = {
                FamiliaID = 1,
                Nombre = "Libre",
                Rango = 1
            }
            exports["MR1_Inicio"]:setValue(objetivo, "Familia", varDataUser.Familia)
        else
            -- Si ya tiene familia, actualizar los datos
            
            varDataUser.Familia["FamiliaID"] = 1
            varDataUser.Familia["Nombre"] = "Libre"
            varDataUser.Familia["Rango"] = 1
            exports["MR1_Inicio"]:setValue(objetivo, "Familia", varDataUser.Familia)
        end
    -- Actualizar la data externa
        local varDataFacciones = exports["MR1_Inicio"]:query("SELECT * FROM FamiliasUsers WHERE Personajes=?", varDataUser.IDPersonaje)
        if varDataFacciones and #varDataFacciones == 1 then
            exports["MR1_Inicio"]:execute("UPDATE FamiliasUsers SET Familia=1, Rango=1 WHERE Personajes=?", varDataUser.IDPersonaje)
        else
            exports["MR1_Inicio"]:execute("INSERT INTO FamiliasUsers(Personajes, Familia, Rango) VALUES(?,?,?)", varDataUser.IDPersonaje, 1, 1)
        end

    -- Confirmación al jugador que ejecutó el comando
        outputChatBox("#9AA498[#A03535Éxito#9AA498] #FFFFFFHas quitado al jugador " .. getPlayerName(objetivo) .. " de su familia.", source, 0, 255, 0, true)

    -- Notificación al jugador objetivo
        outputChatBox("#9AA498[#A03535Familia#9AA498] #FFFFFFHas sido removido de tu familia.", objetivo, 255, 0, 0, true)
end
function enviarTerritoriosFamilias()
    --iprint(source)
    local familiasProcesadas = {}
    local varDataFacciones = exports["MR1_Inicio"]:query('SELECT * FROM Familias WHERE Activo = "true"')
    for i, Familia in ipairs(varDataFacciones) do 
        --local famInfo = Familia.Nombre
        --local famUbi = Familia.Ubicacion
        local famTerritorio = fromJSON(Familia.Territorio)
        local famColor = fromJSON(Familia.Color)
        --local famActivo = Familia.Activo
        -- Verificar que se hayan convertido correctamente
        if famTerritorio and famColor then
            -- Insertar la información procesada en la tabla final
            table.insert(familiasProcesadas, {
                Territorio = famTerritorio, -- El territorio ya en formato tabla Lua
                Color = famColor -- El color ya en formato tabla Lua
            })
        end
    end
    -- Enviar la tabla ya procesada al cliente
        if #familiasProcesadas > 0 then
            triggerClientEvent(source, "Familias::Territorios::RecibirTerritorios", source, familiasProcesadas)
            --iprint("Datos procesados enviados al cliente.")
        else
            outputDebugString("No hay familias activas para enviar.")
        end
        --triggerClientEvent(source, "Familias::Territorios::RecibirTerritorios", source, varDataFacciones)
end
function FamGetMembers(IDFam)
    local varMiembrosFam = exports["MR1_Inicio"]:query('SELECT * FROM FamiliasUsers WHERE Familia =?', IDFam)

    local combinedResults = {}
    for i, MiembroFam in ipairs(varMiembrosFam) do
        local varDataPersonajes = exports["MR1_Inicio"]:query('SELECT Nombre FROM Personajes WHERE ID =?', MiembroFam.Personajes)
        local varDataRangos = exports["MR1_Inicio"]:query('SELECT Nombre FROM FamiliasRangos WHERE IDFam = ? AND IDRango = ?', IDFam, MiembroFam.Rango)
        local personajeConectado = false
        for _, player in ipairs(getElementsByType("player")) do
            if string.lower(getPlayerName(player)) == string.lower(varDataPersonajes[1].Nombre) then
                personajeConectado = true
                break
            end
        end
        local conectado = personajeConectado and "Conectado" or "Desconectado"

        table.insert(combinedResults, {
            IDPJ = MiembroFam.Personajes,  -- ID del personaje
            rank = varDataRangos[1].Nombre,  -- Rango
            CharacterName = varDataPersonajes[1].Nombre,  -- Nombre del personaje
            PlayerConectado = conectado
        })
    end
    -- Enviar la información combinada al cliente
    triggerClientEvent(client, 'Familias::Miembros::Entregar', client, combinedResults)
end
function FamUpdateMembers(IDFam, objetivo)
    --iprint(NombreFam, objetivo)
    local varMiembrosFam = exports["MR1_Inicio"]:query('SELECT * FROM FamiliasUsers WHERE Familia =?', IDFam)

    local combinedResults = {}
    for i, MiembroFam in ipairs(varMiembrosFam) do
        local varDataPersonajes = exports["MR1_Inicio"]:query('SELECT Nombre FROM Personajes WHERE ID =?', MiembroFam.Personajes)
        local varDataRangos = exports["MR1_Inicio"]:query('SELECT Nombre FROM FamiliasRangos WHERE IDFam = ? AND IDRango = ?', IDFam, MiembroFam.Rango)
        local personajeConectado = false
        for _, player in ipairs(getElementsByType("player")) do
            if string.lower(getPlayerName(player)) == string.lower(varDataPersonajes[1].Nombre) then
                personajeConectado = true
                break
            end
        end
        local conectado = personajeConectado and "Conectado" or "Desconectado"

        table.insert(combinedResults, {
            IDPJ = MiembroFam.Personajes,  -- ID del personaje
            rank = varDataRangos[1].Nombre,  -- Rango
            CharacterName = varDataPersonajes[1].Nombre,  -- Nombre del personaje
            PlayerConectado = conectado
        })
    end
    -- Enviar la información combinada al cliente
    triggerClientEvent(objetivo, 'Familias::Miembros::Entregar', objetivo, combinedResults)
end
function FamGestionMiembro(Accion, NombrePJ)
    -- Comprobar si el usuario tiene rango 6 o 7
        local varDataSource = exports["MR1_Inicio"]:getValueOne(client) 
        if not (varDataSource.Familia["Rango"] == 6 or varDataSource.Familia["Rango"] == 7) then
            -- Bloquear el flujo si el rango no es 6 o 7
            return outputChatBox("#9AA498[#FF7800Familia#9AA498] #A03535No eres ni lider ni sublider.", client, 255, 255, 255, true )
        end
    -- Comprobamos que no se modifique a si mismo
        local varNombreSource = getPlayerName(client)
        if not (varNombreSource ~= Personaje) then
            return outputChatBox("#9AA498[#FF7800Familias#9AA498] #A03535No te puedes ascender a ti mismo.", client, 255, 255, 255, true)
        end
    -- Obtenemos la data del jugador dentro de la DB.
        local varDataPersonaje = exports["MR1_Inicio"]:query('SELECT * FROM Personajes WHERE Nombre=?', NombrePJ)
        local varDataFamilia = exports["MR1_Inicio"]:query('SELECT * FROM FamiliasUsers WHERE Personajes=?', varDataPersonaje[1].ID)
    -- Obtenemos la data del jugando dentro de la Interna
        local Jugador = getPlayerFromName(NombrePJ)
        local varDataJugador = exports["MR1_Inicio"]:getValueOne(Jugador) 
    -- ACCIONES
        local msgclient, msgPersonaje, newFamID, newFamName, newRank;
        if Accion == "Ascender" then
            if varDataFamilia[1].Rango >= 7 then
                msgclient = "#9AA498[#FF7800Familia#9AA498] #24C5BE"..NombrePJ.."#53B440 ya esta en el rango mas alto."
                outputChatBox(msgclient, client, 255, 255, 255, true) 
                return
            else
                msgclient = "#9AA498[#FF7800Familia#9AA498] #53B440Has ascendido a #24C5BE"..NombrePJ.."#53B440."
                msgPersonaje = "#9AA498[#FF7800Familia#9AA498] #53B440Has sido ascendido por #24C5BE"..varNombreSource.."#53B440."
                newFamID = varDataFamilia[1].Familia
                newFamName = varDataJugador.Familia["Nombre"]
                newRank = varDataFamilia[1].Rango + 1
            end
        elseif Accion == "Descender" then
            if varDataFamilia[1].Rango < 1 or varDataFamilia[1].Rango == 1 then
                msgclient = "#9AA498[#FF7800Familia#9AA498] #24C5BE"..NombrePJ.."#53B440 ya esta en el rango mas bajo."
                outputChatBox(msgclient, client, 255, 255, 255, true) 
                return
            else
                msgclient = "#9AA498[#FF7800Familia#9AA498] #53B440Has degradado a #24C5BE"..NombrePJ.."#53B440."
                msgPersonaje = "#9AA498[#FF7800Familia#9AA498] #53B440Has sido degradado por #24C5BE"..varNombreSource.."#53B440."
                newFamID = varDataFamilia[1].Familia
                newFamName = varDataJugador.Familia["Nombre"]
                newRank = varDataFamilia[1].Rango - 1
            end
        elseif Accion == "Expulsar" then
            msgclient = "#9AA498[#FF7800Familia#9AA498] #53B440Has expulsado a #24C5BE"..NombrePJ.."#53B440."
            msgPersonaje = "#9AA498[#FF7800Familia#9AA498] #53B440Has sido expulsado por #24C5BE"..varNombreSource.."#53B440."
            newFamID = 1
            newFamName = "Libre"
            newRank = 1
        end
    -- APLICAR CAMBIOS
        if not (getPlayerFromName(NombrePJ)) then
            exports["MR1_Inicio"]:execute("UPDATE FamiliasUsers SET Rango="..newRank..", Familia ="..newFamID.." WHERE Personajes=?", varDataPersonaje[1].ID)
            outputChatBox(msgclient, client, 255, 255, 255, true) 
        else
            exports["MR1_Inicio"]:execute("UPDATE FamiliasUsers SET Rango="..newRank..", Familia ="..newFamID.." WHERE Personajes=?", varDataPersonaje[1].ID)
            outputChatBox(msgclient, client, 255, 255, 255, true) 

            outputChatBox(msgPersonaje, Jugador, 255, 255, 255, true) 
            Familia = {
                FamiliaID = newFamID,
                Nombre = newFamName,
                Rango = newRank
            }
            exports["MR1_Inicio"]:setValue(Jugador, "Familia", Familia)
        end
        FamUpdateMembers(newFamID, client)

end
function FamVigilarFam(source, cmd, IDFam)
    local Permiso = FaccCheckRank(source)
    if not Permiso then
        return
    end
    IDFam = tonumber(IDFam)
    if not IDFam then
        return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFEl ID de familia debe ser un número válido.", source, 255, 255, 255, true)
    end
    local resultadoFamilia = exports["MR1_Inicio"]:query("SELECT Nombre FROM Familias WHERE ID = ?", IDFam)
    if not resultadoFamilia or #resultadoFamilia == 0 then
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535No se encontró la familia con ID " .. IDFam .. ".", source, 255, 255, 255, true)
    end
    triggerClientEvent(source, "Familias::PanelFaccion::VerPanel", source, resultadoFamilia[1].Nombre, IDFam)
end
function famplayerON(client, familia)
    bindKey(client, "f4", "down", function(source, m)
        local varDatasource = exports["MR1_Inicio"]:getValueOne(source) 
        if varDatasource.Familia and varDatasource.Familia["Nombre"] ~= "Libre" then
            triggerClientEvent(source, "Familias::PanelFaccion::AbrirMiPanel", source)
        end
    end)
end
function famplayerInvite(source, cmd, objetivoID)
    -- Comprobamos que el comando lo esta metiendo un miembro de la familia
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not varDataSource.Familia or varDataSource.Familia["Familia"] == "Libre" then
            return
        end
    -- Comprobamos que el rango NO sea 6 o 7
        if not (varDataSource.Familia["Rango"] == 6 or varDataSource.Familia["Rango"] == 7) then
            return
        end
    -- Comprobamos que el comando esta correcto
        if not objetivoID then
            return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFUso: /faminvite [IDUser]", source, 255, 255, 255, true)
        end
    -- Comprobamos que el jugador existe
        local objetivo = nil
        if tonumber(objetivoID) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetivoID)
        elseif isElement(getPlayerFromName(objetivoID)) then
            objetivo = getPlayerFromName(objetivoID)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no está conectado.", source, 255, 255, 255, true)
        end
        if not isElement(objetivo) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no está conectado.", source, 255, 255, 255, true)
        end

    -- Actualizamos la data del jugador
        local varDataObjetivo = exports["MR1_Inicio"]:getValueOne(objetivo)
        if not varDataObjetivo.Familia then
            varDataObjetivo.Familia = {
                FamiliaID = varDataSource.Familia["FamiliaID"],
                Nombre = varDataSource.Familia["Nombre"],
                Rango = 1
            }
            exports["MR1_Inicio"]:setValue(objetivo, "Familia", varDataObjetivo.Familia)
        else
            -- Si ya tiene familia, actualizar los datos
            varDataObjetivo.Familia = {
                FamiliaID = varDataSource.Familia["FamiliaID"],
                Nombre = varDataSource.Familia["Nombre"],
                Rango = 1
            }
            exports["MR1_Inicio"]:setValue(objetivo, "Familia", varDataObjetivo.Familia)
        end
    -- Obtenemos la data de la familia de la DB.
        local resultadoFamilia = exports["MR1_Inicio"]:query("SELECT * FROM Familias WHERE Nombre = ?", varDataSource.Familia["Nombre"])
        if not resultadoFamilia or #resultadoFamilia == 0 then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535No se encontró la familia con el nombre " .. varDataSource.Familia["Nombre"] .. ".", source, 255, 255, 255, true)
        end
    -- Obtenemos la data del usuario en familias de la DB.
        local resultadoUserFamilia = exports["MR1_Inicio"]:query("SELECT * FROM FamiliasUsers WHERE Personajes=?", varDataSource.IDPersonaje)
        if resultadoUserFamilia and #resultadoUserFamilia == 1 then
            exports["MR1_Inicio"]:execute("UPDATE FamiliasUsers SET Familia="..resultadoFamilia[1].ID..", Rango=1 WHERE Personajes=?", varDataObjetivo.IDPersonaje)
        else
            exports["MR1_Inicio"]:execute("INSERT INTO FamiliasUsers(Personajes, Familia, Rango) VALUES(?,?,?)", varDataObjetivo.IDPersonaje, resultadoFamilia[1].ID, 1)
        end
    -- Confirmación al jugador
        outputChatBox("#9AA498[#A03535Éxito#9AA498] #FFFFFFHas reclutado al jugador " .. getPlayerName(objetivo) .. " con rango 1 en la familia " .. varDataSource.Familia["Nombre"] .. ".", source, 0, 255, 0, true)
    -- Notificación al jugador objetivo
        outputChatBox("#9AA498[#A03535Éxito#9AA498] #FFFFFFHas sido recutado en la familia " ..varDataSource.Familia["Nombre"].. ".", objetivo, 0, 255, 0, true)
end
function StopFamilias()
    for i, Vehicle in ipairs(getElementsByType ('vehicle')) do
        local DataVeh = exports["MR1_Inicio"]:getValueOne(Vehicle)
        if (DataVeh) and (DataVeh["IDFamilia"]) then
            --Tunning
                local CR0, CG0, CB0, CR1, CG1, CB1, CR2, CG2, CB2, CR3, CG3, CB3 = getVehicleColor(Vehicle, true)
                local LR, LG, LB = getVehicleHeadLightColor(Vehicle)
                local Tunning = {
                    Color = {
                        R0 = CR0, G0 = CG0, B0 = CB0,
                        R1 = CR1, G1 = CG1, B1 = CB1,
                        R2 = CR2, G2 = CG2, B2 = CB2,
                        R3 = CR3, G3 = CG3, B3 = CB3
                    },
                    Luces = { R = LR, G = LG, B = LB },
                    Modificaciones = { getVehicleUpgrades(Vehicle) },
                    Paintjob = getVehiclePaintjob(Vehicle)
                }
    
                -- Guardar los datos en la base de datos utilizando parámetros preparados
                local query = "UPDATE FamiliasVehiculos SET Tunning = ?, Inventario = ? WHERE ID = ?"
                local tunningJSON = toJSON(Tunning)
                local inventarioJSON = toJSON(DataVeh["Inventario"])
                --iprint(DataVeh["Inventario"])  
    
                -- Ejecución de la consulta con parámetros
                exports["MR1_Inicio"]:execute(query, tunningJSON, inventarioJSON, DataVeh["IDVeh"])
        end
    end
end
function FamVehExplote()
    -- Obtenemos la data del vehiculo
        local varDataVehicle = exports["MR1_Inicio"]:getValueOne(source)
        if not varDataVehicle or not varDataFamVehicles[1].IDFamilia then
            return
        end
        local varDataFamVehicles = exports["MR1_Inicio"]:query("SELECT * FROM FamiliasVehiculos WHERE ID = ?", varDataVehicle.IDVeh)
        local varDataFacciones = exports["MR1_Inicio"]:query('SELECT * FROM Familias WHERE ID = "?"', varDataFamVehicles[1].IDFamilia)
    -- Creamos el nuevo vehiculo
        setTimer(function()
            for i2, Vehiculo in ipairs(varDataFamVehicles) do
                local vehInformacion = fromJSON(Vehiculo.INFORMACION)
                local vehEstado = fromJSON(Vehiculo.ESTADO)
                local vehUbicacion = fromJSON(Vehiculo.UBICACION)
                local vehTunning = fromJSON(Vehiculo.TUNNING)
                local vehInventario = fromJSON(Vehiculo.INVENTARIO)
                if not isVehicleExists(vehInformacion["Matricula"]) then
                    --iprint(vehInformacion["Matricula"])
                    local veh = createVehicle(vehInformacion["Modelo"], vehUbicacion["posX"], vehUbicacion["posY"], vehUbicacion["posZ"], vehUbicacion["rotX"], vehUbicacion["rotY"], vehUbicacion["rotZ"], vehInformacion["Matricula"])
                    setElementDimension(veh, vehUbicacion["Dimension"])
                    setElementInterior(veh, vehUbicacion["Interior"])
                    exports["MR1_Inicio"]:setValue(veh, 'IDVeh', Vehiculo.ID)
                    exports["MR1_Inicio"]:setValue(veh, 'IDFamilia', Vehiculo.IDFamilia)
                    exports["MR1_Inicio"]:setValue(veh, 'Personaje', varDataFacciones[1].Nombre)
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
        end, 4000, 1)
    -- Destruimos el vehiculo si es un vehiculo de familia
        if (varDataVehicle) and (varDataVehicle.IDVeh) and (varDataVehicle.IDFamilia) then
            setTimer(function(source)
                destroyElement(source)
            end, 3000, 1, source)
        end
end
function famEntrarHod(hitElement)
    if eventName == "onPickupHit" then
        if getElementType(hitElement) == "player" then
            local key = getElementID(source):match("Entrada_(%d+)")
            local value = Hoods[tonumber(key)] -- Obtener datos del interior
            --iprint(Hoods[tonumber(key)].id_fam)
            
            local varDataHitElement = exports["MR1_Inicio"]:getValueOne(hitElement) 
            if varDataHitElement and varDataHitElement.Familia and varDataHitElement.Familia["FamiliaID"] then
                if varDataHitElement.Familia["FamiliaID"] == Hoods[tonumber(key)].id_fam then
                    -- Asignar la tecla H para cambiar de interior
                    bindKey(hitElement, "H", "down", function()
                        exports["MR5_Interiores"]:Cambiar_De_Interior_A_Pie(hitElement, value.salida_int, value.salida_dim, value.salida_x, value.salida_y, value.salida_z, 0, 0, 179.30786132812)
                        unbindKey(hitElement, "H") -- Desvincular la tecla después del uso
                    end)
                end
            end
        end
    else
        if getElementType(hitElement) == "player" then
            unbindKey(hitElement, "H") -- Asegurar que la tecla H se desvincula al salir
        end
    end
end
function famSalirHood(hitElement)
    if eventName == "onPickupHit" then
        if getElementType(hitElement) == "player" then
            local key = getElementID(source):match("Salida_(%d+)")
            local value = Hoods[tonumber(key)] -- Obtener datos del interior
            
            -- Asignar la tecla H para salir del interior
            bindKey(hitElement, "H", "down", function()
                exports["MR5_Interiores"]:Cambiar_De_Interior_A_Pie(hitElement, value.entrada_int, value.entrada_dim, value.entrada_x, value.entrada_y, value.entrada_z, 0, 0, 179.30786132812)
                unbindKey(hitElement, "H") -- Desvincular la tecla después del uso
            end)
        end
    else
        if getElementType(hitElement) == "player" then
            unbindKey(hitElement, "H") -- Asegurar que la tecla H se desvincula al salir
        end
    end
end
-- Eventos y Handlers
addCommandHandler("verfamilias", verFamilias)
addCommandHandler("famestado", cambiarEstadoFamilia)
addCommandHandler("famnombre", cambiarNombreFamilia)
addCommandHandler("famcolor", cambiarColorFamilia)
addCommandHandler("famverrangos", famverrangos)
addCommandHandler("fameditarrangos", fameditarrangos)
addCommandHandler("famasignar", famasignar)
addCommandHandler("famquitar", famquitar)
addEvent("Familias::Territorios::SolicitarTerritorios", true)
addEventHandler("Familias::Territorios::SolicitarTerritorios", root, enviarTerritoriosFamilias)
addEvent("Familias::Miembros::Obtener", true)
addEventHandler("Familias::Miembros::Obtener", getRootElement(), FamGetMembers)
addEvent("Familias::Miembros::Ascender", true)
addEventHandler("Familias::Miembros::Ascender", getRootElement(), FamGestionMiembro)
addEvent("Familias::Miembros::Descender", true)
addEventHandler("Familias::Miembros::Descender", getRootElement(), FamGestionMiembro)
addEvent("Familias::Miembros::Expulsar", true)
addEventHandler("Familias::Miembros::Expulsar", getRootElement(), FamGestionMiembro)
addCommandHandler("famver", FamVigilarFam)
addCommandHandler("faminvite", famplayerInvite)
addCommandHandler("facc", FaccCommands)
addEventHandler("onVehicleExplode", getRootElement(), FamVehExplote)
addEventHandler("onPickupHit", PickUpsEnterHoods, famEntrarHod)
addEventHandler("onPickupLeave", PickUpsEnterHoods, famEntrarHod)
addEventHandler("onPickupHit", PickUpsLeaveHoods, famSalirHood)
addEventHandler("onPickupLeave", PickUpsLeaveHoods, famSalirHood)

-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
addEventHandler("onResourceStart", resourceRoot, FaccStart)
addEventHandler("onResourceStop", resourceRoot, StopFamilias)