Datas = {}

addEvent(resName..':sync', true)
addEventHandler(resName..':sync', getElementByID('SyncData'), 
	function(t)
		Datas = t
	end
)

addEvent('execute:'..resName..':client', true)
addEventHandler('execute:'..resName..':client', resourceRoot,
    function(fun, ...)
        local s = fun:find('%.')
        if s then
            _G[fun:sub(1, s-1)][fun:sub(s+1)](...)
        else
            _G[fun](...)
        end
    end
, false)

Server = setmetatable({}, {
    __index = function(t, k)
        t[k] = function(...) triggerServerEvent('execute:'..resName..':server', resourceRoot, k, ...) end
        return t[k]
    end
})
