-- MRJobs5_EmpDa_Silva
-- Script que gestiona el Mecanico Willowfield
-- Autor: ElTitoJet
-- Fecha: 30/10/2023

-- Variables Globales y Configuración
local PICKUPS = {
    [1] = {119.4326171875, -198.3935546875, 1.8841308355331, "Servicio", "entrar/salir de servicio"},
    [2] = {120.9814453125, -191.4033203125, 1.8841308355331, "Vestuario", "cambiarte de ropa."},
    [3] = {2315.42578125, -1408.1943359375, 29.754472732544, "Servicio", "entrar/salir de servicio"},
    [4] = {2307.576171875, -1410.04296875, 29.754472732544, "Vestuario", "cambiarte de ropa."},
}

-- Funciones Auxiliares


-- Funciones Principales


-- Eventos y Handlers
addEventHandler("onClientRender", root, function()
    for i, v in ipairs (PICKUPS) do
        local x, y, z = v[1], v[2], v[3]
        local x2, y2, z2 = getCameraMatrix()
        local distance = 8
        local height = 1
        local size = 2
        local text = "#53B440["..v[4].."] #FFFFFF\n Presiona #24C5BEH #FFFFFFpara "..v[5]..""
        --if (isLineOfSightClear(x, y, z+2, x2, y2, z2)) then
            local sx, sy = getScreenFromWorldPosition(x, y, z+height)
            if(sx) and (sy) then
                local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
                if(distanceBetweenPoints < distance) then
                    dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "bankgothic", "center", "center", false, false, false, true)
                end
            end
        --end
    end
end)

-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
