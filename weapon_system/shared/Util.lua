resName = resource.name

Weapon = {
	[0] = {slot = 0, name = "Fist", ammo = 1},
	[1] = {slot = 0, name = "Brassknuckle", ammo = 1},
	[2] = {slot = 1, name = "Golfclub", ammo = 1},
	[3] = {slot = 1, name = "Nightstick", ammo = 1},
	[4] = {slot = 1, name = "Knife", ammo = 1},
	[5] = {slot = 1, name = "Bat", ammo = 1},
	[6] = {slot = 1, name = "Shovel", ammo = 1},
	[7] = {slot = 1, name = "Poolstick", ammo = 1},
	[8] = {slot = 1, name = "Katana", ammo = 1},
	[9] = {slot = 1, name = "Chainsaw", ammo = 1},
	[22] = {slot = 2, name = "Colt 45", ammo = 17},
	[23] = {slot = 2, name = "Silenced", ammo = 17},
	[24] = {slot = 2, name = "Deagle", ammo = 7},
	[25] = {slot = 3, name = "Shotgun", ammo = 99999},
	[26] = {slot = 3, name = "Sawed-off", ammo = 2},
	[27] = {slot = 3, name = "Combat Shotgun", ammo = 7},
	[28] = {slot = 4, name = "Uzi", ammo = 50},
	[29] = {slot = 4, name = "MP5", ammo = 30},
	[32] = {slot = 4, name = "Tec-9", ammo = 50},
	[30] = {slot = 5, name = "AK-47", ammo = 30},
	[31] = {slot = 5, name = "M4", ammo = 50},
	[33] = {slot = 6, name = "Rifle", ammo = 1},
	[34] = {slot = 6, name = "Sniper", ammo = 1},
	[35] = {slot = 7, name = "Rocket Launcher", ammo = 1},
	[36] = {slot = 7, name = "Rocket Launcher HS", ammo = 1},
	[37] = {slot = 7, name = "Flamethrower", ammo = 500},
	[38] = {slot = 7, name = "Minigun", ammo = 500},
	[16] = {slot = 8, name = "Grenade", ammo = 99999},
	[17] = {slot = 8, name = "Teargas", ammo = 99999},
	[18] = {slot = 8, name = "Molotov", ammo = 99999},
	[39] = {slot = 8, name = "Satchel", ammo = 99999},
	[41] = {slot = 9, name = "Spraycan", ammo = 99999},
	[42] = {slot = 9, name = "Fire Extinguisher", ammo = 99999},
	[43] = {slot = 9, name = "Camera", ammo = 99999},
	[10] = {slot = 10, name = "Dildo", ammo = 1},
	[11] = {slot = 10, name = "Dildo", ammo = 1},
	[12] = {slot = 10, name = "Vibrator", ammo = 1},
	[14] = {slot = 10, name = "Flower", ammo = 1},
	[15] = {slot = 10, name = "Cane", ammo = 1},
	[44] = {slot = 11, name = "Nightvision", ammo = 1},
	[45] = {slot = 11, name = "Infrared", ammo = 1},
	[46] = {slot = 11, name = "Parachute", ammo = 1},
	[40] = {slot = 12, name = "Bomb", ammo = 1},
}



weaponsBySlot = {
	[0] = {0, 1}, -- Hand
	[1] = {2, 3, 4, 5, 6, 7, 8, 9},	-- Melee
	[2] = {22, 23, 24}, -- Handguns
	[3] = {25, 26, 27}, -- Shotguns
	[4] = {28, 29, 32}, -- Sub-Machine Guns
	[5] = {30, 31}, -- Assault Rifles
	[6] = {33, 34}, -- Rifles
	[7] = {35, 36, 37, 38}, -- Heavy Weapons
	[8] = {16, 17, 18, 39}, -- Projectiles
	[9] = {41, 42, 43}, -- Special 1
	[10] = {10, 11, 12, 14, 15}, -- Gifts
	[11] = {44, 45, 46}, -- Special 2
	[12] = {40}, -- Satchel Detonator
}

Weapon.specials = {
    [35] = true, --rpg
    [36] = true, --rpg_red
    [37] = true, --flametower
    [38] = true, --minigun
    [16] = true, --grenade
    [17] = true, --gas
    [18] = true, --molotov
}

Weapon.noReload = {
	[46] = true, --minigun
    [16] = true, --grenade
    [17] = true, --gas
    [18] = true, --molotov
	[10] = true,
	[11] = true,
	[12] = true,
	[14] = true,
	[15] = true,
	[43] = true,
	[39] = true,
	[44] = true,
	[45] = true,
	[40] = true,
}

Weapon.reloadWeaponAnim = {
	[22] = {'colt45', 'colt45_reload', 'colt45_crouchreload'},
	[23] = {'silenced', "Silence_reload", "CrouchReload"},
	[24] = {'python', 'python_reload', 'python_crouchreload'},
	--[25] = {slot = 3, name = "Shotgun", ammo = 99999},
	[26] = {'colt45', 'sawnoff_reload', 'sawnoff_reload'},
	[27] = {'buddy', 'buddy_reload', 'buddy_crouchreload'},
	[28] = {'uzi', 'uzi_reload', 'uzi_crouchreload'},
	[29] = {'rifle', "rifle_load", "rifle_crouchload"},
	[32] = {'tec', 'tec_reload', 'tec_crouchreload'},
	[30] = {'rifle', "rifle_load", "rifle_crouchload"},
	[31] = {'rifle', "rifle_load", "rifle_crouchload"},
}


for i = 1,9 do
	Weapon.noReload[i] = true
end


Weapon.created = {}

function Weapon.getSlot(weapon)
	return Armas[weapon] and Armas[weapon].slot;
end

function Weapon.getCurrentSlot(ped)
	Datas[ped] = Datas[ped] or {}
	Datas[ped].currentSlot = Datas[ped].currentSlot or 0

	return Datas[ped].currentSlot;
end

function table.find(tabla, valor)
	for _, v in ipairs(tabla) do
		if v == valor then
			return _
		end
	end
	return false
end

function Weapon.getInfo(weapon)
	return Weapon[weapon];
end

function Weapon.getFromPed(ped, slot_)
	Datas[ped] = Datas[ped] or {}
	Datas[ped].weapons = Datas[ped].weapons or {}
	Datas[ped].currentSlot = Datas[ped].currentSlot or 0
	--
	local slot = slot_ or Weapon.getCurrentSlot(ped)
	if slot == 0 then
		return 0, {id=0, ammo=0, clip=0}
	else
		return slot, Datas[ped].weapons[slot]
	end
end

function Weapon.getAllFromPed(ped)
	Datas[ped] = Datas[ped] or {}
	Datas[ped].weapons = Datas[ped].weapons or {}
	Datas[ped].currentSlot = Datas[ped].currentSlot or 0
	--
	local all = {}
	for k, v in pairs(Datas[ped].weapons) do
		table.insert(all, v)
	end
	--
	return all
end

function Weapon.setCurrentSlot(ped, slot)
	Datas[ped] = Datas[ped] or {}
	Datas[ped].currentSlot = Datas[ped].currentSlot or 0

	local _, wep = Weapon.getFromPed(ped, slot)
	if wep and wep.id ~= 0 then

		Weapon.give(ped, wep.id, 0, true)

	elseif slot == 0 then

		ped:takeAllWeapons()
		Datas[ped].currentSlot = 0

	end
end

function Weapon.give(ped, wepID, ammo, setAsCurrent)

	Weapon.created[ped] = Weapon.created[ped] or {}
	Datas[ped] = Datas[ped] or {}
	Datas[ped].weapons = Datas[ped].weapons or {}
	Datas[ped].currentSlot = Datas[ped].currentSlot or 0

	if wepID == 0 then return end;

	local info = Weapon[wepID]
	if info then

		if setAsCurrent then

			ped:takeAllWeapons()
			ped:giveWeapon(wepID, 9999, true)
			--setWeaponAmmo(ped, wepID, 9999, 975)
			Datas[ped].currentSlot = info.slot

			if Datas[ped].weapons[info.slot] and Datas[ped].weapons[info.slot].id ~= wepID then
				Datas[ped].weapons[info.slot] = nil
			end

			if not Datas[ped].weapons[info.slot] then
				local newAmmo = ammo or info.ammo
				local clip = info.ammo
				local newAmmo = newAmmo - clip

				if newAmmo < 0 then
					newAmmo = 0
					clip = ammo
				end

				Datas[ped].weapons[info.slot] = {id=wepID, ammo=newAmmo, clip=clip}
			else
				Datas[ped].weapons[info.slot].ammo = Datas[ped].weapons[info.slot].ammo + ammo
			end
		else
			
			if Datas[ped].weapons[info.slot] and Datas[ped].weapons[info.slot].id == wepID then
				Datas[ped].weapons[info.slot].ammo = Datas[ped].weapons[info.slot].ammo + ammo

			else

				local newAmmo = ammo or info.ammo
				local clip = info.ammo
				local newAmmo = newAmmo - clip

				if newAmmo < 0 then
					newAmmo = 0
					clip = ammo
				end

				Datas[ped].weapons[info.slot] = {id=wepID, ammo=newAmmo, clip=clip}
			end
		end
	end
end

function Weapon.giveAmmo(ped, wepID, ammo)

	Weapon.created[ped] = Weapon.created[ped] or {}
	Datas[ped] = Datas[ped] or {}
	Datas[ped].weapons = Datas[ped].weapons or {}
	Datas[ped].currentSlot = Datas[ped].currentSlot or 0

	local info = Weapon[wepID]
	if info then

		if Datas[ped].weapons[info.slot] then

			Datas[ped].weapons[info.slot].ammo = Datas[ped].weapons[info.slot].ammo + math.abs(ammo)
		end
	end
end

function Weapon.take(ped, wepID, ammo)

	Weapon.created[ped] = Weapon.created[ped] or {}
	Datas[ped] = Datas[ped] or {}
	Datas[ped].weapons = Datas[ped].weapons or {}
	Datas[ped].currentSlot = Datas[ped].currentSlot or 0

	local info = Weapon[wepID]
	if info then

		if Datas[ped].weapons[info.slot] then

			if not ammo then
				Datas[ped].weapons[info.slot].ammo = 0
				Datas[ped].weapons[info.slot].clip = 0
			else
				local resto = Datas[ped].weapons[info.slot].ammo - ammo
				Datas[ped].weapons[info.slot].ammo = math.max(0, resto)

				if Datas[ped].weapons[info.slot].ammo <= 0 then
					Datas[ped].weapons[info.slot].clip = math.max(0, Datas[ped].weapons[info.slot].clip-math.abs(resto))
				end
			end

			if Datas[ped].weapons[info.slot].ammo <= 0 and Datas[ped].weapons[info.slot].clip <= 0 then

				--ped:takeWeapon(wepID)
				ped:takeAllWeapons()
				Datas[ped].weapons[info.slot] = nil

				local my = Weapon.getAllFromPed(ped)
				if #my > 0 then

					Weapon.give(ped, my[1].id, 0, true)
				end
			end
		end
	end
end

function Weapon.takeAll(ped)

	Weapon.created[ped] = Weapon.created[ped] or {}
	Datas[ped] = Datas[ped] or {}
	Datas[ped].weapons = {}
	Datas[ped].currentSlot = 0
	ped:takeAllWeapons()

end

function getCurrentSlot(...)
	return Weapon.getCurrentSlot(...)
end

function getInfo(...)
	return Weapon.getInfo(...)
end

function getFromPed(...)
	return Weapon.getFromPed(...)
end

function getAllFromPed(...)
	return Weapon.getAllFromPed(...)
end