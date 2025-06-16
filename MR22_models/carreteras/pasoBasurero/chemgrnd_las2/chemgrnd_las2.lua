-- modelo 5192
local chemgrnd_las2dff = engineLoadDFF("carreteras/pasoBasurero/chemgrnd_las2/chemgrnd_las2.dff", 5192)
if chemgrnd_las2dff then
    --engineReplaceModel(chemgrnd_las2dff, 5192)
    outputDebugString("Modelo 3D cargado y reemplazado correctamente.")
else
    outputDebugString("Error al cargar el archivo .dff.", 2)
end


-- modelo 5192
local chemgrnd_las2col = engineLoadCOL("carreteras/pasoBasurero/chemgrnd_las2/chemgrnd_las2.col")
if chemgrnd_las2col then
    --engineReplaceCOL(chemgrnd_las2col, 5192)
    outputDebugString("Colisión cargada y reemplazada correctamente.")
else
    outputDebugString("Error al cargar el archivo .col.", 2)
end