-- Countdown Client Script --

local ScreenW, ScreenH = guiGetScreenSize()

function clientRenderCountdown()
	local countdownSource = getElementData(localPlayer, "cdn.countdownSource")
	if (countdownSource) then
		local countdownTime = getElementData(countdownSource, "cdn.countdownTime")
		if (countdownTime) then
			local countdownPrev = getElementData(localPlayer, "cdn.countdownPrev")
			if (countdownPrev) then
				if (countdownPrev ~= countdownTime) then
					if (countdownTime == 0) then
						playSoundFrontEnd(45)
						setTimer(stopClientCountdown, 1500, 1)
					else
						playSoundFrontEnd(44)
					end
					setElementData(localPlayer, "cdn.countdownPrev", countdownTime)
				end
			else
				setElementData(localPlayer, "cdn.countdownPrev", countdownTime)
			end
			if (countdownTime == 0) then
				dxDrawText("GO!", (ScreenW - 64) / 2, 0, (ScreenW + 64) / 2, 236, tocolor(10, 255, 10, 215), 6.15, "pricedown", "center", "bottom", false, false, true)
			else
				dxDrawText(tostring(countdownTime), (ScreenW - 64) / 2, 0, (ScreenW + 64) / 2, 236, tocolor(255, 255, 255, 215), 6.15, "pricedown", "center", "bottom", false, false, true)
			end
			return
		end
	end
	stopClientCountdown()
end

function stopClientCountdown()
	removeEventHandler("onClientRender", root, clientRenderCountdown)
	setElementData(localPlayer, "cdn.countdownSource", false)
end

function countdownSet(SourcePlayer)
	setElementData(localPlayer, "cdn.countdownSource", SourcePlayer)
	addEventHandler("onClientRender", root, clientRenderCountdown)
	if (SourcePlayer ~= localPlayer) then
		outputChatBox("You were included in " .. getPlayerName(SourcePlayer) .. "#FFFFFF's countdown event!", 255, 255, 255, true)
		outputChatBox("To leave type /cstop", 245, 215, 0)
	end
end
addEvent("cdn.countdown_set", true)
addEventHandler("cdn.countdown_set", resourceRoot, countdownSet)