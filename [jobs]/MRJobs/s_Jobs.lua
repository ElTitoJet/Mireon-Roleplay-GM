-- MRJobs
-- Script que gestiona la familia.
-- Autor: ElTitoJet
-- Fecha: 18/11/2024

-- Variables Globales y Configuración
    local ComandosJobs = {
        "/verjobs",
        "/jobverrangos",
        "/jobasignar",
        "/jobquitar"
    }

    PickUpsInfos = {
        [1] = {
            x = -2031.935546875,
            y = -117.2626953125,
            z = 1035.171875,
            interior = 3,
            dimension = 0,
            tipoPickUp = 3,
            modelo = 1239,
            tipo = "JobInfo"
        }
    }
    local PickUpsInfoJobs = createElement("PickUps")
-- Funciones Auxiliares
    function JobsCheckRank(player)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(player)
        if not (varDataSource.InfoCuenta["Rango"] >= 5) then
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
    function crearPickUp(x, y, z, int, dim, tipoPickUp, ModeloPickup, parentElement, tipo, index)
        local pickup = createPickup(x, y, z, tipoPickUp, ModeloPickup, 0, 0) -- Crear el pickup
        setElementInterior(pickup, int) -- Establecer interior
        setElementDimension(pickup, dim) -- Establecer dimensión
        setElementParent(pickup, parentElement) -- Agrupar el pickup
        setElementID(pickup, tipo .. "_" .. index) -- Asignar un ID único
    end
    function UpdateJobListPannel(client)
        -- Obtener la lista de trabajos activos
        local JobList = exports["MR1_Inicio"]:query('SELECT * FROM Jobs WHERE Activo=?', 'true')
    
        -- Obtener los rangos y salarios por trabajo
        local JobRanks = exports["MR1_Inicio"]:query('SELECT IDJob, COUNT(*) as TotalRangos, MIN(Salario) as MinPaga, MAX(Salario) as MaxPaga FROM JobsRangos GROUP BY IDJob')
    
        -- Obtener el número de miembros por trabajo
        local JobMembers = exports["MR1_Inicio"]:query('SELECT IDJob, COUNT(*) as TotalMiembros FROM JobsUsers GROUP BY IDJob')
    
        -- Organizar los datos en una estructura más manejable
        local JobsInfo = {}
        for _, job in ipairs(JobList) do
            local jobID = job.ID
            local ranks = {TotalRangos = 0, MinPaga = 0, MaxPaga = 0}
            local members = 0
    
            -- Encontrar los rangos y salarios correspondientes
            for _, rank in ipairs(JobRanks) do
                if rank.IDJob == jobID then
                    ranks = rank
                    break
                end
            end
    
            -- Encontrar los miembros correspondientes
            for _, member in ipairs(JobMembers) do
                if member.IDJob == jobID then
                    members = member.TotalMiembros
                    break
                end
            end
    
            -- Agregar la información organizada
            table.insert(JobsInfo, {
                ID = jobID,
                Nombre = job.Nombre,
                TotalRangos = ranks.TotalRangos,
                MinPaga = ranks.MinPaga,
                MaxPaga = ranks.MaxPaga,
                TotalMiembros = members,
                Ubicacion = job.Ubicacion
            })
        end
    
        -- Enviar los datos al cliente
        triggerClientEvent(client, "Jobs::JobList::UpdatePannel", client, JobsInfo)
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
    function JobsCommands(source, command)
        local Permiso = JobsCheckRank(source)
        if not Permiso then
            return
        end
        outputChatBox("#9AA498==== [#A03535Lista de Comandos Jobs#9AA498] ====", source, 255, 255, 255, true)
        local filaComandos = "" -- Variable para almacenar los comandos por fila
        local contador = 0      -- Contador para controlar los comandos en cada fila
        for _, comando in ipairs(ComandosJobs) do
            filaComandos = filaComandos .. comando .. ", "
            contador = contador + 1

            -- Cuando hay 4 comandos en la fila o es el último comando, mostrar la fila
            if contador == 4 or _ == #ComandosJobs then
                outputChatBox("#9AA498" .. filaComandos, source, 255, 255, 255, true)
                filaComandos = ""  -- Reiniciar la fila
                contador = 0       -- Reiniciar el contador
            end
        end
    end
    function StartJobs()
        setTimer(function()
            for i, PickUp in ipairs(PickUpsInfos) do
                -- Crear Pickup de Entrada con Blip
                crearPickUp(PickUp.x, PickUp.y, PickUp.z, PickUp.interior, PickUp.dimension, PickUp.tipoPickUp, PickUp.modelo, PickUpsInfoJobs, PickUp.tipo, i)
            end
        end, 3000, 1)
    end
    function verJobs(source, cmd, filtro)
        local Permiso = JobsCheckRank(source)
        if not Permiso then
            return
        end
        local consulta = ""
        
        -- Definir la consulta según el filtro recibido
        if filtro == "activos" then
            consulta = 'SELECT * FROM Jobs WHERE Activo = "true";'
        elseif filtro == "inactivos" then
            consulta = 'SELECT * FROM Jobs WHERE Activo = "false";'
        elseif filtro == "todos" then
            consulta = 'SELECT * FROM Jobs;'
        else
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/verjobs [todos/activos/inactivos]", source, 255, 255, 255, true)
        end
        
        -- Consultar la base de datos
        local Jobs = exports["MR1_Inicio"]:query(consulta)
    
        if Jobs and #Jobs > 0 then
            outputChatBox("==== Jobs (" .. filtro .. ") ====", source, 255, 255, 0)
    
            for _, job in ipairs(Jobs) do
                outputChatBox(
                    string.format(
                        "#FFFFFFID: %d - Nombre: #24C5BE%s #FFFFFF- Estado: %s",
                        job.ID, job.Nombre, (job.Activo == "true" and "#00FF00Activo" or "#FF0000Inactivo")
                    ),
                    source, 255, 255, 255, true
                )
            end
        else
            outputChatBox("No se encontraron jobs " .. filtro, source, 255, 0, 0)
        end
    end
    function JobsVerRangos(source, cmd, IDJob)
        local Permiso = JobsCheckRank(source)
        if not Permiso then
            return
        end
        -- Verificar que se ingrese el ID de la familia
        if not IDJob or tonumber(IDJob) == nil then
            return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFPor favor, proporciona un ID de Job válido.", source, 255, 255, 255, true)
        end
    
        -- Realizar la consulta para obtener los rangos de la familia
        local consulta = 'SELECT * FROM JobsRangos WHERE IDJob = ? ORDER BY IDRango DESC'
        local rangos = exports["MR1_Inicio"]:query(consulta, tonumber(IDJob))
    
        -- Verificar si se encontraron rangos para la familia
        if rangos and #rangos > 0 then
            outputChatBox("==== Rangos del Job ID: " .. IDJob .. " ====", source, 255, 255, 0)
            for _, rango in ipairs(rangos) do
                outputChatBox("Rango ID: " .. rango.IDRango .. " - Nombre: " .. rango.Nombre, source, 255, 255, 255)
            end
        else
            outputChatBox("No se encontraron rangos para el Job con ID " .. IDJob, source, 255, 0, 0)
        end
    end
    function Jobasignar(source, cmd, objetivoID, IDJob, IDRango)
        -- Comprobar si soy ADM. Familias
            local Permiso = JobsCheckRank(source)
            if not Permiso then
                return
            end
        -- Verificar que se proporcionen todos los argumentos necesarios
            if not objetivoID or not IDJob or not IDRango then
                return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFUso: /jobasignar [IDUser] [IDJob] [IDRango]", source, 255, 255, 255, true)
            end
    
        -- Convertir a números para asegurarnos de que son válidos
            IDJob = tonumber(IDJob)
            IDRango = tonumber(IDRango)
            if not IDJob or not IDRango then
                return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFEl ID de job y el ID de rango deben ser números válidos.", source, 255, 255, 255, true)
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
        -- Obtener datos del Job
            local resultadoJob = exports["MR1_Inicio"]:query("SELECT * FROM Jobs WHERE ID = ?", IDJob)
            if not resultadoJob or #resultadoJob == 0 then
                return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535No se encontró el Job con ID " .. IDJob .. ".", source, 255, 255, 255, true)
            end
        -- Actualizar los datos del jugador objetivo en la data interna
            local varDataUser = exports["MR1_Inicio"]:getValueOne(objetivo)
            local PlayerJob = varDataUser.Jobs or {}
            if not PlayerJob.Normal then
                PlayerJob.Normal = {
                    IDJob = tonumber(jobID),
                    Nombre = resultadoJob[1].Nombre,
                    IDRango = 1 
                }
                exports["MR1_Inicio"]:setValue(objetivo, 'Jobs', PlayerJob)
            else
                -- Si ya tiene Job, actualizar los datos
                PlayerJob.Normal["IDJob"] = IDJob
                PlayerJob.Normal["Nombre"] = resultadoJob[1].Nombre
                PlayerJob.Normal["IDRango"] = IDRango
                exports["MR1_Inicio"]:setValue(objetivo, 'Jobs', PlayerJob)
            end

        -- Actualizar los datos del jugador objetivo en la DB
            local varDataJobs = exports["MR1_Inicio"]:query("SELECT * FROM JobsUsers WHERE IDPersonaje=?", varDataUser.IDPersonaje)
            if varDataJobs and #varDataJobs == 1 then
                exports["MR1_Inicio"]:execute("UPDATE JobsUsers SET IDJob="..IDJob..", IDRango="..IDRango.." WHERE IDPersonaje=?", varDataUser.IDPersonaje)
            else
                exports["MR1_Inicio"]:execute("INSERT INTO JobsUsers(IDPersonaje, IDJob, IDRango) VALUES(?,?,?)", varDataUser.IDPersonaje, IDJob, IDRango)
            end

        -- Confirmación al jugador
            outputChatBox("#9AA498[#A03535Éxito#9AA498] #FFFFFFHas asignado al jugador " .. getPlayerName(objetivo) .. " al rango " .. IDRango .. " del Job con ID " .. IDJob .. ".", source, 0, 255, 0, true)
    
        -- Notificación al jugador objetivo
            outputChatBox("#9AA498[#A03535Éxito#9AA498] #FFFFFFHas sido asignado al rango " .. IDRango .. " del Job " .. PlayerJob.Normal["Nombre"] .. ".", objetivo, 0, 255, 0, true)
    end
    function Jobquitar(source, cmd, objetivoID)
        -- Comprobar si soy ADM. Familias
            local Permiso = JobsCheckRank(source)
            if not Permiso then
                return
            end
        -- Verificar que se proporcione el ID del jugador objetivo
            if not objetivoID then
                return outputChatBox("#9AA498[#A03535Error#9AA498] #FFFFFFUso: /jobquitar [IDUser]", source, 255, 255, 255, true)
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
            local PlayerJob = varDataUser.Jobs or {}
            if not PlayerJob.Normal then
                PlayerJob.Normal = {
                    IDJob = 1,
                    Nombre = "Desempleado",
                    IDRango = 1 
                }
                exports["MR1_Inicio"]:setValue(objetivo, 'Jobs', PlayerJob)
            else
                -- Si ya tiene Job, actualizar los datos
                PlayerJob.Normal["IDJob"] = 1
                PlayerJob.Normal["Nombre"] = "Desempleado"
                PlayerJob.Normal["IDRango"] = 1
                exports["MR1_Inicio"]:setValue(objetivo, 'Jobs', PlayerJob)
            end
        -- Actualizar la data externa
            local varDataJobs = exports["MR1_Inicio"]:query("SELECT * FROM JobsUsers WHERE IDPersonaje=?", varDataUser.IDPersonaje)
            if varDataJobs and #varDataJobs == 1 then
                exports["MR1_Inicio"]:execute("UPDATE JobsUsers SET IDJob=1, IDRango=1 WHERE IDPersonaje=?", varDataUser.IDPersonaje)
            else
                exports["MR1_Inicio"]:execute("INSERT INTO JobsUsers(IDPersonaje, IDJob, IDRango) VALUES(?,?,?)", varDataUser.IDPersonaje, 1, 1)
            end

        -- Confirmación al jugador que ejecutó el comando
            outputChatBox("#9AA498[#A03535Éxito#9AA498] #FFFFFFHas quitado al jugador " .. getPlayerName(objetivo) .. " de su trabajo.", source, 0, 255, 0, true)
    
        -- Notificación al jugador objetivo
            outputChatBox("#9AA498[#A03535Jobs#9AA498] #FFFFFFHas sido removido de tu trabajo.", objetivo, 255, 0, 0, true)
    end
    function setJobUser(client)
        local player = getPlayerName(client)
        local varDataPlayer = exports["MR1_Inicio"]:getValueOne(client)
        local PlayerJob = varDataPlayer.Jobs or {}

        local DBJobsUsers = exports["MR1_Inicio"]:query('SELECT * FROM JobsUsers WHERE IDPersonaje = ?', varDataPlayer.IDPersonaje)
    
        if DBJobsUsers and #DBJobsUsers > 0 then
            
            local resultadoJob = exports["MR1_Inicio"]:query("SELECT * FROM Jobs WHERE ID = ?", DBJobsUsers[1].IDJob)
            PlayerJob.Normal = {
                IDJob = DBJobsUsers[1].IDJob,
                Nombre = resultadoJob[1].Nombre,
                IDRango = DBJobsUsers[1].IDRango or 1 
            }
            PlayerJob.VIP = {
                IDJob = 1,
                Nombre = "Desempleado",
                IDRango = 1 
            }
            exports["MR1_Inicio"]:setValue(client, 'Jobs', PlayerJob)
            
            data = fromJSON(resultadoJob[1].Ubicacion)
            triggerClientEvent(client, 'Jobs::Blips::Create', client, data['x'], data['y'], data['z'], DBJobsUsers[1].IDJob)
        else
            exports["MR1_Inicio"]:execute('INSERT INTO JobsUsers (IDPersonaje, IDJob, IDRango) VALUES (?, ?, ?)', varDataPlayer.IDPersonaje, 1, 1)
            PlayerJob.Normal = {
                IDJob = 1, 
                Nombre = "Desempleado",
                IDRango = 1
            }
            PlayerJob.VIP = {
                IDJob = 1,
                Nombre = "Desempleado",
                IDRango = 1 
            }
            exports["MR1_Inicio"]:setValue(client, 'Jobs', PlayerJob) 
        end
    end
    function JobsAbrirInfo(hitElement)
        if eventName == "onPickupHit" then
            if getElementType(hitElement) == "player" then
                outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Presiona #FFFFFFH #53B440 para ver los trabajos.", source, 255, 255, 255, true)
                local key = getElementID(source):match("JobInfo_(%d+)")
                local value = PickUpsInfos[tonumber(key)]
                bindKey(hitElement, "H", "down", function()
                    triggerClientEvent(hitElement, "Jobs::JobList::AbrirPanel", hitElement)
                    unbindKey(hitElement,"H")
                    UpdateJobListPannel(hitElement)
                end)
            end
        else
            if getElementType(hitElement) == "player" then
                unbindKey(hitElement, "H")
            end
        end
    end
    function JobsAsignarPanel(jobID, jobNombre)
        local varDataClient = exports["MR1_Inicio"]:getValueOne(client)
        exports["MR1_Inicio"]:execute("UPDATE JobsUsers SET IDJob='"..tonumber(jobID).."', IDRango=1 WHERE IDPersonaje=?", varDataClient.IDPersonaje)
        
        local PlayerJob = varDataClient.Jobs or {}
        PlayerJob.Normal = {
            IDJob = tonumber(jobID),
            Nombre = jobNombre,
            IDRango = 1 
        }
        exports["MR1_Inicio"]:setValue(client, 'Jobs', PlayerJob)
    end
    function JobsPayDay()
        local players = getElementsByType("player")
        local varDataJobs = exports["MR1_Inicio"]:query('SELECT * FROM JobsRangos')
    
        local jobData = {}
        for _, job in ipairs(varDataJobs) do
            if not jobData[job.IDJob] then
                jobData[job.IDJob] = {}
            end
            jobData[job.IDJob][job.IDRango] = job.Salario
        end
        for _, player in ipairs(players) do
            local varDataPlayer = exports["MR1_Inicio"]:getValueOne(player)
            if varDataPlayer and varDataPlayer.Jobs then
                local PlayerJobs = varDataPlayer.Jobs
                local Salario = jobData[PlayerJobs.Normal["IDJob"]][PlayerJobs.Normal["IDRango"]]
                exports["MR6_Economia"]:SumarDinero(player, Salario, "MRJobs(PayDay)")
                local NumeroFormato = formatNumber(Salario)
                outputChatBox("#9AA498[#FF7800Jobs-PayDay#9AA498] #53B440Has recibido #FFFFFF"..NumeroFormato.." #53B440$.", player, 255, 255, 255, true) -- STAFF
            end
        end  
    end
-- Eventos y Handlers
    -- EVENTOS
        addEventHandler("onResourceStart", resourceRoot, StartJobs)
        addEventHandler("onPickupHit", PickUpsInfoJobs, JobsAbrirInfo)
        addEventHandler("onPickupLeave", PickUpsInfoJobs, JobsAbrirInfo)
        addEvent("Jobs::JobList::AsignarJob", true)
        addEventHandler("Jobs::JobList::AsignarJob", getRootElement(), JobsAsignarPanel)
    -- COMANDOS
        addCommandHandler("jobs", JobsCommands)
        addCommandHandler("verjobs", verJobs)
        addCommandHandler("jobverrangos", JobsVerRangos)
        addCommandHandler("jobasignar", Jobasignar)
        addCommandHandler("jobquitar", Jobquitar)
        addCommandHandler("PayDay", JobsPayDay)
    -- TIMER
        setTimer(JobsPayDay, 3600000, 0) --1 Hora = 3600000