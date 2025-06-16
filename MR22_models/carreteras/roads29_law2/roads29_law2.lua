-- carretera 6309
local roads29_law2dff = engineLoadDFF("carreteras/roads29_law2/roads29_law2.dff", 6309)
if roads29_law2dff then
    engineReplaceModel(roads29_law2dff, 6309)
end

-- Finalmente, carga y reemplaza el archivo COL
local roads29_law2col = engineLoadCOL("carreteras/roads29_law2/roads29_law2.col")
if roads29_law2col then
    engineReplaceCOL(roads29_law2col, 6309)
end