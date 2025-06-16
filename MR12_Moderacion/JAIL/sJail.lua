--[[
    AJUSTES PRINCIPALES
]]
local CondenasOOC = {}
local controlTable = { "fire", "aim_weapon", "next_weapon", "previous_weapon", "forwards", "backwards", "left", "right", "zoom_in", "zoom_out",
	"change_camera", "jump", "sprint", "look_behind", "crouch", "action", "walk", "conversation_yes", "conversation_no",
	"group_control_forwards", "group_control_back", "enter_exit", "vehicle_fire", "vehicle_secondary_fire", "vehicle_left", "vehicle_right",
	"steer_forward", "steer_back", "accelerate", "brake_reverse", "radio_next", "radio_previous", "radio_user_track_skip", "horn", "sub_mission",
	"handbrake", "vehicle_look_left", "vehicle_look_right", "vehicle_look_behind", "vehicle_mouse_look", "special_control_left", "special_control_right",
	"special_control_down", "special_control_up"
}
--[[
    SCRIPT START
]]
function Iniciar_Recurso_Jails(resource)
	exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS JailOOCHistory(ID INT NOT NULL AUTO_INCREMENT, IDPersonaje INT NOT NULL, Staff VARCHAR(255) NOT NULL, Fecha VARCHAR(255) NOT NULL, Razon VARCHAR(255) NOT NULL, PRIMARY KEY(ID))")
	exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS JailOOCDisconnect(ID INT NOT NULL AUTO_INCREMENT, IDPersonaje INT NOT NULL, Staff VARCHAR(255) NOT NULL, Tiempo INT NOT NULL, Razon VARCHAR(255) NOT NULL, PRIMARY KEY(ID))")
end
addEventHandler("onResourceStart", resourceRoot, Iniciar_Recurso_Jails)

--[[
	FUNCIONES UTILES
]]
	
function Comprobar_Rango_Source(source)
	if isElement( source ) then
		local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta')
		local result = exports["MR1_Inicio"]:query("SELECT Abreviatura FROM Rangos WHERE ID=?", tonumber(rank.Rango));
		if result and #result == 1 then
			return result[1].Abreviatura
		end
	end
	return 'none'
end

function ObtenerFechaIRL()
	local t = getRealTime();
	local dia = t.monthday;
	local mes = t.month +1;
	local ano = t.year +1900;
	local hora = t.hour
	local minuto = t.minute
	local segundo = t.second

	local time = ""..dia.."|"..mes.."|"..ano..""
	return time
end

function isPlayerJailed(objetivo)
	if objetivo and CondenasOOC[getPlayerName(objetivo)] then
		return true
	else 
		return false 
	end
end

function getPlayerJailOOCInfo(objetivo)
	if objetivo then
		Name = getPlayerName(objetivo)
		if CondenasOOC[Name] then
			info = {CondenasOOC[Name][1], CondenasOOC[Name][2], CondenasOOC[Name][3], CondenasOOC[Name][4]}
			if info then 
				return info 
			end
		else 
			return false 
		end
	else 
		return false 
	end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function playerJailLiberty(Player)

	if not (Player) or not (isElement(Player)) or not (isPlayerJailed(Player)) then
		return false
	end

	name = getPlayerName(Player)
	local IDPJ = exports["MR1_Inicio"]:getValue(Player, 'IDPersonaje')
	if not (exports["MRJobs2_FaccLSPD"]:playerJailICConnect(source)) then
		setElementInterior(Player, 0, 2099.5529785156, -1804.1966552734, 13.5546875)
		setElementDimension(Player, 0)
	end
	outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Terminaste tu sanción, reflexiona sobre tus errores.", Player, 0, 0, 0, true)
	local test = exports["MR1_Inicio"]:execute("DELETE FROM JailOOCDisconnect WHERE IDPersonaje=?", IDPJ)
	exports["MR1_Inicio"]:setValue(Player, 'JailOOC', nil)
	triggerClientEvent(Player, "jail:exitDX", Player)
	outputDebugString("[JAIL-LIBERTY] PERSONAJE: "..name.." EN LIBERTAD.")

end

function playerJailDisconnect(Usuario, IDPJ)
	if isPlayerJailed(Usuario) then
		JailInfo = getPlayerJailOOCInfo(Usuario)
		if isTimer(JailInfo[1]) then
			obj = getPlayerName(Usuario)
			milisegundosRestantes = getTimerDetails(JailInfo[1])
			local tiempo = milisegundosRestantes / 60000 --Combertimos el tiempo a milesimas.
			outputDebugString("[JAIL-DISCONNECT] PERSONAJE: "..obj)
			exports["MR1_Inicio"]:execute("INSERT INTO JailOOCDisconnect(IDPersonaje, Staff, Tiempo, Razon) VALUES(?,?,?,?)", IDPJ, JailInfo[2], tiempo, JailInfo[4])
			table.remove(CondenasOOC[obj])
		end
	end
end

function playerJailConnect(source)

	objetivo = getPlayerName(source)
	
	local IDPJ = exports["MR1_Inicio"]:getValue(source, 'IDPersonaje')
	local result = exports["MR1_Inicio"]:query("SELECT * FROM JailOOCDisconnect WHERE IDPersonaje=?", IDPJ)

	if #result > 0 then
		tiemposancion = result[1]["Tiempo"]*60000
		timer = setTimer(playerJailLiberty, tiemposancion, 1, source)
		CondenasOOC[objetivo] = {timer, result[1]["Staff"], tiemposancion, result[1]["Razon"]}

		exports["MR1_Inicio"]:setValue(source, 'JailOOC', CondenasOOC[objetivo])

		setElementInterior(source, 10, 419.6140, 2536.6030, 10.0000)
		setElementDimension(source, IDPJ)

		exports["MR1_Inicio"]:execute("DELETE FROM JailOOCDisconnect WHERE IDPersonaje=?", IDPJ)
		iprint(CondenasOOC[objetivo][3])
		triggerClientEvent(source, "jail:initDX", source, CondenasOOC[objetivo][3])
	
		outputDebugString("[JAIL-CONNECT] PERSONAJE "..objetivo.." TIEMPO: "..result[1]["Tiempo"].." RAZON: "..result[1]["Razon"])
		outputChatBox("#9AA498[#FF7800Server#9AA498]#A03535 Te has vuelto a conectar #24C5BE"..objetivo.."#A03535 ahora cumpliras tu sancion puesta por #FF7800"..result[1]["Staff"].." \n#A03535 Minutos: #FF7800"..result[1]["Tiempo"].."#A03535 Razón: #FF7800"..result[1]["Razon"], source, 0, 0, 0, true)	
	end
end

--[[
	FUNCIONES EJECUTORAS
]]
addCommandHandler("jail", function(source, command, objetive, tiempo, ...)
    local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta') --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
    if not (rank["Rango"] >= 3) then -- COMPROBAMOS SI SU RANGO ES MENOR A 3.
        return --CANCELAMOS LA EJECUCION DEL COMANDO
    end

    local staff = getAccountName(getPlayerAccount(source)) --TOMAMOS SU NOMBRE DE CUENTA/STAFF
    if not (objetive) then --COMPROBAMOS SI METIO EL COMANDO /jail Nombre_Apellido correctamente
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario] [Tiempo] [Razón]", source, 0, 0, 0, true) --RETORNAMOS LA SYNTAXIS CORRECTA
    end

	local resultIDObjetivo = exports["MR1_Inicio"]:query("SELECT ID FROM Personajes WHERE Nombre = ?", objetive) 
	if not (resultIDObjetivo[1].ID > 0) then --COMPROBAMOS SI EL USUARIO EXISTE EN LA DB
		return outputChatBox("#56c450El jugador #24C5BE"..objetive.." #56c450no esta registrado en este servidor.", source, 0,0,0, true) -- INFORMAMOS DE QUE EL USUARIO A SANCIONAR NO EXISTE Y CANCELAMOS COMANDO
	end
	
    local objetivo = getPlayerFromName(objetive) -- TOMAMOS EL ELEMENTO DEL USUARIO A SANCIONAR

    if not (tiempo) then --COMPROBAMOS SI METIO EL COMANDO /jail Nombre_Apellido Tiempo correctamente
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." "..objetive.." [Tiempo] [Razón]", source, 0, 0, 0, true) --RETORNAMOS LA SYNTAXIS CORRECTA
    end
	local tiempoSancion = tiempo * 60000 --Combertimos el tiempo a milesimas.
    
	local reason = table.concat({...}, " ") --Concatenamos la razon en una sola variable.
    if not (#reason > 1) then --COMPROBAMOS SI METIO EL COMANDO /jail Nombre_Apellido Tiempo Razón correctamente
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." "..objetive.." "..tiempo.." [Razón]", source, 0, 0, 0, true) --RETORNAMOS LA SYNTAXIS CORRECTA
    end

	local fecha = ObtenerFechaIRL() --OBTENEMOS LA FECHA ACTUAL DEL SERVIDOR

	if not (isElement(objetivo)) then --Comprobamos si el jugador a sancionar no esta conectado.
		local result = exports["MR1_Inicio"]:query("SELECT * FROM JailOOCDisconnect WHERE IDPersonaje = ?", resultIDObjetivo[1].ID) 
		if not (#result > 0) then --COMPROBAMOS SI EL USUARIO NO TIENE UN JAIL ACTIVO
			
			local jail = exports["MR1_Inicio"]:execute("INSERT INTO JailOOCDisconnect(IDPersonaje, Staff, Tiempo, Razon) VALUES(?,?,?,?)", resultIDObjetivo[1].ID, staff, tiempo, reason)
			if not (jail > 0) then
				return outputChatBox("#56c450ERROR al sancionar a #24C5BE"..objetive.."", source, 0,0,0, true)
			end
			exports["MR1_Inicio"]:execute("INSERT INTO JailOOCHistory(IDPersonaje, Staff, Fecha, Razon) VALUES(?,?,?,?)", resultIDObjetivo[1].ID, staff, fecha, reason)
			outputDebugString("[JAIL-OOC New] JUGADOR: "..objetive.." STAFF: "..staff.." MINUTOS: "..tiempo.." RAZON: "..reason)
			outputChatBox("#56c450El jugador #24C5BE"..objetive.." #56c450ha sido #FF0000jaileado #56c450por "..tiempo.." minutos.\n#56c450Motivo: #24C5BE"..reason, source, 0,0,0, true)
		
			exports["MR15_Discord"]:sendDiscordSanciones(objetive, getAccountName(getPlayerAccount(source)), tiempo, "Jail", reason)
			return
		end
		--DESDE ESTE PUNTO EL JUGADOR YA ESTA EN JAILOOC PERO SIGUE DESCONECTADO
		TiempoNuevo = result[1]["Tiempo"] + tiempo --TOMAMOS EL TIEMPO EN MINUTOS QUE YA TIENE Y LO SUMAMOS CON EL ACTUAL

		local jail = exports["MR1_Inicio"]:execute("UPDATE JailOOCDisconnect SET Staff=?, Tiempo=?, Razon=? WHERE IDPersonaje=?", staff, TiempoNuevo, reason, resultIDObjetivo[1].ID)
		if not (jail > 0) then
			return outputChatBox("#56c450ERROR al sancionar a #24C5BE"..objetive.."", source, 0,0,0, true)
		end
		exports["MR1_Inicio"]:execute("INSERT INTO JailOOCHistory(IDPersonaje, Staff, Fecha, Razon) VALUES(?,?,?,?)", resultIDObjetivo[1].ID, staff, fecha, reason)
		outputDebugString("[JAIL-OOC Update] JUGADOR: "..objetive.." STAFF: "..staff.." MINUTOS: "..TiempoNuevo.." RAZON: "..reason)
		outputChatBox("#56c450El jail OOC del jugador #24C5BE"..objetive.." #56c450ha sido #FF0000aumentado #56c450en "..tiempo.." minutos, ahora estara por "..TiempoNuevo.."\n#56c450Motivo: #24C5BE"..reason, source, 0,0,0, true)
	
        exports["MR15_Discord"]:sendDiscordSanciones(objetive, getAccountName(getPlayerAccount(source)), TiempoNuevo, "Jail", reason)
		return
	end
	--EL JUGADOR ESTA CONECTADO
	local Estado = exports["MR1_Inicio"]:getValue(objetivo, 'Estado') --OBTENEMOS LA INFORMACION DEL ESTADO DEL OBJETIVO
	if Estado.Muerto == true then --COMPROBAMOS SI ESTA MUERTO Y LO REVIVIMOS
		local xRevive, yRevive, zRevive = getElementPosition(objetivo)
		local intRevive = getElementInterior(objetivo)
		local dimRevive = getElementDimension(objetivo)
		local revivePlayer = spawnPlayer(objetivo, xRevive, yRevive, zRevive, 0, Estado.Skin, 0, 0)
		local reviveDim = setElementInterior(objetivo, intRevive)
		local reviveInt = setElementDimension(objetivo, dimRevive)
		if revivePlayer then
			for i, v in ipairs(controlTable) do
				toggleControl(objetivo, v, true)
			end
			if isEventHandlerAdded("onClientRender", objetivo) then
				removeEventHandler("onClientRender", objetivo)
			end
			Estado.Muerto = false
			local Estado = exports["MR1_Inicio"]:setValue(objetivo, 'Estado', Estado)
			local Resucitar = exports["MR3_Muertes"]:resucitar(objetivo)
		end
	end

	local jailIC = exports["MRJobs2_FaccLSPD"]:isPlayerJailedIC(objetivo)
	if jailIC then
		exports["MRJobs2_FaccLSPD"]:playerJailICExitForJailOOC(objetivo)
	end

	if CondenasOOC[objetive] and isTimer(CondenasOOC[objetive][1]) then --COMPROBAMOS SI YA SE ENCUENTRA JAILEADO
		triggerClientEvent(objetivo, "jail:exitDX", objetivo) --BORRAMOS EL DX QUE TIENE EL CLIENTE
		oldTime = getTimerDetails(CondenasOOC[objetive][1]) -- OBTENEMOS EL TIEMPO EN MILESIMAS QUE SE ESTA EJECUTANDO
		newTime = oldTime + tiempoSancion --SUMAMOS EL NUEVO TIEMPO
		killTimer(CondenasOOC[objetive][1]) --ELIMINAMOS EL TIEMER ANTIGUO
		table.remove(CondenasOOC[objetive]) --SACAMOS AL JUGADOR DE LA TABLA DE JAIL
		newTimer = setTimer(playerJailLiberty, newTime, 1, objetivo) --CREAMOS EL NUEVO TIMER
		CondenasOOC[objetive] = {newTimer, staff, newTime, reason} --VOLVEMOS A METER AL JUGADOR CON LOS NUEVOS DATOS
		timemessage = newTime / 60000 --CONVERTIMOS EL TIEMPO A MINUTOS PARA MOSTRARLO EN PANTALLA
		outputDebugString("[Jail-OOC Update] JUGADOR: "..objetive.." STAFF: "..staff.." MINUTOS: "..math.floor(timemessage).." RAZON: "..reason)
		outputChatBox("#56c450El jail OOC del jugador #24C5BE"..objetive.." #56c450ha sido #FF0000aumentado #56c450en "..tiempo.." minutos, ahora estara por "..math.floor(timemessage).." minutos.\n#56c450Motivo: #24C5BE"..reason, source, 0,0,0, true)
		
		exports["MR15_Discord"]:sendDiscordSanciones(objetive, getAccountName(getPlayerAccount(source)), math.floor(timemessage), "Jail", reason)
	else --NO SE ENCUENTRA JAILEADO
		timer = setTimer(playerJailLiberty, tiempoSancion, 1, objetivo) -- CREAMOS EL TIMER
		CondenasOOC[objetive] = {timer, staff, tiempoSancion, reason} -- METEMOS AL JUGADOR EN LA TABLA DE JAILS ACTIVOS
		outputDebugString("[JAIL-OOC New] JUGADOR: "..objetive.." STAFF: "..staff.." MINUTOS: "..tiempo.." RAZON: "..reason)
		outputChatBox("#56c450El jugador #24C5BE"..objetive.." #56c450ha sido #FF0000jaileado #56c450por "..tiempo.." minutos.\n#56c450Motivo: #24C5BE"..reason, source, 0,0,0, true)
		
		exports["MR15_Discord"]:sendDiscordSanciones(objetive, getAccountName(getPlayerAccount(source)), tiempo, "Jail", reason)
	end

	exports["MR1_Inicio"]:setValue(objetivo, 'JailOOC', CondenasOOC[objetive])
	if isPedInVehicle(objetivo) then removePedFromVehicle(objetivo) end
	setElementInterior(objetivo, 10, 419.6140, 2536.6030, 10.0000)
	setElementDimension(objetivo, resultIDObjetivo[1].ID)
	
	exports["MR1_Inicio"]:execute("INSERT INTO JailOOCHistory(IDPersonaje, Staff, Fecha, Razon) VALUES(?,?,?,?)", resultIDObjetivo[1].ID, staff, fecha, reason)
	triggerClientEvent(objetivo, "jail:initDX", objetivo, CondenasOOC[objetive][3])
end)

addCommandHandler("unjail", function(source, command, objetive, ...)
    local rank = exports["MR1_Inicio"]:getValue(source, 'InfoCuenta') --TOMAMOS LA INFO DE LA CUENTA DEL SOURCE
    if not (rank["Rango"] >= 4) then -- COMPROBAMOS SI SU RANGO ES MENOR A 3.
        return --CANCELAMOS LA EJECUCION DEL COMANDO
    end

    local staff = getAccountName(getPlayerAccount(source)) --TOMAMOS SU NOMBRE DE CUENTA/STAFF
    if not (objetive) then --COMPROBAMOS SI METIO EL COMANDO /jail Nombre_Apellido correctamente
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [Usuario] [Tiempo] [Razón]", source, 0, 0, 0, true) --RETORNAMOS LA SYNTAXIS CORRECTA
    end

	local resultIDObjetivo = exports["MR1_Inicio"]:query("SELECT ID FROM Personajes WHERE Nombre = ?", objetive) 
	if not (resultIDObjetivo[1].ID > 0) then --COMPROBAMOS SI EL USUARIO EXISTE EN LA DB
		return outputChatBox("#56c450El jugador #24C5BE"..objetive.." #56c450no esta registrado en este servidor.", source, 0,0,0, true) -- INFORMAMOS DE QUE EL USUARIO A SANCIONAR NO EXISTE Y CANCELAMOS COMANDO
	end
	
    local objetivo = getPlayerFromName(objetive) -- TOMAMOS EL ELEMENTO DEL USUARIO A LIBERAR
	if not (isElement(objetivo)) then --COMPROBAMOS SI ESTA ON
		return outputChatBox("#56c450El jugador #24C5BE"..objetive.." #56c450no esta conectado.", source, 0,0,0, true)
	end

	local reason = table.concat({...}, " ") --Concatenamos la razon en una sola variable.
    if not (#reason > 2) then --COMPROBAMOS SI METIO EL COMANDO /jail Nombre_Apellido Tiempo Razón correctamente
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." "..objetive.." [Razón]", source, 0, 0, 0, true) --RETORNAMOS LA SYNTAXIS CORRECTA
    end

	if not (isPlayerJailed(objetivo)) then --COMPROBAMOS SI ESTA EN JAIL OOC
		return outputChatBox("#56c450El jugador #24C5BE"..objetive.." #56c450no esta jaileado OOC.", source, 0,0,0, true)
	end

	exports["MR1_Inicio"]:setValue(objetivo, 'JailOOC', nil) --LE QUITAMOS EL TIEMPO DE SANCION DE SU DATA

	setElementInterior(objetivo, 0, 2099.5529785156, -1804.1966552734, 13.5546875)
	setElementDimension(objetivo, 0)

	outputDebugString("[Jail-OOC Remove] JUGADOR: "..objetive.." STAFF: "..staff.." RAZON: "..reason)
	outputChatBox("#56c450El jail OOC del jugador #24C5BE"..objetive.." #56c450ha sido #FF0000retirado.\n#56c450Motivo: #24C5BE"..reason, source, 0,0,0, true)

	if isTimer(CondenasOOC[objetive][1]) then
		killTimer(CondenasOOC[objetive][1])
	end
	CondenasOOC[objetive] = nil
	local IDPJ = exports["MR1_Inicio"]:getValue(objetivo, 'IDPersonaje')
	local test = exports["MR1_Inicio"]:execute("DELETE FROM JailOOCDisconnect WHERE IDPersonaje=?", IDPJ)

	triggerClientEvent(objetivo, "jail:exitDX", objetivo)
end)