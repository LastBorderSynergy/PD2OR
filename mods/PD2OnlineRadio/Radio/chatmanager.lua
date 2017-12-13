ChatManager._GO_RADIO = {
"RADIO!*",
}

local prefix = "[PD2OR]"
local function sendMessage(msg, color)
	if managers.chat then
		managers.chat:_receive_message(ChatManager.GAME, prefix, msg, color)
	end
end

-- HOST CHECK
local function isHost()
	if not Network then
		return false
	end
	return not Network:is_client()
end

--SHOW HINT
function showHint(msg)
  if not managers or not managers.hud then return end
  managers.hud:show_hint({text = msg})
end

local function radio()
    local fileCheckLang = io.open("mods/PD2OnlineRadio/Radio/OnlineRadioCheckLang.txt", "r")
    local fileCheckEnabled = io.open("mods/PD2OnlineRadio/Radio/OnlineRadioCheck.txt", "r")
    local file = io.open("mods/PD2OnlineRadio/Radio/OnlineRadio.txt", "r")
	if file then
	    if isHost() then
		    if fileCheckEnabled:read() == "true" then
	            if fileCheckLang:read() == "ru" then
		            sendMessage(managers.network.account:username() .." сейчас с музыкой: ".. file:read(), Color.green)
	            else
		            sendMessage(managers.network.account:username() .." now with music: ".. file:read(), Color.green)
	            end
		    else
	            if fileCheckLang:read() == "ru" then
		            sendMessage(managers.network.account:username() .." без музыки, радио выключено.", Color.green)
	            else
		            sendMessage(managers.network.account:username() .." without music, radio offline.", Color.green)
	            end
		    end
		else
		    if fileCheckEnabled:read() == "true" then
	            if fileCheckLang:read() == "ru" then
		            showHint("[PD2OR]: ".. managers.network.account:username() .." сейчас с музыкой: ".. file:read())
	            else
		            showHint("[PD2OR]: ".. managers.network.account:username() .." now with music: ".. file:read())
	            end
		    else
	            if fileCheckLang:read() == "ru" then
		            showHint("[PD2OR]: ".. managers.network.account:username() .." без музыки, радио выключено.")
	            else
		            showHint("[PD2OR]: ".. managers.network.account:username() .." without music, radio offline.")
	            end
		    end
		end
	end
end

if RequiredScript == 'lib/managers/chatmanager' then 
	local _receive_message_original = ChatManager._receive_message
	function ChatManager:_receive_message(channel_id, name, message, ...)
				
		for i, msg in ipairs(ChatManager._GO_RADIO) do
			if message:match("^" .. msg .. "$") then
				DelayedCalls:Add("_BLOCK_RADIO", 1, function() radio() end)
			end
		end
		
		return _receive_message_original(self, channel_id, name, message, ...)
	end
end