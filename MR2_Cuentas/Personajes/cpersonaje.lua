-- MR2_Cuentas
-- Gestiona el sistema de personajes
-- Autor: ElTitoJet
-- Fecha: 12/02/2024

-- Variables Globales y Configuración
    local screenW, screenH = guiGetScreenSize();
    local components = { "crosshair", "radar"}
    -- PANEL DE SELECCION DE PJs
        SelecPersonaje = guiCreateWindow(0.35, 0.35, 0.29, 0.30, "Personajes", true)
            guiSetVisible(SelecPersonaje, false)
            guiWindowSetSizable(SelecPersonaje, false)
            JoinBotton = guiCreateButton(0.10, 0.78, 0.27, 0.16, "Entrar", true, SelecPersonaje)
                guiSetProperty(JoinBotton, "NormalTextColour", "FFAAAAAA")
            ExitBotton = guiCreateButton(0.64, 0.78, 0.27, 0.16, "Salir", true, SelecPersonaje)
                guiSetProperty(ExitBotton, "NormalTextColour", "FFAAAAAA")
            ListaPersonajes = guiCreateGridList(0.10, 0.16, 0.81, 0.56, true, SelecPersonaje)
            MisPersonajes = guiGridListAddColumn(ListaPersonajes, "Personajes", 0.9)
            CreateBotton = guiCreateButton(0.37, 0.78, 0.27, 0.16, "Crear", true, SelecPersonaje)
                guiSetProperty(CreateBotton, "NormalTextColour", "FFAAAAAA")

    -- PANEL DE CREACION DE PJs
        CrearPersonaje = guiCreateWindow((screenW - 186) / 2, (screenH - 217) / 2, 186, 217, "CREAR PERSONAJE", false)
            guiSetVisible(CrearPersonaje, false)
            guiWindowSetSizable(CrearPersonaje, false)
            BoxName = guiCreateEdit(10, 22, 164, 31, "Nombre_Apellido", false, CrearPersonaje)
            BoxNacion = guiCreateEdit(10, 63, 164, 31, "Nacionalidad", false, CrearPersonaje)
            BoxEdad = guiCreateEdit(10, 104, 164, 31, "Edad", false, CrearPersonaje)
            SelectHombre = guiCreateRadioButton(14, 143, 77, 15, "Masculino", false, CrearPersonaje)
            SelectMujer = guiCreateRadioButton(97, 143, 77, 15, "Femenino", false, CrearPersonaje)
                guiRadioButtonSetSelected(SelectMujer, true)
            BotonAtras = guiCreateButton(15, 172, 76, 28, "Volver", false, CrearPersonaje)
                guiSetProperty(BotonAtras, "NormalTextColour", "FFAAAAAA")
            CreateBottom = guiCreateButton(98, 172, 76, 28, "Crear", false, CrearPersonaje)
                guiSetProperty(CreateBottom, "NormalTextColour", "FFAAAAAA")

-- Funciones Auxiliares

-- Funciones Principales

-- Eventos y Handlers
    addEventHandler( "onClientGUIClick", getRootElement(),
        function(b,s)
            if not (b == 'left' and s == 'up') then
                return
            end
            --PANEL PERSONAJES
            if source == JoinBotton then
                local seleccionado = guiGridListGetItemText ( ListaPersonajes, guiGridListGetSelectedItem ( ListaPersonajes ), 1 )
                if not (#seleccionado > 3) then
                    return outputChatBox ( "#9AA498[#FF7800SELECCION#9AA498] #A03535Selecciona un personaje.", 255, 255, 255, true )
                end
                triggerServerEvent("SpawnPJ", getLocalPlayer(), seleccionado)

            elseif source == ExitBotton then
                triggerServerEvent("LogOut", getLocalPlayer())
                guiSetVisible(SelecPersonaje, false)
                ScriptCStart()
            elseif source == CreateBotton then
                guiSetVisible(SelecPersonaje, false)
                guiSetVisible(CrearPersonaje, true)
            --PANEL CREAR PJS
            elseif source == BoxName then
                if (guiGetText(BoxName) == "Nombre_Apellido") then
                    guiSetText(BoxName, "")
                end
            elseif source == BoxNacion then
                if (guiGetText(BoxNacion) == "Nacionalidad") then
                    guiSetText(BoxNacion, "")
                end
            elseif source == BoxEdad then
                if (guiGetText(BoxEdad) == "Edad") then
                    guiSetText(BoxEdad, "")
                end
            elseif source == BotonAtras then
                guiSetText(BoxName, "Nombre_Apellido")
                guiSetText(BoxNacion, "Nacionalidad")
                guiSetText(BoxEdad, "Edad")
                guiSetVisible(CrearPersonaje, false)
                guiSetVisible(SelecPersonaje, true)
            elseif source == CreateBottom then
                local varBoxName = guiGetText(BoxName)
                local varBoxNacion = guiGetText(BoxNacion)
                local varBoxEdad = guiGetText(BoxEdad)

                if not (#varBoxName > 3) then
                    return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535El nombre no puede ser menosr a 3 caracteres.", 255, 255, 255, true )
                end
                if not (#varBoxName < 22) then
                    return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535El nombre no puede pasar de los 20 caracteres.", 255, 255, 255, true )
                end
                if not (string.find(varBoxName, "_"))then
                    return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535El nombre y el apellido tienen que estar separados por un _ (Nombre_Apellido).", 255, 255, 255, true )
                end
                if not (string.match(varBoxName, "^[A-Za-z_]+$")) then
                    return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535El nombre y el apellido no deben tener caracteres especiales ni numeros.", 255, 255, 255, true )
                end
                if (string.find(varBoxName, " ")) then
                    newvarBoxName = string.gsub(varBoxName, " ", "")
                    guiSetText(BoxName, newvarBoxName)
                end
                if not (#varBoxNacion > 1) then
                    return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535Escribe una nacionalidad para tu PJ.", 255, 255, 255, true )
                end
                if not (tonumber(varBoxEdad)) then
                    return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535La edad del PJ, tiene que ser entre 18 años y 99 años.", 255, 255, 255, true )
                end 
                if not (tonumber(varBoxEdad) >= 18) then
                    return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535La edad del PJ, tiene que ser entre 18 años y 99 años.", 255, 255, 255, true )
                end 
                if not (tonumber(varBoxEdad) <= 99) then
                    return outputChatBox ( "#9AA498[#FF7800CREACION#9AA498] #A03535La edad del PJ, tiene que ser entre 18 años y 99 años.", 255, 255, 255, true )
                end
                if (guiRadioButtonGetSelected(SelectHombre)) then
                    clearChatBox()
                    triggerServerEvent("CrearPJs", getLocalPlayer(), varBoxName, varBoxNacion, varBoxEdad, "Masculino") 
                else
                    clearChatBox()
                    triggerServerEvent("CrearPJs", getLocalPlayer(), varBoxName, varBoxNacion, varBoxEdad, "Femenino")
                end
            end
        end
    )
    addEvent("SelectPJ", true)
    addEventHandler("SelectPJ", getLocalPlayer(), function()
        guiGridListClear(ListaPersonajes)
        guiSetVisible(SelecPersonaje, true)
    end)

    addEvent("MostrarPJ", true)
    addEventHandler("MostrarPJ", getLocalPlayer(), function(PJs)
        for i, v in ipairs(PJs) do
            guiGridListSetItemText(ListaPersonajes, guiGridListAddRow(ListaPersonajes), MisPersonajes, v.Nombre, false, false)
        end
    end)

    addEvent("PJCreado", true)
    addEventHandler("PJCreado", getLocalPlayer(), function()
        guiSetVisible(CrearPersonaje, false)
        guiGridListClear(ListaPersonajes)
        guiSetVisible(SelecPersonaje, true)
    end)
    addEvent("FinSpawn", true)
    addEventHandler("FinSpawn", getLocalPlayer(), function()
        guiSetInputEnabled(false)
        showCursor(false)
        setCameraTarget(getLocalPlayer())
        guiSetVisible(SelecPersonaje, false)
        clearChatBox()
        
            setDevelopmentMode(localPlayer, true) --ELIMINAR EN LA BETA
        
        for _, component in ipairs( components ) do
            setPlayerHudComponentVisible( component, true )
        end

        for i=0, 49, 1 do
            setGarageOpen(i, true)
        end
        setOcclusionsEnabled( false )   
        setAmbientSoundEnabled("gunfire", false)

        setFPSLimit(100)

        triggerServerEvent("SyncTimeICServer", resourceRoot)
    end)

    addEvent("SyncTimeICClient", true)
    addEventHandler("SyncTimeICClient", getLocalPlayer(), function(varTimeHour, varTimeMinute)
        setTime(varTimeHour, varTimeMinute)
        setMinuteDuration(7500)
    end)