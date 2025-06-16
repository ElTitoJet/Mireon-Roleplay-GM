-- MRJobs3_FaccLSES
-- Script que gestiona las funciones de la faccion de medicos del servidor.
-- Autor: ElTitoJet
-- Fecha: 30/10/2023

-- Variables Globales y Configuración
local PICKUPS = {
    [1] = {1172.490234375, -1321.486328125, 15.398905754089, "Emergencias", "ser atendido"},
    [2] = {1870.2041015625, -1740.7197265625, 1111.3000488281, "Servicio", "entrar/salir de servicio"},
    [3] = {1838.447265625, -1743.48828125, 1112.3000488281, "Vestuario", "para cambiarte de ropa."},
}
local varPickUpEmergencias = {1172.490234375, -1321.486328125, 15.398905754089, 3, 1240, 0, 0}
local varPickUpDuty = {1870.2041015625, -1740.7197265625, 1111.3000488281, 3, 1210, 0, 0}
local varPickUpVestuario = {1838.447265625, -1743.48828125, 1112.3000488281, 3, 1275, 0, 0}

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
        if (isLineOfSightClear(x, y, z+2, x2, y2, z2)) then
            local sx, sy = getScreenFromWorldPosition(x, y, z+height)
            if(sx) and (sy) then
                local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
                if(distanceBetweenPoints < distance) then
                    dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "bankgothic", "center", "center", false, false, false, true)
                end
            end
        end
    end
end)
addEvent("llamadoEmergencia:LSES", true)
addEventHandler("llamadoEmergencia:LSES", localPlayer, function(x, y, z)   
    local blip = createBlip(x, y, z, 59, 2, 255, 0, 0, 255, 0, 65535)
	setTimer ( function()
        destroyElement(blip)
	end, 60000, 1 )
end)

-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
