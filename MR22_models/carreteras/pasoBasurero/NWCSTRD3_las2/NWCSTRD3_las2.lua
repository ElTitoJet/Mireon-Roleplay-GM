-- modelo 5125
local NWCSTRD3_las2dff = engineLoadDFF("carreteras/pasoBasurero/NWCSTRD3_las2/NWCSTRD3_las2.dff", 5125)
if NWCSTRD3_las2dff then
    --engineReplaceModel(NWCSTRD3_las2dff, modelo)
    outputDebugString("Modelo 3D cargado y reemplazado correctamente.")
else
    outputDebugString("Error al cargar el archivo .dff.", 2)
end


-- modelo 5125
local NWCSTRD3_las2col = engineLoadCOL("carreteras/pasoBasurero/NWCSTRD3_las2/NWCSTRD3_las2.col")
if NWCSTRD3_las2col then
    --engineReplaceCOL(NWCSTRD3_las2col, modelo)
    outputDebugString("Colisión cargada y reemplazada correctamente.")
else
    outputDebugString("Error al cargar el archivo .col.", 2)
end


-- modelo 5125
local NewTXD = engineLoadTXD("carreteras/pasoBasurero/NWCSTRD3_las2/freeway2_las2.txd")
if NewTXD then
    --engineImportTXD(NewTXD, modelo)  -- Importar y aplicar la textura al modelo
end
