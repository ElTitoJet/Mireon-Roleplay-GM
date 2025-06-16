-- MR5_Interiores
-- Gestiona el sistema de TP de interiores
-- Autor: ElTitoJet
-- Fecha: 01/03/2024

-- Variables Globales y Configuración
    local ENTRADAS = {
        [1] = {1498.5, -1581.0, 13.5, "Centro de Trabajos"},
        [2] = {1172.7, -1325.3, 15.4, "Hospital Market"},
        [3] = {1554.8, -1675.5, 16.2, "Comisaria Pershing Square"},
        [4] = {1111.5, -1795.5, 16.6, "Licencieros Marina"},
        
        [5]  = {2244.5, -1664.9, 15.5, "Binco"},
        [6]  = {2112.8, -1212.1, 24.0, "SubUrban"},
        [7]  = {499.80, -1359.9, 16.3, "ProLabs"},
        [8]  = {1456.7, -1138.1, 24.0, "Zip"},
        [9]  = {460.80, -1500.9, 31.1, "Victim"},
        [10] = {453.20, -1478.4, 30.8, "DidierShachs"},
        [11] = {2400.5, -1981.5, 13.5, "Ammu Nation"}, 
        [12] = {1367.5, -1279.5, 13.5, "Ammu Nation"}, 
        [13] = {2333.5, 61.5, 26.5, "Ammu Nation"},
        [14] = {242.5, -178.5, 1.5, "Ammu Nation"},

        -- 24/7
        [15] = {1832.931640, -1842.556640625, 13.578125, "24/7"},
        [16] = {1315.435546, -898.6044921875, 39.578125, "24/7"},
        [17] = {2001.793945, -1761.400390625, 13.539081, "24/7"},
        [18] = {2423.421875, -1742.126953125, 13.546875, "24/7"},
        [19] = {1446.154296, -1261.114257812, 13.546875, "24/7"},
        [20] = {2175.347656, -1333.567382812, 23.984375, "24/7"},
        [21] = {2714.053710, -1108.752929687, 69.578933, "24/7"},
        [22] = {773.2148437, -1793.497070312, 13.023437, "24/7"},
        [23] = {332.2822265, -1337.797851562, 14.507812, "24/7"},
        [24] = {1352.191406, -1757.973632812, 13.507812, "24/7"},
        [25] = {1975.809570, -2036.804687500, 13.546875, "24/7"},
        [26] = {2423.670898, -1922.637695312, 13.546875, "24/7"},
        [27] = {2249.522460, 52.676757812500, 26.667125, "24/7"},
        [28] = {1258.418945, 204.03515625000, 19.717418, "24/7"},
        [29] = {273.1962890, -180.6982421875, 1.5781250, "24/7"},
        [30] = {691.3466796, -546.7666015625, 16.335937, "24/7"}
    }

    local SALIDAS = {
        [1] = {-2026.9, -104.5, 1035.2, "Centro de Trabajos"},
        [2] = {1858, -1760.8, 1111.3, "Hospital Market"},
        [3] = {246.7, 63.3, 1003.6, "Comisaria Pershing Square"},
        [4] = {-2026.9, -104.5, 1035.2, "Licencieros Marina"},

        [5] = {207.6, -111.0, 1005.1, "Binco"},
        [6] = {203.7, -50.1, 1001.8, "SubUrban"},
        [7] = {206.9, -139.8, 1003.5, "ProLabs"},
        [8] = {161.4, -96.5, 1001.8, "Zip"},
        [9] = {226.7, -8.2, 1002.2, "Victim"},
        [10] = {204.3, -168.6, 1000.5, "DidierShachs"},
        [11] = {316.5, -169.5, 999.5, "Ammu Nation"},
        [12] = {285.5, -41.5, 1001.5, "Ammu Nation"},
        [13] = {296.5, -111.5, 1001.5,"Ammu Nation"},
        [14] = {285.5, -85.5, 1001.5, "Ammu Nation"},
        -- 24/7
        [15] = {-26.849609375, -57.1835937, 1003.546875, "24/7"},
        [16] = {-30.963867187, -90.9863281, 1003.546875, "24/7"},
        [17] = {-27.356445312, -30.9765625, 1003.557250, "24/7"},
        [18] = {-26.849609375, -57.1835937, 1003.546875, "24/7"},
        [19] = {-27.356445312, -30.9765625, 1003.557250, "24/7"},
        [20] = {-26.849609375, -57.1835937, 1003.546875, "24/7"},
        [21] = {-30.963867187, -90.9863281, 1003.546875, "24/7"},
        [22] = {-30.963867187, -90.9863281, 1003.546875, "24/7"},
        [23] = {-26.849609375, -57.1835937, 1003.546875, "24/7"},
        [24] = {-30.963867187, -90.9863281, 1003.546875, "24/7"},
        [25] = {-26.849609375, -57.1835937, 1003.546875, "24/7"},
        [26] = {-30.963867187, -90.9863281, 1003.546875, "24/7"},
        [27] = {-27.356445312, -30.9765625, 1003.557250, "24/7"},
        [28] = {-26.849609375, -57.1835937, 1003.546875, "24/7"},
        [29] = {-26.849609375, -57.1835937, 1003.546875, "24/7"},
        [30] = {-27.356445312, -30.9765625, 1003.557250, "24/7"}

    }

    local pickupsStreaming = {}
-- Funciones Auxiliares
    function recibirDatosInteriores(entradas, salidas)
        ENTRADAS = entradas
        SALIDAS = salidas
    end
-- Funciones Principales
    function elementStreamInOut()
        if getElementType(source) ~= "player" then
            if eventName:find("In") then
                if getElementType(source) == 'pickup' then
                    local x, y, z = getElementPosition(source)
                    for i, v in ipairs(ENTRADAS) do
                        if getDistanceBetweenPoints3D(x, y, z, v[1], v[2], v[3]) <= 1 then
                            pickupsStreaming[source] = exports["MR1_Inicio"]:createText3D(
                                "#53B440["..v[6].."]#FFFFFF\n Presiona #24C5BEH #FFFFFFpara entrar", 
                                x, y, z + 1, 2, "bankgothic", -1, false, false, true
                            )
                        end
                    end
                    for i, v in ipairs(SALIDAS) do
                        if getDistanceBetweenPoints3D(x, y, z, v[1], v[2], v[3]) <= 1 then
                            pickupsStreaming[source] = exports["MR1_Inicio"]:createText3D(
                                "#FFFFFF\n Presiona #24C5BEH #FFFFFFpara salir", 
                                x, y, z + 1, 2, "bankgothic", -1, false, false, true
                            )
                        end
                    end
                end
            else
                if isElement(pickupsStreaming[source]) then
                    destroyElement(pickupsStreaming[source])
                end
            end
        end

    end
-- Eventos y Handlers
    addEventHandler( "onClientElementStreamIn", getRootElement(), elementStreamInOut)
    addEventHandler( "onClientElementStreamOut", getRootElement(), elementStreamInOut)

    addEventHandler("onClientResourceStart", resourceRoot, function()
        triggerServerEvent("Interiores::SolicitarInts", localPlayer)
    end)
    addEvent("Interiores::RecibirInts", true)
    addEventHandler("Interiores::RecibirInts", root, recibirDatosInteriores)