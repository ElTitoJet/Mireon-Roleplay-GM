-- modelo 5107
local chemplant2_las2dff = engineLoadDFF("carreteras/pasoBasurero/chemplant2_las2/chemplant2_las2.dff", 5107)
if chemplant2_las2dff then
    --engineReplaceModel(chemplant2_las2dff, 5107)
    outputDebugString("Modelo 3D cargado y reemplazado correctamente.")
else
    outputDebugString("Error al cargar el archivo .dff.", 2)
end