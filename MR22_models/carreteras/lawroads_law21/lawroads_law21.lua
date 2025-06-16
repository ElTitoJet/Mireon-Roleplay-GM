-- carretera 6127
local lawroads_law21dff = engineLoadDFF("carreteras/lawroads_law21/lawroads_law21.dff", 6127)
if lawroads_law21dff then
    engineReplaceModel(lawroads_law21dff, 6127)
end

-- Finalmente, carga y reemplaza el archivo COL
local lawroads_law21col = engineLoadCOL("carreteras/lawroads_law21/lawroads_law21.col")
if lawroads_law21col then
    engineReplaceCOL(lawroads_law21col, 6127)
end