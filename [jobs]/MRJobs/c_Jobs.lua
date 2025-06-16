-- MRJobs
-- Script que gestiona la familia.
-- Autor: ElTitoJet
-- Fecha: 18/11/2024

-- Variables Globales y Configuración
    local screenW, screenH = guiGetScreenSize()
    local blips = {}
    local JobsInfoActual = nil
    -- PANELES
        -- LISTA DE TRABAJOS 1
        JobsPannel = guiCreateWindow((screenW - 447) / 2, (screenH - 436) / 2, 447, 436, "Lista de trabajos", false)
            guiSetVisible(JobsPannel, false)
            guiWindowSetSizable(JobsPannel, false)
            GridTrabajos = guiCreateGridList(10, 93, 426, 296, false, JobsPannel)
                ColumID = guiGridListAddColumn(GridTrabajos, "IDJob", 0.5)
                ColumNombre = guiGridListAddColumn(GridTrabajos, "Nombre", 0.5)
            ButtomClosePanel = guiCreateButton(207, 393, 32, 32, "x", false, JobsPannel)
                guiSetProperty(ButtomClosePanel, "NormalTextColour", "FFAAAAAA")
            ButtomJobTake = guiCreateButton(10, 393, 187, 32, "Tomar Trabajo", false, JobsPannel)
                guiSetProperty(ButtomJobTake, "NormalTextColour", "FFAAAAAA")
            ButtomJobTakeVIP = guiCreateButton(249, 393, 187, 32, "Tomar Trabajo V.I.P", false, JobsPannel)
                guiSetProperty(ButtomJobTakeVIP, "NormalTextColour", "FFAAAAAA")
            LabelInfo1 = guiCreateLabel(10, 24, 188, 59, "Trabajo: Ninguno\nRangos: N/A\nPagas: N/A", false, JobsPannel)
            LabelInfo2 = guiCreateLabel(248, 24, 188, 59, "Miembros: N/A", false, JobsPannel)    
-- Funciones Auxiliares
-- Funciones Principales
    function JobsListOpen()
        if not guiGetVisible(JobsPannel) then
            guiSetVisible(JobsPannel, true)
            --guiSetInputEnabled(true)
            showCursor(true)
        else
            guiSetVisible(JobsPannel, false)
            --guiSetInputEnabled(false)
            showCursor(false)
        end
    end
    function JobListUpdate(JobsInfo)
        guiGridListClear(GridTrabajos)
        JobsInfoActual = JobsInfo
        for i, row in ipairs(JobsInfo) do
            fila = guiGridListAddRow(GridTrabajos)
            guiGridListSetItemText(GridTrabajos, fila, ColumID, row.ID, false, false)
            guiGridListSetItemText(GridTrabajos, fila, ColumNombre, row.Nombre, false, false)
        end
    end
    function JobPannelInteract(b,s)
        if not (b == 'left' and s == 'up') then
            return
        end
        if source == ButtomClosePanel then
            guiSetVisible(JobsPannel, false)
            guiSetInputEnabled(false)
            showCursor(false)
        elseif source == GridTrabajos then
            local filaSeleccionada = guiGridListGetSelectedItem(GridTrabajos)
            if filaSeleccionada == -1 then
                guiSetText(LabelInfo1, "Trabajo: Ninguno\nRangos: N/A\nPagas: N/A")
                guiSetText(LabelInfo2, "Miembros: N/A")
                return
            end
            -- Obtener el ID y Nombre del trabajo seleccionado
            local jobID = guiGridListGetItemText(GridTrabajos, filaSeleccionada, ColumID)
            local jobNombre = guiGridListGetItemText(GridTrabajos, filaSeleccionada, ColumNombre)

            local jobInfo = nil
            for _, row in ipairs(JobsInfoActual) do
                if tostring(row.ID) == jobID then
                    jobInfo = row
                    break
                end
            end
    
            if not jobInfo then
                outputDebugString("Error: No se encontró información para el trabajo con ID " .. tostring(jobID))
                guiSetText(LabelInfo1, "Trabajo: " .. (jobNombre or "Ninguno") .. "\nRangos: N/A\nPagas: N/A")
                guiSetText(LabelInfo2, "Miembros: N/A")
                return
            end
            local totalRangos = jobInfo.TotalRangos or "N/A"
            local minPay = jobInfo.MinPaga or "N/A"
            local maxPay = jobInfo.MaxPaga or "N/A"
            local miembros = jobInfo.TotalMiembros or "N/A"

            -- Actualizar labels
            guiSetText(LabelInfo1, string.format("Trabajo: %s\nRangos: %s\nPagas: %s - %s", jobNombre, totalRangos, minPay, maxPay))
            guiSetText(LabelInfo2, string.format("Miembros: %s", miembros))

        elseif source == ButtomJobTake then
            local filaSeleccionada = guiGridListGetSelectedItem(GridTrabajos)
            if filaSeleccionada == -1 then
                outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Selecciona un trabajo.", 255, 255, 255, true )
                return
            end
            -- Obtener el ID y Nombre del trabajo seleccionado
            local jobID = guiGridListGetItemText(GridTrabajos, filaSeleccionada, ColumID)
            local jobNombre = guiGridListGetItemText(GridTrabajos, filaSeleccionada, ColumNombre)
            
            local varDataPlayer = exports["MR1_Inicio"]:getValueOne(localPlayer)
            local PlayerJob = varDataPlayer.Jobs or {}
            jobID = tonumber(jobID)
            if varDataPlayer and PlayerJob then
                if jobID ~= 1 then
                    if PlayerJob.Normal["IDJob"] == jobID or PlayerJob.VIP["IDJob"] == jobID then
                        outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Ya trabajas de "..jobNombre..".", 255, 255, 255, true )
                    else
                        triggerServerEvent('Jobs::JobList::AsignarJob', localPlayer, jobID, jobNombre)
                        outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Empezaste a trabajar de "..jobNombre, 255, 255, 255, true)
                        setblips(jobID)
                    end
                else
                    if PlayerJob.Normal["IDJob"] == jobID then
                        outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Ya trabajas de "..jobNombre..".", 255, 255, 255, true )
                    else
                        triggerServerEvent('Jobs::JobList::AsignarJob', localPlayer, jobID, jobNombre)
                        outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Empezaste a trabajar de "..jobNombre, 255, 255, 255, true)
                        setblips(jobID)
                    end
                end
            end

        end
    end
    function setblips(jobID)

        for i, blipData in ipairs(blips) do
            if isElement(blipData[1]) then
                destroyElement(blipData[1])
            end
        end
        blips = {} -- Limpiar la tabla de blips
        
        local jobInfo = nil
        for _, job in ipairs(JobsInfoActual) do
            if tonumber(job.ID) == tonumber(jobID) then
                jobInfo = job
                break
            end
        end
    
        if not jobInfo or not jobInfo.Ubicacion then
            outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535No se encontró la ubicación del trabajo.", 255, 255, 255, true)
            return
        end

        local ubicaciones = fromJSON(jobInfo.Ubicacion)
        if not ubicaciones or type(ubicaciones) ~= "table" then
            outputChatBox("#9AA498[#FF7800Server#9AA498] #A03535Error al leer la ubicación del trabajo.", 255, 255, 255, true)
            return
        end

        local x, y, z = ubicaciones.x, ubicaciones.y, ubicaciones.z
        local blip = createBlip(x, y, z, 56, 2, 255, 0, 0, 255, 1, 200)
        table.insert(blips, {blip, jobID})

        outputChatBox("#9AA498[#FF7800Server#9AA498] #53B440Blips del trabajo creados correctamente.", 255, 255, 255, true)
    end
    function setBlipJoin(x, y, z, tipo)

        for i, blip in ipairs(blips) do
            if isElement(blip[1]) then
                destroyElement(blip[1])
            end
        end
        
        blip = createBlip(x, y, z, 56, 2, 255, 0, 0, 255, 1, 200)
        table.insert(blips, {blip, tipo})
    
    end

-- Eventos y Handlers
    addEvent("Jobs::JobList::AbrirPanel", true)
    addEventHandler("Jobs::JobList::AbrirPanel", getLocalPlayer(), JobsListOpen)
    addEvent("Jobs::JobList::UpdatePannel", true)
    addEventHandler("Jobs::JobList::UpdatePannel", getLocalPlayer(), JobListUpdate)
    addEventHandler( "onClientGUIClick", getRootElement(), JobPannelInteract)
    addEvent("Jobs::Blips::Create", true)
    addEventHandler("Jobs::Blips::Create", getRootElement(), setBlipJoin)

    