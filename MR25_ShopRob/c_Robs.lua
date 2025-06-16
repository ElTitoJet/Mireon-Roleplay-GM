
addEventHandler("onClientPedDamage", getRootElement(), function()
    if getElementData(source, "inmortal") then
        cancelEvent()  -- Cancelar el daño si el NPC es inmortal
    end
end)