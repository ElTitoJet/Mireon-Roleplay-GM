-- modelo 5481
local laebridgedff = engineLoadDFF("modelo/laebridge/laebridge.dff", 5481)
if laebridgedff then
    engineReplaceModel(laebridgedff, 5481)
end


-- modelo 5481
local laebridgecol = engineLoadCOL("modelo/laebridge/laebridge.col")
if laebridgecol then
    engineReplaceCOL(laebridgecol, 5481)
end