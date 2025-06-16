-- MR2_Cuentas
-- Gestiona el sistema de registro y login de usuario
-- Autor: ElTitoJet
-- Fecha: 12/02/2024

-- Variables Globales y Configuración
-- Funciones Auxiliares
    local screenW, screenH = guiGetScreenSize(); 
    -- PANEL DE SPAWN
        SpawnPanel = guiCreateWindow((screenW - 117) / 2, (screenH - 133) / 2, 117, 133, "Bienvenido", false)
            guiSetVisible(SpawnPanel, false)
            guiWindowSetSizable(SpawnPanel, false)
            BotonReg = guiCreateButton(0.09, 0.23, 0.82, 0.27, "Registrarse", true, SpawnPanel)
                guiSetProperty(BotonReg, "NormalTextColour", "FFAAAAAA")
            BotonLog = guiCreateButton(0.09, 0.57, 0.82, 0.27, "Loguearse", true, SpawnPanel)
                guiSetProperty(BotonLog, "NormalTextColour", "FFAAAAAA")

    -- PANEL DE REGISTRO
        RegPanel = guiCreateWindow((screenW - 235) / 2, (screenH - 224) / 2, 235, 224, "REGISTRO", false)
            guiWindowSetSizable(RegPanel, false)
            guiSetVisible(RegPanel, false)
            
            NombreUser = guiCreateEdit(66, 32, 104, 30, "Usuario", false, RegPanel)
            PassUser = guiCreateEdit(66, 66, 104, 30, "Contraseña", false, RegPanel)
            RePassUser = guiCreateEdit(66, 100, 104, 30, "Contraseña", false, RegPanel)
            MailUser = guiCreateEdit(66, 135, 104, 30, "Email@gmail.com", false, RegPanel)
            BotonVolverReg = guiCreateButton(34, 175, 65, 30, "Volver", false, RegPanel)
                guiSetProperty(BotonVolverReg, "NormalTextColour", "FFAAAAAA")
            BotonRegReg = guiCreateButton(136, 175, 65, 30, "Registrarse", false, RegPanel)
                guiSetProperty(BotonRegReg, "NormalTextColour", "FFAAAAAA")

    -- PANEL DE LOGGIN
        LogPanel = guiCreateWindow((screenW - 112) / 2, (screenH - 150) / 2, 112, 150, "LOGIN", false)
            guiWindowSetSizable(LogPanel, false)
            guiSetVisible(LogPanel, false)

            NombreUserLog = guiCreateEdit(9, 26, 93, 23, "Usuario", false, LogPanel)
            PassUserLog = guiCreateEdit(9, 54, 93, 23, "Contraseña", false, LogPanel)
                guiEditSetMasked(PassUserLog, true)
            BotonVolverLog = guiCreateButton(9, 83, 93, 24, "Volver", false, LogPanel)
                guiSetProperty(BotonVolverLog, "NormalTextColour", "FFAAAAAA")
            BotonLogLog = guiCreateButton(10, 111, 93, 27, "Login", false, LogPanel)
                guiSetProperty(BotonLogLog, "NormalTextColour", "FFAAAAAA") 

-- Funciones Principales
    function ScriptCStart()
        clearChatBox()
        guiSetInputEnabled(true) -- Anula que podamos activar Binds o movernos.
        showCursor(true) -- Muestra el cursor en la pantalla.
        guiSetVisible(SpawnPanel, true)
    end
-- Eventos y Handlers

    addEventHandler("onClientResourceStart", resourceRoot, ScriptCStart)
    addEventHandler( "onClientGUIClick", getRootElement(),
        function(b,s)
            if not (b == 'left' and s == 'up') then
                return
            end
            --PANEL SPAWN
            if source == BotonReg then
                guiSetVisible(SpawnPanel, false)
                guiSetVisible(RegPanel, true)
            elseif source == BotonLog then
                guiSetVisible(SpawnPanel, false)
                guiSetVisible(LogPanel, true) 
            --PANEL REGISTRO
            elseif source == NombreUser then
                if (guiGetText(NombreUser) == "Usuario") then
                    guiSetText(NombreUser, "")
                end
            elseif source == PassUser then
                if (guiGetText(PassUser) == "Contraseña") then
                    guiSetText(PassUser, "")
                end
            elseif source == RePassUser then
                if (guiGetText(RePassUser) == "Contraseña") then
                    guiSetText(RePassUser, "")
                end
            elseif source == MailUser then
                if (guiGetText(MailUser) == "Email@gmail.com") then
                    guiSetText(MailUser, "")
                end
            elseif source == BotonVolverReg then
                guiSetText(NombreUser, "Usuario")
                guiSetText(PassUser, "Contraseña")
                guiSetText(RePassUser, "Contraseña")
                guiSetText(MailUser, "Email@gmail.com")
                guiSetVisible(RegPanel, false)
                guiSetVisible(SpawnPanel, true)
            elseif source == BotonRegReg then
                local varUserReg = guiGetText(NombreUser)
                local varPassUser = guiGetText(PassUser)
                local varRePassUser = guiGetText(RePassUser)
                local varMailUser = guiGetText(MailUser)
                if not (#varUserReg < 255) then
                    return outputChatBox ( "#9AA498[#FF7800REGISTRO#9AA498] #A03535El usuario no puede pasar de los 255 caracteres.", 255, 255, 255, true )
                end
                if (varUserReg == "Usuario") then
                    return outputChatBox ( "#9AA498[#FF7800REGISTRO#9AA498] #A03535Esta cuenta no puede ser registrada.", 255, 255, 255, true )
                end
                if not (varPassUser == varRePassUser) then
                    return outputChatBox ( "#9AA498[#FF7800REGISTRO#9AA498] #A03535Las contraseñas deben ser iguales.", 255, 255, 255, true )
                end
                if not (string.find(varMailUser, "@"))then
                    return outputChatBox ( "#9AA498[#FF7800REGISTRO#9AA498] #A03535Pon un correo valido.", 255, 255, 255, true )
                end

                clearChatBox()
                triggerServerEvent("UserRegister", getLocalPlayer(), varUserReg, varPassUser, varMailUser)
            --PANEL LOGIN
            elseif source == NombreUserLog then
                if (guiGetText(NombreUserLog) == "Usuario") then
                    guiSetText(NombreUserLog, "")
                end
            elseif source == PassUserLog then
                if (guiGetText(PassUserLog) == "Contraseña") then
                    guiSetText(PassUserLog, "")
                end
            elseif source == BotonVolverLog then
                guiSetText(NombreUserLog, "Usuario")
                guiSetText(PassUserLog, "Contraseña")
                guiSetVisible(LogPanel, false)
                guiSetVisible(SpawnPanel, true)
            elseif source == BotonLogLog then
                varUserLog = guiGetText(NombreUserLog)
                varPassLog = guiGetText(PassUserLog)

                if (varUserLog == "Usuario") then
                    return outputChatBox ( "#9AA498[#FF7800REGISTRO#9AA498] #A03535Esta cuenta no puede ser logeada.", 255, 255, 255, true )
                end
                clearChatBox()
                triggerServerEvent("UserLoggin", getLocalPlayer(), varUserLog, varPassLog)
            end
        end
    )
    addEvent("ExitRG", true)
    addEventHandler("ExitRG", getRootElement(), function()
        guiSetVisible(RegPanel, false)
    end)

    addEvent("ExitLG", true)
    addEventHandler("ExitLG", getRootElement(), function()
        guiSetVisible(LogPanel, false)
    end)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.