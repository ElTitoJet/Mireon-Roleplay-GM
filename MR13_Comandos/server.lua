--Configuracion Inicial
local enabledCommands = {
    --COMANDOS USER ["cmd"] = true
        --Comando Muerto
            ["reaparecer"] = true,
        -- Comando Chats
            ["say"] = true,
            ["s"] = true, ["sus"] = true, ["susurrar"] = true,
            ["g"] = true, ["gr"] = true, ["gritar"] = true,
            ["togb"] = true, ["b"] = true, ["ooc"] = true,
            ["do"] = true, ["entorno"] = true,
            ["togmp"] = true, ["mp"] = true,
            ["hz"] = true, ["frec"] = true, ["verhz"] = true,
            ["r"] = true, ["radio"] = true,
        -- Comando Economia
            ["pagar"] = true,
        -- Comando Vehiculos
            ["bloqueo"] = true, ["motor"] = true, ["luces"] = true, ["cinturon"] = true,
            ["localizarveh"] = true,
            ["repararveh"] = true,
            ["vendervehiculo"] = true, ["confirmarcompra"] = true,
            ["maletero"] = true, ["capo"] = true, ["vermaletero"] = true, ["metermaletero"] = true, ["sacarmaletero"] = true,
        -- Comando Soporte
            ["duda"] = true, ["cduda"] = true,
            ["reporte"] = true, ["re"] = true, ["report"] = true, ["creporte"] = true, ["cre"] = true, ["creport"] = true,
            ["cambiarmypass"] = true,
            ["staff"] = true, ["usersTop"] = true,
        -- Comando estadisticas
            ["pos"] = true,
            ["dni"] = true,
            ["inventario"] = true, ["cachear"] = true,
            ["caminar"] = true,
            ["id"] = true,
            ["limitfps"] = true,
            ["fpslimit"] = true,
            ["stats"] = true,
            ["tiempojugado"] = true,
        -- Comando Armamento
            ["dararma"] = true, ["tirararma"] = true, ["verhuellas"] = true, ["vercaja"] = true, ["tomararma"] = true,
        -- Comando Facciones
            ["verfacciones"] = true, ["faccestado"] = true, ["faccnombre"] = true, ["facccolor"] = true, ["faccverrangos"] = true,
            ["facceditarrangos"] = true, ["faccasignar"] = true, ["faccquitar"] = true, ["faccver"] = true, ["faccinvite"] = true,


            ["rf"] = true, ["rec"] = true, ["rd"] = true, ["sirenas"] = true, ["balizas"] = true,



        -- Comando LSPD
            ["taser"] = true, ["esposar"] = true, ["multar"] = true, ["lspd"] = true, ["contratar"] = true, ["carcel"] = true, ["vermultas"] = true,
            ["conos"] = true,
            ["barrera"] = true,
            ["pinchos"] = true,
            ["eliminarobjeto"] = true,
        -- Comando LSES
            ["reanimar"] = true, ["atender"] = true, ["lses"] = true, 
        -- Comando Mecanico
            ["meca"] = true,
        -- Comando Eventos
            ["evento"] = true, ["irevento"] = true,
        -- Comando Animaciones
            ["sentarse"] = true,
            ["apoyarse"] = true,
            ["beber"] = true,
            ["reparar"] = true,
            ["ctm"] = true,
            ["camara"] = true,
            ["vendedor"] = true,
            ["perdedor"] = true,
            ["tocar"] = true,
            ["tomar"] = true,
            ["pose"] = true,
            ["cruzarbrazos"] = true,
            ["esperar"] = true,
            ["pensar"] = true,
            ["reloj"] = true,
            ["bate"] = true,
            ["dormir"] = true,
            ["herido"] = true,
            ["baile"] = true,
            ["guardia"] = true,
            ["cansado"] = true,
            ["comer"] = true,
            ["vomitar"] = true,
            ["asco"] = true,
            ["festejo"] = true,
            ["fumar"] = true,
            ["no"] = true,
            ["si"] = true,
            ["gang"] = true,
            ["llorar"] = true,
            ["pararse"] = true,
            ["escribir"] = true,
            ["saludar"] = true,
            ["nose"] = true,
            ["quepaso"] = true,
            ["rap"] = true,
            ["rcp"] = true,
            ["apuntar"] = true,
            ["facepalm"] = true,
            ["rascar"] = true,
            ["buscar"] = true,
            ["alentar"] = true,
            ["taichi"] = true,
            ["mear"] = true,
            ["paja"] = true,
            ["asustado"] = true,
            ["queteden"] = true,
            ["caer"] = true,
            ["estirar"] = true,
            ["trafico"] = true,
            ["patear"] = true,
            ["reir"] = true,
            ["dj"] = true,
            ["rendirse"] = true,
            ["strip"] = true,
            ["tirarse"] = true,

        ["ayuda"] = true, ["comandos"] = true, ["ayudastaff"] = true, ["comandosstaff"] = true, ["servicios"] = true,
    --COMANDOS Staff
        -- Comandos ubicacion
            ["tppos"] = true, ["ls"] = true, ["sf"] = true, ["lv"] = true, ["ir"] = true, ["dios"] = true,
            ["traer"] = true, ["llevar"] = true, ["airbreak"] = true, ["locateUser"] = true,
        -- Comandos de chat
            ["a"] = true, ["A"] = true, ["an"] = true, ["anuncio"] = true, ["spymp"] = true,
        -- Comandos de soporte
            ["treport"] = true, ["treporte"] = true, ["tre"] = true,
            ["vreporte"] = true, ["vre"] = true, ["vreport"] = true, 
            ["vdudas"] = true, ["rduda"] = true,
            ["vanish"] = true, ["invisible"] = true, ["visible"] = true,
            ["revivir"] = true, ["revive"] = true,
            ["curar"] = true, ["heal"] = true,
            ["cambiarPass"] = true, ["cambiarCuenta"] = true,  ["cambiarname"] = true, ["cambiarnacionalidad"] = true,
            ["cambiarsexo"] = true, ["matar"] = true, ["verinventario"] = true, ["verfrecuencia"] = true,
        -- Comandos de Sancion
            ["jail"] = true, ["unjail"] = true,
            ["echar"] = true, ["kick"] = true, ["expulsar"] = true,
            ["ban"] = true, ["banear"] = true, ["desban"] = true, ["desbanear"] = true, ["unban"] = true, ["unbanear"] = true,
        -- Comandos de vehiculo     
            ["traerveh"] = true,
        -- Comandos de trabajo
            ["setJob"] = true,
        -- Comandos de Familia 
            ["fam"] = true,
            ["verfamilias"] = true, ["famestado"] = true, ["famnombre"] = true, ["famcolor"] = true, ["faminvite"] = true,
            ["famverrangos"] = true, ["fameditarrangos"] = true, ["famasignar"] = true, ["famquitar"] = true, ["famver"] = true,
        -- Comandos de Jobs
            ["jobs"] = true,
            ["verjobs"] = true, ["jobverrangos"] = true, ["jobasignar"] = true, ["jobquitar"] = true,

    ["verAllData"] = true, ["verData"] = true,
    ["verSanciones"] = true,
    ["top"] = true,
    ["PayDay"] = true,
    ["abrirEvento"] = true, ["restartEvento"] = true, ["comoempezar"] = true,
    
    -- DESARROLADOR
    ["admin"] = true, ["debugscript"] = true, ["showcol"] = true,
    ["devmode"] = true, ["fortnite"] = true, ["guied"] = true, ["ipb"] = true, 
    ["countdown"] = true, ["cd"] = true, ["cdn"] = true, ["count"] = true, ["cstop"] = true,
    ["crearcasa"] = true,

    ["srun"] = true, ["camhack"] = true, ["toghud"] = true, ["crearnpc"] = true, ["anim"] = true, ["guied"] = true, ["crearcajero"] = true,

    ["mark"] = true, ["pepe"] = true, ["setRank"] = true, ["usersTop2"] = true, ["reinicio"] = true, ["updateIP"] = true,

    
["sound"] = true,
["music"] = true,
["radio"] = true,
["speaker"] = true,
["delbox"] = true,
["subirmoto"] = true, ["bajarmoto"] = true, 
["int"] = true, ["startrace"] = true,
}
local VehiculosUsuarios = {}
local cooldowns = {}

local ayudaComandos = {
    ["muerto"] = {
        {"reaparecer", "Reaparecer después de morir"}
    },
    ["chat"] = {
        {"say", "Chat de habla IC"},
        {"s", "Susurrar"},
        {"susurrar", "Susurrar"},
        {"g", "Gritar"},
        {"gr", "Gritar"},
        {"gritar", "Gritar"},
        {"togb", "Activar/desactivar chat B"},
        {"b", "Chat B"},
        {"ooc", "Chat OOC"},
        {"do", "Describir acciones"},
        {"entorno", "Describir el entorno"},
        {"togmp", "Activar/desactivar MP"},
        {"mp", "Mensaje privado"},
        {"hz", "Cambiar frecuencia de radio"},
        {"frec", "Ver frecuencia de radio"},
        {"verhz", "Ver frecuencia de radio"},
        {"r", "Radio"},
        {"radio", "Radio"}
    },
    ["economia"] = {
        {"pagar", "Pagar a otro jugador"}
    },
    ["vehiculos"] = {
        {"bloqueo", "Bloquear/desbloquear vehículo"},
        {"motor", "Encender/apagar motor"},
        {"luces", "Encender/apagar luces"},
        {"cinturon", "Ponerse/quitarse el cinturón"},
        {"localizarveh", "Localizar vehículo"},
        {"repararveh", "Reparar vehículo"},
        {"vendervehiculo", "Vender tu vehiculo a un jugador"},
        {"confirmarcompra", "Aceptar Oferta de un vehiculo"},
        {"maletero", "Abrir o cerrar el maletero"},
        {"capo", "Abrir o cerrar el capo"},
        {"vermaletero", "Ver el contenido de un maletero"},
        {"metermaletero", "Meter contenido al maletero"},
        {"sacarmaletero", "Sacar contenido del maletero"}
    },
    ["soporte"] = {
        {"duda", "Enviar una duda"},
        {"cduda", "Cancelar una duda"},
        {"reporte", "Enviar un reporte"},
        {"re", "Enviar un reporte"},
        {"report", "Enviar un reporte"},
        {"creporte", "Cancelar un reporte"},
        {"cre", "Cancelar un reporte"},
        {"creport", "Cancelar un reporte"},
        {"cambiarmypass", "Cambiar contraseña"},
        {"staff", "Ver miembros del staff"}
    },
    ["estadisticas"] = {
        {"pos", "Ver posición actual"},
        {"dni", "Ver DNI"},
        {"inventario", "Ver inventario"},
        {"cachear", "Cachear a un jugador"},
        {"caminar", "Cambiar estilo de caminar"},
        {"id", "Ver ID de jugador"},
        {"limitfps", "Limitar FPS"},
        {"fpslimit", "Limitar FPS"}
    },
    ["armamento"] = {
        {"dararma", "Dar arma"},
        {"tirararma", "Tirar arma"},
        {"verhuellas", "Ver huellas"},
        {"vercaja", "Ver caja"},
        {"tomararma", "Tomar arma"}
    },
    ["facciones"] = {
        {"rf", "Radio facción"},
        {"rec", "Radio económica"},
        {"rd", "Radio directa"},
        {"sirenas", "Activar/desactivar sirenas"},
        {"balizas", "Activar/desactivar balizas"}
    },
    ["lspd"] = {
        {"taser", "Usar taser"},
        {"esposar", "Esposar a un jugador"},
        {"multar", "Multar a un jugador"},
        {"lspd", "Comando LSPD"},
        {"contratar", "Contratar a un jugador"},
        {"carcel", "Enviar a la cárcel"},
        {"vermultas", "Ver multas del jugador"},
        {"conos", "Coloca conos"},
        {"barrera", "Coloca barreras"},
        {"pinchos", "Coloca pinchos"},
        {"eliminarobjeto", "Elimina tu ultimo objeto"}
    },
    ["lses"] = {
        {"rcp", "Realizar RCP"},
        {"atender", "Atender a un jugador"},
        {"lses", "Comando LSES"}
    },
    ["mecanico"] = {
        {"meca", "Comando mecánico"}
    },
    ["eventos"] = {
        {"evento", "Crear evento"},
        {"irevento", "Ir a un evento"}
    },
    ["animaciones"] = {
       {"sentarse", "Animaciones de sentarse"},
       {"apoyarse", "Animaciones de apoyarse"},
       {"beber", "Animaciones de beber"},
       {"reparar", "Animaciones de reparar"},
       {"ctm", "Animaciones de ctm"},
       {"camara", "Animaciones de camara"},
       {"vendedor", "Animaciones de vendedor"},
       {"perdedor", "Animaciones de perdedor"},
       {"tocar", "Animaciones de tocar"},
       {"tomar", "Animaciones de tomar"},
       {"pose", "Animaciones de pose"},
       {"cruzarbrazos", "Animaciones de cruzarbrazos"},
       {"esperar", "Animaciones de esperar"},
       {"pensar", "Animaciones de pensar"},
       {"reloj", "Animaciones de reloj"},
       {"bate", "Animaciones de bate"},
       {"dormir", "Animaciones de dormir"},
       {"herido", "Animaciones de herido"},
       {"baile", "Animaciones de baile"},
       {"guardia", "Animaciones de guardia"},
       {"cansado", "Animaciones de cansado"},
       {"comer", "Animaciones de comer"},
       {"vomitar", "Animaciones de vomitar"},
       {"asco", "Animaciones de asco"},
       {"festejo", "Animaciones de festejo"},
       {"fumar", "Animaciones de fumar"},
       {"no", "Animaciones de no"},
       {"si", "Animaciones de si"},
       {"gang", "Animaciones de gang"},
       {"llorar", "Animaciones de llorar"},
       {"pararse", "Animaciones de pararse"},
       {"escribir", "Animaciones de escribir"},
       {"saludar", "Animaciones de saludar"},
       {"nose", "Animaciones de nose"},
       {"quepaso", "Animaciones de quepaso"},
       {"rap", "Animaciones de rap"},
       {"rcp", "Animaciones de rcp"},
       {"apuntar", "Animaciones de apuntar"},
       {"facepalm", "Animaciones de facepalm"},
       {"rascar", "Animaciones de rascar"},
       {"buscar", "Animaciones de buscar"},
       {"alentar", "Animaciones de alentar"},
       {"taichi", "Animaciones de taichi"},
       {"mear", "Animaciones de mear"},
       {"paja", "Animaciones de paja"},
       {"asustado", "Animaciones de asustado"},
       {"queteden", "Animaciones de queteden"},
       {"caer", "Animaciones de caer"},
       {"estirar", "Animaciones de estirar"},
       {"trafico", "Animaciones de trafico"},
       {"patear", "Animaciones de patear"},
       {"reir", "Animaciones de reir"},
       {"dj", "Animaciones de dj"},
       {"rendirse", "Animaciones de rendirse"},
       {"strip", "Animaciones de strip"},
       {"tirarse", "Animaciones de tirarse"}
    }
}
local ayudaStaff = {
    ["ubicacion"] = {
        {"tppos", "Teletransportarse a una posición"},
        {"ls", "Teletransportarse a Los Santos"},
        {"sf", "Teletransportarse a San Fierro"},
        {"lv", "Teletransportarse a Las Venturas"},
        {"ir", "Teletransportarse a un jugador"},
        {"dios", "Modo Dios"},
        {"traer", "Traer a un jugador"},
        {"llevar", "Llevar a un jugador"},
        {"airbreak", "El nuevo superman"}
    },
    ["chat"] = {
        {"a", "Chat de administradores"},
        {"A", "Chat de administradores"},
        {"an", "Hacer un anuncio"},
        {"anuncio", "Hacer un anuncio"},
        {"spymp", "Espiar mensajes privados"}
    },
    ["soporte"] = {
        {"rreport", "Responder un reporte"},
        {"rreporte", "Responder un reporte"},
        {"rre", "Responder un reporte"},
        {"vreporte", "Ver reportes"},
        {"vre", "Ver reportes"},
        {"vreport", "Ver reportes"},
        {"vdudas", "Ver dudas"},
        {"rduda", "Responder una duda"},
        {"vanish", "Modo invisible"},
        {"invisible", "Modo invisible"},
        {"visible", "Modo visible"},
        {"revivir", "Revivir a un jugador"},
        {"revive", "Revivir a un jugador"},
        {"curar", "Curar a un jugador"},
        {"heal", "Curar a un jugador"},
        {"cambiarPass", "Cambiar contraseña de un jugador"},
        {"cambiarCuenta", "Cambiar cuenta de un jugador"},
        {"cambiarname", "Cambiar el nombre de un personaje"},
        {"cambiarnacionalidad", "Cambiar la nacionalidad de un Personaje"},
        {"cambiarsexo", "Cambiar el sexo de un Personaje"},
        {"matar", "Matar a un jugador"},
        {"verinventario", "Ver inventario del jugador"},
        {"verfrecuencia", "Ver frecuencias"}
    },
    ["sancion"] = {
        {"jail", "Enviar a la cárcel"},
        {"unjail", "Liberar de la cárcel"},
        {"echar", "Expulsar del servidor"},
        {"kick", "Expulsar del servidor"},
        {"expulsar", "Expulsar del servidor"},
        {"ban", "Banear a un jugador"},
        {"banear", "Banear a un jugador"},
        {"desban", "Desbanear a un jugador"},
        {"desbanear", "Desbanear a un jugador"},
        {"unban", "Desbanear a un jugador"},
        {"unbanear", "Desbanear a un jugador"}
    },
    ["vehiculo"] = {
        {"traerveh", "Traer un vehículo"}
    },
    ["trabajo"] = {
        {"setJob", "Asignar un trabajo"}
    }
}

-- Función para crear un blip en la ubicación actual del jugador
function crearBlipEnPosicion(source, command)
    local x, y, z = getElementPosition(source) -- Obtener la posición del jugador
    local rx, ry, rz = getElementRotation(source)
    local int = getElementInterior(source)
    local dim = getElementDimension(source)
    local blip = createBlip(x, y, z, 0) -- Crear un blip en esa posición (el tipo 0 es el blip por defecto)

    -- Ajustar el color y el tamaño del blip (opcional)
    setBlipSize(blip, 2)
    setBlipColor(blip, 255, 0, 0, 255) -- Rojo

    iprint(x, y, z, dim, int)
end
-- Registrar el comando /mark
addCommandHandler("mark", crearBlipEnPosicion)

--METODOS
    function onPlayerCommand(pCommand)
        local enabledCommand = enabledCommands[pCommand]

        if (pCommand == "me") then
            return false
        elseif enabledCommand then
            return false
        end

        cancelEvent()
    end
    addEventHandler("onPlayerCommand", root, onPlayerCommand)
    function formatNumber(n)
        -- Redondeando al entero más cercano:
        n = math.floor(n + 0.5)
    
        local formatted = tostring(n) -- Convertir a cadena para el formateo
        while true do  
            formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
            if (k==0) then
                break
            end
        end
        return formatted
    end
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

--COMANDOS
    function posicion(player)
        x, y, z = getElementPosition(player)
        RotX,RotY,RotZ = getElementRotation(player)
        Dim = getElementDimension(player)
        Int = getElementInterior(player)
        outputChatBox("#FF9000======[[ #F054FFInformacion de: "..getPlayerName(player).."#FF9000 ]]======", player, 0,0,0, true)
        outputChatBox("#FF7800[POSICION]: #ffffff".. x ..", ".. y ..", " .. z, player, 0,255,0, true)
        outputChatBox("#FF7800[ROTACION]: #ffffff".. RotX ..", ".. RotY ..", " .. RotZ, player, 0,255,0, true)
        outputChatBox("#FF7800[DIMENSION]: #ffffff".. Dim, player, 0, 255, 0, true)
        outputChatBox("#FF7800[INTERIOR]: #ffffff".. Int, player, 0, 255, 0, true)
        outputChatBox("#FF9000======[[ #F054FFInformacion de: "..getPlayerName(player).."#FF9000 ]]======", player, 0,0,0, true) 
    end
    addCommandHandler("pos", posicion)
    
    function WalkStyle(source, command, style)

        if not (style) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [estilo] \n#A03535Estilos :: Gordo, Sigilo,  Hombre,  Viejo, Gang1, Gang2, Borracho, Mujer, Sexy, Puta", source, 0, 0, 0, true)
        end

        if (style == "Gordo") or (style == "gordo") then
            return setPedWalkingStyle(source, 55)
        end
        if (style == "Sigilo") or (style == "sigilo") then
            return setPedWalkingStyle(source, 69)
        end
        if (style == "Hombre") or (style == "hombre") then
            return setPedWalkingStyle(source, 118)
        end
        if (style == "Viejo") or (style == "viejo") then
            return setPedWalkingStyle(source, 120)
        end
        if (style == "Gang1") or (style == "gang1") then
            return setPedWalkingStyle(source, 121)
        end
        if (style == "Gang2") or (style == "gang2") then
            return setPedWalkingStyle(source, 122)
        end
        if (style == "Borracho") or (style == "borracho") then
            return setPedWalkingStyle(source, 126)
        end
        if (style == "Mujer") or (style == "mujer") then
            return setPedWalkingStyle(source, 129)
        end
        if (style == "Sexy") or (style == "sexy") then
            return setPedWalkingStyle(source, 132)
        end
        if (style == "Puta") or (style == "puta") then
            return setPedWalkingStyle(source, 133)
        end
    end
    addCommandHandler("caminar", WalkStyle)


    function dni(source, command, objetive)
        local infoSource = exports['MR1_Inicio']:getValueOne(source)
        if not (infoSource["Informacion"]) then
            return
        end
        
        local str = getPlayerName(source)
        local e = str:find('_')
        local name, apellido = str:sub(1, e-1), str:sub(e+1)
        if not (objetive) then
            outputChatBox("#FF7800---------------------------", source, 255, 255, 255, true)
            outputChatBox("#FF7800Apellido: #24C5BE"..apellido, source, 255, 255, 255, true)
            outputChatBox("#FF7800Nombre: #24C5BE"..name, source, 255, 255, 255, true)
            outputChatBox("#FF7800Sexo: #24C5BE"..infoSource["Informacion"]["Sexo"].." #FF7800Nacionalidad: #24C5BE"..infoSource["Informacion"]["Nacionalidad"], source, 255, 255, 255, true)
            outputChatBox("#FF7800DNI: #24C5BE"..infoSource["Informacion"]["DNI"], source, 255, 255, 255, true)
            outputChatBox("#FF7800Edad: #24C5BE"..infoSource["Informacion"]["Edad"], source, 255, 255, 255, true)
            outputChatBox("#FF7800---------------------------", source, 255, 255, 255, true)
            return
        end

        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if not (objetivo) then
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end

        local posX1, posY1, posZ1 = getElementPosition(source)
        local posX2, posY2, posZ2 = getElementPosition(objetivo)

        if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) <= 5 then 
            for _, player in ipairs(getElementsByType("player")) do
                local posX3, posY3, posZ3 = getElementPosition(player)
                if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX3, posY3, posZ3) <= 7 then
                    outputChatBox("#F600FF"..getPlayerName(source).." saca su DNI y se lo entrega a "..getPlayerName(objetivo)..".", player, 246, 0, 255, true)
                end
            end
            outputChatBox("#9AA498[#FF7800Server#9AA498] #24C5BE"..getPlayerName(source).." #53B440te ha entregado su DNI", objetivo, 255, 255, 255, true) -- USER

            outputChatBox("#FF7800---------------------------", objetivo, 255, 255, 255, true)
            outputChatBox("#FF7800Apellido: #24C5BE"..apellido, objetivo, 255, 255, 255, true)
            outputChatBox("#FF7800Nombre: #24C5BE"..name, objetivo, 255, 255, 255, true)
            outputChatBox("#FF7800Sexo: #24C5BE"..infoSource["Informacion"]["Sexo"].." #FF7800Nacionalidad: #24C5BE"..infoSource["Informacion"]["Nacionalidad"], objetivo, 255, 255, 255, true)
            outputChatBox("#FF7800DNI: #24C5BE"..infoSource["Informacion"]["DNI"], objetivo, 255, 255, 255, true)
            outputChatBox("#FF7800Edad: #24C5BE"..infoSource["Informacion"]["Edad"], objetivo, 255, 255, 255, true)
            outputChatBox("#FF7800---------------------------", objetivo, 255, 255, 255, true)
        end
    end
    addCommandHandler("dni", dni)

    addCommandHandler("inventario", function(p, command)
        local DataPJ = exports["MR1_Inicio"]:getValueOne(p)
        local inv = DataPJ.Inventario
        outputChatBox("#FFFFFF        ====== #FF6F00Inventario de "..getPlayerName(p).."#FFFFFF======", p, 200, 200, 200, true)
        
        local cantidadFormateada = formatNumber(math.abs(math.floor(tonumber(inv.Dinero))))
        outputChatBox("#FF7800Dinero: #FFFFFF"..cantidadFormateada.."", p, 200, 200, 200, true)
        for i, Licencia in pairs(inv.Licencias) do
            outputChatBox("#FF7800"..i..": #FFFFFF x1", p, 200, 200, 200, true)
        end
        if inv.Items then
            for i, Cantidad in pairs(inv.Items) do
                outputChatBox("#FF7800"..i..": #FFFFFF x"..Cantidad.."", p, 200, 200, 200, true)
            end
        end
        local playerWeapons = (exports["weapon_system"]:getAllFromPed(p))
        if (playerWeapons) then
            for i, weapon in ipairs(playerWeapons) do
                local fullammo = weapon.ammo + weapon.clip

                if (weapon.id > 0) and (fullammo > 0) then
                    local municionformateada = formatNumber(math.abs(math.floor(tonumber(fullammo))))
                    outputChatBox("#FF7800"..getWeaponNameFromID(weapon.id)..": #FFFFFF"..municionformateada.." balas", p, 200, 200, 200, true)
                end
            end
        end
    end)

    addCommandHandler("cachear", function(p, command, objetive)
        if not objetive then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/cachear [Player]", p, 255, 255, 255, true)
        end
        objetivo = nil;
        if tonumber(objetive) then
            objetivo = exports["MR2_Cuentas"]:getPlayerFromID(objetive)
        elseif (isElement(getPlayerFromName(objetive))) then
            objetivo = getPlayerFromName(objetive)
        else
            return outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535El jugador no esta conectado.", source, 255, 255, 255, true)
        end
        if not isElement(objetivo) then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/cachear [Player]", p, 255, 255, 255, true)
        end
        local posX1, posY1, posZ1 = getElementPosition(p)
        local posX2, posY2, posZ2 = getElementPosition(objetivo)
        if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) <= 2 then 
            local DataPJ = exports["MR1_Inicio"]:getValueOne(objetivo)
            local cacheartrue = nil

            if DataPJ.Estado["Muerto"] == true then
                cacheartrue = true
            else
                if DataPJ.Rendirse == true then
                    cacheartrue = true
                else
                    cacheartrue = false
                end
            end
            if cacheartrue == false then
                return outputChatBox("#ffe100Debería tener las manos levantadas o estar muerto...", p, 255, 255, 255, true) 
            end
            local invObjetivo = exports['MR1_Inicio']:getValue(objetivo, "Inventario")
            local inv = DataPJ.Inventario
            outputChatBox("#FFFFFF        ====== #FF6F00Inventario de "..getPlayerName(objetivo).." #FFFFFF======", p, 200, 200, 200, true)
            
            local cantidadFormateada = formatNumber(math.abs(math.floor(tonumber(inv.Dinero))))
            outputChatBox("#FF7800Dinero: #FFFFFF"..cantidadFormateada.."", p, 200, 200, 200, true)
            for i, Licencia in pairs(inv.Licencias) do
                outputChatBox("#FF7800"..i..": #FFFFFF x1", p, 200, 200, 200, true)
            end
            local playerWeapons = (exports["weapon_system"]:getAllFromPed(objetivo))
            if (playerWeapons) then
                for i, weapon in ipairs(playerWeapons) do
                    local fullammo = weapon.ammo + weapon.clip

                    if (weapon.id > 0) and (fullammo > 0) then
                        local municionformateada = formatNumber(math.abs(math.floor(tonumber(fullammo))))
                        outputChatBox("#FF7800"..getWeaponNameFromID(weapon.id)..": #FFFFFF"..municionformateada.." balas", p, 200, 200, 200, true)
                    end
                end
            end
            for _, player in ipairs(getElementsByType("player")) do
                local posX3, posY3, posZ3 = getElementPosition(player)
                if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX3, posY3, posZ3) <= 7 then
                    outputChatBox("#F600FF"..getPlayerName(p).." palpa por todo el cuerpo a "..getPlayerName(objetivo).." en busca de objetos.", player, 246, 0, 255, true)
                end
            end


            outputChatBox("#9AA498[#FF7800Server#9AA498] #24C5BE"..getPlayerName(p).." #53B440te ha cacheado", objetivo, 255, 255, 255, true) -- USER
        end
    end)
    
    addCommandHandler("id", function(p, command, objetive)
        if not objetive then
            return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/id [Nombre]", p, 255, 255, 255, true)
        end
        local objetivo = getPlayerFromName(objetive)
        local id = exports["MR2_Cuentas"]:getIDTempFromPlayer(objetivo)
        if (id ~= nil) then
            outputChatBox("#FFFFFFID de "..objetive.." : "..id, p, 0, 0, 0, true)
        end
    end)

    function HelpMenu(source, command, option)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (varDataSource) or not (varDataSource.Estado) then
            cancelEvent()
            return
        end
        
        local cooldownTime = 1000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end

        if not option then
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFCategorías disponibles:", source, 0, 0, 0, true)
            for categoria, _ in pairs(ayudaComandos) do
                outputChatBox("#9AA498- #FFFFFF"..categoria, source, 255, 255, 255, true)
            end
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFUsa /"..command.." [categoría] para ver los comandos disponibles en cada categoría.", source, 0, 0, 0, true)
            return
        end
        
        if ayudaComandos[option] then
        outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFComandos de "..option..":", source, 0, 0, 0, true)
        local lineaComandos = ""
        local contador = 0
        for _, Comando in ipairs(ayudaComandos[option]) do
            -- Añadir cada comando a la línea
            lineaComandos = lineaComandos .. "/" .. Comando[1] .. ", "
            contador = contador + 1

            -- Cuando tengamos 7 comandos, mostramos la línea y reiniciamos
            if contador % 7 == 0 then
                outputChatBox("#9AA498" .. lineaComandos, source, 255, 255, 255, true)
                lineaComandos = ""  -- Reiniciar la cadena para la siguiente línea
            end
        end

        -- Mostrar los comandos restantes que no completaron una línea de 7
        if lineaComandos ~= "" then
            -- Eliminar la última coma y espacio sobrante
            lineaComandos = lineaComandos:sub(1, -3)
            outputChatBox("#9AA498" .. lineaComandos, source, 255, 255, 255, true)
        end
        else
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFCategoría no encontrada. Usa /"..command.." para ver las categorías disponibles.", source, 255, 255, 255, true)
        end
    end
    addCommandHandler("ayuda", HelpMenu)
    addCommandHandler("comandos", HelpMenu)

    function HelpMenuStaff(source, command, option)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (varDataSource) or not (varDataSource.Estado) then
            cancelEvent()
            return
        end
        if not (varDataSource.InfoCuenta["Rango"] >= 3) then -- COMPROBAMOS SI SU RANGO ES MENOR A 3.
            return --CANCELAMOS LA EJECUCION DEL COMANDO
        end
        local cooldownTime = 1000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end

        if not option then
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFCategorías disponibles:", source, 0, 0, 0, true)
            for categoria, _ in pairs(ayudaStaff) do
                outputChatBox("#9AA498- #FFFFFF"..categoria, source, 255, 255, 255, true)
            end
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFUsa /"..command.." [categoría] para ver los comandos disponibles en cada categoría.", source, 0, 0, 0, true)
            return
        end
        
        if ayudaStaff[option] then
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFComandos de "..option..":", source, 0, 0, 0, true)
            for _, Comando in ipairs(ayudaStaff[option]) do
                outputChatBox("#9AA498/"..Comando[1].." #FFFFFF- "..Comando[2], source, 255, 255, 255, true)
            end
        else
            outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFFCategoría no encontrada. Usa /"..command.." para ver las categorías disponibles.", source, 255, 255, 255, true)
        end
    end
    addCommandHandler("ayudastaff", HelpMenuStaff)
    addCommandHandler("comandosstaff", HelpMenuStaff)

    function OcultarHUD(source, command)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (varDataSource) or not (varDataSource.Estado) then
            cancelEvent()
            return
        end
        
        local cooldownTime = 1000 -- 5000 milisegundos = 5 segundos
        if isOnCooldown(source, command, cooldownTime) then
            outputChatBox("Debes esperar antes de volver a usar este comando.", source)
            return
        end
        --iprint(varDataSource.Ajustes["HUD"])

        if (varDataSource.Ajustes["HUD"] == false) then
            varDataSource.Ajustes["HUD"] = true
            setPlayerHudComponentVisible(source, "radar", true)
        else
            varDataSource.Ajustes["HUD"] = false
            setPlayerHudComponentVisible(source, "radar", false)
        end

        exports["MR1_Inicio"]:setValue(source, "Ajustes", varDataSource.Ajustes)
    end
    addCommandHandler("toghud", OcultarHUD)

    addEventHandler("onResourceStart", resourceRoot, function()
        local varPickupInfo = createPickup(1481.2490234375, -1739.759765625, 13.546875, 3, 1239, 0, 0)
    end) 
    function comoempezar(source, command)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not (varDataSource) or not (varDataSource.Estado) then
            cancelEvent()
            return
        end
        outputChatBox("Si no te carga copia este enlace desde el F8 https://www.youtube.com/watch?v=drpx0F4m768", source, 255, 255, 255)
        triggerClientEvent(source, "abrirVideoTutorial", source)
        
    end
    addCommandHandler("comoempezar", comoempezar)

    function tiempoJugado(source, command)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if not varDataSource then return end

        local tiempoJugadoTotal = varDataSource.Informacion["TiempoJugado"] or 0
        local tiempoInicioTimestamp = varDataSource.TiempoInicio
        local tiempoInicioMinutos = math.floor((getRealTime().timestamp - tiempoInicioTimestamp) / 60)

        local tiempoTotal = tiempoJugadoTotal + tiempoInicioMinutos

        local dias = math.floor(tiempoTotal / 1440) -- 1440 minutos en un día
        local horas = math.floor((tiempoTotal % 1440) / 60) -- Horas restantes
        local minutos = math.floor(tiempoTotal % 60) -- Minutos restantes

        -- Formatear el texto
        local diasTexto = dias > 0 and dias .. " día(s)" or ""
        local horasTexto = horas > 0 and horas .. " hora(s)" or ""
        local minutosTexto = minutos > 0 and minutos .. " minuto(s)" or ""

        -- Unir el texto adecuadamente
        local tiempoFormateado = table.concat({diasTexto, horasTexto, minutosTexto}, ", "):gsub(", $", "")

        outputChatBox("#9AA498[#FF7800Servidor#9AA498] #53B440Tiempo jugado: #FFFFFF" .. tiempoFormateado, source, 255, 255, 255, true)
    end
    addCommandHandler("tiempojugado", tiempoJugado)