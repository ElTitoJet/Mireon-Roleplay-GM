--[[
    AJUSTES PRINCIPALES
]]
local screenW, screenH = guiGetScreenSize()
local blips = {}

--[[
    PANELES
]]
PannelTrabajos = guiCreateWindow(244, 151, 331, 308, "Trabajos", false)
    guiWindowSetMovable(PannelTrabajos, false)
    guiWindowSetSizable(PannelTrabajos, false)
    guiSetVisible(PannelTrabajos, false)

    GridTrabajos = guiCreateGridList(11, 29, 310, 231, false, PannelTrabajos)
    colum = guiGridListAddColumn(GridTrabajos, "Trabajo", 1)

    BotonTrabajo = guiCreateButton(31, 270, 92, 28, "Obtener Trabajo 1", false, PannelTrabajos)
        guiSetProperty(BotonTrabajo, "NormalTextColour", "FFAAAAAA")
    --BotonVIP = guiCreateButton(189, 270, 106, 28, "...", false, PannelTrabajos)
    --guiSetProperty(BotonVIP, "NormalTextColour", "FFAAAAAA")
    BotonSalirPannelTrabajos = guiCreateButton(145, 270, 24, 28, "X", false, PannelTrabajos)
        guiSetProperty(BotonSalirPannelTrabajos, "NormalTextColour", "FFAAAAAA")

----------------------------------------------------------------------------------------------------------

JobPannel = guiCreateWindow((screenW - 689) / 2, (screenH - 446) / 2, 689, 446, "Panel Jobs", false)
    guiWindowSetMovable(JobPannel, false)
    guiWindowSetSizable(JobPannel, false)
    guiSetVisible(JobPannel, false)

    BotonAscender = guiCreateButton(10, 105, 120, 33, "Ascender", false, JobPannel)
        guiSetProperty(BotonAscender, "NormalTextColour", "FFAAAAAA")
    BotonDescender = guiCreateButton(10, 148, 120, 33, "Descender", false, JobPannel)
        guiSetProperty(BotonDescender, "NormalTextColour", "FFAAAAAA")
    BotonCerrarJobPannel = guiCreateButton(10, 403, 120, 33, "Cerrar Panel", false, JobPannel)
        guiSetProperty(BotonCerrarJobPannel, "NormalTextColour", "FFAAAAAA")
    BotonDespedir = guiCreateButton(10, 191, 120, 33, "Despedir", false, JobPannel)
        guiSetProperty(BotonDespedir, "NormalTextColour", "FFAAAAAA") 

    --labelInformacion = guiCreateLabel(140, 29, 539, 76, ""..Trabajos.Trabajo.."" , false, JobPannel)
    ListaTrabajadores = guiCreateGridList(140, 105, 539, 331, false, JobPannel)
    ColumnaTrabajador = guiGridListAddColumn(ListaTrabajadores, "Trabajador", 0.3)
    ColumnaRango = guiGridListAddColumn(ListaTrabajadores, "Rango", 0.3) 
    ColumnaConectado = guiGridListAddColumn(ListaTrabajadores, "Conectado", 0.3)

addEventHandler( "onClientGUIClick", getRootElement(),
    function(b,s)
        if not (b == 'left' and s == 'up') then
            return
        end
        
        if source == BotonSalirPannelTrabajos then
            guiSetVisible(PannelTrabajos, false)
            showCursor(false)
            guiSetInputEnabled(false)
        elseif source == BotonTrabajo then
            local seleccionado = guiGridListGetItemText ( GridTrabajos, guiGridListGetSelectedItem ( GridTrabajos ), 1 )
            Trabajos = exports["MR1_Inicio"]:getValue(getLocalPlayer(), 'Trabajos')
            if #seleccionado > 2 then
                if Trabajos.Trabajo == seleccionado then
                    outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Ya trabajas de "..seleccionado, 255, 255, 255, true)
                else
                    outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Empezaste a trabajar de "..seleccionado, 255, 255, 255, true)
                    triggerServerEvent('getBlips', getLocalPlayer(), seleccionado, 'Trabajo_Nombre')
                    triggerServerEvent('setWorkerDB', getLocalPlayer(), seleccionado)
                end
            end
        elseif source == BotonAscender then
            local seleccionado = guiGridListGetItemText ( ListaTrabajadores, guiGridListGetSelectedItem ( ListaTrabajadores ), 1 )
            if #seleccionado > 2 then
                triggerServerEvent("AscenderTrabajador", getLocalPlayer(), seleccionado)
            else
                outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Selecciona un personaje.", 255, 255, 255, true )
            end
        elseif source == BotonDescender then
            local seleccionado = guiGridListGetItemText ( ListaTrabajadores, guiGridListGetSelectedItem ( ListaTrabajadores ), 1 )
            if #seleccionado > 2 then
                triggerServerEvent("DescenderTrabajador", getLocalPlayer(), seleccionado)
            else
                outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Selecciona un personaje.", 255, 255, 255, true )
            end
        elseif source == BotonCerrarJobPannel then
            guiSetVisible(JobPannel, false)
            guiSetInputEnabled(false) -- Anula que podamos activar Binds o movernos.
            showCursor(false) -- Muestra el cursor en la pantalla.
        elseif source == BotonDespedir then
            local seleccionado = guiGridListGetItemText ( ListaTrabajadores, guiGridListGetSelectedItem ( ListaTrabajadores ), 1 )
            if #seleccionado > 2 then
                triggerServerEvent("DespedirTrabajador", getLocalPlayer(), seleccionado)
            else
                outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Selecciona un personaje.", 255, 255, 255, true )
            end
        end
    end
)


--[[
    FUNCIONES
]]
function paneltrabajos()
    guiSetVisible(PannelTrabajos, true)
    guiSetInputEnabled(true) -- Anula que podamos activar Binds o movernos.
    showCursor(true) -- Muestra el cursor en la pantalla.
    triggerServerEvent("getTrabajos", getLocalPlayer())
end
addEvent("PanelTrabajos", true)
addEventHandler("PanelTrabajos", getLocalPlayer(), paneltrabajos)

function ListaJobs2(result1)

    guiGridListClear(GridTrabajos)
    for i, row in ipairs(result1) do

        fila = guiGridListAddRow(GridTrabajos)
        guiGridListSetItemText(GridTrabajos, fila, colum, row.Nombre, false, false)

    end

end
addEvent("ListaJobs2", true)
addEventHandler("ListaJobs2", getLocalPlayer(), ListaJobs2)

function setblips(x, y, z, tipo)

    for i, blip in ipairs(blips) do
        if isElement(blip[1]) then
            destroyElement(blip[1])
        end
    end
    
    blip = createBlip(x, y, z, 56, 2, 255, 0, 0, 255, 1, 200)
    table.insert(blips, {blip, tipo})

end
addEvent("setBlips", true)
addEventHandler("setBlips", getRootElement(), setblips)

function TrabajoPannel()
    Trabajos = exports["MR1_Inicio"]:getValue(getLocalPlayer(), 'Trabajos')
    if Trabajos.Trabajo ~= "Desempleado" then
        guiSetVisible(JobPannel, true)
        guiSetInputEnabled(true) -- Anula que podamos activar Binds o movernos.
        showCursor(true) -- Muestra el cursor en la pantalla.
        guiSetText(JobPannel, " "..Trabajos.Trabajo.." ")
        triggerServerEvent("getWorkers", getLocalPlayer(), Trabajos.Trabajo)
    end
end
addCommandHandler ( "job", TrabajoPannel )
addEvent("TrabajoPannel", true)
addEventHandler("TrabajoPannel", getLocalPlayer(), TrabajoPannel)

function ListaWorkers2(combinedResults)
    guiGridListClear(ListaTrabajadores)
    for i, data in ipairs(combinedResults) do
        local NewWorker = guiGridListAddRow(ListaTrabajadores)
        guiGridListSetItemText(ListaTrabajadores, NewWorker, ColumnaRango, data.rank, false, false)
        guiGridListSetItemText(ListaTrabajadores, NewWorker, ColumnaTrabajador, data.CharacterName, false, false)
        guiGridListSetItemText(ListaTrabajadores, NewWorker, ColumnaConectado, data.PlayerConectado, false, false)
    end
end
addEvent("ListaWorkers2", true)
addEventHandler("ListaWorkers2", getLocalPlayer(), ListaWorkers2)


function CerrarPanelJob()
    guiSetVisible(JobPannel, false)
    TrabajoPannel()
end
addEvent("CerrarPanelJob", true)
addEventHandler("CerrarPanelJob", getRootElement(), CerrarPanelJob)