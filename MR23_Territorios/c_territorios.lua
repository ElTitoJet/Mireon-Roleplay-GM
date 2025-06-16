-- Definir las zonas con 4 cuadrados por zona
local Familias = {
    -- x, y, extenderEste, extenderNorte, R, G, B
    --["Ganton"] = {
    --    {2224, -1839, 200, 150, 155, 155, 155},
    --},
    ["GroveStreet"] = {
        {2228, -1690, 310, 100, 155, 155, 155},
        {2421, -1725, 116, 35, 155, 155, 155}
    },
    --["Seville"] = {
    --    {2620, -2042, 300, 150, 155, 155, 155}
    --},
    --["Willowfield"] = {
    --    {2406, -2058, 150, 200, 155, 155, 155}
    --},
    --["BarrioWillow"] = {
    --    {2204, -2003, 150, 150, 155, 155, 155}
    --},
    ["Corona"] = {
        {1658, -2156, 305, 150, 155, 155, 155},
        {1811, -2006, 150, 125, 155, 155, 155}
    },
    --["Las Flores"] = {
    --    {2559, -1453, 100, 270, 155, 155, 155 },
    --    {2659, -1390, 75, 207, 155, 155, 155 },
    --},
    --["Las colinas"] = {
    --    {1957, -1053, 122, 160, 155, 155, 155 },
    --    {2079, -1100, 188, 207, 155, 155, 155 },
    --    {2267, -1162, 600, 269, 155, 155, 155 },
    --    {2185, -1130, 82, 30, 155, 155, 155 },
    --},
    --["Jefferson"] = {
    --    {1980, -1471, 76, 120, 155, 155, 155 },
    --    {2056, -1475, 47, 255, 155, 155, 155 },
    --    {2103, -1551, 80, 331, 155, 155, 155 },
    --    {2183, -1550, 85, 420, 155, 155, 155 },
    --},
    --["GlenPark"] = {
    --    {1857, -1456, 125, 400, 155, 155, 155 },
    --    {1982, -1351, 75, 295, 155, 155, 155 },
    --    {2057, -1220, 125, 120, 155, 155, 155 },
    --},
    --["East Los Santos"] = {
    --    {2274, -1549, 280, 400, 155, 155, 155 }
    --},
    --["Idlewood"] = {
    --    {1827, -1882, 370, 325, 255, 0, 0 }
    --}
}--
local Mafias = {
    -- x, y, extenderEste, extenderNorte, R, G, B
    --["Temple"] = {
    --    {970, -1150, 420, 275, 155, 155, 155 }
    --},
    --["Marina"] = {
    --    {634, -1800, 290, 400, 155, 155, 155 }
    --},
    --["East Beach"] = {
    --    {2660, -1900, 300, 500, 155, 155, 155 },
    --    {2735, -1400, 220, 220, 155, 155, 155 }
    --},
    --["Rich man"] = {
    --    {70, -1550, 100, 550, 155, 155, 155 },
    --    {170, -1480, 50, 480, 155, 155, 155 },
    --    {220, -1427, 50, 425, 155, 155, 155 },
    --    {270, -1381, 100, 380, 155, 155, 155 },
    --    {370, -1312, 100, 630, 155, 155, 155 },
    --    {470, -1250, 200, 570, 155, 155, 155 },
    --    {670, -1100, 120, 200, 155, 155, 155 },
    --},
    --["Mulholland"] = {
    --    {670, -900, 300, 250, 155, 155, 155 },
    --    {970, -875, 700, 400, 255, 0, 0 },
    --}
}
-- Crear las áreas del radar por cada zona
for nombreZona, areaCoords in pairs(Familias) do
    nr, ng, nb = math.random(1,255), math.random(1,255), math.random(1,255)
    if nombreZona == "GroveStreet" then
        nr, ng, nb = 0, 84, 27
    elseif nombreZona == "Corona" then
        nr, ng, nb = 55, 138, 211
    end
    for _, areaData in ipairs(areaCoords) do
        local x, y, width, height, r, g, b = unpack(areaData)
        local area = createRadarArea(x, y, width, height, nr, ng, nb, 120)
        -- Si quieres que parpadeen puedes usar:
        -- setRadarAreaFlashing(area, true)
    end
    --outputChatBox("Zona marcada: " .. nombreZona)
end
for nombreZona, areaCoords in pairs(Mafias) do
    nr, ng, nb = math.random(1,255), math.random(1,255), math.random(1,255)
    for _, areaData in ipairs(areaCoords) do
        local x, y, width, height, r, g, b = unpack(areaData)
        local area = createRadarArea(x, y, width, height, nr, ng, nb, 120)
        -- Si quieres que parpadeen puedes usar:
        -- setRadarAreaFlashing(area, true)
    end
    --outputChatBox("Zona marcada: " .. nombreZona)
end