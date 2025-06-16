-- MR4_CHATS
-- Gestiona el sistema de CHAT
-- Autor: ElTitoJet
-- Fecha: 01/03/2024

-- Variables Globales y Configuración

-- Funciones Auxiliares

-- Funciones Principales

-- Eventos y Handlers
addEvent("Recibir_MP", true)
addEventHandler("Recibir_MP", getLocalPlayer(), function()
	local sound = playSound("sounds/mp.mp3") -- Play wasted.mp3 from the sounds folder
	setSoundVolume(sound, 1) -- Set the sound volume to 50%
end)