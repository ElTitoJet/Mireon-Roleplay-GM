-- MR21_NPCIlegales
-- Gestiona el sistema de armas ilegales.
-- Autor: ElTitoJet
-- Fecha: 05/09/2024

-- Variables Globales y Configuración
    local screenW, screenH = guiGetScreenSize();
    local NPCsDatos = {}    
    local catalogos = {
        -- Catálogo de Traficante 1
        --[ID] = {"Nombre", Slot, ID, Precio, Municion},
        [1] = {
            {nombre = "Puño americano", Slot = 0,           ID = 1,             Precio = 1000, stock = math.random(20, 30)},
            {nombre = "Cuchillo",       Slot = 1,           ID = 4,             Precio = 3000, stock = math.random(20, 30)},
            {nombre = "Colt",           Slot = 2,           ID = 22,            Precio = 9000, stock = math.random(20, 30)},
            {nombre = "Desert",         Slot = 2,           ID = 23,            Precio = 10000, stock = math.random(20, 30)},
            {nombre = "Ganzúas",        Slot = "Custom",    ID = "Custom",      Precio = 4000, stock = math.random(20, 30)},
        },
        -- Catálogo de Traficante 2
        [2] = {
            {nombre = "Cuchillo",   Slot = 1,                   ID = 4,             Precio = 3000, stock = math.random(20, 30)},
            {nombre = "Tec-9",      Slot = 4,                   ID = 32,            Precio = 18000, stock = math.random(20, 30)},
            {nombre = "Uzi",        Slot = 4,                   ID = 28,            Precio = 20000, stock = math.random(20, 30)},
            {nombre = "Chaleco",    Slot = "Custom",            ID = "Custom",      Precio = 7000, stock = math.random(20, 30)},
            {nombre = "Ganzúas",    Slot = "Custom",            ID = "Custom",      Precio = 4000, stock = math.random(20, 30)},
        },
        -- Catálogo de Traficante 3
        [3] = { 
            {nombre = "Escopeta",           Slot = 3,                   ID = 25,        Precio = 15000, stock = math.random(20, 30)},
            {nombre = "Escopeta recortada", Slot = 3,                   ID = 26,        Precio = 12000, stock = math.random(20, 30)},
            {nombre = "Rifle de Caza",      Slot = 6,                   ID = 33,        Precio = 20000, stock = math.random(20, 30)},
            {nombre = "Chaleco",            Slot = "Custom",            ID = 4,         Precio = 7000, stock = math.random(20, 30)},
        },
        -- Catálogo de Traficante 4
        [4] = {
            {nombre = "Katana",     Slot = 1,                   ID = 8,             Precio = 5000, stock = math.random(20, 30)},
            {nombre = "Ak-47",      Slot = 5,                   ID = 30,            Precio = 42000, stock = math.random(20, 30)},
            {nombre = "Chaleco",    Slot = "Custom",            ID = "Custom",      Precio = 7000, stock = math.random(20, 30)},
        },
        -- Catálogo de Traficante 5
        [5] = {
            {nombre = "Escopeta",   Slot = 3,                   ID = 25,            Precio = 15000, stock = math.random(20, 30)},
            {nombre = "MP5",        Slot = 4,                   ID = 29,            Precio = 25000, stock = math.random(20, 30)},
            {nombre = "Sniper",     Slot = 6,                   ID = 34,            Precio = 55000, stock = math.random(20, 30)},
            {nombre = "Chaleco",    Slot = "Custom",            ID = "Custom",      Precio = 7000, stock = math.random(20, 30)},
        }
    }
    local TipoNPC = 0;
--PANELES
    NPCWeaponPannel = guiCreateWindow((screenW - 313) / 2, (screenH - 243) / 2, 313, 243, "Tienda de armas", false)
        guiWindowSetSizable(NPCWeaponPannel, false)
        guiSetVisible(NPCWeaponPannel, false)

        BuyButtom = guiCreateButton(10, 193, 122, 40, "Comprar", false, NPCWeaponPannel)
        guiSetProperty(BuyButtom, "NormalTextColour", "FFAAAAAA")
        ExitButtom = guiCreateButton(181, 193, 122, 40, "Salir", false, NPCWeaponPannel)
        guiSetProperty(ExitButtom, "NormalTextColour", "FFAAAAAA")
        GridList = guiCreateGridList(10, 29, 293, 154, false, NPCWeaponPannel)
        Arma = guiGridListAddColumn(GridList, "Arma", 0.7)
        Precio = guiGridListAddColumn(GridList, "Precio", 0.3)
-- Funciones Auxiliares

-- Funciones Principales
    function Text3DNPCs()
        for i, NPC in ipairs (NPCsDatos) do
            local x, y, z = NPC.x, NPC.y, NPC.z
            local x2, y2, z2 = getCameraMatrix()
            local distance = 8
            local height = 1
            local size = 2
            
            local text = "#9AA498[??#9AA498] #FFFFFF"..NPC.nombre..""
            if (isLineOfSightClear(x, y, z+2, x2, y2, z2)) then
                local sx, sy = getScreenFromWorldPosition(x, y, z+height)
                if(sx) and (sy) then
                    local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
                    if(distanceBetweenPoints < distance) then
                        dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center", false, false, false, true)
                    end
                end
            end
        end
    end
    function NPCWeaponShopOpen(Tipo)
        if not guiGetVisible(NPCWeaponPannel) then
            showCursor(true)
            guiSetVisible(NPCWeaponPannel, true)
            guiGridListClear(GridList)
            local catalogo = catalogos[Tipo]
            if catalogo then
                for i, arma in ipairs(catalogo) do
                    local fila = guiGridListAddRow(GridList)
                    guiGridListSetItemText(GridList, fila, Arma, arma.nombre, false, false)
                    guiGridListSetItemText(GridList, fila, Precio, arma.Precio, false, false) -- O muestra precio si lo añades
                end
                TipoNPC = Tipo
            else
                outputChatBox("No hay armas disponibles para este tipo de NPC.", 255, 0, 0)
            end
        end 
    end
-- Eventos y Handlers    
    addEvent("NPC::Ilegal::setNPCData", true)
    addEventHandler("NPC::Ilegal::setNPCData", root, function(datosNPCs)
        -- Guardar todos los datos de los NPCs recibidos (posiciones + nombres)
        for _, datos in ipairs(datosNPCs) do
            table.insert(NPCsDatos, {
                x = datos.posicion.x,
                y = datos.posicion.y,
                z = datos.posicion.z,
                nombre = datos.nombre
            })
        end
    end)
    addEventHandler("onClientRender", root, Text3DNPCs)
    addEvent( "NPC::Ilegal::WeaponPannel::Open", true)
    addEventHandler( "NPC::Ilegal::WeaponPannel::Open", getRootElement(), NPCWeaponShopOpen)
    addEventHandler( "onClientGUIClick", getRootElement(),
        function(b,s)
            if not (b == 'left' and s == 'up') then
                return
            end
            if source == BuyButtom then
                local WeaponName = guiGridListGetItemText ( GridList, guiGridListGetSelectedItem ( GridList ), 1 )
                local PrecioWeapon = tonumber(guiGridListGetItemText ( GridList, guiGridListGetSelectedItem ( GridList ), 2 ))
                if not (#WeaponName > 1) then
                    return outputChatBox ( "#9AA498[#FF7800AmmuNation#9AA498] #A03535Selecciona un arma.", 255, 255, 255, true )
                end
                Money = exports["MR1_Inicio"]:getValue(localPlayer, 'Inventario')
                if not (Money.Dinero >= PrecioWeapon) then
                    return outputChatBox("#ffe100No tengo los "..PrecioWeapon.." dolares del arma...", 255, 255, 255, true) 
                end
                triggerServerEvent('NPC::Ilegal::BuyWeapon', getLocalPlayer(), WeaponName, PrecioWeapon, TipoNPC)
            elseif source == ExitButtom then
                showCursor(false)
                guiSetVisible(NPCWeaponPannel, false)
            end
        end
    )
    addEventHandler("onClientPedDamage", getRootElement(), function()
        if getElementData(source, "inmortal") then
            cancelEvent()  -- Cancelar el daño si el NPC es inmortal
        end
    end)

-- Inicialización
    addEventHandler("onClientResourceStart", resourceRoot, function()
        triggerServerEvent("NPC::Ilegal::solicitarNPCs", resourceRoot) -- Pedir al servidor los datos de los NPC
    end)
