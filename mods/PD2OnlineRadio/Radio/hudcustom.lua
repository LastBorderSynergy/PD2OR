Hooks:PostHook( HUDAssaultCorner, "init", "PD2OnlineRadio", function(self, hud, full_hud, tweak_hud)
    self._pd2or_panel_color = Color(178, 0, 255, 0) / 255

    self.pd2or_panel = self._hud_panel:panel({
		visible = true,
		name = "pd2or_panel",
		w = 450,
		h = 100,
		color = self._pd2or_panel_color
	})

	self.other_pd2or_panel = self._hud_panel:panel({
		visible = true,
		name = "other_pd2or_panel",
		w = 400,
		h = 100,
		color = self._pd2or_panel_color
	})
	
    self._pd2or_panel_box = HUDBGBox_create(self.pd2or_panel, {
		w = 450,
		h = 38,
		x = 0,
		y = 0
	}, {
		visible = true,
		blend_mode = "add"
	})
	
	self.pd2or_text = self._pd2or_panel_box:text({
		name = "pd2or_text",
		text = "PD2OR - Offline",
		valign = "center",
		align = "left",
		vertical = "center",
		w = self._pd2or_panel_box:w(),
		h = self._pd2or_panel_box:h(),
		layer = 1,
		x = 10,
		y = 0,
		color = Color.white,
		font = tweak_data.hud_corner.assault_font,
		font_size = tweak_data.hud_corner.numhostages_size
	})

	self.other_pd2or_text = self.other_pd2or_panel:text({
		name = "other_pd2or_text",
		text = "Hotkey for Pay Day 2 Online Radio: (Ctrl+P)\nChat command show to all your music: RADIO!",
		valign = "center",
		align = "left",
		vertical = "center",
		w = self._pd2or_panel_box:w(),
		h = self._pd2or_panel_box:h(),
		layer = 1,
		x = 10,
		y = 0,
		color = Color.white,
		font = tweak_data.hud_corner.assault_font,
		font_size = 14
	})
	
    self.pd2or_panel:set_top(self._hostages_bg_box:bottom() + 30)
    self.pd2or_panel:set_left(self._hostages_bg_box:left() + 21)
	
    self.other_pd2or_panel:set_top(self.pd2or_panel:bottom() - 60)
    self.other_pd2or_panel:set_left(self.pd2or_panel:left() - 8)
end )
