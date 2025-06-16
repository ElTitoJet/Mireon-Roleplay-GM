-- MR1_Inicio
-- Gestiona los textos 3D del server
-- Autor: Clawsuit
-- Fecha: 11/02/2024

-- Variables Globales y Configuración
    local text3Ds = {}
-- Funciones Auxiliares
    function dxDrawText2(t, x,y,w,h,...)
        return dxDrawText(t, x,y,w+x,h+y,...)
    end
-- Funciones Principales
    function createText3D(text, x, y, z, scale, font, color, outline, outlinecolor, colorcoded, lockX, lockY, lockZ)

        local count = select ( 2, text:gsub('\n', '') )
        local lines = {}
        local maxWidth = 0

        for line in text:gmatch("[^\n]+") do
            table.insert(lines, line)
            maxWidth = math.max(maxWidth, dxGetTextWidth(line, scale, font))
        end

        local width, height = dxGetTextSize (text, 0, scale, font, #lines > 1, colorcoded )
        local render = dxCreateRenderTarget(width, height, true)

        dxSetRenderTarget(render)
            dxSetBlendMode('modulate_add')
                local height = height / #lines
                for i = 1, #lines do

                    local text = lines[i]
                    if tonumber(outline) then

                        for oX = (outline * -1), outline do
                            for oY = (outline * -1), outline do
                                dxDrawText (text:gsub('#%x%x%x%x%x%x', ''), 0 + oX, (height*(i-1)) + oY, width + oX, (height*(i-1))+height + oY, (outlinecolor or tocolor(0, 0, 0, 100)), scale, font, "center", "center", true, true, false, false, false, 0, 0, 0)
                            end
                        end
                    
                        dxDrawText2(text, 0, (height*(i-1)), width, height, color, scale, font, "center", "center", true, true, false, colorcoded, false, 0, 0, 0)
                    else
                        dxDrawText2(text, 0, (height*(i-1)), width, height, color, scale, font, "center", "center", true, true, false, colorcoded, false, 0, 0, 0 )
                    end
                end
            dxSetBlendMode('blend')
        dxSetRenderTarget()

        
        text3Ds[render] = {x = x, y = y, z = z, scale = scale or 1, w=width, h=height, lockX=lockX, lockY=lockY, lockZ=lockZ}
        
        if sourceResource and type(sourceResource) == 'userdata' then
            addEventHandler('onClientResourceStop', getResourceRootElement( sourceResource ), function() destroyElement( render ) end)
        end

        return render
    end

    function attachText3D(render, attachTo)
        local cache = text3Ds[render]
        if cache then
            cache.attach = attachTo
            cache.attach.offsets = cache.attach.offsets or {0, 0, 0}
        end
    end

    function detachText3D(render)
        local cache = text3Ds[render]
        if cache then
            cache.attach = nil
        end
    end

    function isAttachText3D(render, element)
        local cache = text3Ds[render]
        return cache and cache.attach and cache.attach.element == element
    end
-- Eventos y Handlers
    addEventHandler("onClientPreRender", root, function()
        for render, v in pairs(text3Ds) do
            if isElement(render) then

                local x, y, z = v.x, v.y, v.z
                if v.attach and isElement( v.attach.element ) then

                    local ox, oy, oz = v.attach.offsets[1], v.attach.offsets[2], v.attach.offsets[3]
                    if v.attach.bone and (getElementType( v.attach.element ) == 'player' or getElementType( v.attach.element ) == 'ped') then
                        x, y, z = getPedBonePosition(v.attach.element, v.attach.bone)
                    else
                        x, y, z = getElementPosition( v.attach.element )
                    end

                    x, y, z = x+ox, y+oy, z+oz
                end

                dxSetBlendMode('add')
                    dxDrawMaterialLine3D(x, y, z+(v.scale/10), x, y, z-(v.scale/10), render, v.scale, -1, v.lockX, v.lockY, v.lockZ)
                dxSetBlendMode('blend')
            else
                text3Ds[render] = nil
            end
        end
    end)

    addEventHandler( "onClientElementDestroy", resourceRoot, function()
        if text3Ds[source] then
            text3Ds[source] = nil
        end
    end)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.














