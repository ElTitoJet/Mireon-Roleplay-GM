--print(getAllWeaponsGGO())
addEvent('onPlayerPostWeaponFire')
addEvent('onPlayerWeaponChange')

delay = {}
delayChangeDrive = {}
addEventHandler( 'onPlayerResourceStart', getRootElement(),
	function(res)
		if res == getThisResource(  ) then
			Datas[source] = {
				currentSlot = 0,
			}

			table.insert(SyncPlayers, source)
			bindKey(source, 'next_weapon', 'down', playerWeaponChange)
			bindKey(source, 'previous_weapon', 'down', playerWeaponChange)

			--bindKey(source, 'vehicle_fire', 'up', _fire_)
		end 
	end 
)

addEventHandler( 'onResourceStop', getRootElement(),
	function(res)
		for i, v in ipairs(getElementsByType('player')) do
			takeAllWeapons(v)
		end
	end 
)


addEventHandler( 'onPlayerQuit', getRootElement(),
	function(res)
		Datas[source] = nil

		unbindKey(source, 'next_weapon', 'down', playerWeaponChange)
		unbindKey(source, 'previous_weapon', 'down', playerWeaponChange)

		for i, v in pairs(SyncPlayers) do
			if v == source then
				table.remove(SyncPlayers, i)
				break
			end
		end
	end,
true, 'low-99999')

 
function playerWeaponChange(ped, key, state)
	
	local slot = Weapon.getCurrentSlot(ped)
	if slot then

		local old_slot = slot
		local weps = Weapon.getAllFromPed(ped)

		if #weps > 0 then

			delay[ped] = delay[ped] or {}
			if delay[ped].change and getTickCount() - delay[ped].change <= 500 then
				return
			end

			delay[ped].change = getTickCount()
			
			if getControlState(ped, 'aim_weapon') then
				local _, wep = Weapon.getFromPed(ped, slot)
				if wep and (wep.id == 34 or wep.id == 43) then
					return
				end
			end

			if key == 'next_weapon' then

				for i = 1, 12 do

					slot = slot + 1
					if slot > 12 then
						slot = 0
					end

					if Datas[ped].weapons[slot] or slot == 0 then
						break
					end
				end

			else
				for i = 1, 12 do

					slot = slot - 1
					if slot < 0 then
						slot = 12
					end

					if Datas[ped].weapons[slot] or slot == 0 then
						break
					end
				end
			end
			
			if old_slot ~= slot then

				triggerEvent('onPlayerWeaponChange', ped, old_slot, slot)

				if not wasEventCancelled() then

					ped:takeAllWeapons()

					triggerClientEvent(ped, 'onClientPlayerWeaponChange', ped, old_slot, slot)
					Datas[ped].currentSlot = slot
				
					local _, wep = Weapon.getFromPed(ped, slot)
					if wep then

						Weapon.give(ped, wep.id, 0, true)

					end
				end
			end
		end
	end
end

function driveByChangeWeaponChange(ped, key, state)
	if not isPedInVehicle ( ped ) or not isPedDoingGangDriveby(ped) then
		return
	end
	local okWeapon = { 22, 23, 24, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33}
	local slot, currentWeapon = Weapon.getFromPed(ped)
	if slot then
		local old_slot = slot
		local weps = Weapon.getAllFromPed(ped)
			local armaActual = table.find(okWeapon, currentWeapon.id)
		if #weps > 0 and armaActual then
			delayChangeDrive[ped] = delayChangeDrive[ped] or {}
			if delayChangeDrive[ped].change and getTickCount() - delayChangeDrive[ped].change <= 500 then
				return
			end

			delayChangeDrive[ped].change = getTickCount()

			for i, weapon in ipairs(okWeapon) do
				if key == "e" then
					armaActual = armaActual + 1
					if armaActual > #okWeapon then
						armaActual = 1
					end
				else
					armaActual = armaActual - 1
					if armaActual <= 0 then
						armaActual = #okWeapon
					end
				end
				local check;
				for i2, weapon2 in ipairs(weps) do
					if weapon2.id == okWeapon[armaActual] and weapon2.ammo+weapon2.clip > 1 then
						setCurrentSlot(ped, Weapon[weapon2.id].slot)
						check = true
						break
					end
				end
				if check then
					break
				end
			end
		end
	end
end


addEventHandler ("onPlayerWeaponFire", root, 
   	function (weapon, endX, endY, endZ, hitElement, startX, startY, startZ)
		takeAmmoBySpecialsWeapons(source, hitElement, endX, endY, endZ, startX, startY, startZ)
   	end
)

function takeAmmoBySpecialsWeapons(ped, hitElement, endX, endY, endZ, startX, startY, startZ)
	local slot, wep = Weapon.getFromPed(ped)
	if wep then

		setWeaponAmmo(ped, wep.id, 9999, 999)

		triggerEvent('onPlayerPostWeaponFire', ped, slot, wep, hitElement, endX, endY, endZ, startX, startY, startZ)

		if wasEventCancelled() then
			if ped:isDoingGangDriveby() then
				toggleControl(ped, 'vehicle_fire', false)
			end
			return setControlState(ped, 'fire', false)
		end

		if wep.clip > 0 then
			wep.clip = wep.clip - 1

			if wep.clip <= 0 then
				--toggleControl(ped, 'fire', false)
				setControlState(ped, 'fire', false)

				if ped:isDoingGangDriveby() then
					toggleControl(ped, 'vehicle_fire', false)
				end

				if wep.ammo <= 0 then
					Weapon.take(ped, wep.id)
				else
					if not Weapon.noReload[wep.id] then
						if wep.ammo > 0 then
							--reloadPedCustomWeapon(ped, wep.id)
						end
					end
				end
			end
		else
			if not Weapon.noReload[wep.id] then
				if wep.ammo > 0 then
					--reloadPedCustomWeapon(ped, wep.id)
				end
			end
		end
	end
end

addEvent("WeaponsCustom:reload", true)
addEventHandler( "WeaponsCustom:reload", resourceRoot,
	function(wep_)
		if not isElement(client) then return end;
		reloadPedCustomWeapon(client, wep_)
	end 
, false)

function reloadPedCustomWeapon(ped, wep_)
	local slot, wep = Weapon.getFromPed(ped)
	if wep then

		if wep.id == wep_ then
			if wep.ammo > 0 then

				local info = Weapon[wep_]
				if info then

					local newAmmo = 0
					local diff = info.ammo - wep.clip

					if diff > 0 then

						if diff > wep.ammo then

							wep.clip = math.min(info.ammo, wep.clip+wep.ammo)
							wep.ammo = 0

						else

							wep.ammo = wep.ammo - diff
							wep.clip = info.ammo

						end

						if not ped.inVehicle then
							ped:reloadWeapon()
						
							--setWeaponAmmo(ped, wep.id, 9999, 999)

							local anim = Weapon.reloadWeaponAnim[wep.id]
							if anim then

								local index = ped:isDucked() and 3 or 2
								ped:setAnimation (anim[1], anim[index], -1, false, true, false, false, 250, true)

							end
						end
					end
				end
			end
		end
	end
end

function _fire_(player, _, state)
    local state = state
    if state == 'up' then
        if player:isDoingGangDriveby() then

        	local slot = getCurrentSlot(player)

        	setPedDoingGangDriveby(player, false)
        	setPedDoingGangDriveby(player, true)
            
            setCurrentSlot(player, slot)
        end
    end
end

function enterVehicle ( thePlayer, seat, jacked ) 
	if not getElementType(thePlayer) == "player" and seat ~= 0 then
		return
	end
	
    if eventName == "onVehicleEnter" then
		bindKey(thePlayer, "mouse2", "down", driveBy)
		bindKey(thePlayer, "q", "down", driveByChangeWeaponChange)
		bindKey(thePlayer, "e", "down", driveByChangeWeaponChange)
	else
		unbindKey(thePlayer, "mouse2", "down", driveBy)
	end
end
addEventHandler ( "onVehicleEnter", getRootElement(), enterVehicle ) 
addEventHandler ( "onVehicleExit", getRootElement(), enterVehicle ) 
function driveBy(thePlayer)
	if isPedInVehicle ( thePlayer ) then
		if getPedOccupiedVehicleSeat ( thePlayer ) ~= 0 then
			if not isPedDoingGangDriveby(thePlayer) then
				for i, object in ipairs(Weapon.getAllFromPed(thePlayer)) do
					if validDrivebyWeapons[object.id] then
						if object.ammo + object.clip > 1 then
							local slot = Weapon[object.id]
							setCurrentSlot(thePlayer, slot.slot)
							setPedDoingGangDriveby ( thePlayer, true )
							break
						end
					end
				end
			else
				setPedDoingGangDriveby ( thePlayer, false )
			end
		end
	end
end
-- function nombre(jugador,comando,arg)

-- 	Weapon.give(jugador, tonumber(arg), 300, true)
-- end
-- addCommandHandler("gun", nombre)

--setTimer(function() nombre(getPlayerFromName( "CS" ), _, 24) end,2000,1)


function give(...)
	return Weapon.give(...)
end

function take(...)
	return Weapon.take(...)
end

function takeAll(...)
	return Weapon.takeAll(...)
end

function giveAmmo(...)
	return Weapon.giveAmmo(...)
end

function setCurrentSlot(...)
	return Weapon.setCurrentSlot(...)
end

for _,weapon in ipairs( { {"colt 45", 13}, {"silenced", 13}, {"deagle", 8}, {"shotgun", 8}, {"sawed-off", 2}, {"combat shotgun", 8}, {"uzi", 26}, {"mp5", 31}, {"ak-47", 31}, {"m4", 31}, {"tec-9", 26}, {"rifle", 2}, {"sniper", 2}, {"minigun", 51} } ) do
    for _,skill in ipairs( { "poor", "std", "pro" } ) do
        setWeaponProperty( weapon[1], skill, "maximum_clip_ammo", 999)
    end
end

