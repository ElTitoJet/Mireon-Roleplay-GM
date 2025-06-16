local screenW, screenH = guiGetScreenSize()
local tableJ = {}

function iniciarDibujado(ms)
    -- {Timer, Staff, MilisegundosJail, Razon}
    addEventHandler("onClientRender", this, dibujadoDXIC)
    if ms then
        timer = setTimer(function()

        end, ms, 1)
        tableJ[1] = timer
    end
end
addEvent("jailIC:initDX", true)
addEventHandler("jailIC:initDX", root, iniciarDibujado)


function detenerDibujadoIC()
    removeEventHandler("onClientRender", this, dibujadoDXIC)
end
addEvent("jailIC:exitDX", true)
addEventHandler("jailIC:exitDX", root, detenerDibujadoIC)


function dibujadoDXIC()
    table = exports["MR1_Inicio"]:getValue(getLocalPlayer(), 'JailIC')
    if table then
        if isTimer(tableJ[1]) then
            remaining = getTimerDetails(tableJ[1])
            seconds = remaining / 1000
            secondsRounded = math.floor(seconds)
            dxDrawText("Jail IC\nSegundos Restantes: "..secondsRounded.."", (screenW * 0.2959) - 1, (screenH * 0.2565) - 1, (screenW * 0.7139) - 1, (screenH * 0.4440) - 1, tocolor(0, 0, 0, 255), 3.00, "clear", "center", "center", false, false, false, false, false)
            dxDrawText("Jail IC\nSegundos Restantes: "..secondsRounded.."", (screenW * 0.2959) + 1, (screenH * 0.2565) - 1, (screenW * 0.7139) + 1, (screenH * 0.4440) - 1, tocolor(0, 0, 0, 255), 3.00, "clear", "center", "center", false, false, false, false, false)
            dxDrawText("Jail IC\nSegundos Restantes: "..secondsRounded.."", (screenW * 0.2959) - 1, (screenH * 0.2565) + 1, (screenW * 0.7139) - 1, (screenH * 0.4440) + 1, tocolor(0, 0, 0, 255), 3.00, "clear", "center", "center", false, false, false, false, false)
            dxDrawText("Jail IC\nSegundos Restantes: "..secondsRounded.."", (screenW * 0.2959) + 1, (screenH * 0.2565) + 1, (screenW * 0.7139) + 1, (screenH * 0.4440) + 1, tocolor(0, 0, 0, 255), 3.00, "clear", "center", "center", false, false, false, false, false)
            dxDrawText("Jail IC\nSegundos Restantes: "..secondsRounded.."", screenW * 0.2959, screenH * 0.2565, screenW * 0.7139, screenH * 0.4440, tocolor(255, 255, 255, 255), 3.00, "clear", "center", "center", false, false, false, false, false)
        end
    end
end