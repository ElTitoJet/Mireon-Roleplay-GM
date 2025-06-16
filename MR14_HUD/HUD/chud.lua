-- MR14_HUD
-- Gestiona el HUD del servidor
-- Autor: ElTitoJet
-- Fecha: 25/03/2024

-- Variables Globales y Configuración
    local hudTable = { "ammo", "armour", "clock", "health", "money", "weapon", "wanted", "breath", "clock" }
    local sx,sy = guiGetScreenSize()
    local px,py = 1600,900
    local x,y =  (sx/px), (sy/py)	
    local clientFpsVar = 0
    local clientFpsStartTick = false
    local clientFpsCurrentTick = 0
    local FechaServer = "00/00/0000 00:00"
    local Est = 100
    local originalWalkingStyle = nil
    local isChatOpen = false
    local chatText = "[.]"
    local blips = {
        sur = nil,
        este = nil,
        oeste = nil
    }
    local desfaseUTC = 0
-- Funciones Auxiliares
    function convertNumber ( number )  
        local formatted = number  
        while true do      
            formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
            if ( k==0 ) then      
                break  
            end  
        end  
        return formatted
    end
    function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
        dxDrawText ( ""..text.."", x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
        dxDrawText ( ""..text.."", x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
        dxDrawText ( ""..text.."", x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
        dxDrawText ( ""..text.."", x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
        dxDrawText ( ""..text.."", x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
        dxDrawText ( ""..text.."", x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
        dxDrawText ( ""..text.."", x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
        dxDrawText ( ""..text.."", x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
        dxDrawText ( ""..text.."", x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
    end
    function getElementSpeed(element,unit)
        if not unit then unit = 0 end
        if isElement(element) then
            local x, y, z = getElementVelocity(element)
            if unit == "mph" or unit == 1 then
                return (x^2 + y^2 + z^2) ^ 0.5 * 100
            else
                return (x^2 + y^2 + z^2) ^ 0.5 * 1.8 * 100
            end
        else
            return false
        end
    end

    addEvent("RecibirTiempoServidor", true)
    addEventHandler("RecibirTiempoServidor", root, function(tiempoUTC)
        local tiempoCliente = getRealTime(nil, false)
        desfaseUTC = tiempoUTC.timestamp - tiempoCliente.timestamp  -- Calculamos el desfase de tiempo
        outputChatBox("Desfase de tiempo: "..desfaseUTC.." segundos")
    end)

    function ObtenerFechaHoraServidor()
        local tiempoCliente = getRealTime(nil, false)
        local tiempoServidor = tiempoCliente.timestamp + desfaseUTC  -- Ajustamos con el desfase
    
        local tiempoAjustado = getRealTime(tiempoServidor, false)  -- Convertimos el timestamp ajustado
    
        local fechaHoraString = string.format("%02d/%02d/%d %02d:%02d:%02d", 
            tiempoAjustado.monthday, tiempoAjustado.month + 1, tiempoAjustado.year + 1900, -- Fecha
            tiempoAjustado.hour, tiempoAjustado.minute, tiempoAjustado.second -- Hora
        )
        
        return fechaHoraString
    end
    function getFPS()
        if not (clientFpsStartTick) then
            clientFpsStartTick = getTickCount()
        end
        clientFpsVar = clientFpsVar + 1
        clientFpsCurrentTick = getTickCount()
        if ((clientFpsCurrentTick - clientFpsStartTick) >= 1000) then
            clientFps = clientFpsVar
            clientFpsVar = 0
            clientFpsStartTick = false
        end
        if (clientFps) then
            return clientFps
        else
            return 0
        end
    end
    function checkPlayerMovement()
        if isPedOnGround(localPlayer) and not isPedInVehicle(localPlayer) then
            if getControlState("sprint") then
                -- El jugador está corriendo
                if not originalWalkingStyle then
                    originalWalkingStyle = getPedWalkingStyle(localPlayer)
                    triggerServerEvent("onPlayerStartRunning", localPlayer, originalWalkingStyle)
                end
            else
                -- El jugador no está corriendo
                if originalWalkingStyle then
                    triggerServerEvent("onPlayerStopRunning", localPlayer, originalWalkingStyle)
                    originalWalkingStyle = nil
                end
            end
        end
    end
    function updateChatTextAnimation()
        if chatText == "[.]" then
            chatText = "[..]"
        elseif chatText == "[..]" then
            chatText = "[...]"
        else
            chatText = "[.]"  -- Reinicia la secuencia
        end
    end
-- Funciones Principales

    --createBlip(0, -5000, 4, 15) -- SUR
    --createBlip(5000, 0, 4, 13) -- Este
    --createBlip(-5000, 0, 4, 8) -- OESTE
    function HUD()
        --COMPROBACION HUD ACTIVO
            local Ajustes = exports["MR1_Inicio"]:getValue(localPlayer, "Ajustes")
            if not Ajustes or not Ajustes["HUD"] then
                return
            end
        -- OXIGENO
            local oxygen = math.floor (getPedOxygenLevel ( getLocalPlayer() )) -- 1000
            --if isElementInWater (getLocalPlayer()) then
                if getPedStat(getLocalPlayer(), 225) < 1000 then
                    dxDrawRectangle(x * 1228, y * 107, x * 195, y * 10, tocolor(0, 0, 0, 255), false) -- fondo preto
                    dxDrawRectangle(x * 1230, y * 109, x * 191, y * 6, tocolor(0, 75, 75, 255), false) -- fondo
                    local oxygenScale = (oxygen / 1000) * 191
                    dxDrawRectangle(x * 1230, y * 109, x * oxygenScale, y * 6, tocolor(0, 255, 255, 255), false)
                else
                    dxDrawRectangle(x * 1228, y * 107, x * 195, y * 10, tocolor(0, 0, 0, 255), false) -- fondo preto
                    dxDrawRectangle(x * 1230, y * 109, x * 191, y * 6, tocolor(0, 75, 75, 255), false) -- fondo
                    local oxygenScale = (oxygen / 1000) * 191
                    dxDrawRectangle(x * 1230, y * 109, x * oxygenScale, y * 6, tocolor(0, 255, 255, 255), false)
                end
            --end
        -- VIDA
            local health = math.floor (getElementHealth ( getLocalPlayer() )) + 0
            if getPedStat ( getLocalPlayer(), 24 ) < 570 then
                dxDrawRectangle(x*1228, y*83, x*195, y*10, tocolor(0, 0, 0, 255), false)--fundo preto
                dxDrawRectangle(x*1230, y*85, x*191, y*6, tocolor(75, 0, 0, 255), false)--fundo
                dxDrawRectangle(x*1230, y*85, x*191/100*health, y*6, tocolor(255, 0, 0, 255), false)
            else
                if getPedStat ( getLocalPlayer(), 24 ) < 745 then
                    dxDrawRectangle(x*1228, y*83, x*195, y*10, tocolor(0, 0, 0, 255), false)--fundo preto
                    dxDrawRectangle(x*1230, y*85, x*191, y*6, tocolor(75, 0, 0, 255), false)--fundo
                    dxDrawRectangle(x*1230, y*85, x*191/140*health, y*6, tocolor(255, 0, 0, 255), false)
                else
                    if getPedStat ( getLocalPlayer(), 24 ) < 832 then
                        dxDrawRectangle(x*1228, y*83, x*195, y*10, tocolor(0, 0, 0, 255), false)--fundo preto
                        dxDrawRectangle(x*1230, y*85, x*191, y*6, tocolor(75, 0, 0, 255), false)--fundo
                        dxDrawRectangle(x*1230, y*85, x*191/160*health, y*6, tocolor(255, 0, 0, 255), false)
                    else
                        if getPedStat ( getLocalPlayer(), 24 ) < 918 then
                            dxDrawRectangle(x*1228, y*83, x*195, y*10, tocolor(0, 0, 0, 255), false)--fundo preto
                            dxDrawRectangle(x*1230, y*85, x*191, y*6, tocolor(75, 0, 0, 255), false)--fundo
                            dxDrawRectangle(x*1230, y*85, x*191/180*health, y*6, tocolor(255, 0, 0, 255), false)
                        else
                            if getPedStat ( getLocalPlayer(), 24 ) < 959 then
                                dxDrawRectangle(x*1228, y*83, x*195, y*10, tocolor(0, 0, 0, 255), false)--fundo preto
                                dxDrawRectangle(x*1230, y*85, x*191, y*6, tocolor(75, 0, 0, 255), false)--fundo
                                dxDrawRectangle(x*1230, y*85, x*191/189*health, y*6, tocolor(255, 0, 0, 255), false)
                            else
                                dxDrawRectangle(x*1228, y*83, x*195, y*10, tocolor(0, 0, 0, 255), false)--fundo preto
                                dxDrawRectangle(x*1230, y*85, x*191, y*6, tocolor(75, 0, 0, 255), false)--fundo
                                dxDrawRectangle(x*1230, y*85, x*191/200*health, y*6, tocolor(255, 0, 0, 255), false)
                            end
                        end
                    end
                end
            end
        -- DINERO
            local Inv = exports["MR1_Inicio"]:getValue(localPlayer, "Inventario")
            money = convertNumber(Inv.Dinero)
            if Inv.Dinero < 0 then
                dxDrawBorderedText("$"..money.."",x*1355, y*050, x*1420, y*90,tocolor(155,70,70,255),1.0,"pricedown","right","top", false, false, false, true)
            else
                dxDrawBorderedText("$"..money.."",x*1355, y*050, x*1420, y*90,tocolor(70,155,70,255),1.0,"pricedown","right","top", false, false, false, true)
            end
        -- HORA
            local hour, mins = getTime ()
            local time = hour .. ":" .. (((mins < 10) and "0"..mins) or mins)
            if getTime (getLocalPlayer()) < 10 then
                dxDrawBorderedText("0"..time.."",x*1372, y*028, x*1358, y*40,tocolor(255,255,255,255),1.0,"pricedown","left","top",false, false, false, true)
            else
                dxDrawBorderedText(""..time.."",x*1372, y*028, x*1358, y*40,tocolor(255,255,255,255),1.0,"pricedown","left","top",false, false, false, true)
            end
        -- UBUCACION
            local clientX, clientY, clientz = getElementPosition(localPlayer)
            local zona = getZoneName(clientX, clientY, clientz)
                dxDrawBorderedText(""..zona.."",x*1228, y*133, x*195, y*20,tocolor(255, 255, 255, 255),0.9,"pricedown","left","top",false, false, false, true)
        -- CHALECO
            local armour = math.floor (getPedArmor ( getLocalPlayer() ))
            --if armour > 0 then
                if getPedStat ( getLocalPlayer(), 164 ) < 1000 then
                    dxDrawRectangle(x*1228, y*95, x*195, y*10, tocolor(0, 0, 0, 255), false)--fundo preto
                    dxDrawRectangle(x*1230, y*97, x*191, y*6, tocolor(75, 75, 75, 255), false) --fundo
                    dxDrawRectangle(x*1230, y*97, x*191/100*armour, y*6, tocolor(255, 255, 255, 255), false)	
                else
                    dxDrawRectangle(x*1228, y*95, x*195, y*10, tocolor(0, 0, 0, 255), false)--fundo preto
                    dxDrawRectangle(x*1230, y*97, x*191, y*6, tocolor(75, 75, 75, 255), false) --fundo
                    dxDrawRectangle(x*1230, y*97, x*191/200*armour, y*6, tocolor(255, 255, 255, 255), false)
                end
            --end
        -- ESTAMINA
                --iprint(Est)
                if Est > 0 then
                    dxDrawRectangle(x*1228, y*119, x*195, y*10, tocolor(0, 0, 0, 255), false)--fundo preto
                    dxDrawRectangle(x*1230, y*121, x*191, y*6, tocolor(75, 75, 0, 255), false) --fundo
                    dxDrawRectangle(x*1230, y*121, x*191/100*Est, y*6, tocolor(255, 255, 0, 255), false)	
                else
                    dxDrawRectangle(x*1228, y*119, x*195, y*10, tocolor(0, 0, 0, 255), false)--fundo preto
                    dxDrawRectangle(x*1230, y*121, x*191, y*6, tocolor(75, 75, 0, 255), false) --fundo
                    dxDrawRectangle(x*1230, y*121, x*191/100*Est, y*6, tocolor(255, 255, 0, 255), false)	
                end
                
            --iprint(getPedWalkingStyle(localPlayer).." / "..getElementSpeed(localPlayer))
            --end
        -- ARMAS
            weapon = getPedWeapon ( getLocalPlayer() )
            dxDrawImage(x*1440, y*020, x*120, y*120, "HUD/images/".. tostring( weapon ) ..".png")
            local slot, wep = exports["weapon_system"]:getFromPed(localPlayer)
            if slot > 0 and wep then
                local fullammo = wep.ammo + wep.clip
                if fullammo < 9999 then
                    if (wep.id == 0 or wep.id == 1 or wep.id == 2 or wep.id == 3 or wep.id == 4 or wep.id == 5 or wep.id == 6 or wep.id == 7 or wep.id == 8 or wep.id == 9 or wep.id == 10 or wep.id == 11 or wep.id == 12 or wep.id == 14 or wep.id == 15 or wep.id == 40 or wep.id == 44 or wep.id == 45 or wep.id == 46 or fullammo == 0) then 
                        moneyY = 0 
                        return 
                    end	
                    dxDrawRectangle(x*1450, y*133, x*100, y*20, tocolor(0, 0, 0, 155), false)
                    dxDrawText(""..fullammo.."", x*1454, y*245, x*1545, y*42, tocolor(0, 0, 0, 255), 1.3, "default-bold", "center", "center", false, false, false, false, false)
                    dxDrawText(""..fullammo.."", x*1454, y*245, x*1545, y*42, tocolor(0, 0, 0, 255), 1.3, "default-bold", "center", "center", false, false, false, false, false)
                    dxDrawText(""..fullammo.."", x*1454, y*245, x*1545, y*42, tocolor(0, 0, 0, 255), 1.3, "default-bold", "center", "center", false, false, false, false, false)
                    dxDrawText(""..fullammo.."", x*1454, y*245, x*1545, y*42, tocolor(0, 0, 0, 255), 1.3, "default-bold", "center", "center", false, false, false, false, false)
                    dxDrawText(""..fullammo.."", x*1454, y*245, x*1545, y*42, tocolor(255, 255, 255, 255), 1.3, "default-bold", "center", "center", false, false, false, false, true)
                else
                    dxDrawRectangle(x*1450, y*133, x*100, y*20, tocolor(0, 0, 0, 155), false)
                    dxDrawText(""..fullammo.."", x*1454, y*245, x*1545, y*42, tocolor(0, 0, 0, 255), 1.3, "default-bold", "center", "center", false, false, false, false, false)
                    dxDrawText(""..fullammo.."", x*1454, y*245, x*1545, y*42, tocolor(0, 0, 0, 255), 1.3, "default-bold", "center", "center", false, false, false, false, false)
                    dxDrawText(""..fullammo.."", x*1454, y*245, x*1545, y*42, tocolor(0, 0, 0, 255), 1.3, "default-bold", "center", "center", false, false, false, false, false)
                    dxDrawText(""..fullammo.."", x*1454, y*245, x*1545, y*42, tocolor(0, 0, 0, 255), 1.3, "default-bold", "center", "center", false, false, false, false, false)
                    dxDrawText(""..fullammo.."", x*1454, y*245, x*1545, y*42, tocolor(255, 255, 255, 255), 1.3, "default-bold", "center", "center", false, false, false, false, false)
                end
            end
        -- Puntos cardinales
            local playerX, playerY, playerZ = getElementPosition(localPlayer)

            -- Actualizar los blips en función de la posición del jugador
            setElementPosition(blips.sur, playerX, -5000, playerZ)
            setElementPosition(blips.este, 5000, playerY, playerZ)
            setElementPosition(blips.oeste, -5000, playerY, playerZ)
    end
    function HUDCabezas()
        local Ajustes = exports["MR1_Inicio"]:getValue(localPlayer, "Ajustes")
        if not Ajustes or not Ajustes["HUD"] then
            return
        end
        for i, v in ipairs(getElementsByType("player")) do
            if getPlayerFromName(getPlayerName(localPlayer)) ~= v then
                if getElementAlpha(v) > 0 then
                    local x2, y2, z2 = getElementPosition(v)
                    local x, y, z = getElementPosition(localPlayer)
                    local xc, yc, zc = getPedBonePosition(v, 8)
                    if getElementInterior(localPlayer) == getElementInterior(v) and getElementDimension(localPlayer) == getElementDimension(v) then
                        if x and y and z then
                            if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 18 then
                                if isLineOfSightClear(x, y, z, x2, y2, z2, true, false, false, true, false, false, false) then
                                    local sx, sy = getScreenFromWorldPosition(xc, yc, zc + 0.3)
                                    if sx and sy then
                                        dxDrawText("["..exports["MR1_Inicio"]:getValue(v, 'TempID').."] " ..getPlayerName(v), sx - 1, sy - 1, sx - 1, sy - 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                        dxDrawText("["..exports["MR1_Inicio"]:getValue(v, 'TempID').."] " ..getPlayerName(v), sx + 1, sy - 1, sx + 1, sy - 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                        dxDrawText("["..exports["MR1_Inicio"]:getValue(v, 'TempID').."] " ..getPlayerName(v), sx - 1, sy + 1, sx - 1, sy + 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                        dxDrawText("["..exports["MR1_Inicio"]:getValue(v, 'TempID').."] " ..getPlayerName(v), sx + 1, sy + 1, sx + 1, sy + 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                        dxDrawText("#9AA498["..exports["MR1_Inicio"]:getValue(v, 'TempID').."#9AA498] #FFFFFF" .. getPlayerName(v), sx, sy, sx, sy, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                        
                                        local Estado = exports["MR1_Inicio"]:getValue(v, "Estado")
                                        if Estado.Esposado then
                                            local syEsposado = sy - 40 -- Subir el texto "Esposado" 20 píxeles
                                            dxDrawText("Esposado", sx - 1, syEsposado - 1, sx - 1, syEsposado - 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                            dxDrawText("Esposado", sx + 1, syEsposado - 1, sx + 1, syEsposado - 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                            dxDrawText("Esposado", sx - 1, syEsposado + 1, sx - 1, syEsposado + 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                            dxDrawText("Esposado", sx + 1, syEsposado + 1, sx + 1, syEsposado + 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                            dxDrawText("Esposado", sx, syEsposado, sx, syEsposado, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                        end
                                        
                                        if Estado.Muerto then
                                            local syMuerto = sy - 40
                                            dxDrawText("Inconsciente", sx - 1, syMuerto - 1, sx - 1, syMuerto - 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                            dxDrawText("Inconsciente", sx + 1, syMuerto - 1, sx + 1, syMuerto - 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                            dxDrawText("Inconsciente", sx - 1, syMuerto + 1, sx - 1, syMuerto + 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                            dxDrawText("Inconsciente", sx + 1, syMuerto + 1, sx + 1, syMuerto + 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                            dxDrawText("Inconsciente", sx, syMuerto, sx, syMuerto, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    function HUDEsposadoMio()
        local Ajustes = exports["MR1_Inicio"]:getValue(localPlayer, "Ajustes")
        if not Ajustes or not Ajustes["HUD"] then
            return
        end
        for i, v in ipairs(getElementsByType("player")) do
            if getElementAlpha(v) > 100 then
                local x2, y2, z2 = getElementPosition(v)
                local x, y, z = getElementPosition(localPlayer)
                local xc, yc, zc = getPedBonePosition(v, 8)
                if x and y and z then
                    if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 6 then
                        if isLineOfSightClear(x, y, z, x2, y2, z2, true, false, false, true, false, false, false) then
                            local sx, sy = getScreenFromWorldPosition(xc, yc, zc + 0.3)
                            if sx and sy then
                                local Estado = exports["MR1_Inicio"]:getValue(v, "Estado")
                                if Estado.Esposado then
                                    local syEsposado = sy - 40 -- Subir el texto "Esposado" 20 píxeles
                                    dxDrawText("Esposado", sx - 1, syEsposado - 1, sx - 1, syEsposado - 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                    dxDrawText("Esposado", sx + 1, syEsposado - 1, sx + 1, syEsposado - 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                    dxDrawText("Esposado", sx - 1, syEsposado + 1, sx - 1, syEsposado + 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                    dxDrawText("Esposado", sx + 1, syEsposado + 1, sx + 1, syEsposado + 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                    dxDrawText("Esposado", sx, syEsposado, sx, syEsposado, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                end
                            end
                        end
                    end
                end
                
            end
        end
    end
    function HUDIzquierda()
        
        local Ajustes = exports["MR1_Inicio"]:getValue(localPlayer, "Ajustes")
        if not Ajustes or not Ajustes["HUD"] then
            return
        end
        local fechaHoraServidor  = ObtenerFechaHoraServidor()
        local fps = getFPS() or 0 -- Si getFPS() retorna nil, usar 0
        local ping = getPlayerPing(localPlayer) or 0 -- Si getPlayerPing() retorna nil, usar 0
        --local texto = ""..getPlayerName(localPlayer).." | "..fechaHora.." | "..getFPS().."fps | "..getPlayerPing(localPlayer).."ms "
        local texto = string.format("%s | %s UTC +0| %dfps | %dms", getPlayerName(localPlayer), fechaHoraServidor, fps, ping)

        if sx <= 1024 and sy <= 768 then
            dxDrawText(texto, (sx * 0.0146) + 1, (sy * 0.9557) + 1, (sx * 0.4502) + 1, (sy * 0.9870) + 1, tocolor(0, 0, 0, 255), 1.0, "default-bold", "left", "center", false, false, false, false, false)
            dxDrawText(texto, sx * 0.0146, sy * 0.9557, sx * 0.4502, sy * 0.9870, tocolor(192, 86, 13, 230), 1.0, "default-bold", "left", "center", false, false, false, false, false)
        else
            dxDrawText(texto, (sx * 0.0146) + 1, (sy * 0.9557) + 1, (sx * 0.4502) + 1, (sy * 0.9870) + 1, tocolor(0, 0, 0, 255), 1.5, "default-bold", "left", "center", false, false, false, false, false)
            dxDrawText(texto, sx * 0.0146, sy * 0.9557, sx * 0.4502, sy * 0.9870, tocolor(192, 86, 13, 230), 1.5, "default-bold", "left", "center", false, false, false, false, false)
        end
    end
    
    setTimer(updateChatTextAnimation, 500, 0)
    function HUDChat()
        
        local Ajustes = exports["MR1_Inicio"]:getValue(localPlayer, "Ajustes")
        if not Ajustes or not Ajustes["HUD"] then
            return
        end
        for i, v in ipairs(getElementsByType("player")) do
            if getElementData(v, "isChatOpen") == true then
                if getElementAlpha(v) >100 then
                    local x2, y2, z2 = getElementPosition(v)
                    local x, y, z = getElementPosition(localPlayer)
                    local xc, yc, zc = getPedBonePosition(v, 8)
                    if x and y and z then
                        if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 6 then
                            if isLineOfSightClear(x, y, z, x2, y2, z2, true, false, false, true, false, false, false) then
                                local sx, sy = getScreenFromWorldPosition(xc, yc, zc + 0.4)
                                if sx and sy then
                                    --dxDrawText(chatText, sx - 1, sy - 1, sx - 1, sy - 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                    --dxDrawText(chatText, sx + 1, sy - 1, sx + 1, sy - 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                    --dxDrawText(chatText, sx - 1, sy + 1, sx - 1, sy + 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                    --dxDrawText(chatText, sx + 1, sy + 1, sx + 1, sy + 1, tocolor(0, 0, 0, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                    dxDrawText(chatText, sx, sy, sx, sy, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, true, false)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    setTimer(checkPlayerMovement, 1000, 0)
-- Eventos y Handlers
    addEventHandler("onClientRender", getRootElement(), HUD)
    addEventHandler("onClientRender", getRootElement(), HUDCabezas)
    addEventHandler("onClientRender", getRootElement(), HUDEsposadoMio)
    addEventHandler("onClientRender", getRootElement(), HUDIzquierda)
    addEventHandler("onClientRender", getRootElement(), HUDChat)
    addEventHandler("onClientKey", root, function(button, press)
        if button == "t" and press and not isChatOpen then
            isChatOpen = true
            setTimer(function()
                if isChatOpen then
                    isChatOpen = false
                    setElementData(localPlayer, "isChatOpen", false)
                end
            end, 60000, 1)
            setElementData(localPlayer, "isChatOpen", true)
        elseif (button == "enter" or button == "escape") and isChatOpen then
            isChatOpen = false
            setElementData(localPlayer, "isChatOpen", false)
        end
    end)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
    addEventHandler("onClientResourceStart", resourceRoot, function()
        for id, hudComponents in ipairs(hudTable) do
            setPlayerHudComponentVisible(hudComponents, false)
        end
        --triggerServerEvent("TimeIRL::Pedir", resourceRoot, localPlayer)
            -- Puntos cardinales
                local playerX, playerY, playerZ = getElementPosition(localPlayer)

                -- Blips iniciales (Se crean en relación al jugador, pero se actualizarán)
                blips.sur = createBlip(playerX, playerY - 5000, playerZ, 15) -- SUR
                blips.este = createBlip(playerX + 5000, playerY, playerZ, 13) -- ESTE
                blips.oeste = createBlip(playerX - 5000, playerY, playerZ, 8) -- OESTE
            --ESTAMINA TIMER
                setTimer(function()
                    if Est then
                        
                        local status = getPedMoveState(localPlayer)

                        local speed = getElementSpeed(localPlayer)
                        -- NADANDO
                        if isElementInWater(localPlayer) then
                            if speed >= 15 then
                                Est = Est - 5
                            elseif speed < 15 then
                                Est = Est + 2
                            end
                        end
                        -- Saltando
                        if status == "jump" then
                            --iprint(status)
                            Est = Est - 10
                        end
                        -- CORRIENDO
                        if status == "sprint" then
                            --iprint(status)
                            Est = Est - 5
                        end
                        -- TROTANDO
                        if status == "jog" then
                            --iprint(status)
                            Est = Est + 1
                        end
                        -- CAMINANDO
                        if status == "walk" or status == "crawl" then
                            --iprint(status)
                            Est = Est + 2
                        end
                        -- Quieto
                        if status == "stand" or status == "crouch" then
                            --iprint(status)
                            Est = Est + 5
                        end
                        if isPedInVehicle(localPlayer) then
                            Est = Est + 5
                        end
                        Est = math.max(1, math.min(100, Est))
            
                        if Est <= 1 then
                            triggerServerEvent("Estamina:Cansado", resourceRoot, localPlayer)
                        end
                        if Est >=100 then
                            return
                        end
                    --[[

                        
                        if isPedOnGround(localPlayer) then
                            if speed >= 20 then
                                --outputChatBox("CORRIENDO")
                                Est = Est - 5
                            elseif speed < 20 then
                                --outputChatBox("CAMINANDO")
                                Est = Est + 2
                            end
                        end
                        

                        Est = math.max(1, math.min(100, Est))
            
                        if Est <= 1 then
                            triggerServerEvent("Estamina:Cansado", resourceRoot, localPlayer)
                        end
                        if Est >=100 then
                            return
                        end
                    ]]--
                        
                        
                    end
                end, 1000, 0)
    end)
    addEventHandler("onClientResourceStop", resourceRoot,function()
        for id, hudComponents in ipairs(hudTable) do
            showPlayerHudComponent(hudComponents, true)
        end
    end)



