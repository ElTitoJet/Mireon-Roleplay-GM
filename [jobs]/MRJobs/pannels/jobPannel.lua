
GUIEditor = {
    gridlist = {},
    window = {},
    button = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 447) / 2, (screenH - 436) / 2, 447, 436, "Lista de trabajos", false)
        guiWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.gridlist[1] = guiCreateGridList(10, 93, 426, 296, false, GUIEditor.window[1])
        guiGridListAddColumn(GUIEditor.gridlist[1], "IDJob", 0.5)
        guiGridListAddColumn(GUIEditor.gridlist[1], "Nombre", 0.5)
        ButtomClosePanel = guiCreateButton(207, 393, 32, 32, "x", false, GUIEditor.window[1])
        guiSetProperty(ButtomClosePanel, "NormalTextColour", "FFAAAAAA")
        GUIEditor.button[1] = guiCreateButton(10, 393, 187, 32, "Tomar Trabajo", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
        GUIEditor.button[2] = guiCreateButton(249, 393, 187, 32, "Tomar Trabajo V.I.P", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFAAAAAA")
        GUIEditor.label[1] = guiCreateLabel(10, 24, 188, 59, "Trabajo: JobName \nRangos: TotalRanks \nPagas: MinPay - MaxPay", false, GUIEditor.window[1])
        GUIEditor.label[2] = guiCreateLabel(248, 24, 188, 59, "Miembros: TotalMembers", false, GUIEditor.window[1])    
    end
)