-- MR3_Muertes
-- Gestiona el sistema de muerte de los personajes
-- Autor: ElTitoJet
-- Fecha: 22/02/2024

-- Variables Globales y Configuración
    local screenW, screenH = guiGetScreenSize()
    local timerS;
    local AprobedSpawn = false
-- Funciones Auxiliares

-- Funciones Principales

-- Eventos y Handlers
addEvent("DeathClientUptade", true)
addEventHandler("DeathClientUptade", root, function()
	timerS = setTimer(function()
        AprobedSpawn = true
        outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Utiliza el comando #FFFFFF/reaparecer #53B440para aceptar tu muerte.", 200, 20, 20, true)
    end, 30000, 1)
    addCommandHandler('reaparecer', function(command)
        if not AprobedSpawn then
            return
        end
        local localPlayer = getLocalPlayer()
        local varEstado = exports["MR1_Inicio"]:getValue(localPlayer, 'Estado')
        if (varEstado == nil) or (varEstado.Muerto == false) then
            return
        end
        triggerServerEvent("ReviveOrder", localPlayer)
        AprobedSpawn = false
    end)
    removeEventHandler("onClientRender", this, function()
        if timerS and isTimer(timerS) then
            local segundos = getTimerDetails(timerS) / 1000
            dxDrawText("Espera "..math.floor(segundos).." segundos mas, para reaparecer.", (screenW * 0.3137) - 1, (screenH * 0.3917) - 1, (screenW * 0.6863) - 1, (screenH * 0.6100) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "top", false, false, false, false, false)
            dxDrawText("Espera "..math.floor(segundos).." segundos mas, para reaparecer.", (screenW * 0.3137) + 1, (screenH * 0.3917) - 1, (screenW * 0.6863) + 1, (screenH * 0.6100) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "top", false, false, false, false, false)
            dxDrawText("Espera "..math.floor(segundos).." segundos mas, para reaparecer.", (screenW * 0.3137) - 1, (screenH * 0.3917) + 1, (screenW * 0.6863) - 1, (screenH * 0.6100) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "top", false, false, false, false, false)
            dxDrawText("Espera "..math.floor(segundos).." segundos mas, para reaparecer.", (screenW * 0.3137) + 1, (screenH * 0.3917) + 1, (screenW * 0.6863) + 1, (screenH * 0.6100) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "top", false, false, false, false, false)
            dxDrawText("Espera "..math.floor(segundos).." segundos mas, para reaparecer.", screenW * 0.3137, screenH * 0.3917, screenW * 0.6863, screenH * 0.6100, tocolor(255, 255, 255, 255), 1.00, "pricedown", "left", "top", false, false, false, false, false)
        end
    end)
	addEventHandler("onClientRender", this, function()
        if timerS and isTimer(timerS) then
            local segundos = getTimerDetails(timerS) / 1000
            dxDrawText("Espera "..math.floor(segundos).." segundos mas, para reaparecer.", (screenW * 0.3137) - 1, (screenH * 0.3917) - 1, (screenW * 0.6863) - 1, (screenH * 0.6100) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "top", false, false, false, false, false)
            dxDrawText("Espera "..math.floor(segundos).." segundos mas, para reaparecer.", (screenW * 0.3137) + 1, (screenH * 0.3917) - 1, (screenW * 0.6863) + 1, (screenH * 0.6100) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "top", false, false, false, false, false)
            dxDrawText("Espera "..math.floor(segundos).." segundos mas, para reaparecer.", (screenW * 0.3137) - 1, (screenH * 0.3917) + 1, (screenW * 0.6863) - 1, (screenH * 0.6100) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "top", false, false, false, false, false)
            dxDrawText("Espera "..math.floor(segundos).." segundos mas, para reaparecer.", (screenW * 0.3137) + 1, (screenH * 0.3917) + 1, (screenW * 0.6863) + 1, (screenH * 0.6100) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "top", false, false, false, false, false)
            dxDrawText("Espera "..math.floor(segundos).." segundos mas, para reaparecer.", screenW * 0.3137, screenH * 0.3917, screenW * 0.6863, screenH * 0.6100, tocolor(255, 255, 255, 255), 1.00, "pricedown", "left", "top", false, false, false, false, false)
        end
    end)
end)

addEvent("RematarClient", true)
addEventHandler("RematarClient", root, function()
    if timerS and isTimer(timerS) then
        killTimer(timerS)
        timerS = nil
    end
    triggerServerEvent("ReviveOrder", localPlayer)
end)

addEvent("resucito",true)
addEventHandler("resucito", root, function()
    if timerS and isTimer(timerS) then
        killTimer(timerS)
        timerS = nil
    end
end)