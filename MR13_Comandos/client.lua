
local availableCMD = {
    ['discord'] = true,
    ['clearchat'] = true,
    ['devmode'] = true,
    ['vision'] = true,
    ['reaparecer'] = true,
    ["superman"] = true,
    ["blur"] = true,
    ["limitfps"] = true,
    ["fpslimit"] = true,
    --["debug"] = true,
}
function onPreFunction( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, cmd )
    if not availableCMD[cmd] then
        return "skip"
    end
end
addDebugHook( "preFunction", onPreFunction, {"addCommandHandler"} )

addCommandHandler("clearchat", function(command, objetive)
    clearChatBox()
end)

addCommandHandler("vision", function(command, cantidad)
    setFarClipDistance( cantidad )
end)

addCommandHandler("blur", function(command)
    setPlayerBlurLevel(0)
    outputChatBox("#FFFFFF"..command.." a 0", 0, 0, 0, true)
end)

addCommandHandler("discord", function(command, objetive)
    outputChatBox("https://discord.gg/dvUHAxX22b")
end)



function enableDebug()
	local state = not isDebugViewActive()
	setDebugViewActive(state)
    if state then
        outputChatBox("DEBUG MODE: TRUE")
    else
        
        outputChatBox("DEBUG MODE: FALSE")
    end
end
addCommandHandler("debug", enableDebug)

addCommandHandler("devmode", function()
    iprint(1)
    setDevelopmentMode(true)

    showCol (not isShowCollisionsEnabled())
    outputChatBox("DEVMODE")
end)
function fpsFunction(command, cantidad)
    local minFPS = 25
    local maxFPS = 100
    local newFPS = tonumber(cantidad)
    if cantidad == nil then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [FPS] (Minimo 25, Maximo 100)", 0, 0, 0, true)
    end
    if (newFPS < minFPS) or (newFPS > maxFPS) then
        return outputChatBox("#9AA498[#A03535Syntaxis#9AA498] #FFFFFF/"..command.." [FPS] (Minimo 25, Maximo 100)", 0, 0, 0, true)
    end
    outputChatBox("Limite de FPS: "..newFPS..".")
    setFPSLimit(newFPS)
end
addCommandHandler("limitfps", fpsFunction)
addCommandHandler("fpslimit", fpsFunction)


local infopoints = {
    --[] = {x, y, z, int}
    [1] = {1481.2490234375, -1739.759765625, 13.546875},
}
local pickupsStreaming = {}
function elementStreamInOut()
    if getElementType(source) ~= "player" then
        if eventName:find("In") then
            if getElementType(source) == 'pickup' then
                local x,y,z = getElementPosition(source)
                for i, v in ipairs(infopoints) do
                    if getDistanceBetweenPoints3D(x,y,z, unpack(v)) <= 1 then
                        pickupsStreaming[source] = exports["MR1_Inicio"]:createText3D("#FFFFFF\n Usa #24C5BE/comoempezar #FFFFFFpara ver una guia", x, y, z+1, 2, "bankgothic", -1, false, false, true)
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

addEventHandler( "onClientElementStreamIn", getRootElement(), elementStreamInOut)
addEventHandler( "onClientElementStreamOut", getRootElement(), elementStreamInOut)

-- In order to render the browser fullscreen, we need to get the dimensions of the screen
local screenWidth, screenHeight = guiGetScreenSize()
local window, browser, closeButton

function abrirVideoTutorial()
    local width, height = 905, 697

    -- Crear la ventana del navegador
    window = guiCreateWindow((screenWidth - width) / 2, (screenHeight - height) / 2, width, height + 50, "Como empezar by ->  kaii006", false)
    
    -- Crear el navegador dentro de la ventana GUI
    browser = guiCreateBrowser(0, 28, width, height - 50, false, false, false, window)
    local theBrowser = guiGetBrowser(browser) -- Obtener el elemento navegador
    
    -- Crear botón para cerrar la ventana
    closeButton = guiCreateButton(10, height - 20, width - 20, 30, "Cerrar", false, window)
    addEventHandler("onClientGUIClick", closeButton, cerrarVentanaTutorial, false)

    -- Mostrar el cursor para que el jugador pueda interactuar con la GUI
    showCursor(true, true)

    -- El evento onClientBrowserCreated se activará después de que el navegador se haya inicializado
    addEventHandler("onClientBrowserCreated", theBrowser, 
        function()
            -- Cargar la URL del video de YouTube
            loadBrowserURL(source, "https://www.youtube.com/watch?v=drpx0F4m768")
        end
    )
end

function cerrarVentanaTutorial()
    -- Destruir el navegador y la ventana
    if isElement(browser) then
        destroyElement(browser)
    end
    if isElement(window) then
        destroyElement(window)
    end

    -- Ocultar el cursor
    showCursor(false, false)
end

addEvent("abrirVideoTutorial", true)
addEventHandler("abrirVideoTutorial", getRootElement(), abrirVideoTutorial)