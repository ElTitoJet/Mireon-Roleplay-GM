local screenW, screenH = guiGetScreenSize()
local tableJ = {}

function iniciarDibujado(ms)
    -- {Timer, Staff, MilisegundosJail, Razon}
    addEventHandler("onClientRender", this, dibujadoDX)
    if ms then
        timer = setTimer(function()

        end, ms, 1)
        tableJ[1] = timer
    end
end
addEvent("jail:initDX", true)
addEventHandler("jail:initDX", root, iniciarDibujado)


function detenerDibujado()
    removeEventHandler("onClientRender", this, dibujadoDX)
end
addEvent("jail:exitDX", true)
addEventHandler("jail:exitDX", root, detenerDibujado)

function segundosAHMS(segundos)
    local horas = math.floor(segundos / 3600)
    local minutos = math.floor((segundos % 3600) / 60)
    segundos = segundos % 60
    return string.format("%02d:%02d:%02d", horas, minutos, segundos)
end


function dibujadoDX()
    table = exports["MR1_Inicio"]:getValue(getLocalPlayer(), 'JailOOC')
    
    if table and isTimer(tableJ[1]) then

        local remaining = getTimerDetails(tableJ[1])
        local seconds = remaining / 1000
        local secondsRounded = math.floor(seconds)
        local tiempoFormateado = segundosAHMS(math.floor(seconds))

        local texto = "Jail OOC\nStaff: "..table[2].."\nMotivo: "..table[4].."\nTiempo Restante: "..tiempoFormateado
        local font = "bankgothic"
        local scale = 1.00
        
        local textWidth = dxGetTextWidth(texto, scale, font)
        local textHeight = dxGetFontHeight(scale, font) * 4

        local posX = (screenW - textWidth) / 2
        local posY = (screenH - textHeight) / 2
        local margin = 10
        
        dxDrawRectangle(posX - margin, posY - margin, textWidth + 2 * margin, textHeight + 2 * margin, tocolor(0, 0, 0, 150))
        dxDrawText(texto, posX, posY, posX + textWidth, posY + textHeight, tocolor(255, 255, 255, 255), scale, font, "left", "top", false, false, false, false, false)
    end
end