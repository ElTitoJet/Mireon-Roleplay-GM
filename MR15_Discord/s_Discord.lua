-- MR15_Discord
-- Gestiona discord
-- Autor: ElTitoJet
-- Fecha: 19/02/2024

-- Variables Globales y Configuración
    local application = {
        id = "1166426171240628295", -- Application ID
        state = "Jugadores Online",
        max_slots = tonumber(getServerConfigSetting("maxplayers")),
        logo = "my_logo",
        logo_name = "Mireon Roleplay - Server MTA",
        details = "Server de Rol - MTA San Andreas",

        buttons = {
            [1] = {
                use = true,
                name = "Discord",
                link = "https://discord.gg/GzyvYtv"
            },

            [2] = {
                use = true,
                name = "Foro",
                link = "https://foros.mireonroleplay.site/"
            }
        }
    };

    local DiscordWebHookStatusServer = "https://discord.com/api/webhooks/1209270748775194675/XZyQkVSwFkbmkR0QEJVlDFtizQyVbaqRyLrxx85917ZF6eEMtPXTR3Q02dHPIAc0rlYT"
    local DiscordWebHookQuit = "https://discord.com/api/webhooks/1209271017491398696/fKZ4vl9gA2Bow5DyXf1ndT9UmkowevKaJuQinteSmEaD_poZYaP52wSlZAUGoUDWTGeG"
    local DiscordWebHookChatStaff = "https://discord.com/api/webhooks/1256520825926848512/v-J4VKVyX06KiGBy5wESXVE7cDZIP-h-lsGzisXDI6DRZAzLAobRLs5_cngYMJOZ1ust"
    local DiscordWebHookSanciones = "https://discord.com/api/webhooks/1256525774018580520/9l6uJvWFmDIRazrIFv3bJB2m_Y-RLCGp5GJJp2I7iwdtrvy2n0aDUSGa3OvyLukJcvcb"
    local DiscordWebHookChangeName = "https://discord.com/api/webhooks/1265704056286875658/ninVAqt62j8N_Yg1Tp5QcmtynbFybe4XU46EqE2WsKRzny5Qy7G1GdNiBUhyprQcwofB"
    local DiscordWebHookChangeNacion = "https://discord.com/api/webhooks/1266537135130017886/SNyBi9lJypUel26rVDAVHMOW98T6I3lYLuogmZuGKQMJiTvkmYCMh_nZFyU_dn6QY_UH"
    local DiscordWebHookDudas = "https://discord.com/api/webhooks/1269465665992003687/DmjTX7cRPWDrfoiqAyyTHtrvCfcagUP_8hc8wlEeviYnDWxU8mm_YxnbMnHwx40-E0U0"
    local DiscordWebHookReportes = "https://discord.com/api/webhooks/1275424288245284966/cz18iC909G5psY-AkUqNDxNvprds_K7XYl8He45EaKhG0S9WFcn5JWKlHYH6e1O46mzr"
    local DiscordWebHookStaffJoin = "https://discord.com/api/webhooks/1275429055318982731/Br6NQaxlDpcLMRURXjvWf0vF5VoQXBvFHmhxn14l0smnA7jrUXtq_2Nl6An0nLj6fxsD"
    local DiscordWebHookTopPlayers = "https://discord.com/api/webhooks/1288471129140494376/yZBV-bizPhj3zvkuRrWS4dwAhwBLp7jx09vWvhetQdUDeJArsj8SSiSxg31eVucFSloV"
    local DiscordWebHookDinero = "https://discord.com/api/webhooks/1297556930931458100/mqE3az2-c9NkXVtwQ6IvnfybS6OdQE6BwGgLgDAyrb4Z7NW_hGVz0NTNdlUt7axgogg0"
    local DiscordWebHookArmas = "https://discord.com/api/webhooks/1309904422486282330/E_-Dq7wOde9i5Vk1tixBmHS-5m0IvwFw98E_1nwSzBGbchKhgXb3m4ojJ4_Y6-DwN8RO"
    local hours, minutes, seconds
-- Funciones Auxiliares
    function callback()
    end
-- Funciones Principales
        function sendDiscordLogStatusServer(message)
            local time = getRealTime( )
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second

            if (hours < 10) then
                hours = "0"..hours
            end
            if (minutes < 10) then
                minutes = "0"..minutes
            end
            if (seconds < 10) then
                seconds = "0"..seconds
            end
            message = message or nil
            if message == nil then
                return
            end

            sendOptions = {
                queueName = "tcq",
                connectionAttempts = 3,
                connectTimeout = 5000,
                formFields = { 
                    content= "`"..( "[%04d/%02d/%02d" ):format( time.year + 1900, time.month + 1, time.monthday ).." - "..hours..":"..minutes..":"..seconds.."]` "..message
                },
            }

            fetchRemote ( DiscordWebHookStatusServer, sendOptions, callback, name )
        end
        function sendDiscordTopPlayers(count, TopDay, maximoHistorico)
            local time = getRealTime( )
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second

            if (hours < 10) then
                hours = "0"..hours
            end
            if (minutes < 10) then
                minutes = "0"..minutes
            end
            if (seconds < 10) then
                seconds = "0"..seconds
            end

            local foro = "https://foros.mireonroleplay.site/"
            local discord = "https://discord.gg/dvUHAxX22b"
            local ipServidor = "mtasa://149.56.107.9:22003"
            sendOptions = {
                queueName = "dcq",
                connectionAttempts = 3,
                connectTimeout = 5000,
                formFields = { 
                    content = "**Información del servidor - MTA**\n\n" ..
                              ":computer: **Jugadores en el servidor**: " .. count .. "\n" ..
                              ":checkered_flag: **Top del día**: " .. TopDay .. "\n" ..
                              ":trophy: **Máximo histórico**: " .. maximoHistorico .. "\n\n" ..
                              ":link: **Foro**: " .. foro .. "\n" ..
                              ":speech_balloon: **Discord**: " .. discord .. "\n" ..
                              ":desktop: **IP del servidor**: " .. ipServidor .. "\n\n" ..
                              ":clock3: **Hora actual**: " .. hours .. ":" .. minutes .. ":" .. seconds
                },
            }
            fetchRemote ( DiscordWebHookTopPlayers, sendOptions, callback, name )
        end
    -- LOG INFO PJ
        function sendDiscordChangeName(Usuario, newName, Staff)
            local time = getRealTime( )
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second

            if (hours < 10) then
                hours = "0"..hours
            end
            if (minutes < 10) then
                minutes = "0"..minutes
            end
            if (seconds < 10) then
                seconds = "0"..seconds
            end

            sendOptions = {
                queueName = "dcq",
                connectionAttempts = 3,
                connectTimeout = 5000,
                formFields = { 
                    content="`"..( "[%04d/%02d/%02d" ):format( time.year + 1900, time.month + 1, time.monthday ).." - "..hours..":"..minutes..":"..seconds.."]` :pencil: `"..Staff.."` ha cambiado el nombre de `"..Usuario.."` a `"..newName.."`."
                },
            }
            
            fetchRemote ( DiscordWebHookChangeName, sendOptions, callback, name )
        end
        function sendDiscordChangeNacionalidad(Usuario, newnacion, Staff)
            local time = getRealTime( )
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second

            if (hours < 10) then
                hours = "0"..hours
            end
            if (minutes < 10) then
                minutes = "0"..minutes
            end
            if (seconds < 10) then
                seconds = "0"..seconds
            end

            sendOptions = {
                queueName = "dcq",
                connectionAttempts = 3,
                connectTimeout = 5000,
                formFields = { 
                    content="`"..( "[%04d/%02d/%02d" ):format( time.year + 1900, time.month + 1, time.monthday ).." - "..hours..":"..minutes..":"..seconds.."]` :map: `"..Staff.."` ha cambiado la nacionlidad de `"..Usuario.."` a `"..newnacion.."`."
                },
            }
            
            fetchRemote ( DiscordWebHookChangeNacion, sendOptions, callback, name )
        end
        function sendDiscordChangeSexo(Usuario, newsexo, Staff)
            local time = getRealTime( )
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second

            if (hours < 10) then
                hours = "0"..hours
            end
            if (minutes < 10) then
                minutes = "0"..minutes
            end
            if (seconds < 10) then
                seconds = "0"..seconds
            end

            sendOptions = {
                queueName = "dcq",
                connectionAttempts = 3,
                connectTimeout = 5000,
                formFields = { 
                    content="`"..( "[%04d/%02d/%02d" ):format( time.year + 1900, time.month + 1, time.monthday ).." - "..hours..":"..minutes..":"..seconds.."]` :restroom: `"..Staff.."` ha cambiado el sexo de `"..Usuario.."` a `"..newsexo.."`."
                },
            }
            
            fetchRemote ( DiscordWebHookChangeNacion, sendOptions, callback, name )
        end
    -- DISCORD STAFF
        function sendDiscordChatStaff(Usuario, Rango, message)
            local time = getRealTime( )
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second

            if (hours < 10) then
                hours = "0"..hours
            end
            if (minutes < 10) then
                minutes = "0"..minutes
            end
            if (seconds < 10) then
                seconds = "0"..seconds
            end

            sendOptions = {
                queueName = "dcs",
                connectionAttempts = 3,
                connectTimeout = 5000,
                formFields = { 
                    content="`"..( "[%04d/%02d/%02d" ):format( time.year + 1900, time.month + 1, time.monthday ).." - "..hours..":"..minutes..":"..seconds.."]` **["..Usuario.." - "..Rango.."] :: ** "..message
                },
            }
            
            fetchRemote ( DiscordWebHookChatStaff, sendOptions, callback, name )
        end
        function sendDiscordSanciones(Usuario, Staff, Tiempo, Sancion, Motivo)
            local time = getRealTime( )
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second

            if (hours < 10) then
                hours = "0"..hours
            end
            if (minutes < 10) then
                minutes = "0"..minutes
            end
            if (seconds < 10) then
                seconds = "0"..seconds
            end
            if Sancion == "Jail" then
                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="`"..( "[%04d/%02d/%02d" ):format( time.year + 1900, time.month + 1, time.monthday ).." - "..hours..":"..minutes..":"..seconds.."]` **JAIL** - "..Staff.." - "..Usuario.." - "..Tiempo.." - "..Motivo..""
                    },
                }
            end
            
            fetchRemote ( DiscordWebHookSanciones, sendOptions, callback, name )
        end
        function sendDiscordDudaReport(Tipo, Usuario, message, Staff, respuesta)
            local time = getRealTime( )
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second

            if (hours < 10) then
                hours = "0"..hours
            end
            if (minutes < 10) then
                minutes = "0"..minutes
            end
            if (seconds < 10) then
                seconds = "0"..seconds
            end

            if Tipo == "Duda" then
                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="**:red_square: [**`Duda`**]** - `"..Usuario.."`\n**Pregunta**: `"..message.."`"
                    },
                }
                fetchRemote ( DiscordWebHookDudas, sendOptions, callback, name )
            elseif Tipo == "cDuda" then
                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="**:orange_square: [**`Duda - Cancelada`**]** - `"..Usuario.."`\n**Pregunta**: `"..message.."`"
                    },
                }
                fetchRemote ( DiscordWebHookDudas, sendOptions, callback, name )
            elseif Tipo == "rDuda" then
                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="**:green_square: [**`Duda - Respondida`**]** - `"..Usuario.."` - `"..Staff.."` \n**Pregunta**: `"..message.."` \n**Respuesta**: `"..respuesta.."`"
                    },
                }
                fetchRemote ( DiscordWebHookDudas, sendOptions, callback, name )
            elseif Tipo == "Reporte" then
                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="**:red_square: [**`Reporte`**]** - `"..Usuario.."`\n**Mensaje**: `"..message.."`"
                    },
                }
                fetchRemote ( DiscordWebHookReportes, sendOptions, callback, name )
                
            elseif Tipo == "cReporte" then
                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="**:orange_square: [**`Reporte - Cancelada`**]** - `"..Usuario.."`\n**Mensaje**: `"..message.."`"
                    },
                }
                fetchRemote ( DiscordWebHookReportes, sendOptions, callback, name )
            elseif Tipo == "rReporte" then
                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="**:green_square: [**`Reporte - Respondido`**]** - `"..Usuario.."` - `"..Staff.."` \n**Mensaje**: `"..message.."`"
                    },
                }
                fetchRemote ( DiscordWebHookReportes, sendOptions, callback, name )
            end
        end
        function sendDiscordLoginQuitStaff(Tipo, Usuario, ContadorStaff, Tiempo)
            local time = getRealTime( )
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second

            if (hours < 10) then
                hours = "0"..hours
            end
            if (minutes < 10) then
                minutes = "0"..minutes
            end
            if (seconds < 10) then
                seconds = "0"..seconds
            end
            if Tipo == "Login" then
                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="**:green_square: [**`Staff ON`**]** - "..Usuario.." (`"..ContadorStaff.." conectados`)"
                    },
                }
                fetchRemote ( DiscordWebHookStaffJoin, sendOptions, callback, name )
            elseif Tipo == "Quit" then
                -- Calcular tiempo jugado actual

                local tiempoConectado = (getRealTime().timestamp - Tiempo) / 60 -- Convertir a minutos

                local dias = math.floor(tiempoConectado / 1440) -- 1440 minutos en un día
                local horas = math.floor((tiempoConectado % 1440) / 60) -- Horas restantes
                local minutos = math.floor(tiempoConectado % 60) -- Minutos restantes
        
                -- Formatear el texto
                local diasTexto = dias > 0 and dias .. " día(s)" or ""
                local horasTexto = horas > 0 and horas .. " hora(s)" or ""
                local minutosTexto = minutos > 0 and minutos .. " minuto(s)" or ""
        
                -- Unir el texto adecuadamente
                local tiempoFormateado = table.concat({diasTexto, horasTexto, minutosTexto}, ", "):gsub(", $", "")

                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="**:red_square: [**`Staff LEAVE`**]** - "..Usuario.." (Tiempo ON : "..horas.." Horas, "..minutosTexto.." Minutos) (`"..ContadorStaff.." conectados`)"
                    },
                }
                fetchRemote ( DiscordWebHookStaffJoin, sendOptions, callback, name )
            end
        end
        function sendDiscordDineroStaff(Tipo, Usuario, Cantidad, Script)
            Usuario = getPlayerName(Usuario)
            local time = getRealTime( )
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second

            if (hours < 10) then
                hours = "0"..hours
            end
            if (minutes < 10) then
                minutes = "0"..minutes
            end
            if (seconds < 10) then
                seconds = "0"..seconds
            end
            if Tipo == "Sumar" then
                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="`"..( "[%04d/%02d/%02d" ):format( time.year + 1900, time.month + 1, time.monthday ).." - "..hours..":"..minutes..":"..seconds.."]` **:green_square: [**"..Script.."**]** - "..Usuario.." `"..Cantidad.."`"
                    },
                }
                fetchRemote ( DiscordWebHookDinero, sendOptions, callback, name )
            elseif Tipo == "Restar" then
                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="`"..( "[%04d/%02d/%02d" ):format( time.year + 1900, time.month + 1, time.monthday ).." - "..hours..":"..minutes..":"..seconds.."]` **:red_square: [**"..Script.."**]** - "..Usuario.." `"..Cantidad.."`"
                    },
                }
                fetchRemote ( DiscordWebHookDinero, sendOptions, callback, name )
            end
        end
        function sendDiscordArmasStaff(Tipo, Usuario, Cantidad, Arma, Script)
            Usuario = getPlayerName(Usuario)
            local time = getRealTime( )
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second

            if (hours < 10) then
                hours = "0"..hours
            end
            if (minutes < 10) then
                minutes = "0"..minutes
            end
            if (seconds < 10) then
                seconds = "0"..seconds
            end
            if Tipo == "Dar" then
                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="`"..( "[%04d/%02d/%02d" ):format( time.year + 1900, time.month + 1, time.monthday ).." - "..hours..":"..minutes..":"..seconds.."]` **:green_square: [**"..Script.."**]** - "..Usuario.." `"..Cantidad.."` `"..getWeaponNameFromID(Arma).."`"
                    },
                }
                fetchRemote ( DiscordWebHookArmas, sendOptions, callback, name )
            elseif Tipo == "Quitar" then
                sendOptions = {
                    queueName = "dcs",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="`"..( "[%04d/%02d/%02d" ):format( time.year + 1900, time.month + 1, time.monthday ).." - "..hours..":"..minutes..":"..seconds.."]` **:red_square: [**"..Script.."**]** - "..Usuario.." `"..Cantidad.."` `"..getWeaponNameFromID(Arma).."`"
                    },
                }
                fetchRemote ( DiscordWebHookArmas, sendOptions, callback, name )
            end
        end
-- Eventos y Handlers
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.
    addEventHandler("onPlayerResourceStart", root,
        function(theResource)
            if (theResource == resource) then
                triggerClientEvent(source, "addPlayerRichPresence", source, application);
            end
        end
    );

--[[
    function sendDiscordLogMessage(message, thePlayer)

        if thePlayer  then
            if message and #message > 0 then
                local time = getRealTime( )
                local hours = time.hour
                local minutes = time.minute
                local seconds = time.second

                if (hours < 10) then
                    hours = "0"..hours
                end
                if (minutes < 10) then
                    minutes = "0"..minutes
                end
                if (seconds < 10) then
                    seconds = "0"..seconds
                end
                sendOptions = {
                    queueName = "dcq",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = { 
                        content="`"..( "[%04d/%02d/%02d" ):format( time.year + 1900, time.month + 1, time.monthday ).." - "..hours..":"..minutes..":"..seconds.."]` "..getPlayerName(thePlayer).." "..message..""
                    },
                }
                fetchRemote ( discordWebhookLOGS, sendOptions, callback, name )
            end
        end
    end
]]