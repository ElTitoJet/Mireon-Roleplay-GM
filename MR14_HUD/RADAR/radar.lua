local tiles = { }
local timer
local enabled = false

local ROW_COUNT = 12
function toggleCustomTiles ( )
	-- Toggle!
	enabled = not enabled
	
	-- Check whether we enabled it
	if enabled then
		-- Load all tiles
		handleTileLoading ( )
		
		-- Set a timer to check whether new tiles should be loaded (less resource hungry than doing it on render)
		timer = setTimer ( handleTileLoading, 500, 0 )
	else
		-- If our timer is still running, kill it with fire
		if isTimer ( timer ) then killTimer ( timer ) end
		
		-- Unload all tiles, so the memory footprint has disappeared magically
		for name, data in pairs ( tiles ) do
			unloadTile ( name )
		end
	end
	
	--outputChatBox ( "Custom radar "..(enabled and "enabled" or "disabled"))
end
--bindKey("F5","down",toggleCustomTiles)
--addCommandHandler ( "cusradar", toggleCustomTiles )

addEventHandler("onClientResourceStart", resourceRoot, function()
	toggleCustomTiles()
	changeRadarDesign()
end)

function handleTileLoading ( )
	-- Get all visible radar textures
	local visibleTileNames = table.merge ( engineGetVisibleTextureNames ( "radar??" ), engineGetVisibleTextureNames ( "radar???" ) )
	
	-- Unload tiles we don't see
	for name, data in pairs ( tiles ) do
		if not table.find ( visibleTileNames, name ) then
			unloadTile ( name )
		end
	end
	
	-- Load tiles we do see
	for index, name in ipairs ( visibleTileNames ) do
		loadTile ( name )
	end
end

function table.merge ( ... )
	local ret = { }
	
	for index, tbl in ipairs ( {...} ) do
		for index, val in ipairs ( tbl ) do
			table.insert ( ret, val )
		end
	end
	
	return ret
end

function table.find ( tbl, val )
	for index, value in ipairs ( tbl ) do
		if value == val then
			return index
		end
	end
	
	return false
end

-------------------------------------------
--
-- Tile loading and unloading functions
--
-------------------------------------------

function loadTile ( name )
	-- Make sure we have a string
	if type ( name ) ~= "string" then
		return false
	end
	
	-- Check whether we already loaded this tile
	if tiles[name] then
		return true
	end
	
	-- Extract the ID
	local id = tonumber ( name:match ( "%d+" ) )
	
	-- If not a valid ID, abort
	if not id then
		return false
	end
	
	-- Calculate row and column
	local row = math.floor ( id / ROW_COUNT )
	local col = id - ( row * ROW_COUNT )
	
	-- Now just calculate start and end positions
	local posX = -3000 + 500 * col
	local posY =  3000 - 500 * row
	
	-- Fetch the filename
	local file = string.format ( "RADAR/radar2/sattelite_%d_%d.jpeg", row, col )
	--local file = string.format ( "RADAR/radar/sattelite_%d_%d.jpeg", row, col )
	
	-- Now, load that damn file! (Also create a transparent overlay texture)
	local texture = dxCreateTexture ( file )
	
	-- If it failed to load, abort
	if not texture --[[or not overlay]] then
		return false
	end
	
	-- Now we just need the shader
	local shader = dxCreateShader ( "RADAR/radar_shader.fx" )
	
	-- Abort if failed (don't forget to destroy the texture though!!!)
	if not shader then
		outputChatBox ( "Failed to load shader" )
		destroyElement ( texture )
		return false
	end
	
	-- Now hand the texture to the shader
	dxSetShaderValue ( shader, "gTexture", texture )
	
	-- Now apply this stuff on the tile
	engineApplyShaderToWorldTexture ( shader, name )
	
	-- Store the stuff
	tiles[name] = { shader = shader, texture = texture }
	
	-- Return success
	return true
end

function unloadTile ( name )
	-- Get the tile data
	local tile = tiles[name]
	
	-- If no data is present, we failed
	if not tile then
		return false
	end
	
	-- Destroy the shader and texture elements, if they exist
	if isElement ( tile.shader )  then destroyElement ( tile.shader )  end
	if isElement ( tile.texture ) then destroyElement ( tile.texture ) end
	
	-- Now remove all reference to it
	tiles[name] = nil
	
	-- We succeeded
	return true
end

function changeRadarDesign()
	local shader = dxCreateShader ( "RADAR/radar_shader.fx" )
	local texture = dxCreateTexture ( "RADAR/imgs/radardisc.png" )
	engineApplyShaderToWorldTexture ( shader, "radardisc" )
	dxSetShaderValue ( shader, "gTexture", texture )
end

local texturesimg = {
	{"RADAR/radar_img/arrow.png", "arrow"},
	{"RADAR/radar_img/radarRingPlane.png", "radarRingPlane"},
	{"RADAR/radar_img/radar_airYard.png", "radar_airYard"},
	{"RADAR/radar_img/radar_ammugun.png", "radar_ammugun"},
	{"RADAR/radar_img/radar_barbers.png", "radar_barbers"},
	{"RADAR/radar_img/radar_BIGSMOKE.png", "radar_BIGSMOKE"},
	{"RADAR/radar_img/radar_boatyard.png", "radar_boatyard"},
	{"RADAR/radar_img/radar_bulldozer.png", "radar_bulldozer"},
	{"RADAR/radar_img/radar_burgerShot.png", "radar_burgerShot"},
	{"RADAR/radar_img/radar_cash.png", "radar_cash"},
	{"RADAR/radar_img/radar_CATALINAPINK.png", "radar_CATALINAPINK"},
	{"RADAR/radar_img/radar_centre.png", "radar_centre"},
	{"RADAR/radar_img/radar_CESARVIAPANDO.png", "radar_CESARVIAPANDO"},
	{"RADAR/radar_img/radar_chicken.png", "radar_chicken"},
	{"RADAR/radar_img/radar_CJ.png", "radar_CJ"},
	{"RADAR/radar_img/radar_CRASH1.png", "radar_CRASH1"},
	{"RADAR/radar_img/radar_dateDisco.png", "radar_dateDisco"},
	{"RADAR/radar_img/radar_dateDrink.png", "radar_dateDrink"},
	{"RADAR/radar_img/radar_dateFood.png", "radar_dateFood"},
	{"RADAR/radar_img/radar_diner.png", "radar_diner"},
	{"RADAR/radar_img/radar_emmetGun.png", "radar_emmetGun"},
	{"RADAR/radar_img/radar_enemyAttack.png", "radar_enemyAttack"},
	{"RADAR/radar_img/radar_fire.png", "radar_fire"},
	{"RADAR/radar_img/radar_Flag.png", "radar_Flag"},
	{"RADAR/radar_img/radar_gangB.png", "radar_gangB"},
	{"RADAR/radar_img/radar_gangG.png", "radar_gangG"},
	{"RADAR/radar_img/radar_gangN.png", "radar_gangN"},
	{"RADAR/radar_img/radar_gangP.png", "radar_gangP"},
	{"RADAR/radar_img/radar_gangY.png", "radar_gangY"},
	{"RADAR/radar_img/radar_girlfriend.png", "radar_girlfriend"},
	{"RADAR/radar_img/radar_gym.png", "radar_gym"},
	{"RADAR/radar_img/radar_hostpital.png", "radar_hostpital"},
	{"RADAR/radar_img/radar_impound.png", "radar_impound"},
	{"RADAR/radar_img/radar_light.png", "radar_light"},
	{"RADAR/radar_img/radar_LocoSyndicate.png", "radar_LocoSyndicate"},
	{"RADAR/radar_img/radar_MADDOG.png", "radar_MADDOG"},
	{"RADAR/radar_img/radar_mafiaCasino.png", "radar_mafiaCasino"},
	{"RADAR/radar_img/radar_MCSTRAP.png", "radar_MCSTRAP"},
	{"RADAR/radar_img/radar_modGarage.png", "radar_modGarage"},
	{"RADAR/radar_img/radar_north.png", "radar_north"},
	{"RADAR/radar_img/radar_OGLOC.png", "radar_OGLOC"},
	{"RADAR/radar_img/radar_pizza.png", "radar_pizza"},
	{"RADAR/radar_img/radar_police.png", "radar_police"},
	{"RADAR/radar_img/radar_propertyG.png", "radar_propertyG"},
	{"RADAR/radar_img/radar_propertyR.png", "radar_propertyR"},
	{"RADAR/radar_img/radar_qmark.png", "radar_qmark"},
	{"RADAR/radar_img/radar_race.png", "radar_race"},
	{"RADAR/radar_img/radar_runway.png", "radar_runway"},
	{"RADAR/radar_img/radar_RYDER.png", "radar_RYDER"},
	{"RADAR/radar_img/radar_saveGame.png", "radar_saveGame"},
	{"RADAR/radar_img/radar_school.png", "radar_school"},
	{"RADAR/radar_img/radar_spray.png", "radar_spray"},
	{"RADAR/radar_img/radar_SWEET.png", "radar_SWEET"},
	{"RADAR/radar_img/radar_tattoo.png", "radar_tattoo"},
	{"RADAR/radar_img/radar_THETRUTH.png", "radar_THETRUTH"},
	{"RADAR/radar_img/radar_TORENO.png", "radar_TORENO"},
	{"RADAR/radar_img/radar_TorenoRanch.png", "radar_TorenoRanch"},
	{"RADAR/radar_img/radar_triads.png", "radar_triads"},
	{"RADAR/radar_img/radar_triadsCasino.png", "radar_triadsCasino"},
	{"RADAR/radar_img/radar_truck.png", "radar_truck"},
	{"RADAR/radar_img/radar_tshirt.png", "radar_tshirt"},
	{"RADAR/radar_img/radar_waypoint.png", "radar_waypoint"},
	{"RADAR/radar_img/radar_WOOZIE.png", "radar_WOOZIE"},
	{"RADAR/radar_img/radar_ZERO.png", "radar_ZERO"},
}

addEventHandler( "onClientResourceStart", resourceRoot,
    function()
		
		for i=1, #texturesimg do 
			local shader = dxCreateShader( "RADAR/radar_shader.fx" )
			engineApplyShaderToWorldTexture ( shader, texturesimg[i][2] )
            dxSetShaderValue ( shader, "gTexture", dxCreateTexture(texturesimg[i][1]) )
		end
		
    end
)