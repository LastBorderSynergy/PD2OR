if managers.hud and managers.money and managers.loot then
	if Utils:IsInHeist() then

		PD2ORFX = {}
		PD2ORFX.Data = {}

		function Load_Data()
		local file = io.open( SavePath .. "PD2OR_Options.txt" , "r")
			if file then
				for k, v in pairs(json.decode(file:read("*all")) or {}) do
					if k then
						PD2ORFX.Data[k] = v
					end
				end
				file:close()
			end
		end

		Load_Data()

		local fileCheckEnabled = io.open("mods/PD2OnlineRadio/Radio/OnlineRadioCheck.txt", "r")
		local correction_x = math.floor(PD2ORFX.Data["PD2OR_Pos_X_Value"] or 0)
		local correction_y = math.floor(PD2ORFX.Data["PD2OR_Pos_Y_Value"] or 0)

		if fileCheckEnabled:read() == "true" then
		--  managers.hud._hud_assault_corner._pd2or_panel_box:set_visible(true)
		    managers.hud._hud_assault_corner.pd2or_panel:set_visible(true)
			managers.hud._hud_assault_corner.pd2or_text:set_visible(true)
			managers.hud._hud_assault_corner.other_pd2or_text:set_visible(true)
		else
		--  managers.hud._hud_assault_corner._pd2or_panel_box:set_visible(false)
		    managers.hud._hud_assault_corner.pd2or_panel:set_visible(false)
			managers.hud._hud_assault_corner.pd2or_text:set_visible(false)
			managers.hud._hud_assault_corner.other_pd2or_text:set_visible(false)
		end
		
		if correction_x then
			managers.hud._hud_assault_corner.pd2or_panel:set_left(managers.hud._hud_assault_corner._hostages_bg_box:left() + 21 + correction_x)
			managers.hud._hud_assault_corner.other_pd2or_panel:set_left(managers.hud._hud_assault_corner.pd2or_panel:left() - 8)
		end

		if correction_y then
			managers.hud._hud_assault_corner.pd2or_panel:set_top(managers.hud._hud_assault_corner._hostages_bg_box:bottom() + 30 + correction_y)
		    managers.hud._hud_assault_corner.other_pd2or_panel:set_top(managers.hud._hud_assault_corner.pd2or_panel:bottom() - 60)
		end

		local file = io.open("mods/PD2OnlineRadio/Radio/OnlineRadio.txt", "r")
		if file then
		    managers.hud._hud_assault_corner.pd2or_text:set_color(Color(255, 0, 255, 0) / 255)
			managers.hud._hud_assault_corner.pd2or_text:set_text("" .. file:read())
	    end

		managers.hud._hud_assault_corner.other_pd2or_text:set_text("Hotkey for Pay Day 2 Online Radio: (Ctrl+P)\nChat command: RADIO!")
		managers.hud._hud_assault_corner.other_pd2or_text:set_color(Color(1, 0.75, 0.75, 0.75))
	end
end

local fileCheckEnabled = io.open("mods/PD2OnlineRadio/Radio/OnlineRadioCheck.txt", "r")
if fileCheckEnabled:read() == "true" then
    SoundDevice:set_rtpc("option_music_volume", 0)
else
    SoundDevice:set_rtpc("option_music_volume", 100)
end
