-- Countdown Server Script --

local LimitOfUse = 40 -- A required delay (in seconds) between uses of countdown (default is 40)
local RadiusOfPlayersInvolved = 30 -- Players who are under this radius (distance from countdown triggerer) will be involved in countdown (default is 30)
local MinCountdownSeconds = 3 -- Minimum countdown seconds (default is 3)
local MaxCountdownSeconds = 1000 -- Maximum countdown seconds (default is 12)

function startCountdown(Player, Command, Seconds)
	if (getElementData(Player, "cdn.countdownSource")) then
		outputChatBox("You are already in a countdown! Use /cstop to abort it", Player, 245, 15, 0)
	else
		local lastUsed = getElementData(Player, "cdn.lastUsed")
		local currentUse = getRealTime().timestamp
		if (lastUsed) then
			local delayOfUse = currentUse - lastUsed
			if (delayOfUse >= LimitOfUse) then
				initiateCountdown(Player, Command, tonumber(Seconds), currentUse)
			else
				outputChatBox("You can use countdown again after " .. tostring(LimitOfUse - delayOfUse) .. " second(s)", Player, 255, 215, 0)
			end
		else
			initiateCountdown(Player, Command, tonumber(Seconds), currentUse)
		end
	end
end
addCommandHandler("countdown", startCountdown)
addCommandHandler("cd", startCountdown)
addCommandHandler("cdn", startCountdown)
addCommandHandler("count", startCountdown)

function stopCountdown(Player)
	local countdownSource = getElementData(Player, "cdn.countdownSource")
	if (countdownSource) then
		setElementData(Player, "cdn.countdownSource", false)
		outputChatBox(getPlayerName(Player) .. "#FFFFFF left your countdown event", countdownSource, 255, 255, 255, true)
	end
end
addCommandHandler("cstop", stopCountdown)

function initiateCountdown(Player, Command, Seconds, currentUse)
	if (Seconds) then
		if ((Seconds >= MinCountdownSeconds) and (Seconds <= MaxCountdownSeconds)) then
			setElementData(Player, "cdn.lastUsed", currentUse)
			setElementData(Player, "cdn.countdownTime", Seconds)
			local Participants = 0
			for _, v in pairs(getElementsByType("player")) do
				local x1, y1, z1 = getElementPosition(Player)
				local x2, y2, z2 = getElementPosition(v)
				if (getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2) <= RadiusOfPlayersInvolved) then
					if not (getElementData(v, "cdn.countdownSource")) then
						triggerClientEvent(v, "cdn.countdown_set", resourceRoot, Player)
						Participants = Participants + 1
					end
				end
			end
			outputChatBox("Your countdown event includes " .. tostring(Participants) .. " participant(s)", Player, 75, 215, 0)
			setTimer(doCountdown, 1000, Seconds, Player)
		else
			outputChatBox("Countdown length must be between " .. tostring(MinCountdownSeconds) .. " and " .. tostring(MaxCountdownSeconds) .. " seconds!", Player, 245, 25, 0)
		end
	else
		outputChatBox("Countdown syntax is /" .. Command .. " [seconds]", Player, 245, 25, 0)
	end
end

function doCountdown(Player)
	local Timer = tonumber(getElementData(Player, "cdn.countdownTime"))
	if (Timer) then
		Timer = Timer - 1
		setElementData(Player, "cdn.countdownTime", Timer)
	end
end