
local NewTXD = engineLoadTXD("modelo/wattspark1_LAe2/txd_wattspark1_LAe2.txd")
if NewTXD then
    engineImportTXD(NewTXD, 17563)  -- Importar y aplicar la textura al modelo
end


---- modelo 17563
local wattspark1_LAe2dff = engineLoadDFF("modelo/wattspark1_LAe2/wattspark1_LAe2.dff", 17563)
if wattspark1_LAe2dff then
    engineReplaceModel(wattspark1_LAe2dff, 17563)  -- Reemplazar el modelo
end


-- modelo 17563
local wattspark1_LAe2col = engineLoadCOL("modelo/wattspark1_LAe2/wattspark1_LAe2.col")
if wattspark1_LAe2col then
    engineReplaceCOL(wattspark1_LAe2col, 17563)  -- Reemplazar la colisión
end
