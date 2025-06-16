-- MR13_Comandos > Stats
-- Gestiona el sistema de stats del usuario
-- Autor: ElTitoJet
-- Fecha: 08/09/2024

-- Variables Globales y Configuración

--PANELES
  
-- Funciones Auxiliares
    function formatNumber(n)
        local formatted = n
        while true do  
            formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
            if (k==0) then
                break
            end
        end
        return formatted
    end
-- Funciones Principales
    function AbrirPanelStats(source, command)
        triggerClientEvent(source, "Stats::Selector::Open", source)
    end
    function StatsCuentaData()
        -- Obtener el nombre de la cuenta del jugador que solicitó la información
            local accountName = getAccountName(getPlayerAccount(client))
        -- Consultar información de la cuenta desde la tabla Cuentas
            local accountConsult = exports["MR1_Inicio"]:query('SELECT * FROM Cuentas WHERE Usuario = ?', accountName)
        -- Variables para almacenar los datos
            local accountID, accountRankID, accountRank, accountVIP, accountTime
            local personajes = {}  -- Lista para almacenar los personajes y sus detalles
            local sanciones = {}   -- Lista para almacenar las sanciones

            if accountConsult and accountConsult[1] then
                accountID = accountConsult[1].ID
                accountRankID = accountConsult[1].Rango
                accountTime = accountConsult[1].TiempoJugado or 0 -- Ejemplo
                accountVIP = accountConsult[1].VIP or "No"  -- Ejemplo de VIP
        
                -- Consultar el rango
                local rankConsult = exports["MR1_Inicio"]:query('SELECT * FROM Rangos WHERE ID = ?', accountRankID)
                if rankConsult and rankConsult[1] then
                    accountRank = rankConsult[1].Abreviatura
                end
            end
        -- Consultar personajes asociados a la cuenta desde la tabla Personajes
            local personajesConsult = exports["MR1_Inicio"]:query('SELECT * FROM Personajes WHERE Cuenta = ?', accountID)
            
            if personajesConsult then
                for _, personaje in ipairs(personajesConsult) do
                    -- Decodificar el JSON de la columna Informacion e Inventario
                    local info = fromJSON(personaje.Informacion)
                    local inventario = fromJSON(personaje.Inventario)
        
                    -- Extraer el nombre, dinero y banco
                    local personajeData = {
                        ID = personaje.ID,
                        Nombre = personaje.Nombre,
                        Dinero = inventario and inventario.Dinero or 0,
                        Banco = info and info.Banco or 0
                    }
        
                    -- Guardar cada personaje en la lista
                    table.insert(personajes, personajeData)
        
                    -- Consultar las sanciones de este personaje desde JailOOCHistory
                    local sancionesConsult = exports["MR1_Inicio"]:query('SELECT * FROM JailOOCHistory WHERE IDPersonaje = ?', personaje.ID)
                    if sancionesConsult then
                        for _, sancion in ipairs(sancionesConsult) do
                            table.insert(sanciones, {
                                Personaje = personaje.Nombre,
                                Staff = sancion.Staff,
                                Fecha = sancion.Fecha,
                                Motivo = sancion.Razon
                            })
                        end
                    end
                end
            end

            -- Enviar los datos al cliente
            local datosCuenta = {
                Nombre = accountName,
                ID = accountID,
                Rank = accountRank,
                TiempoJugado = accountTime,
                VIP = accountVIP,
                Personajes = personajes,
                Sanciones = sanciones
            }
            
        -- Retorna los datos si deseas utilizarlos posteriormente
            triggerClientEvent(client, "Stats::Cuenta::RecibirData", client, datosCuenta)
    end
    
-- Eventos y Handlers    
    addCommandHandler("stats", AbrirPanelStats)
    addEvent("Stats::Cuenta::solicitarData", true)
    addEventHandler("Stats::Cuenta::solicitarData", getRootElement(), StatsCuentaData)
-- Inicialización
