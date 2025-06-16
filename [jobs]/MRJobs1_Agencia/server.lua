local FaccEmp = {
    [1] = { "Los Santos Police Departament", "LSPD", "#3556CC", "Facc"},
    [2] = { "Los Santos Emergency Services", "LSES", "#a03535", "Facc"},
    [3] = { "Los Santos Justice Departament", "LSJD", "#8b8b8b", "Facc"},
    [4] = { "ROSS Custom Garage", "ROSS", "#353535", "Meca"}, 
    [5] = { "Sanctuary Garage", "Sanct", "#54F3E0", "Meca"}, 
    [6] = { "GoldenWrench", "Golden", "#FF0000", "Meca"}
}

local cooldowns = {}
function isOnCooldown(player, command, cooldownTime)
    if not cooldowns[player] then
        cooldowns[player] = {}
    end

    local lastUsed = cooldowns[player][command] or 0
    local currentTime = getTickCount()

    if currentTime - lastUsed < cooldownTime then
        return true -- El jugador está en cooldown
    else
        cooldowns[player][command] = currentTime
        return false -- El jugador no está en cooldown
    end
end
function Start(resource)
    exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS Trabajos ( ID INT NOT NULL AUTO_INCREMENT, Nombre VARCHAR(255) NOT NULL, Activo VARCHAR(255) NOT NULL, Posicion VARCHAR(255) NOT NULL, PRIMARY KEY (ID));")
    exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS TrabajosRangos (ID INT NOT NULL AUTO_INCREMENT, Trabajo VARCHAR(255) NOT NULL, Rango INT NOT NULL, Nombre VARCHAR(255) NOT NULL, Salario INT NOT NULL, PRIMARY KEY(ID));")

    --ENTRADA
    --    local PickUpInfo = createPickup(-2031.935546875, -117.2626953125, 1035.171875, 3, 1239, 0, 0)
    --    local IntPickUpInfo = setElementInterior(PickUpInfo, 3)
    --
    --	addEventHandler("onPickupHit", PickUpInfo, function(source)
    --        outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Presiona #FFFFFFH #53B440 para ver los trabajos.", source, 255, 255, 255, true)
    --
    --		bindKey(source, "H", "down", function(source, m)
    --            triggerClientEvent(source, "PanelTrabajos", source)
    --			unbindKey(source,"H")
    --		end)
    --
    --	end)
    --    addEventHandler("onPickupLeave", PickUpInfo, function(source, m)
    --        unbindKey(source,"H")
    --    end)
    --
    --    for i, v in ipairs(getElementsByType("player")) do
    --        bindKey(v, "f3", "down", function(source, m)
    --            triggerClientEvent(source, "TrabajoPannel", source)
    --        end)
    --    end
end
addEventHandler("onResourceStart", resourceRoot, Start)

function getTrabajos()

    local user = getPlayerName(client)


    local Vehiculos = exports["MR1_Inicio"]:query('SELECT Nombre FROM Trabajos WHERE Activo=?', 'true')
    triggerClientEvent(client, "ListaJobs2", client, Vehiculos)

    
end
addEvent("getTrabajos", true)
addEventHandler("getTrabajos", getRootElement(), getTrabajos)

function getBlips(job, tipo)

    local result = exports["MR1_Inicio"]:query('SELECT * FROM Trabajos WHERE Nombre =?', job)
    data = fromJSON(result[1].Posicion)
    triggerClientEvent(client, 'setBlips', client, data['x'], data['y'], data['z'], tipo)

end
addEvent("getBlips", true)
addEventHandler("getBlips", getRootElement(), getBlips)

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

function setWorkerDB(job)
    
    DataPJ = exports["MR1_Inicio"]:getValueOne(client)
    exports["MR1_Inicio"]:execute("UPDATE TrabajosUsers SET Trabajo='"..job.."', Rango=1 WHERE Personajes=?", DataPJ.IDPersonaje)
    
    Trabajos = exports["MR1_Inicio"]:getValue(client, 'Trabajos')
    Trabajos.Trabajo = job
    Trabajos.Rango = 1
    exports["MR1_Inicio"]:setValue(client, 'Trabajos', Trabajos)
end
addEvent("setWorkerDB", true)
addEventHandler("setWorkerDB", getRootElement(), setWorkerDB)

function setJobUser(client)
    player = getPlayerName(client)
    local DataPJ = exports["MR1_Inicio"]:getValueOne(client)
    
    local result = exports["MR1_Inicio"]:query('SELECT * FROM TrabajosUsers WHERE Personajes = ?', DataPJ.IDPersonaje)
    if(result) then
        if result[1].Trabajo ~= nil then
            Jobs = {Trabajo = result[1].Trabajo, Rango = result[1].Rango}
            exports["MR1_Inicio"]:setValue(client, 'Trabajos', Jobs)
            playerON(client, result[1].Trabajo)
        end
    end
end

function playerON(client, job)

    if job ~= nil then

        local result = exports["MR1_Inicio"]:query('SELECT * FROM Trabajos WHERE Nombre =?', job)
        data = fromJSON(result[1].Posicion)
        triggerClientEvent(client, 'setBlips', client, data['x'], data['y'], data['z'], tipo)

    end

    bindKey(client, "f3", "down", function(source, m)
        triggerClientEvent(source, "TrabajoPannel", source)
    end)
end
addEvent("playerON", true)
addEventHandler("playerON", getRootElement(), playerON)

function getWorkers(job)
    local workers = exports["MR1_Inicio"]:query('SELECT * FROM TrabajosUsers WHERE Trabajo =?', job)
    
    -- Crear una tabla para almacenar la información combinada
    local combinedResults = {}

    for i, worker in ipairs(workers) do
        -- Obtener el nombre del personaje
        local characterInfo = exports["MR1_Inicio"]:query('SELECT Nombre FROM Personajes WHERE ID =?', worker.Personajes)
        -- Obtener el nombre del rango a partir de la tabla 'TrabajosRangos'
        local rankInfo = exports["MR1_Inicio"]:query('SELECT Nombre FROM TrabajosRangos WHERE Trabajo = ? AND Rango = ?', job, worker.Rango)
        
        local personajeConectado = false
        for _, player in ipairs(getElementsByType("player")) do
            if string.lower(getPlayerName(player)) == string.lower(characterInfo[1].Nombre) then
                personajeConectado = true
                break
            end
        end
        local conectado = personajeConectado and "Conectado" or "Desconectado"

        -- Combinar la información del trabajador, nombre del personaje y nombre del rango
        table.insert(combinedResults, {
            IDPJ = worker.Personajes,  -- ID del personaje
            rank = rankInfo[1].Nombre,  -- Rango
            CharacterName = characterInfo[1].Nombre,  -- Nombre del personaje
            PlayerConectado = conectado
        })
    end

    -- Enviar la información combinada al cliente
    triggerClientEvent(client, 'ListaWorkers2', client, combinedResults)
end
addEvent("getWorkers", true)
addEventHandler("getWorkers", getRootElement(), getWorkers)

function setJobIC(source, command, objetive, jobID, rango)
    local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
    if not (rank["Rango"] >= 6) then
        return
    end
    if not (objetive) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario] [JobID] [Rank]", source, 0, 0, 0, true)
    end
    
    objetivo = nil;
    if tonumber(objetive) then
        objetivo = exports["MR1_Inicio"]:getPlayerFromID(objetive)
    elseif (isElement(getPlayerFromName(objetive))) then
        objetivo = getPlayerFromName(objetive)
    else
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
    end


    if not (jobID) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." "..getPlayerName(objetivo).." [IDJob] [Rank]", source, 0, 0, 0, true)
    end
    if not (rango) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." "..getPlayerName(objetivo).." "..jobID.." [Rank]", source, 0, 0, 0, true)
    end
    job = exports["MR1_Inicio"]:query("SELECT Nombre FROM Trabajos WHERE ID=?", jobID)
    DataPJ2 = exports["MR1_Inicio"]:getValueOne(objetivo)
    exports["MR1_Inicio"]:execute("UPDATE TrabajosUsers SET Trabajo='"..job[1]["Nombre"].."', Rango="..rango.." WHERE Personajes=?", DataPJ2.IDPersonaje)
    
    Jobs = {Trabajo = job[1]["Nombre"], Rango = tonumber(rango), OnDuty = true}
    exports["MR1_Inicio"]:setValue(objetivo, 'Trabajos', Jobs)

    local result = exports["MR1_Inicio"]:query('SELECT * FROM Trabajos WHERE Nombre =?', job[1]["Nombre"])
    data = fromJSON(result[1].Posicion)
    triggerClientEvent(objetivo, 'setBlips', objetivo, data['x'], data['y'], data['z'], tipo)

    outputChatBox("#9AA498[#FF7800Jobs#9AA498] #53B440Has dado el trabajo #24C5BE"..job[1]["Nombre"].." #53B440con rango #24C5BE"..rango.." #53B440a #24C5BE"..getPlayerName(objetivo).."#53B440.", source, 255, 255, 255, true) 
    outputChatBox("#9AA498[#FF7800Jobs#9AA498] #53B440Ahora trabajas de #24C5BE"..job[1]["Nombre"].." #53B440con rango #24C5BE"..rango.." #53B440.", objetivo, 255, 255, 255, true) 
end
addCommandHandler("setJob", setJobIC)

addEvent("AscenderTrabajador", true)
addEventHandler("AscenderTrabajador", getRootElement(), function(Personaje)
    Trabajos = exports["MR1_Inicio"]:getValue(client, 'Trabajos')
    local maxRank = exports["MR1_Inicio"]:query('SELECT max(Rango) FROM TrabajosRangos WHERE Trabajo=?', Trabajos.Trabajo)
    if not (maxRank[1]['max(Rango)'] == tonumber(Trabajos.Rango)) then
        return outputChatBox("#9AA498[#FF7800TRABAJO#9AA498] #A03535No eres el jefe de esta faccion/empresa.", client, 255, 255, 255, true )
    end

    Jefe = getPlayerName(client)

    if not (Jefe ~= Personaje) then
        return outputChatBox("#9AA498[#FF7800Jobs#9AA498] #A03535No te puedes ascender a ti mismo.", client, 255, 255, 255, true)
    end

    local DataPJObjetivo = exports["MR1_Inicio"]:query('SELECT * FROM Personajes WHERE Nombre=?', Personaje)
    if not (getPlayerFromName(Personaje)) then
        local actualRank = exports["MR1_Inicio"]:query("SELECT Rango FROM TrabajosUsers WHERE Personajes=?", DataPJObjetivo[1].ID)

        if (maxRank[1]['max(Rango)'] == actualRank[1].Rango) then
            return outputChatBox("#9AA498[#FF7800Jobs#9AA498] #24C5BE"..Personaje.." #53B440ya tiene el rango mas alto.", client, 255, 255, 255, true) 
        end

        newRank = actualRank[1].Rango + 1
        exports["MR1_Inicio"]:execute("UPDATE TrabajosUsers SET Rango="..newRank.." WHERE Personajes=?", DataPJObjetivo[1].ID)
        outputChatBox("#9AA498[#FF7800Jobs#9AA498] #53B440Has ascendido a #24C5BE"..Personaje.."#53B440.", client, 255, 255, 255, true) 
        triggerClientEvent(client, "CerrarPanelJob", client)
        return
    end


    Jugador = getPlayerFromName(Personaje)
    Trabajos2 = exports["MR1_Inicio"]:getValue(Jugador, 'Trabajos')

    if not (Trabajos2.Rango <= maxRank[1]['max(Rango)']) then
        return outputChatBox("#9AA498[#FF7800Jobs#9AA498] #24C5BE"..Personaje.." #53B440ya tiene el rango mas alto.", client, 255, 255, 255, true)
    end

    Trabajos2.Rango = Trabajos2.Rango + 1
    NewTrabajos2 = exports["MR1_Inicio"]:setValue(Jugador, 'Trabajos', Trabajos2)
    exports["MR1_Inicio"]:execute("UPDATE TrabajosUsers SET Rango="..Trabajos2.Rango.." WHERE Personajes=?", DataPJObjetivo[1].ID)
    outputChatBox("#9AA498[#FF7800Jobs#9AA498] #53B440Has ascendido a #24C5BE"..Personaje.."#53B440.", client, 255, 255, 255, true) 
    outputChatBox("#9AA498[#FF7800Jobs#9AA498] #53B440Has sido ascendido.", Jugador, 255, 255, 255, true)     
    triggerClientEvent(client, "CerrarPanelJob", client)
end)

addEvent("DescenderTrabajador", true)
addEventHandler("DescenderTrabajador", getRootElement(), function(Personaje)

    Jefe = getPlayerName(client)

    if not (Jefe ~= Personaje) then
        return outputChatBox("#9AA498[#FF7800Jobs#9AA498] #A03535No te puedes degradar a ti mismo.", client, 255, 255, 255, true)
    end

    local DataPJObjetivo = exports["MR1_Inicio"]:query('SELECT * FROM Personajes WHERE Nombre=?', Personaje)

    Trabajos = exports["MR1_Inicio"]:getValue(client, 'Trabajos')
    local minRank = exports["MR1_Inicio"]:query('SELECT min(Rango) FROM TrabajosRangos WHERE Trabajo=?', Trabajos.Trabajo)
    local maxRank = exports["MR1_Inicio"]:query('SELECT max(Rango) FROM TrabajosRangos WHERE Trabajo=?', Trabajos.Trabajo)
    if not (maxRank[1]['max(Rango)'] == tonumber(Trabajos.Rango)) then
        return outputChatBox("#9AA498[#FF7800TRABAJO#9AA498] #A03535No eres el jefe de esta faccion/empresa.", client, 255, 255, 255, true )
    end

    if not (getPlayerFromName(Personaje)) then
        local actualRank = exports["MR1_Inicio"]:query("SELECT Rango FROM TrabajosUsers WHERE Personajes=?", DataPJObjetivo[1].ID)

        if (minRank[1]['min(Rango)'] == actualRank[1].Rango) then
            return outputChatBox("#9AA498[#FF7800Jobs#9AA498] #24C5BE"..Personaje.." #53B440ya tiene el rango mas bajo.", client, 255, 255, 255, true) 
        end

        newRank = actualRank[1].Rango - 1
        exports["MR1_Inicio"]:execute("UPDATE TrabajosUsers SET Rango="..newRank.." WHERE Personajes=?", DataPJObjetivo[1].ID)
        outputChatBox("#9AA498[#FF7800Jobs#9AA498] #53B440Has degradado a #24C5BE"..Personaje.."#53B440.", client, 255, 255, 255, true) 
        triggerClientEvent(client, "CerrarPanelJob", client)
        return
    end


    Jugador = getPlayerFromName(Personaje)
    Trabajos2 = exports["MR1_Inicio"]:getValue(Jugador, 'Trabajos')
    if not (Trabajos2.Rango > minRank[1]['min(Rango)']) then
        return outputChatBox("#9AA498[#FF7800Jobs#9AA498] #24C5BE"..Personaje.." #53B440ya tiene el rango mas bajo.", client, 255, 255, 255, true)
    end

    Trabajos2.Rango = Trabajos2.Rango - 1
    NewTrabajos2 = exports["MR1_Inicio"]:setValue(Jugador, 'Trabajos', Trabajos2)
    exports["MR1_Inicio"]:execute("UPDATE TrabajosUsers SET Rango="..Trabajos2.Rango.." WHERE Personajes=?", DataPJObjetivo[1].ID)
    outputChatBox("#9AA498[#FF7800Jobs#9AA498] #53B440Has degradado a #24C5BE"..Personaje.."#53B440.", client, 255, 255, 255, true) 
    outputChatBox("#9AA498[#FF7800Jobs#9AA498] #53B440Has sido degradado.", Jugador, 255, 255, 255, true)     
    triggerClientEvent(client, "CerrarPanelJob", client)
end)

addEvent("DespedirTrabajador", true)
addEventHandler("DespedirTrabajador", getRootElement(), function(Personaje)

    Trabajos = exports["MR1_Inicio"]:getValue(client, 'Trabajos')
    local maxRank = exports["MR1_Inicio"]:query('SELECT max(Rango) FROM TrabajosRangos WHERE Trabajo=?', Trabajos.Trabajo)
    if not (maxRank[1]['max(Rango)'] == tonumber(Trabajos.Rango)) then
        return outputChatBox("#9AA498[#FF7800TRABAJO#9AA498] #A03535No eres el jefe de esta faccion/empresa.", client, 255, 255, 255, true )
    end

    Jefe = getPlayerName(client)

    if not (Jefe ~= Personaje) then
        return outputChatBox("#9AA498[#FF7800Jobs#9AA498] #A03535No te puedes despedir a ti mismo.", client, 255, 255, 255, true)
    end

    newJob = "Desempleado"
    newRank = 1
    local DataPJObjetivo = exports["MR1_Inicio"]:query('SELECT * FROM Personajes WHERE Nombre=?', Personaje)
    

    if not (getPlayerFromName(Personaje)) then
        exports["MR1_Inicio"]:execute("UPDATE TrabajosUsers SET Trabajo='"..newJob.."', Rango="..newRank.." WHERE Personajes=?", DataPJObjetivo[1].ID)
        outputChatBox("#9AA498[#FF7800Jobs#9AA498] #53B440Has despedido a #24C5BE"..Personaje.."#53B440.", client, 255, 255, 255, true) 
        triggerClientEvent(client, "CerrarPanelJob", client)
        return
    end

    Jugador = getPlayerFromName(Personaje)
    exports["MR1_Inicio"]:execute("UPDATE TrabajosUsers SET Trabajo='"..newJob.."', Rango="..newRank.." WHERE Personajes=?", DataPJObjetivo[1].ID)
    Jobs = {Trabajo = "Desempleado", Rango = newRank}
    exports["MR1_Inicio"]:setValue(Jugador, 'Trabajos', Jobs)
    outputChatBox("#9AA498[#FF7800Jobs#9AA498] #53B440Has despedido a #24C5BE"..Personaje.."#53B440.", client, 255, 255, 255, true) 
    outputChatBox("#9AA498[#FF7800Jobs#9AA498] #53B440Has sido despedido.", Jugador, 255, 255, 255, true)     
    triggerClientEvent(client, "CerrarPanelJob", client)
end)

function PlayerDead(source)
    
    local Estado = exports["MR1_Inicio"]:getValue(source, 'Estado')
    if Estado.Muerto == true then
        return true
    else
        return false
    end
end

local ubicaciones = {}
function ubicar(p, _)
	facc = exports["MR1_Inicio"]:getValue(p, 'Trabajos')

	r, g, b = 0, 0, 0
	if facc.Trabajo == "Los Santos Police Departament" or facc.Trabajo == "Los Santos Emergency Services" then
		if facc.Trabajo == "Los Santos Police Departament" then
			r, g, b = 0, 0, 255
		elseif facc.Trabajo == "Los Santos Emergency Services" then
			r, g, b = 255, 0, 0
		end
		if not ubicaciones[p] then
			blip = createBlipAttachedTo(p, 0, 2, r, g, b, 255, 0, 99999.0, p)
			ubicaciones[p] = {blip}
			p:outputChat("Empiezas a trasmitir tu ubicación actual.", 20, 200, 20, true)
			for i, v in ipairs(getElementsByType("player")) do
                facc2 = exports["MR1_Inicio"]:getValue(v, 'Trabajos')
                --[[
                if facc2.Trabajo == "Los Santos Police Departament" then
					outputChatBox("[#FF3333Alerta #3556CCLSPD#FFFFFF] Tu compañero #3556CC"..string.gsub(getPlayerName(p), "_", " ").."#FFFFFF trasmité su ubicación, esta en #FF3333"..zone, v, 255, 255, 255, true)
				end
                ]]
                if facc2 ~= nil then
                    if facc2.Trabajo == "Los Santos Police Departament" or facc2.Trabajo == "Los Santos Emergency Services" then
                        setElementVisibleTo(blip, v, true)
                    end
                end
			end
		else
			if isElement(ubicaciones[p][1]) then
				destroyElement(ubicaciones[p][1])
				ubicaciones[p] = nil
				p:outputChat("Dejas de trasmitir tu ubicación actual.", 200, 20, 20, true)
			end
		end
	end

end
addCommandHandler("rec", ubicar)
-- Limpieza de blip cuando el jugador sale
addEventHandler("onPlayerQuit", root, function()
    if ubicaciones[source] then  -- Verificamos si el jugador tiene un blip activo
        if isElement(ubicaciones[source][1]) then
            destroyElement(ubicaciones[source][1])  -- Destruir el blip
        end
        ubicaciones[source] = nil  -- Eliminar la referencia en la tabla
    end
end)
function RadioDepartamental(source, command, ...)
    local Abreviatura = nil;
    local Color = nil;
    local foundMatch = false;
    local Div = nil;
    local isDead = PlayerDead(source)
    if (isDead) then 
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535¿Un fiambre con una radio?", source, 255, 255, 255, true)
    end
    if (exports["MR12_Moderacion"]:isPlayerJailed(source)) then
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Amigo mio, tas Jaileado OOC, no puedes hacer esto.", source, 255, 255, 255, true)
    end
    if (exports["MRJobs2_FaccLSPD"]:isPlayerJailedIC(source)) then
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Compa eres tremendo ilegal, no tienes acceso a esto ahora.", source, 255, 255, 255, true)
    end
    local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
    for i, job in ipairs(FaccEmp) do
        if (Trabajos.Trabajo == job[1]) then
            foundMatch = true
            Abreviatura = job[2]
            Color = job[3]
            Div = job[4]
            break 
        end
    end
    if not (foundMatch ) then
        return 
    end
    if not (Trabajos.OnDuty == true) then 
        return outputChatBox("#ffe100Deberia ponerme de servicio primero...", source, 255, 255, 255, true) 
    end
    local togrf = exports["MR1_Inicio"]:getValue(source, 'togrf')
    if (togrf == true) then
        outputChatBox("#ffe100La radio esta apagada...", source, 255, 255, 255, true) 
        outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/togrf", source, 255, 255, 255, true)
        return
    end
    local message = table.concat({...}, " ")
    if not (#message >= 2) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/rd [Mensaje]", source, 255, 255, 255, true)
    end
    message2 = "#9AA498["..Color..""..Abreviatura.."-Dep#9AA498] "..Color..""..getPlayerName(source).." dice:#FFFFFF "..message
    

    for _, player in ipairs(getElementsByType("player")) do -- Obtenemos una lista de TODOS los jugadores
        Trabajos2 = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
        if not (Trabajos2 == nil) and not (Trabajos2.Trabajo == nil) and not (Trabajos2.OnDuty == nil) then
            for i, job in ipairs(FaccEmp) do
                if (job[4] == Div) then
                    if (Trabajos2.Trabajo == job[1]) then
                        if (Trabajos2.OnDuty == true) then 
                            outputChatBox(message2, player, 255,255,255, true)
                        end
                    end
                end
            end
        end
    end
end
addCommandHandler("rd", RadioDepartamental)

addCommandHandler("rf", function(source, command, ...)
    local Abreviatura = nil;
    local Color = nil;
    local foundMatch = false;
    local isDead = PlayerDead(source)
    if (isDead) then 
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535¿Un fiambre con una radio?", source, 255, 255, 255, true)
    end
    if (exports["MR12_Moderacion"]:isPlayerJailed(source)) then
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Amigo mio, tas Jaileado OOC, no puedes hacer esto.", source, 255, 255, 255, true)
    end
    if (exports["MRJobs2_FaccLSPD"]:isPlayerJailedIC(source)) then
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Compa eres tremendo ilegal, no tienes acceso a esto ahora.", source, 255, 255, 255, true)
    end
    local Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
    for i, job in ipairs(FaccEmp) do
        if (Trabajos.Trabajo == job[1]) then
            foundMatch = true
            Abreviatura = job[2]
            Color = job[3]
            break 
        end
    end
    if not (foundMatch ) then
        return 
    end
    if not (Trabajos.OnDuty == true) then 
        return outputChatBox("#ffe100Deberia ponerme de servicio primero...", source, 255, 255, 255, true) 
    end
    local togrf = exports["MR1_Inicio"]:getValue(source, 'togrf')
    if (togrf == true) then
        outputChatBox("#ffe100La radio esta apagada...", source, 255, 255, 255, true) 
        outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/togrf", source, 255, 255, 255, true)
        return
    end
    local message = table.concat({...}, " ")
    if not (#message >= 2) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/rf [Mensaje]", source, 255, 255, 255, true)
    end
    local RankName = exports["MR1_Inicio"]:query('SELECT Nombre FROM TrabajosRangos WHERE Trabajo=? AND Rango=?', Trabajos.Trabajo, Trabajos.Rango)

    for _, player in ipairs(getElementsByType("player")) do -- Obtenemos una lista de TODOS los jugadores
        Trabajos2 = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
        if (Trabajos2 and Trabajos2.Trabajo == Trabajos.Trabajo )then
            if (Trabajos.OnDuty == true) then 
                outputChatBox("#9AA498["..Color..""..Abreviatura.."-Radio#9AA498] #9AA498["..Color..""..RankName[1].Nombre.."#9AA498] #24C5BE"..getPlayerName(source).." dice:#FFFFFF "..message, player, 255,255,255, true)
            end
        end
    end
end)

function LlamadoLSES(source, command, ...)
    local cooldownTime = 60000 -- 5000 milisegundos = 5 segundos
    if isOnCooldown(source, command, cooldownTime) then
        outputChatBox("Debes esperar antes de volver a usar este comando.", source)
        return
    end
    local message = table.concat({...}, " ")
    if not (#message >= 2) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/lses [Mensaje]", source, 255, 255, 255, true)
    end
    if not (getElementInterior(source) == 0 and getElementDimension(source) == 0) then
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Tienes que llamar desde el exterior.", source, 255, 255, 255, true)
    end
    local x, y, z = getElementPosition(source)
    for _, player in ipairs(getElementsByType("player")) do -- Obtenemos una lista de TODOS los jugadores
        local Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
        if (Trabajos == nil) or (Trabajos.Trabajo == nil) then
            break 
        end
        if (Trabajos.Trabajo == "Los Santos Emergency Services" and Trabajos.OnDuty == true) then
            outputChatBox("#9AA498[#a03535CLSES-Central#9AA498]#FFFFFF Nos ha llegado el siguiente llamado:\n#24c5be"..message, player, 255,255,255, true)
            local blip = createBlip(x, y, z, 59, 2, 255, 0, 0, 255, 0, 65535, player)
            setTimer ( function()
                destroyElement(blip)
            end, 120000, 1 )
        end
    end
    outputChatBox("#9AA498[#a03535LSES-Central#9AA498]#FFFFFF Tu llamado ha sido entregado a las unidades activas.", source, 255,255,255, true)
end
function LlamadoLSPD(source, command, ...)
    local cooldownTime = 60000 -- 5000 milisegundos = 5 segundos
    if isOnCooldown(source, command, cooldownTime) then
        outputChatBox("Debes esperar antes de volver a usar este comando.", source)
        return
    end
    local message = table.concat({...}, " ")
    if not (#message >= 2) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/lspd [Mensaje]", source, 255, 255, 255, true)
    end
    if not (getElementInterior(source) == 0 and getElementDimension(source) == 0) then
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Tienes que llamar desde el exterior.", source, 255, 255, 255, true)
    end
    local x, y, z = getElementPosition(source)
    for _, player in ipairs(getElementsByType("player")) do -- Obtenemos una lista de TODOS los jugadores
        local Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
        if (Trabajos == nil) or (Trabajos.Trabajo == nil) then
            break 
        end
        if (Trabajos.Trabajo == "Los Santos Police Departament" and Trabajos.OnDuty == true) then
            outputChatBox("#9AA498[#0058ffLSPD-Central#9AA498]#FFFFFF Nos ha llegado el siguiente llamado:\n#24c5be"..message, player, 255,255,255, true)
            local blip = createBlip(x, y, z, 58, 2, 255, 0, 0, 255, 0, 65535, player)
            setTimer ( function()
                destroyElement(blip)
            end, 120000, 1 )
        end
    end
    outputChatBox("#9AA498[#a03535LSPD-Central#9AA498]#FFFFFF Tu llamado ha sido entregado a las unidades activas.", source, 255,255,255, true)
end

function LlamadoMecanico(source, command, ...)
    local cooldownTime = 60000 -- 5000 milisegundos = 5 segundos
    if isOnCooldown(source, command, cooldownTime) then
        outputChatBox("Debes esperar antes de volver a usar este comando.", source)
        return
    end
    local message = table.concat({...}, " ")
    if not (#message >= 2) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/meca [Mensaje]", source, 255, 255, 255, true)
    end
    if not (getElementInterior(source) == 0 and getElementDimension(source) == 0) then
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Tienes que llamar desde el exterior.", source, 255, 255, 255, true)
    end
    local x, y, z = getElementPosition(source)
    for _, player in ipairs(getElementsByType("player")) do -- Obtenemos una lista de TODOS los jugadores
        Trabajos2 = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
        if (Trabajos2 == nil) or (Trabajos2.Trabajo == nil) then 
            break
        end
        for i, job in ipairs(FaccEmp) do
            if (job[4] == "Meca") then
                if (Trabajos2.Trabajo == job[1]) then
                    if (Trabajos2.OnDuty == true) then 
                        outputChatBox("#9AA498["..job[3]..""..job[2].."-Central#9AA498]#FFFFFF Nos ha llegado el siguiente llamado:\n#24c5be"..message, player, 255,255,255, true)
                        local blip = createBlip(x, y, z, 60, 2, 255, 0, 0, 255, 0, 65535, player)
                        setTimer ( function()
                            destroyElement(blip)
                        end, 120000, 1 )
                    end
                end
            end
        end
    end
    outputChatBox("#9AA498[#4b0082Mecanicos-Central#9AA498]#FFFFFF Tu llamado ha sido entregado a las unidades activas.", source, 255,255,255, true)
end
addCommandHandler("lses", LlamadoLSES)
addCommandHandler("lspd", LlamadoLSPD)
addCommandHandler("meca", LlamadoMecanico)
local repairsAuto = {
    -- GOLDEN
    [1] = {93.1142578125, -190.8134765625, 0.5},
    [2] = {111.3232421875, -190.8134765625, 0.5},
    [3] = {2298.7021484375, -1402.576171875, 22.975234985352},
    [4] = {2307.8349609375, -1402.576171875, 22.975234985352},
    [5] = {2314.4853515625, -1402.576171875, 22.975234985352},
    --[6] = {2327.451171875, -1399.060546875, 23.231163024902},
    -- SANTU
    [6] = {1090, -1238.5, 15},
    [7] = {1090, -1232.9, 15},
    [8] = {1090, -1227.58984375, 15},
    -- ROSS
    [9] = {2124.6, -1940, 12.5},
    [10] = {2115.7, -1940, 12.5},
    [11] = {2107.5, -1940, 12.5},

}
local Markers = {};
local vehs = {};
local coste = 150;
local MecaDuty = 0;
function PointMecanico()
    MecaDuty = 0
    for _, player in ipairs(getElementsByType("player")) do -- Obtenemos una lista de TODOS los jugadores
        local Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
        if Trabajos ~= nil then
            if (Trabajos.Trabajo == "ROSS Custom Garage" or Trabajos.Trabajo == "Sanctuary Garage" or Trabajos.Trabajo == "GoldenWrench") then
                if (Trabajos.OnDuty == true) then
                    MecaDuty = MecaDuty + 1;
                end
            end
        end
    end
    -- Destruir marcadores existentes
    for marker, _ in pairs(Markers) do
        if isElement(marker) then
            destroyElement(marker)
        end
    end
    Markers = {}
    if (MecaDuty == 0) then
        for i, v in ipairs(repairsAuto) do
            local markerRepair = createMarker( v[1], v[2], v[3], "cylinder", 3, 255, 255, 255, 255)
            Markers[markerRepair] = {pos = {v[1], v[2], v[3]}}
        end
        --outputDebugString("No hay mecánicos en servicio, puntos de reparación creados.")
        return
    end
    for i, v in pairs(Markers) do
        destroyElement(i)
    end
    Markers = {}
    --outputDebugString("Hay mecánicos en servicio, no se crean puntos de reparación.")
end
addEventHandler("onResourceStart", resourceRoot, PointMecanico)
addEventHandler ("onPlayerQuit", root, PointMecanico )
addEventHandler("onPlayerLogin", root, PointMecanico)
function markerhit(hitElement, md)
    if not (md) then
        return iprint(2)
    end
    local element = nil;
    if (getElementType(hitElement) == "player") then
        element = getPedOccupiedVehicle(hitElement)
    elseif (getElementType(hitElement) == "vehicle") then
        element = hitElement
    end
    if Markers[source] then
        outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/repararveh", hitElement, 255, 255, 255, true)
        vehs[element] = source;
        return
    end
end
function markerLeave(hitElement, md)
    if isElement(vehs[hitElement]) then
        vehs[hitElement] = nil;
    end
end
function repairveh(source, command)
    local vehicle = getPedOccupiedVehicle(source)
    if not vehicle then
        return 
    end
    
    if isElement(vehs[vehicle]) then
        local marker = vehs[vehicle]
        local info = Markers[marker]
        if marker and info then
            local dataPJ = exports["MR1_Inicio"]:getValue(source, 'Inventario')
            if (dataPJ["Dinero"] >= coste) then 
                --dataPJ["Dinero"] = dataPJ["Dinero"] - coste;
                --exports["MR1_Inicio"]:setValue(source, "Inventario", dataPJ)
                exports["MR6_Economia"]:restarDinero(source, coste, "MRJobs1_Agencia")
                fixVehicle(vehicle)
                local DataVeh = exports["MR1_Inicio"]:getValueOne(vehicle)
                estado = DataVeh.Estado
                estado.Destruido = false
                estado.Motor = false
                estado.Salud = 1000
                setVehicleEngineState(vehicle, false)
                        
                exports["MR1_Inicio"]:setValue(vehicle, "Estado", estado)
                
                outputChatBox("#ffe100Acabo de pagar "..coste.." dolares por reparar el vehiculo...", source, 255, 255, 255, true)
            end
        end
    end
end

addCommandHandler("repararveh", repairveh)
addEventHandler("onMarkerHit", getRootElement(), markerhit)
addEventHandler("onMarkerLeave", getRootElement(), markerLeave)


function ContratarJob(source, command, objetive)
    local staff = getPlayerName(source)

    if not (objetive) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario]", source, 0, 0, 0, true)
    end

    objetivo = nil;
    if tonumber(objetive) then
        objetivo = exports["MR1_Inicio"]:getPlayerFromID(objetive)
    elseif (isElement(getPlayerFromName(objetive))) then
        objetivo = getPlayerFromName(objetive)
    else
        return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
    end

    --iprint(objetivo)
    Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
    local maxRank = exports["MR1_Inicio"]:query('SELECT max(Rango) FROM TrabajosRangos WHERE Trabajo=?', Trabajos.Trabajo)
    if not (maxRank[1]['max(Rango)'] == tonumber(Trabajos.Rango)) then
        return outputChatBox("#9AA498[#FF7800TRABAJO#9AA498] #A03535No eres el jefe de esta faccion/empresa.", source, 255, 255, 255, true )
    end

    Trabajos2 = exports["MR1_Inicio"]:getValue(objetivo, 'Trabajos')
    if (Trabajos2.Trabajo == Trabajos.Trabajo) then
        return outputChatBox("#9AA498[#FF7800Jobs#9AA498] #24C5BE"..getPlayerName(objetivo).." #53B440ya tiene este trabajo.", source, 255, 255, 255, true)
    end
    Trabajos2.Trabajo = Trabajos.Trabajo
    Trabajos2.Rango = 1
    NewTrabajos2 = exports["MR1_Inicio"]:setValue(objetivo, 'Trabajos', Trabajos2)

    local DataPJObjetivo = exports["MR1_Inicio"]:query('SELECT * FROM Personajes WHERE Nombre=?', objetive)
    exports["MR1_Inicio"]:execute("UPDATE TrabajosUsers SET Trabajo='"..Trabajos.Trabajo.."', Rango="..Trabajos2.Rango.." WHERE Personajes=?", DataPJObjetivo[1].ID)

    outputChatBox("#9AA498[#FF7800Jobs#9AA498] #53B440Has contratado a #24C5BE"..getPlayerName(objetivo), source, 255, 255, 255, true) -- STAFF
    outputChatBox("#9AA498[#FF7800Jobs#9AA498] #FF7800"..staff.." #53B440te ha contratado.", objetivo, 255, 255, 255, true) -- USER
end
addCommandHandler("contratar", ContratarJob)

function PayDay()
    local players = getElementsByType("player")
    local DataJobs = exports["MR1_Inicio"]:query('SELECT * FROM TrabajosRangos')

    local jobData = {}
    for _, job in ipairs(DataJobs) do
        if not jobData[job.Trabajo] then
            jobData[job.Trabajo] = {}
        end
        jobData[job.Trabajo][tostring(job.Rango)] = job.Salario
    end
    for _, player in ipairs(players) do
        local Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
        if Trabajos and jobData[Trabajos.Trabajo] and jobData[Trabajos.Trabajo][tostring(Trabajos.Rango)] then
            local salario = jobData[Trabajos.Trabajo][tostring(Trabajos.Rango)]
            local varInfoClient = exports["MR1_Inicio"]:getValueOne(player)
            --varInfoClient.Inventario["Dinero"] = varInfoClient.Inventario["Dinero"] + salario;
            --exports["MR1_Inicio"]:setValue(player, "Inventario", varInfoClient.Inventario)
            exports["MR6_Economia"]:SumarDinero(player, salario, "MRJobs1_Agencia")
            local NumeroFormato = formatNumber(salario)
            outputChatBox("#9AA498[#FF7800Jobs-PAYDAY#9AA498] #53B440Has recibido #FFFFFF"..NumeroFormato.." #53B440$.", player, 255, 255, 255, true) -- STAFF
        end
    end  
end
setTimer(PayDay, 3600000, 0) --3600000
addCommandHandler("PayDay", PayDay)


function Servicios(source, command)
    local countLSPD, totalLSPD = 0, 0
    local countLSES, totalLSES = 0, 0
    local countLSJD, totalLSJD = 0, 0
    local countMeca, totalMeca = 0, 0
    for _, player in ipairs(getElementsByType("player")) do 
        local Trabajos = exports["MR1_Inicio"]:getValue(player, 'Trabajos')
        if (Trabajos and Trabajos.Trabajo) then
            if (Trabajos.Trabajo == "Los Santos Police Departament") then 
                totalLSPD = totalLSPD + 1
                if (Trabajos.OnDuty == true) then
                    countLSPD = countLSPD + 1
                end
            end

            if (Trabajos.Trabajo == "Los Santos Emergency Services") then 
                totalLSES = totalLSES + 1
                if (Trabajos.OnDuty == true) then
                    countLSES = countLSES + 1
                end
            end

            if (Trabajos.Trabajo == "Los Santos Justice Departament") then 
                totalLSJD = totalLSJD + 1
                if (Trabajos.OnDuty == true) then
                    countLSJD = countLSJD + 1
                end
            end

            for i, job in ipairs(FaccEmp) do
                if (job[4] == "Meca" and Trabajos.Trabajo == job[1]) then
                    totalMeca = totalMeca + 1
                    if (Trabajos.OnDuty == true) then 
                        countMeca = countMeca + 1
                    end
                end
            end
        end
    end
    outputChatBox("LSPD - Comando: /lspd (Texto) | Miembros en servicio: " .. countLSPD.. "/"..totalLSPD, source, 255, 255, 255)
    outputChatBox("LSES - Comando: /lses (Texto) | Miembros en servicio: " .. countLSES.. "/"..totalLSES, source, 255, 255, 255)
    outputChatBox("LSJD - Comando: /lsjd (Texto) | Miembros en servicio: " .. countLSJD.. "/"..totalLSJD, source, 255, 255, 255)
    outputChatBox("Meca - Comando: /meca (Texto) | Miembros en servicio: " .. countMeca.. "/"..totalMeca, source, 255, 255, 255)
end
addCommandHandler("servicios", Servicios)




