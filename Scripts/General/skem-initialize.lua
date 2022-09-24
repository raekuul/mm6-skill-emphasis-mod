-- SKEM INITIALIZE
-- reads settings from mm6.ini File 

local ini = require "inifile"

local UPDATE_INI = false

local PRESETS = {
	["ImprovedQuestItems"] = true,
	["RandomizeMapClusters"] = false,
	["AdaptiveMonsterStats"] = "disabled",
	["ResistancesDisplayMode"] = "default",
	["EasierMonsters"] = false,
	["MoreLinkedSkills"] = false,
	["ShowDiceInSpellDescription"] = false,
	["MonsterExperienceMultiplier"] = 1.09,
}

SETTINGS = { }

local INIT = ini.parse("mm6.ini")

if not (INIT["Skill Emphasis"] == nil) then
	for k,v in pairs(PRESETS) do
		if (INIT["Skill Emphasis"][k] == nil) then
			UPDATE_INI = true
			v = PRESETS[k]
		end
		INIT["Skill Emphasis"][k] = v
		SETTINGS[k] = v
	end
	ini.save("mm6.ini",INIT)
else
	UPDATE_INI = true
	INIT["Skill Emphasis"] = {}
	for k,v in pairs(PRESETS) do
		SETTINGS[k] = v
		INIT["Skill Emphasis"][k] = v
	end
end

if not (UPDATE_INI == false) then
	ini.save("mm6.ini",INIT)
end
