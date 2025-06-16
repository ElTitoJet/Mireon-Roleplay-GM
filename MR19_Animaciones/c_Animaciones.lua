-- MR19_Animaciones
-- Gestiona las Animaciones
-- Autor: ElTitoJet
-- Fecha: 16/08/2024

-- Variables Globales y Configuración

-- Funciones Auxiliares

-- Funciones Principales
-- CLIENTE
function SincAnimation(group, animacion, time, loop, freeze)
    
    local loop = loop or false
    local freeze = freeze or false
    if animacion then
        setPedAnimation(localPlayer, group, animacion, time, loop, freeze, false)
    else
        setPedAnimation(localPlayer, false)
    end
end

addEvent("syncAnimacion", true)
addEventHandler("syncAnimacion", localPlayer, SincAnimation)  -- Solo afecta al jugador local


function aplicarAnimaciones(animaciones)
    for player, datosAnim in pairs(animaciones) do
        if isElement(player) then
            local group, animacion = unpack(datosAnim)
            if group and animacion then
                setPedAnimation(player, group, animacion, -1, true, false, false, false)
            else
                setPedAnimation(player, false)
            end
        end
    end
end

-- Evento para recibir la tabla desde el servidor
addEvent("syncAnimacionesTabla", true)
addEventHandler("syncAnimacionesTabla", root, aplicarAnimaciones)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.

local textosFlotantes = {}

addEvent("crearTextoFlotante", true)
addEventHandler("crearTextoFlotante", root, function(animacion)
    local ped = source
    textosFlotantes[ped] = animacion
end)

addEventHandler("onClientRender", root, function()
    for ped, animacion in pairs(textosFlotantes) do
        if isElement(ped) then
            local x, y, z = getElementPosition(ped)
            local screenX, screenY = getScreenFromWorldPosition(x, y, z + 1) -- Ajustar la altura del texto
            if screenX and screenY then
                dxDrawText(animacion, screenX, screenY, screenX, screenY, tocolor(255, 255, 255, 255), 1.5, "default-bold", "center", "center")
            end
        else
            textosFlotantes[ped] = nil -- Eliminar el texto si el ped ya no existe
        end
    end
end)

addEventHandler("onClientElementDestroy", root, function()
    if textosFlotantes[source] then
        textosFlotantes[source] = nil -- Eliminar el texto cuando el NPC es destruido
    end
end)

