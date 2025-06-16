-- MRJobs5_EmpDa_Silva
-- Script que gestiona el Mecanico Willowfield
-- Autor: ElTitoJet
-- Fecha: 30/10/2023

-- Variables Globales y Configuración
    local screenW, screenH = guiGetScreenSize()

    FuncionesMecanicas = guiCreateWindow((screenW - 292) / 2, (screenH - 103) / 2, 292, 103, "¿Accion?", false)
        guiWindowSetSizable(FuncionesMecanicas, false)
        guiSetVisible(FuncionesMecanicas, false)
        MecaRepair = guiCreateButton(10, 31, 112, 47, "Reparar", false, FuncionesMecanicas)
            guiSetProperty(MecaRepair, "NormalTextColour", "FFAAAAAA")
        MecaTunning = guiCreateButton(170, 31, 112, 47, "Tunnear", false, FuncionesMecanicas)
            guiSetProperty(MecaTunning, "NormalTextColour", "FFAAAAAA")    


    FuncionTunning = guiCreateWindow((screenW - 347) / 2, (screenH - 397) / 2, 347, 397, "", false)
        guiWindowSetSizable(FuncionTunning, false)
        guiSetVisible(FuncionTunning, false)
        ListaPiezasTunning = guiCreateGridList(10, 28, 199, 351, false, FuncionTunning)
            ColumnaUpgradesName = guiGridListAddColumn(ListaPiezasTunning, "Pieza", 0.45)
            ColumnaUpgrades = guiGridListAddColumn(ListaPiezasTunning, "Modelo", 0.45)
        BotonColocar = guiCreateButton(219, 28, 116, 40, "Colocar", false, FuncionTunning)
            guiSetProperty(BotonColocar, "NormalTextColour", "FFAAAAAA")
        BotonQuitar = guiCreateButton(219, 78, 116, 40, "Quitar", false, FuncionTunning)
            guiSetProperty(BotonQuitar, "NormalTextColour", "FFAAAAAA")  
        BotonCerrar = guiCreateButton(219, 128, 116, 40, "Cerrar", false, FuncionTunning)
            guiSetProperty(BotonCerrar, "NormalTextColour", "FFAAAAAA")  

    PannelPintura = guiCreateWindow((screenW - 268) / 2, (screenH - 169) / 2, 268, 169, "PINTAR COCHE", false)
        guiWindowSetSizable(PannelPintura, false)
        guiSetVisible(PannelPintura, false)
        LabelPaintjob = guiCreateLabel(10, 28, 123, 79, "Paint Job \n0 para el primer paint\n1 para el segundo \n2 para el tercero \n3 para quitar el paint ", false, PannelPintura)
        EditPaint = guiCreateEdit(143, 28, 114, 29, " ", false, PannelPintura)
        BotonPaint = guiCreateButton(143, 74, 114, 33, "Colocar paint", false, PannelPintura)
        BotonColor = guiCreateButton(10, 117, 247, 35, "SELECCIONAR COLORES", false, PannelPintura)


-- Funciones Auxiliares
    function tableContains(table, value)
        for _, v in ipairs(table) do
            if v == value then
                return true
            end
        end
        return false
    end
    function ObtenerListaTunning()
        guiGridListClear(ListaPiezasTunning)
        local Vehicle = getPedOccupiedVehicle(localPlayer)
        local upgrades = getVehicleCompatibleUpgrades ( Vehicle )
        local MejorasInstaladas = getVehicleUpgrades ( Vehicle )

        for i, MejoraDisponible in ipairs ( upgrades ) do
            local fila = ListaPiezasTunning:addRow(getVehicleUpgradeSlotName ( MejoraDisponible ), ""..MejoraDisponible)
    
            --iprint(MejorasInstaladas)
            if tableContains(MejorasInstaladas, MejoraDisponible) then
                guiGridListSetItemColor(ListaPiezasTunning, fila, ColumnaUpgradesName, 255, 118, 0)
                guiGridListSetItemColor(ListaPiezasTunning, fila, ColumnaUpgrades, 255, 118, 0)
            end
        end
    end

-- Funciones Principales
    function PanelMecanico()
        guiSetVisible(FuncionesMecanicas, true)
        guiSetInputEnabled(true)
        showCursor(true)
    end
    function PanelPintura()
        guiSetText(EditPaint, getVehiclePaintjob( getPedOccupiedVehicle(localPlayer) ))
        guiSetVisible(PannelPintura, true)
        guiSetInputEnabled(true)
        showCursor(true)
    end
    function openColorPicker()
        editingVehicle = getPedOccupiedVehicle(localPlayer)
        if (editingVehicle) then
            local r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4 = getVehicleColor(editingVehicle, true)
            local r, g, b = 255, 255, 255
            if (guiCheckBoxGetSelected(checkColor1)) then
                r, g, b = r1, g1, b1
            end
            if (guiCheckBoxGetSelected(checkColor2)) then
                r, g, b = r2, g2, b2
            end
            if (guiCheckBoxGetSelected(checkColor3)) then
                r, g, b = r3, g3, b3
            end
            if (guiCheckBoxGetSelected(checkColor4)) then
                r, g, b = r4, g4, b4
            end
            if (guiCheckBoxGetSelected(checkColor5)) then
                r, g, b = getVehicleHeadLightColor(editingVehicle)
            end
            colorPicker.setValue({r, g, b})
            colorPicker.openSelect(colors)
        end
    end
    function closedColorPicker()
        editingVehicle = getPedOccupiedVehicle(localPlayer)
        if not editingVehicle then return end
        local r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4 = getVehicleColor(editingVehicle, true)
        --server.setVehicleColor(editingVehicle, r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4)
        triggerServerEvent("MecanicoAplicarColor", localPlayer, editingVehicle, r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4)
        
        local r, g, b = getVehicleHeadLightColor(editingVehicle)
        --server.setVehicleHeadLightColor(editingVehicle, r, g, b)
        triggerServerEvent("MecanicoAplicarLuces", localPlayer, editingVehicle, r, g, b)
    
        editingVehicle = nil
    end
    function updateColor()
        if (not colorPicker.isSelectOpen) then return end
        local r, g, b = colorPicker.updateTempColors()
        if (editingVehicle and isElement(editingVehicle)) then
            local r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4  = getVehicleColor(editingVehicle, true)
            if (guiCheckBoxGetSelected(checkColor1)) then
                r1, g1, b1 = r, g, b
            end
            if (guiCheckBoxGetSelected(checkColor2)) then
                r2, g2, b2 = r, g, b
            end
            if (guiCheckBoxGetSelected(checkColor3)) then
                r3, g3, b3 = r, g, b
            end
            if (guiCheckBoxGetSelected(checkColor4)) then
                r4, g4, b4 = r, g, b
            end
            if (guiCheckBoxGetSelected(checkColor5)) then
                setVehicleHeadLightColor(editingVehicle, r, g, b)
            end
            setVehicleColor(editingVehicle, r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4)
        end
    end
-- Eventos y Handlers
    addEventHandler( "onClientGUIClick", getRootElement(), function(b,s)
        if not (b == 'left' and s == 'up') then
            return
        end
        if source == MecaRepair then
            guiSetVisible(FuncionesMecanicas, false)
            guiSetInputEnabled(false)
            showCursor(false)
            triggerServerEvent("MecanicosReparar", localPlayer, localPlayer)
        elseif source == MecaTunning then
            guiSetVisible(FuncionesMecanicas, false)
            guiSetVisible(FuncionTunning, true)
            ObtenerListaTunning()
        elseif source == BotonCerrar then
            guiSetVisible(FuncionesMecanicas, false)
            guiSetVisible(FuncionTunning, false)
            guiSetInputEnabled(false)
            showCursor(false)
        elseif source == BotonColocar then
            local seleccionado = guiGridListGetItemText ( ListaPiezasTunning, guiGridListGetSelectedItem ( ListaPiezasTunning ), 2 )
            if not (#seleccionado > 2) then return end
            triggerServerEvent("MecanicoAplicarUpgrade", localPlayer, seleccionado)
            setTimer(function()
                ObtenerListaTunning()
            end, 200, 1)
        elseif source == BotonQuitar then
            local seleccionado = guiGridListGetItemText ( ListaPiezasTunning, guiGridListGetSelectedItem ( ListaPiezasTunning ), 2 )
            if not (#seleccionado > 2) then return end
            triggerServerEvent("MecanicoQuitarUpgrade", localPlayer, seleccionado)
            setTimer(function()
                ObtenerListaTunning()
            end, 200, 1)
        elseif source == BotonPaint then
            local paintjob = guiGetText(EditPaint)
            triggerServerEvent("MecanicoAplicarPaintJob", localPlayer, paintjob)
            guiSetInputEnabled(false)
            showCursor(false)
            guiSetVisible(PannelPintura, false)
        elseif source == BotonColor then
            openColorPicker()
        end
    end)
    addEvent("PanelMecanico", true)
    addEventHandler("PanelMecanico", root, PanelMecanico)
    addEvent("PanelPintura", true)
    addEventHandler("PanelPintura", root, PanelPintura)
    addEventHandler("onClientRender", root, updateColor)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.

addEventHandler("onClientResourceStart", localPlayer, function()
showCursor(false)
end)