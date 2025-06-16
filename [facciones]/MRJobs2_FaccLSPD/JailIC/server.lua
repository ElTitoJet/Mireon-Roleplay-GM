local CondenasIC = {}

addEventHandler("onResourceStart", resourceRoot, function()
	exports["MR1_Inicio"]:execute("CREATE TABLE IF NOT EXISTS JailICDisconnect ( ID INT NOT NULL AUTO_INCREMENT, Personaje VARCHAR(255) NOT NULL, PD VARCHAR(255) NOT NULL, Tiempo VARCHAR(255) NOT NULL, PRIMARY KEY (ID));")
end)

--FUNCIONES UTILES
function fechaIC()
	local t = getRealTime();
	local dia = t.monthday;
	local mes = t.month +1;
	local ano = t.year +1900;
	local hora = t.hour
	local minuto = t.minute
	local segundo = t.second
	return ""..dia.."|"..mes.."|"..ano..""
end

function isPlayerJailedIC(objetivo)
	if objetivo then
		if CondenasIC[getPlayerName(objetivo)] then
			return true
		else 
			return false 
		end
	else 
		return false 
	end
end

function getPlayerJailICInfo(objetivo)
	if objetivo then
		Name = getPlayerName(objetivo)
		if CondenasIC[Name] then
			info = {CondenasIC[Name][1], CondenasIC[Name][2], CondenasIC[Name][3], CondenasIC[Name][4]}
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

--FUNCIONES EJECUTORAS
function encarcelar(source, command, objetive, tiempo)
    local pd = getPlayerName(source)
    Trabajos = exports["MR1_Inicio"]:getValue(source, 'Trabajos')
    if Trabajos.Trabajo == "Los Santos Police Departament" then
        if Trabajos.OnDuty == true then
            if objetive then
                local jugadorSancionado = getPlayerFromName(objetive)
                if jugadorSancionado then
                    local posX1, posY1, posZ1= getElementPosition(source) -- Obtenemos la posicion del sujeto que esta ejecutando el comando.
                    local posX2, posY2, posZ2 = getElementPosition(jugadorSancionado) -- Obtenemos la posicion del objetivo.
                    if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) < 2 then -- Comprobamos si la distancia del que habla y los jugadores es menor o igual a VozNormal
                        --if objetive ~= getPlayerName(source) then
                            if tiempo then
                                tiempoSancion = tiempo * 60000

                                timer = setTimer(playerJailICLiberty, tiempoSancion, 1, jugadorSancionado)
                                CondenasIC[objetive] = {timer, pd, tiempoSancion}

                                exports["MR1_Inicio"]:setValue(jugadorSancionado, 'JailIC', CondenasIC[objetive])
        
                                setElementInterior(jugadorSancionado, 2, 2539.408203125, -1305.388671875, 1044.125)
                                setElementDimension(jugadorSancionado, 0)
        
                                triggerClientEvent(jugadorSancionado, "jailIC:initDX", jugadorSancionado, CondenasIC[objetive][3])

                                outputChatBox("#9AA498[#a03535LSPD#9AA498] #53B440Has encarcelado a #24C5BE"..objetive.."#53B440 durante #24C5BE"..tiempo.." minutos#53B440.", source, 255, 255, 255, true) -- STAFF
                                outputChatBox("#9AA498[#a03535LSPD#9AA498] #FF7800"..pd.." #53B440te encarcelo durante #FF7800"..tostring(tiempo).." minutos#53B440.", jugadorSancionado, 255, 255, 255, true) -- USER

                            else
                                outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/carcel [Usuario] [Tiempo]", source, 0, 0, 0, true)
                            end
                        --end
                    end
                end
            else
                outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/carcel [Usuario] [Tiempo]", source, 0, 0, 0, true)
            end
        end
    end

end
addCommandHandler("carcel", encarcelar)

function playerJailICLiberty(objetivo)
	if objetivo then
		if isElement(objetivo) then
			if isPlayerJailedIC(objetivo) then
				name = getPlayerName(objetivo)
				setElementInterior(objetivo, 0, 1798.9970703125, -1576.5380859375, 14.0625)
				setElementDimension(objetivo, 0)
				outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Terminaste tu sanción, reflexiona sobre tus errores.", objetivo, 0, 0, 0, true)
				exports["MR1_Inicio"]:execute("DELETE FROM JailICDisconnect WHERE IDPersonaje=?", name)
				exports["MR1_Inicio"]:setValue(objetivo, 'JailIC', nil)
				triggerClientEvent(objetivo, "jailIC:exitDX", objetivo)
				CondenasIC[getPlayerName(objetivo)] = nil
			else return false end
		else return false end
	else return false end
end

function playerJailICExitForJailOOC(source)
	if isPlayerJailedIC(source) then
		JailInfo = getPlayerJailICInfo(source)
		if isTimer(JailInfo[1]) then
			obj = getPlayerName(source)
			milisegundosRestantes = getTimerDetails(JailInfo[1])
			exports["MR1_Inicio"]:execute("INSERT INTO JailICDisconnect( Personaje, PD, Tiempo) VALUES(?,?,?)", obj, JailInfo[2], milisegundosRestantes)
			
			if isTimer(CondenasIC[obj][1]) then
				killTimer(CondenasIC[obj][1])
			end
			table.remove(CondenasIC[obj])
			triggerClientEvent(source, "jailIC:exitDX", source)

		end
	end
end

function playerJailICDisconnect()
	if isPlayerJailedIC(source) then
		JailInfo = getPlayerJailICInfo(source)
		if isTimer(JailInfo[1]) then
			obj = getPlayerName(source)
			milisegundosRestantes = getTimerDetails(JailInfo[1])
			exports["MR1_Inicio"]:execute("INSERT INTO JailICDisconnect( Personaje, PD, Tiempo) VALUES(?,?,?)", obj, JailInfo[2], milisegundosRestantes)
			table.remove(CondenasIC[obj])
		end
	end
end
addEventHandler("onPlayerQuit", getRootElement(), playerJailICDisconnect)

function playerJailICConnect(source)
	objetivo = getPlayerName(source)
	local result = exports["MR1_Inicio"]:query("SELECT * FROM JailICDisconnect WHERE Personaje=?", objetivo)
	if #result > 0 then
		timer = setTimer(playerJailICLiberty, result[1]["Tiempo"], 1, source)
		CondenasIC[objetivo] = {timer, result[1]["PD"], result[1]["Tiempo"]}

		exports["MR1_Inicio"]:setValue(source, 'JailIC', CondenasIC[objetivo])

		setElementInterior(source, 3, 281.310546875, 223.3212890625, 1037.15625)
		setElementDimension(source, 0)

		exports["MR1_Inicio"]:execute("DELETE FROM JailICDisconnect WHERE Personaje=?", objetivo)
		
		tiempomessage = result[1]["Tiempo"]/60000
		outputChatBox("#9AA498[#FF7800Server#9AA498]#A03535 Te has vuelto a conectar #24C5BE"..objetivo.."#A03535 ahora cumpliras tu sancion puesta por #FF7800"..result[1]["PD"].." \n#A03535 Minutos: #FF7800"..math.floor(tiempomessage), objetivo, 0, 0, 0, true)	

		triggerClientEvent(source, "jailIC:initDX", source, CondenasIC[objetivo][3])
		return true
	end
	return false
end
