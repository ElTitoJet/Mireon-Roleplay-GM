
local NewTXD = engineLoadTXD("modelo/LAn2_gm1/Parking_lan2_gm1.txd")
if NewTXD then
    engineImportTXD(NewTXD, 4601)  -- Importar y aplicar la textura al modelo
end


---- modelo 4601
local LAn2_gm1dff = engineLoadDFF("modelo/LAn2_gm1/LAn2_gm1.dff", 4601)
if LAn2_gm1dff then
    engineReplaceModel(LAn2_gm1dff, 4601)  -- Reemplazar el modelo
end


-- modelo 4601
local LAn2_gm1col = engineLoadCOL("modelo/LAn2_gm1/LAn2_gm1.col")
if LAn2_gm1col then
    engineReplaceCOL(LAn2_gm1col, 4601)  -- Reemplazar la colisión
end
