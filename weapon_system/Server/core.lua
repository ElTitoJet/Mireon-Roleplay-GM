local sync = Element('SyncData','SyncData')
Datas = {}
SyncPlayers = {}

Timer(
	function()
		if #Element.getAllByType('player') > 0 then

			triggerClientEvent(SyncPlayers, resName..':sync', sync, Datas)

		end
	end,
150, 0)

addEvent('execute:'..resName..':server', true)
addEventHandler('execute:'..resName..':server', resourceRoot,
    function(fun, ...)
        local s = fun:find('%.')
        if s then
            _G[fun:sub(1, s-1)][fun:sub(s+1)](...)
        else
            _G[fun](...)
        end
    end,
false)

Client = setmetatable({}, {
    __index = function(t, k)
        t[k] = function(player, ...) triggerClientEvent(player, 'execute:'..resName..':client', resourceRoot, k, ...) end
        return t[k]
    end
})

--[[
if (not client) or (client ~= source) then
	outputDebugString('Posible intento de trampa evitada \nClient: '..inspect(client)..'\nSource: '..inspect(source)..'\neventName: '..eventName, 2, 255, 255, 255)
    return false
end
]]

--addEventHandler( "onServerTimeInitialized", root, function() initializeAircraft() end )

