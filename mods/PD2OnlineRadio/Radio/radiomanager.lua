PD2OR = {}
PD2OR.Savefile = SavePath .. "PD2OR_Options.txt"

PD2OR.Localization = {}
PD2OR.Localization.Russian = ModPath .. "Translate/Russian.txt"
PD2OR.Localization.English = ModPath .. "Translate/English.txt"
PD2OR.Data = {}

function PD2OR:Save()
	local file = io.open( self.Savefile , "w+")
	if file then
		file:write(json.encode(PD2OR.Data))
		file:close()
	end
end

function PD2OR:Load()
local file = io.open( self.Savefile , "r")
	if file then
		for k, v in pairs(json.decode(file:read("*all")) or {}) do
			if k then
				PD2OR.Data[k] = v
			end
		end
		file:close()
	end
end

MenuCallbackHandler.PD2OR_Size_Callback = function(self, item)
	PD2OR.Data.PD2OR_Size_Value = item:value()
	PD2OR:Save()
end

MenuCallbackHandler.PD2OR_Pos_X_Callback = function(self, item)
	PD2OR.Data.PD2OR_Pos_X_Value = item:value()
	PD2OR:Save()
end

MenuCallbackHandler.PD2OR_Pos_Y_Callback = function(self, item)
	PD2OR.Data.PD2OR_Pos_Y_Value = item:value()
	PD2OR:Save()
end

MenuCallbackHandler.PD2OR_Pos_Reset_Callback = function(self, item)
    MenuHelper:ResetItemsToDefaultValue( item, {["PD2OR_Size"] = true}, 0 )
	MenuHelper:ResetItemsToDefaultValue( item, {["PD2OR_Pos_X"] = true}, 0 )
	MenuHelper:ResetItemsToDefaultValue( item, {["PD2OR_Pos_Y"] = true}, 0 )
end

PD2OR:Load()

Hooks:Add("LocalizationManagerPostInit", "PD2OR_Localization", function(loc)
    local fileCheckLang = io.open("mods/PD2OnlineRadio/Radio/OnlineRadioCheckLang.txt", "r")
	if fileCheckLang:read() == "ru" then
		loc:load_localization_file( PD2OR.Localization.Russian )
	else
		loc:load_localization_file( PD2OR.Localization.English )
	end
end)

MenuHelper:LoadFromJsonFile(ModPath .. "/Radio/PD2OR.json", PD2OR, PD2OR.Data)