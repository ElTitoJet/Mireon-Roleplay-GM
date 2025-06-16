local airbreakEnabled = false
local normalSpeed = 1
local fastSpeed = 3
local currentSpeed = normalSpeed
local lastZ = nil

function toggleAirbreak(state)
    airbreakEnabled = state
    if airbreakEnabled then
        addEventHandler("onClientRender", root, handleAirbreak)
        bindKey("space", "both", handleSpeed)
        outputChatBox("Airbreak activado.", 0, 255, 0)
    else
        removeEventHandler("onClientRender", root, handleAirbreak)
        unbindKey("space", "both", handleSpeed)
        placeOnGround()
        lastZ = nil
        outputChatBox("Airbreak desactivado.", 255, 0, 0)
    end
end

function placeOnGround()
    local player = getLocalPlayer()
    local x, y, z = getElementPosition(player)
    local groundZ = getGroundPosition(x, y, z)
    -- Añadir una pequeña altura adicional para asegurarse de que el personaje está sobre el suelo
    if groundZ then
        setElementPosition(player, x, y, groundZ + 0.5)
    end
end

addEvent("onClientToggleAirbreak", true)
addEventHandler("onClientToggleAirbreak", root, toggleAirbreak)

function handleSpeed(key, state)
    if state == "down" then
        currentSpeed = fastSpeed
    else
        currentSpeed = normalSpeed
    end
end

function handleAirbreak()
    if airbreakEnabled then
        local player = getLocalPlayer()
        local x, y, z = getElementPosition(player)
        local camX, camY, camZ, tarX, tarY, tarZ = getCameraMatrix()

        local directionX = tarX - camX
        local directionY = tarY - camY
        local directionZ = tarZ - camZ

        local length = math.sqrt(directionX^2 + directionY^2 + directionZ^2)
        directionX = directionX / length
        directionY = directionY / length
        directionZ = directionZ / length

        local isMoving = false

        if getPedControlState("forwards") then
            x = x + directionX * currentSpeed
            y = y + directionY * currentSpeed
            z = z + directionZ * currentSpeed
            isMoving = true
        end
        if getPedControlState("backwards") then
            x = x - directionX * currentSpeed
            y = y - directionY * currentSpeed
            z = z - directionZ * currentSpeed
            isMoving = true
        end
        if getPedControlState("left") then
            x = x - directionY * currentSpeed
            y = y + directionX * currentSpeed
            isMoving = true
        end
        if getPedControlState("right") then
            x = x + directionY * currentSpeed
            y = y - directionX * currentSpeed
            isMoving = true
        end
        if getPedControlState("jump") then
            z = z + currentSpeed
            isMoving = true
        end
        if getPedControlState("crouch") or getKeyState("lctrl") then
            z = z - currentSpeed
            isMoving = true
        end

        -- Mantener la altura constante si no se está moviendo verticalmente
        if not isMoving and lastZ then
            z = lastZ
        else
            lastZ = z
        end

        setElementPosition(player, x, y, z)
        -- Ajustar la rotación del personaje según la dirección de la cámara
        local rotZ = -math.deg(math.atan2(tarX - camX, tarY - camY))
        setElementRotation(player, 0, 0, rotZ)
    end
end

function VerStaff(player, vanish)
    if player == localPlayer then
        return
    end
    --iprint(player, vanish)
    if not player then
        return
    end
    local varDataSource = exports["MR1_Inicio"]:getValueOne(localPlayer)
    if not (varDataSource.InfoCuenta["Rango"] >= 3) then
        return
    end
    if vanish then
        setElementAlpha(player, 100) -- Mostrar al staff como semi-visible
    else
        setElementAlpha(player, 255) -- Mostrar al staff como totalmente visible
    end
end
addEvent("Staff::ActualizarVisibilidad", true)
addEventHandler("Staff::ActualizarVisibilidad", root, VerStaff)

addEventHandler( "onClientResourceStart", getRootElement(), function ()
    local varDataSource = exports["MR1_Inicio"]:getValueOne(localPlayer)
    if not (varDataSource.InfoCuenta["Rango"] >= 3) then
        return
    end
    for i, Player in ipairs(getElementsByType("player")) do
        if Player ~= localPlayer then
            local varDataPlayer = exports["MR1_Inicio"]:getValueOne(Player)
            if varDataPlayer and varDataPlayer.Staff then 
                if varDataPlayer.Staff["Vanish"] then
                    setElementAlpha(Player, 100) -- Mostrar al staff como semi-visible
                else
                    setElementAlpha(Player, 255) -- Mostrar al staff como totalmente visible
                end
            end
        end
    end
end);
