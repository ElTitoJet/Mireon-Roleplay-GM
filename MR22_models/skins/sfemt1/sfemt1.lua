-- Skin 275
local sfemt1txd = engineLoadTXD("skins/sfemt1/EMMSAfemale.txd")
if sfemt1txd then
    engineImportTXD(sfemt1txd, 275)
end

-- Carga y reemplaza el archivo DFF
local sfemt1dff = engineLoadDFF("skins/sfemt1/EMMSAfemale.dff", 275)
if sfemt1dff then
    engineReplaceModel(sfemt1dff, 275)
end