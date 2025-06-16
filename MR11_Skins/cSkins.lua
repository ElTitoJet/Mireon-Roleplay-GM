-- MR11_Skins
-- Gestiona el sistema de SKins
-- Autor: ElTitoJet
-- Fecha: 25/03/2024

-- Variables Globales y Configuración
    local tienda;
    local Informacion;
    local maxIndex;
    local index = 1;
    local cost = 20;
    local screenW, screenH = guiGetScreenSize()
    local skins = {
        ["SubUrban"] = {
            ["Masculino"] = {19, 28, 30, 47, 48, 66, 67, 102, 103, 104, 105, 106, 107, 108, 109, 110, 114, 115, 116, 173, 174, 175, 176, 177, 269, 270, 271, 292, 293, 300, 301},
            ["Femenino"] = {13, 190, 195, 207, 304},
        },
        ["Binco"] = {
            ["Masculino"] = {1002, 14, 15, 21, 23, 24, 25, 26, 27, 32, 34, 35, 36, 37, 44, 49, 58, 60, 72, 94, 95, 101, 112, 121, 122, 123, 124, 125, 229, 241, 242, 126, 127, 143, 144, 156, 170, 179, 184, 188, 206, 210, 217, 221, 222, 225, 234, 235, 236, 247, 248, 250, 254, 258, 259, 261, 262, 272, 290, 291, 297, 299, 302, 303, 306, 307, 308, 310, 312},
            ["Femenino"] = {1001, 38, 39, 56, 69, 88, 89, 93, 191, 192, 211, 226, 231, 232, 233, 298},
        },
        ["ProLabs"] = {
            ["Masculino"] = {18, 20, 22, 29, 45, 51, 52, 80, 81, 96, 97, 99, 180, 203, 204},
            ["Femenino"] = {41, 92, 193, 251},
        },
        ["Zip"] = {
            ["Masculino"] = {43, 46, 98, 153, 163, 164, 185, 186, 189, 223, 240, 249},
            ["Femenino"] = {31, 215, 224, 263},
        },
        ["Victim"] = {
            ["Masculino"] = {1, 2, 7, 62, 82, 83, 84, 100, 128, 132, 133, 134, 135, 136, 137, 142, 146, 154, 158, 159, 160, 161, 162, 168, 181, 182, 183, 200, 202, 209, 212, 213,220, 230, 239, 252, 264},
            ["Femenino"] = {53, 54, 63, 64, 75, 85, 87, 90, 92, 129, 130, 131, 138, 139, 140, 145, 151, 152, 157, 178, 196, 197, 198, 199, 201, 214, 218, 237, 238, 243, 244, 245, 246, 256, 257},
        },
        ["DidierShachs"] = {
            ["Masculino"] = {17, 57, 68, 78, 79, 111, 113, 117, 118, 120, 147, 165, 166, 171, 187, 227, 228, 294, 295, 296},
            ["Femenino"] = {9, 11, 12, 40, 55, 76, 77, 91, 141, 148, 150, 169, 172, 194, 216, 219},
        }
    }
    local VENTAS = {
        -- {x, y, z, int, dim, tienda}
        [1] = {207.7177734375, -103.8505859375, 1005.2578125, 15, 0, "Binco"},
        [2] = {203.869140625, -44.6904296875, 1001.8046875, 1, 0, "SubUrban"},
        [3] = {207.4150390625, -130.658203125, 1003.5078125, 3, 0, "ProLabs"},
        [4] = {161.4697265625, -85.244140625, 1001.8046875, 18, 0, "Zip"},
        [5] = {210.9, -9.3, 1001.2, 5, 0, "Victim"},
        [6] = {204.3388671875, -160.30078125, 1000.5234375, 14, 0, "DidierShachs"},
    }
    SkinSelectorPannel = guiCreateWindow((screenW - 191) / 2, (screenH - 110) / 2, 191, 110, "SkinSelector", false)
        guiWindowSetSizable(SkinSelectorPannel, false)
        guiSetVisible(SkinSelectorPannel, false)

        SkinID = guiCreateLabel(64, 39, 57, 15, "Skin: "..index.."", false, SkinSelectorPannel)
        SkinAnterior = guiCreateButton(10, 29, 44, 29, "<--", false, SkinSelectorPannel)
            guiSetProperty(SkinAnterior, "NormalTextColour", "FFAAAAAA")
        SiguienteSkin = guiCreateButton(131, 29, 44, 29, "-->", false, SkinSelectorPannel)
            guiSetProperty(SiguienteSkin, "NormalTextColour", "FFAAAAAA")
        BottonCerrar = guiCreateButton(10, 68, 64, 29, "Cerrar", false, SkinSelectorPannel)
            guiSetProperty(BottonCerrar, "NormalTextColour", "FFAAAAAA")
        BottonComprar = guiCreateButton(111, 68, 64, 29, "Comprar (20$)", false, SkinSelectorPannel)
            guiSetProperty(BottonComprar, "NormalTextColour", "FFAAAAAA")   

    local pickupsStreaming = {}
-- Funciones Auxiliares

-- Funciones Principales
    function elementStreamInOut()
        if getElementType(source) ~= "player" then
            if eventName:find("In") then
                if getElementType(source) == 'pickup' then
                    local x,y,z = getElementPosition(source)
                    for i, v in ipairs(VENTAS) do
                        if getDistanceBetweenPoints3D(x,y,z, unpack(v)) <= 5 then
                            pickupsStreaming[source] = exports["MR1_Inicio"]:createText3D("#FFFFFF\n Presiona #24C5BEH #FFFFFFpara abrir la tienda", x, y, z+1, 2, "bankgothic", -1, false, false, true)
                        end
                    end
                end
            else
                if isElement(pickupsStreaming[source]) then
                    destroyElement(pickupsStreaming[source])
                end
            end
        end

    end
-- Eventos y Handlers
    addEventHandler( "onClientGUIClick", getRootElement(), function(b,s)
        if not (b == 'left' and s == 'up') then
            return
        end
        if source == SkinAnterior then
            if index == 1 then
                local skin = skins[tienda][Informacion.Sexo][index]
                guiSetText(SkinID, "Skin: "..skin)
                setElementModel(localPlayer, skin)
                return
            end
            index = index - 1
            local skin = skins[tienda][Informacion.Sexo][index]
            guiSetText(SkinID, "Skin: "..skin)
            setElementModel(localPlayer, skin)
        elseif source == SiguienteSkin then
            if index == maxIndex then
                return
            end
            index = index + 1
            local skin = skins[tienda][Informacion.Sexo][index]
            guiSetText(SkinID, "Skin: "..skin)
            setElementModel(localPlayer, skin)
        elseif source == BottonCerrar then
            guiSetVisible(SkinSelectorPannel, false)
            showCursor(false)
            local Estado = exports["MR1_Inicio"]:getValue(localPlayer, 'Estado')
            setElementModel(localPlayer, Estado.Skin)
            index = 1
        elseif source == BottonComprar then
            local Inventario = exports["MR1_Inicio"]:getValue(localPlayer, 'Inventario')
            if not (Inventario.Dinero >= cost) then
                return outputChatBox("#ffe100No tengo los "..cost.." dolares de esta ropa...", 255, 255, 255, true) 
            end
            showCursor(false)
            guiSetVisible(SkinSelectorPannel, false)
            local skin = skins[tienda][Informacion.Sexo][index]
            triggerServerEvent("SetSkinServer", getLocalPlayer(), cost, skin)

            outputChatBox("#ffe100¡ESTOY DIVINA Y TODOS LOS SABEN! Aunque gaste 20$...", 255, 255, 255, true)
            index = 1
        end
    end)
    addEventHandler( "onClientElementStreamIn", getRootElement(), elementStreamInOut)
    addEventHandler( "onClientElementStreamOut", getRootElement(), elementStreamInOut)
    addEvent("Abrir_GUI_SkinSelector", true)
    addEventHandler("Abrir_GUI_SkinSelector", getLocalPlayer(), function(Tienda)
        if not guiGetVisible(SkinSelectorPannel) then
            showCursor(true)
            guiSetVisible(SkinSelectorPannel, true)
            tienda = Tienda;
            Informacion = exports["MR1_Inicio"]:getValue(localPlayer, 'Informacion')
            local count = 0;
            for i, s in ipairs(skins[tienda][Informacion.Sexo]) do
                count = count + 1
            end
            maxIndex = count
            guiSetText(SkinID, "Skin: "..getElementModel(localPlayer))
        end 
    end)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
