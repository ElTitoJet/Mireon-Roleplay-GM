sx, sy = guiGetScreenSize()
addEvent('onClientPlayerPreWeaponFire')
addEvent('onClientPlayerWeaponChange', true)

local blockedTasks = {
    ["TASK_SIMPLE_JUMP"] = true,
    ["TASK_SIMPLE_LAND"] = true,
    ["TASK_SIMPLE_SWIM"] = true,
    ["TASK_SIMPLE_FALL"] = true,
    ["TASK_SIMPLE_CLIMB"] = true,
    ["TASK_SIMPLE_GET_UP"] = true,
    ["TASK_SIMPLE_IN_AIR"] = true,
    ["TASK_SIMPLE_HIT_HEAD"] = true,
    ["TASK_SIMPLE_NAMED_ANIM"] = true,
    ["TASK_SIMPLE_CAR_GET_IN"] = true,
    ["TASK_SIMPLE_GO_TO_POINT"] = true,
    ["TASK_SIMPLE_CAR_OPEN_DOOR_FROM_OUTSIDE"] = true,
}

local currentWepReload
local function reloadTimer()
    if blockedTasks[getPedSimplestTask(localPlayer)] then
        return
    end

	local slot, wep = Weapon.getFromPed(localPlayer)
	if not wep or currentWepReload ~= wep.id then
    	return
    end

    currentWepReload = nil
    triggerServerEvent("WeaponsCustom:reload", resourceRoot, wep.id)
end


local timeRecharge
local function reloadWeapon()
	
    if timeRecharge and isTimer(timeRecharge) then
        resetTimer(timeRecharge)
    else
		local slot, wep = Weapon.getFromPed(localPlayer)
		if wep then
    		currentWepReload = wep.id
	   		timeRecharge = setTimer(reloadTimer, 50, 1)
	   	end
    end
end
bindKey("r", "down",reloadWeapon)



toggleControl('fire', true)
toggleControl('action', false)
--
toggleControl('next_weapon', false)
toggleControl('previous_weapon', false)
toggleControl('vehicle_fire', true)

 

function _fire_(_, state)
    local state = state
    if state == 'down' then

        local slot, wep = Weapon.getFromPed(localPlayer)
        if (slot ~= 0 and wep.id ~= localPlayer:getWeapon()) or (slot == 0 and 0 ~= localPlayer:getWeapon()) or antiFire then
            if localPlayer:isDoingGangDriveby() then
                toggleControl('vehicle_fire', false)
            else
                setPedControlState(localPlayer, 'fire', false)
            end
            return
        end

        triggerEvent('onClientPlayerPreWeaponFire', localPlayer, slot, wep)

        if not wasEventCancelled() then

            if slot == 0 then
                if not localPlayer.inVehicle then
                    setPedControlState(localPlayer, 'fire', true)
                end
            else
                if wep and wep.clip > 0 then

                    if localPlayer:isDoingGangDriveby() then
                        toggleControl('vehicle_fire', true)
                    else
                        setPedControlState(localPlayer, 'fire', true)
                    end
                else
                    state = 'up'
                end
            end

        end
    end

    if state == 'up' then
        --toggleControl('fire', false)
        setPedControlState(localPlayer, 'fire', false)

        if localPlayer:isDoingGangDriveby() then
            toggleControl('vehicle_fire', false)
        end
    end
end
bindKey('fire', 'both', _fire_)
bindKey('vehicle_fire', 'both', _fire_)


validDrivebyWeapons = { 
    [22]=300,[23]=300,[24]=800,[25]=700,
    [26]=700,[27]=700,[28]=100,[29]=70,
    [32]=85,[30]=100,[31]=70,[33]=700
}

addEventHandler( "onClientPlayerWeaponFire", localPlayer, 
	function(_wep, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
        if Weapon.specials[_wep] then
            Server.takeAmmoBySpecialsWeapons(localPlayer)    
        end

        if isPedDoingGangDriveby(localPlayer) then
            if not antiFire then
                
                toggleControl('vehicle_fire', false)
                antiFire = true
                Timer(
                    function()
                        antiFire = nil
                        toggleControl('vehicle_fire', true)
                    end,
                validDrivebyWeapons[_wep], 1)
            end
        end
	end
)

local delayfire, oldFire
addEventHandler( "onClientRender", getRootElement(),
	function()
        local fire = localPlayer:getControlState('fire') 
        local slot, wep = Weapon.getFromPed(localPlayer)

		if wep then
			if wep.clip <= 0 then
                if localPlayer:isDoingGangDriveby() then
                    toggleControl('vehicle_fire', false)
                else
                    if localPlayer:getControlState('fire') then
                        localPlayer:setControlState('fire', false)
                    end
                end
            else
                if wep.id == 41 or wep.id == 42 then
                    if fire then
                        if not delayfire or (getTickCount()-delayfire >= 25) then

                            Server.takeAmmoBySpecialsWeapons(localPlayer)
                            delayfire = getTickCount()

                        end
                    end
                elseif wep.id == 43 then
                    if fire and not oldFire and localPlayer:getControlState('aim_weapon') then
                        Server.takeAmmoBySpecialsWeapons(localPlayer)
                    end
                end
			end
		end

        for i, v in ipairs({'fire', 'action', 'next_weapon', 'previous_weapon', 'vehicle_secondary_fire'}) do
            if isControlEnabled ( v ) then
                toggleControl(v, false)
            end
        end

        oldFire = fire
	end
)



