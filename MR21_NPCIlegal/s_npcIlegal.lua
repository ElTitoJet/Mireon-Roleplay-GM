-- MR21_NPCIlegales
-- Gestiona el sistema de armas ilegales.
-- Autor: ElTitoJet
-- Fecha: 05/09/2024

-- Variables Globales y Configuración
    local NewPos = {
        [1] = {2555.29296875, -2176.9150390625, -0.21875, 0, 0, 270.11672973633, 0, 0},
        [2] = {2791.44921875, -1095.5888671875, 30.71875, 0, 0, 133.70288085938, 0, 0},
        [3] = {2550.291015625, -1332.416015625, 34.126243591309, 0, 0, 42.009613037109, 0, 0},
        [4] = {2455.8642578125, -1464.59765625, 24, 0, 0, 5.5069885253906, 0, 0},
        [5] = {2786.7890625, -1415.6220703125, 16.25, 0, 0, 247.62188720703, 0, 0},
        [6] = {2565.5595703125, -2203.3896484375, 13.546875, 0, 0, 2.4417419433594, 0, 0},
        [7] = {2744.8798828125, -2349.484375, 17.340341567993, 0, 0, 185.58114624023, 0, 0},
        [8] = {2726.037109375, -2551.77734375, 13.645210266113, 0, 0, 114.83911132812, 0, 0},
        [9] = {2198.294921875, -2552.505859375, 13.546875, 0, 0, 90.905029296875, 0, 0},
        [10] = {2541.6474609375, -2056.033203125, 13.549994468689, 0, 0, 93.239624023438, 0, 0},
        [11] = {2397.4052734375, -1208.34765625, 28.278001785278, 0, 0, 6.6275939941406, 0, 0},
        [12] = {2700.7431640625, -1106.490234375, 69.576217651367, 0, 0, 141.17919921875, 0, 0},
        [13] = {1802.90625, -1150.595703125, 23.828125, 0, 0, 310.78323364258, 0, 0},
        [14] = {1546.03515625, -1209.1484375, 17.434011459351, 0, 0, 156.64819335938, 0, 0},
        [15] = {1408.392578125, -1499.0048828125, 13.561126708984, 0, 0, 134.24670410156, 0, 0},
        [16] = {1164.025390625, -1648.8828125, 14, 0, 0, 309.89334106445, 0, 0},
        [17] = {995.5009765625, -1521.001953125, 13.551051139832, 0, 0, 146.33190917969, 0, 0},
        [18] = {1092.115234375, -1874.859375, 13.546875, 0, 0, 270.16616821289, 0, 0},
        [19] = {1544.4345703125, -2091.0712890625, 25.515625, 0, 0, 2.0187683105469, 0, 0},
        [20] = {857.9541015625, -1386.478515625, -0.5078125, 0, 0, 90.086517333984, 0, 0},
        [21] = {788.599609375, -1323.1904296875, -0.5078125, 0, 0, 187.98168945312, 0, 0},
        [22] = {572.6318359375, -1359.7001953125, 14.824834823608, 0, 0, 1.7001647949219, 0, 0},
        [23] = {308.77734375, -1338.1083984375, 14.482441902161, 0, 0, 9.9180603027344, 0, 0},
        [24] = {459.994140625, -1277.619140625, 15.413746833801, 0, 0, 34.731048583984, 0, 0},
        [25] = {308.7900390625, -1432.8134765625, 23.708889007568, 0, 0, 95.568786621094, 0, 0},
        [26] = {371.1962890625, -1879.716796875, 2.6137802600861, 0, 0, 183.79583740234, 0, 0},
        [27] = {354.8603515625, -2066.3203125, 7.8359375, 0, 0, 61.082153320312, 0, 0},
        [28] = {835.29296875, -1852.78125, 8.4109287261963, 0, 0, 185.1636505127, 0, 0},
        [29] = {1297.7919921875, -992.1513671875, 32.6953125, 0, 0, 63.098205566406, 0, 0},
        [30] = {771.345703125, -1084.4599609375, 24.0859375, 0, 0, 169.29364013672, 0, 0},
        [31] = {1028.7841796875, -1106.9658203125, 23.828125, 0, 0, 326.00503540039, 0, 0},
        [32] = {1201.5478515625, -975.7216796875, 43.4765625, 0, 0, 233.50422668457, 0, 0},
        [33] = {2058.5146484375, -1025.9267578125, 27.164413452148, 0, 0, 345.90707397461, 0, 0},
        [34] = {1973.1513671875, -1306.34375, 20.830989837646, 0, 0, 271.62188720703, 0, 0},
        [35] = {1964.3671875, -1249.755859375, 20.028604507446, 0, 0, 44.811187744141, 0, 0},
        [36] = {1511.4375, -1352.2470703125, 13.87699508667, 0, 0, 107.2529296875, 0, 0},
        [37] = {1425.9560546875, -1356.216796875, 13.57666015625, 0, 0, 358.23391723633, 0, 0},
        [38] = {1293.1669921875, -1210.8447265625, 13.6796875, 0, 0, 149.95745849609, 0, 0},
        [39] = {1031.392578125, -1430.9189453125, 13.546875, 0, 0, 142.45916748047, 0, 0},
        [40] = {2062.6650390625, -1787.2138671875, 13.546875, 0, 0, 0.65093994140625, 0, 0},
        [41] = {2380.392578125, -2257.1416015625, 6.0625, 0, 0, 134.80703735352, 0, 0},
        [42] = {1210.703125, -1877.0283203125, 13.552515029907, 0, 0, 136.41656494141, 0, 0},
        [43] = {1102.4638671875, -824.70703125, 86.9453125, 0, 0, 290.55709838867, 0, 0},
        [44] = {305.94140625, -36.0439453125, 1.6392669677734, 0, 0, 5.0840148925781, 0, 0},
        [45] = {-51.201171875, 58.1044921875, 3.1102695465088, 0, 0, 115.78393554688, 0, 0},
        [46] = {1273.767578125, 294.3271484375, 19.5546875, 0, 0, 255.88922119141, 0, 0},
        [47] = {2313.962890625, 56.078125, 26.480600357056, 0, 0, 272.56671142578, 0, 0}
    }

    local nombres = {
        "Diego", "Eduardo", "Joaquín", "Sebastián", "Mateo",
        "Daniel", "Samuel", "Tomás", "Martín", "Iván",
        "Lucas", "Nicolás", "Agustín", "Federico", "Oscar",
        "Santiago", "Raúl", "Rubén", "Víctor", "Pablo",
        "Simón", "Enrique", "Emilio", "Esteban", "Adrián",
        "Hugo", "Ismael", "Cristian", "Mario", "Gerardo",
        "Alberto", "Fernando", "Javier", "Rafael", "Francisco",
        "Ramón", "Andrés", "Ricardo", "Miguel", "Gabriel",
        "Felipe", "Alejandro", "Álvaro", "Manuel", "David",
        "Jorge", "Antonio", "Carlos", "Luis", "José"
    }
    local apellidos = {
        "Hernández", "Gómez", "Ruiz", "Pérez", "García",
        "Martínez", "López", "Rodríguez", "Sánchez", "Fernández",
        "Castro", "Torres", "Ramos", "Flores", "Mendoza",
        "Vargas", "Cruz", "Jiménez", "Morales", "Gutiérrez",
        "Salinas", "Vega", "Paredes", "Navarro", "Ríos",
        "Herrera", "Silva", "Molina", "Castillo", "Romero",
        "Rojas", "Ortega", "Reyes", "Domínguez", "Alonso",
        "Suárez", "Rivera", "Bermúdez", "Campos", "Aguirre",
        "Maldonado", "Ponce", "Mejía", "Cervantes", "Montoya",
        "Serrano", "Cortés", "Espinoza", "Quintana", "Zamora"
    }
    local catalogos = {
        -- Catálogo de Traficante 1
        --[ID] = {"Nombre", Slot, ID, Precio, Municion},

            {nombre = "Puño americano",     Slot = 0,                   ID = 1,             Precio = 1000,  Municion = 1},
            {nombre = "Cuchillo",           Slot = 1,                   ID = 4,             Precio = 3000,  Municion = 1},
            {nombre = "Colt",               Slot = 2,                   ID = 22,            Precio = 9000,  Municion = 17},
            {nombre = "Desert",             Slot = 2,                   ID = 23,            Precio = 10000, Municion = 7},
            {nombre = "Ganzúas",            Slot = "Custom",            ID = "Custom",      Precio = 4000,  Municion = 1},
            {nombre = "Tec-9",              Slot = 4,                   ID = 32,            Precio = 18000, Municion = 32},
            {nombre = "Uzi",                Slot = 4,                   ID = 28,            Precio = 20000, Municion = 28},
            {nombre = "Chaleco",            Slot = "Custom",            ID = "Custom",      Precio = 7000,  Municion = 1},
            {nombre = "Escopeta",           Slot = 3,                   ID = 25,            Precio = 15000, Municion = 1},
            {nombre = "Escopeta recortada", Slot = 3,                   ID = 26,            Precio = 12000, Municion = 2},
            {nombre = "Rifle de Caza",      Slot = 6,                   ID = 33,            Precio = 20000, Municion = 1},
            {nombre = "Katana",             Slot = 1,                   ID = 8,             Precio = 5000,  Municion = 1},
            {nombre = "Ak-47",              Slot = 5,                   ID = 30,            Precio = 42000, Municion = 30},
            {nombre = "MP5",                Slot = 4,                   ID = 29,            Precio = 25000, Municion = 30},
            {nombre = "Sniper",             Slot = 6,                   ID = 34,            Precio = 55000, Municion = 1},
    }
    local NPCsCreados = {}
    local colShapes = {}
-- Funciones Auxiliares
    function generarNombreAleatorio()
        local nombre = nombres[math.random(#nombres)]
        local apellido = apellidos[math.random(#apellidos)]
        return nombre .. " " .. apellido
    end
-- Funciones Principales
    function crearNPCs()
        local posicionesTomadas = {}
        local posicionesSeleccionadas = {}
        while #posicionesSeleccionadas < 5 do
            -- Escogemos un índice aleatorio de la tabla NewPos
            local indiceAleatorio = math.random(1, #NewPos)
    
            -- Verificamos que la posición no haya sido ya seleccionada
            if not posicionesTomadas[indiceAleatorio] then
                -- Marcamos la posición como tomada
                posicionesTomadas[indiceAleatorio] = true
                
                -- Añadimos la posición seleccionada a la tabla de posiciones seleccionadas
                table.insert(posicionesSeleccionadas, NewPos[indiceAleatorio])
            end
        end
        local skin;
        for i, pos in ipairs(posicionesSeleccionadas) do
            if i == 1 then
                skin = 67
            elseif i == 2 then
                skin = 72
            elseif i == 3 then
                skin = 32
            elseif i == 4 then
                skin = 112
            elseif i == 5 then
                skin = 265
            end
             iprint("Posición "..i..": ", table.concat(pos, ", "))

                local x, y, z, rx, ry, rz, int, dim = unpack(pos)
            -- Creamos el NPC con un modelo aleatorio (podemos definir un rango de modelos de NPC si es necesario)
                local npc = createPed(skin, x, y, z)  -- Modelo aleatorio del 1 al 5

            -- Establecemos la rotación, dimensión e interior
                setElementRotation(npc, rx, ry, rz)
                setElementDimension(npc, dim)
                setElementInterior(npc, int)
                setElementData(npc, "inmortal", true)
            -- Almacenamos los datos del NPC en la tabla NPCsCreados
                table.insert(NPCsCreados, {
                    nombre = generarNombreAleatorio(),  -- Asignamos un nombre aleatorio
                    tipo = i,  -- El tipo de NPC (1-5)
                    posicion = {x = x, y = y, z = z},  -- Coordenadas de la posición
                    rotacion = {rx = rx, ry = ry, rz = rz},  -- Rotación
                    dimension = dim,  -- Dimensión
                    interior = int,  -- Interior
                    Stock = 30,
                })
        end
       crearColShapes()
    end
    function crearColShapes()
        for _, npcData in ipairs(NPCsCreados) do
            local x, y, z = npcData.posicion.x, npcData.posicion.y, npcData.posicion.z
            -- Crear un ColShape esférico en la posición de cada NPC
                local col = createColSphere(x, y, z, 1)
                table.insert(colShapes, col)
    
            -- Vincular eventos para cuando el jugador entra y sale del ColShape
            addEventHandler("onColShapeHit", col, function(hitElement, matchingDimension)
                onPlayerEnterColShape(hitElement, matchingDimension, npcData)
            end)
            addEventHandler("onColShapeLeave", col, onPlayerLeaveColShape)
        end
    end
    function onPlayerEnterColShape(hitElement, matchingDimension, npcData)
        if getElementType(hitElement) == "player" and matchingDimension then
            -- Bindear la tecla H al jugador que entra en el ColShape
            bindKey(hitElement, "h", "down", onPlayerPressH, npcData)
            -- Informar al jugador que puede pulsar H
            outputChatBox("Presiona H para interactuar con el NPC.", hitElement, 255, 255, 255)
        end
    end
    function onPlayerLeaveColShape(leaveElement, matchingDimension)
        if getElementType(leaveElement) == "player" and matchingDimension then
            -- Desbindear la tecla H al jugador que sale del ColShape
            unbindKey(leaveElement, "h", "down", onPlayerPressH)
        end
    end
    function onPlayerPressH(player, key, state, npcData)
        if npcData.tipo then
            local varDataPlayer = exports["MR1_Inicio"]:getValueOne(player)
            if not varDataPlayer.Familia or varDataPlayer.Familia["Nombre"] == "Libre" then
                return
            end
            outputChatBox("Has interactuado con el NPC.", player, 0, 255, 0)
            triggerClientEvent(player, "NPC::Ilegal::WeaponPannel::Open", player, npcData.tipo)
        end
    end
    function BuyWeapon(WeaponName, Price, TipoNPC)
        --iprint(WeaponName, Price, TipoNPC)
        local DataPJ = exports["MR1_Inicio"]:getValueOne(client)
        local Inventario = DataPJ.Inventario
        --iprint(NPCsCreados)
        for i, Weapon in ipairs(catalogos) do
            --iprint(Weapon.nombre)
            if Weapon.nombre == WeaponName then
                --iprint(WeaponName, Price, TipoNPC)
                if not (Inventario.Dinero >= Weapon.Precio) then
                    return outputChatBox("#ffe100No tengo los "..Weapon.Precio.." dolares del arma...", 255, 255, 255, true) 
                end
                --Inventario.Dinero = Inventario.Dinero - Weapon.Precio
                --exports["MR1_Inicio"]:setValue(client, 'Inventario', Inventario)

                if (WeaponName == "Chaleco") then
                    setPedArmor( client, 100 )
                    outputChatBox("#ffe100Acabo de comprar un chaleco por "..Weapon.Precio.." $...", source, 255, 255, 255, true)
                elseif (WeaponName == "Ganzúas") then
                    if Inventario.Items["Ganzuas"] then
                        Inventario.Items["Ganzuas"] = Inventario.Items["Ganzuas"] + 1
                        exports["MR1_Inicio"]:setValue(client, 'Inventario', Inventario)
                    else
                        Inventario.Items["Ganzuas"] = 1
                        exports["MR1_Inicio"]:setValue(client, 'Inventario', Inventario)
                    end
                else
                    outputChatBox("#ffe100Acabo de comprar "..Weapon.Municion.." balas de "..getWeaponNameFromID(Weapon.ID).." por "..Weapon.Precio.." $...", source, 255, 255, 255, true)
                end
                exports["weapon_system"]:give(client, tonumber(Weapon.ID), Weapon.Municion, true)
                exports["MR15_Discord"]:sendDiscordArmasStaff("Dar", client, Weapon.Municion, Weapon.ID, "MR21_NPCIlegal")
                exports["MR6_Economia"]:restarDinero(client, Weapon.Precio, "MR21_NPCIlegal")
                break
            end
        end
    end
-- Eventos y Handlers
    addEvent("NPC::Ilegal::solicitarNPCs", true)
    addEventHandler("NPC::Ilegal::solicitarNPCs", root, function()
        -- Enviar toda la información de NPCs creados al cliente que lo solicite
        triggerClientEvent(client, "NPC::Ilegal::setNPCData", resourceRoot, NPCsCreados)
    end)
    
    addEvent("NPC::Ilegal::BuyWeapon", true)
    addEventHandler("NPC::Ilegal::BuyWeapon", getRootElement(), BuyWeapon)
-- Inicialización
    addEventHandler("onResourceStart", resourceRoot, crearNPCs)