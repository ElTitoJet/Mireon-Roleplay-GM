-- modelo 5106
local Roadsbx_las2dff = engineLoadDFF("carreteras/pasoBasurero/Roadsbx_las2/Roadsbx_las2.dff", 5106)
if Roadsbx_las2dff then
    --engineReplaceModel(Roadsbx_las2dff, 5106)
    outputDebugString("Modelo 3D cargado y reemplazado correctamente.")
else
    outputDebugString("Error al cargar el archivo .dff.", 2)
end


-- modelo 5106
local Roadsbx_las2col = engineLoadCOL("carreteras/pasoBasurero/Roadsbx_las2/Roadsbx_las2.col")
if Roadsbx_las2col then
    --engineReplaceCOL(Roadsbx_las2col, 5106)
    outputDebugString("Colisión cargada y reemplazada correctamente.")
else
    outputDebugString("Error al cargar el archivo .col.", 2)
end