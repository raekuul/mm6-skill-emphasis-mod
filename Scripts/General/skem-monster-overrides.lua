-- Monster Customization stuff from Skill Emphasis Mod
-- supersedes lines 2279 - 2479 in skill-mod.lua

--[[ 2022-09-08
	Added override entries for Merchant and PeasantF2.

]] 

--[[ EASY MODE
	Shallower curves for the Damage Multiplier, and Energy attacks are not multiplied
	Every monster will drop at least 1 gold, and increases the number of dice rolled for gold drops by 1
	Scales resistances so that they're relative to the resist cap, instead of only reducing immunity to the resist cap
	Forces all flying monsters to attempt to engage in melee 
]]

local EASY_OVERRIDES = false

--[[ ADAPTIVE MODE
	ADAPTIVE = false -- adaptive monster multipliers, relative to derived average map level.  This is the default as of 0.8.5
	ADAPTIVE = true -- adaptive monster multipliers, relative to derived average party level
	ADAPTIVE = nil -- static monster multipliers relative to monster level; this is the pre-0.8.5 behavior
]]

local ADAPTIVE = false

-- the resist_cap is the highest resistance that generic monsters are allowed to have
-- in the absence of core Skill Emphasis (or other immunity removal mods), "Unique" monsters are still allowed to be immune to stuff
resist_cap = 120

-- EnergyMod
-- This is a divisor applied to Energy attacks
-- the larger this number, the weaker Energy attacks become
-- if EASY_OVERRIDES == true, this is ignored entirely (under Easy Mode, energy attacks are not multiplied at all)
EnergyMod = 2

-- base multipliers
-- these multipliers are applied after monster customizations and EZ-exclusive tech are applied
-- defaults are 2 for Health, 2 for Gold, 1 for Armor, 1.09 for Experience
-- Health/Armor/Gold functions will set the larger of vanilla or calculated, so base multipliers less than 1 do not apply 

baseHealthMultiplier = 2
baseArmorMultiplier = 1
baseGoldMultiplier = 2

-- Experience will always set calculated (to permit Zero Monster EXP games)
-- default is 1.09
baseExperienceMultiplier = 1.09

-- masteries text

local masteries =
{
	[const.Novice] = "n",
	[const.Expert] = "e",
	[const.Master] = "m",
}

-- attack types text

local attackTypes =
{
	[const.Damage.Phys] = "Phys",
	[const.Damage.Magic] = "Magic",
	[const.Damage.Fire] = "Fire",
	[const.Damage.Elec] = "Elec",
	[const.Damage.Cold] = "Cold",
	[const.Damage.Poison] = "Poison",
	[const.Damage.Energy] = "Energy",
}

resistanceTypes = { }
for k,v in pairs(attackTypes) do
	if not (v == "Energy")
	then
		resistanceTypes[v] = k
	end
end

-- missiles

local missiles =
{
	["Arrow"] = 1,
	["FireArrow"] = 2,
	["Fire"] = 3,
	["Elec"] = 4,
	["Cold"] = 5,
	["Poison"] = 6,
	["Energy"] = 7,
	["Magic"] = 8,
	["Rock"] = 9,
}

spellTxtIds = { }



local monsterInfos =
{
	--Maddening Eye
	[12] = {["SpellChance"] = 2, ["Spell"] = "Dispell Magic", ["SpellSkill"] = JoinSkill(10, const.Novice), },
	--Priest of Baa
	[16] = 
	{["Name"]= "Priest of Baa",["FullHP"] = 220,["Level"] = 40, ["ArmorClass"]=40,["Experience"]= 1144,["Attack1"] = {["Type"] = const.Damage.Elec, ["DamageDiceCount"] = 6, ["DamageDiceSides"] = 6, ["DamageAdd"] = 0, ["Missile"] = missiles["Elec"], },},
	--Bishop of Baa
	[17] = 
	{["Name"]= "Bishop of Baa",["FullHP"] = 340,["Level"] = 50,["ArmorClass"]=50,["Experience"]= 2375,["Attack1"] = {["Type"] = const.Damage.Elec, ["DamageDiceCount"] = 7, ["DamageDiceSides"] = 6, ["DamageAdd"] = 5, ["Missile"] = missiles["Elec"], },["Spell"] = "Harm", ["SpellSkill"] = JoinSkill(6, const.Master),},
	--Cardinal of Baa
	[18] = 
	{["Name"]= "Cardinal of Baa",["FullHP"] = 510,["Level"] =60,["ArmorClass"]=60,["Experience"]= 4000,["Attack1"] = {["Type"] = const.Damage.Elec, ["DamageDiceCount"] = 10, ["DamageDiceSides"] = 6, ["DamageAdd"] = 10, ["Missile"] = missiles["Elec"], },["Spell"] = "Flying Fist", ["SpellSkill"] = JoinSkill(6, const.Master),},
	--devil captain
	[25] = {["FullHP"] = 650,["Level"] = 70,["ArmorClass"]=60, ["Attack1"] = {["Type"] = const.Damage.Phys, ["DamageDiceCount"] = 6, ["DamageDiceSides"] = 6, ["DamageAdd"] = 0,},["PhysResistance"] = 200, ["FireResistance"] = 50,},
	--Devil Master
	[26] = {["FullHP"] = 850,["Level"] = 85,["ArmorClass"]=80, ["Attack1"] = {["Type"] = const.Damage.Phys, ["DamageDiceCount"] = 7, ["DamageDiceSides"] = 8, ["DamageAdd"] = 20,},["SpellChance"] = 20, ["Spell"] = "Meteor Shower", ["SpellSkill"] = JoinSkill(3, const.Master),["PhysResistance"] = 200, ["FireResistance"] = 50,},	
	--Devil King
	[27] = { ["FullHP"] = 1050,["Level"] = 100,["ArmorClass"]=100, ["Attack1"] = {["Type"] = const.Damage.Phys, ["DamageDiceCount"] = 10, ["DamageDiceSides"] = 8, ["DamageAdd"] = 20,}, ["PhysResistance"] = 200, ["FireResistance"] = 50, ["BonusMul"] = 0, },
	--devil Spawn
	[28] = {["FullHP"] = 80,["Level"] = 50,["ArmorClass"]=40,["Experience"]= 2800, ["Attack1"] = {["Type"] = const.Damage.Phys, ["DamageDiceCount"] = 4, ["DamageDiceSides"] = 6, ["DamageAdd"] = 8,},["SpellChance"] = 20, ["Spell"] = "Fire Bolt", ["SpellSkill"] = JoinSkill(8, const.Master),},
	--devil Worker
	[29] = {["FullHP"] = 290,["Level"] = 70,["ArmorClass"]=60,["Experience"]= 6800, ["Attack1"] = {["Type"] = const.Damage.Phys, ["DamageDiceCount"] = 5, ["DamageDiceSides"] = 6, ["DamageAdd"] = 20,},["SpellChance"] = 20, ["Spell"] = "Fire Bolt", ["SpellSkill"] = JoinSkill(14, const.Master),},
	--devil Warrior
	[30] = {["FullHP"] = 450,["Level"] = 90,["ArmorClass"]=80,["Experience"]= 9500, ["Attack1"] = {["Type"] = const.Damage.Phys, ["DamageDiceCount"] = 5, ["DamageDiceSides"] = 6, ["DamageAdd"] = 30,},["SpellChance"] = 20, ["Spell"] = "Fireball", ["SpellSkill"] = JoinSkill(12, const.Master), ["BonusMul"] = 0, },
	--Defender of VARN
	[88] = {["SpellChance"] = 20, ["Spell"] = "Psychic Shock", ["SpellSkill"] = JoinSkill(4, const.Master), },
	--Sentinel of VARN
	[89] = {["SpellChance"] = 20, ["Spell"] = "Psychic Shock", ["SpellSkill"] = JoinSkill(6, const.Master), },
	--Guardian of VARN
	[90] = {["SpellChance"] = 20, ["Spell"] = "Psychic Shock", ["SpellSkill"] = JoinSkill(7, const.Master), },
	--Lich
	[94] = {["SpellChance"] = 1, ["Spell"] = "Dispell Magic", ["SpellSkill"] = JoinSkill(10, const.Novice), },
	--Greater Lich
	[95] = {["SpellChance"] = 1, ["Spell"] = "Dispell Magic", ["SpellSkill"] = JoinSkill(10, const.Novice), },
	--Gorgon
	[102] = {["SpellChance"] = 30, ["Spell"] = "Psychic Shock", ["SpellSkill"] = JoinSkill(5, const.Master), },
	--Minotaur
	[106] = {["Attack1"] = {["Type"] = const.Damage.Phys, ["DamageDiceCount"] = 3, ["DamageDiceSides"] = 7, ["DamageAdd"] = 25,},},
	--Minotaur Mage
	[107] = {["Attack1"] = {["Type"] = const.Damage.Phys, ["DamageDiceCount"] = 6, ["DamageDiceSides"] = 7, ["DamageAdd"] = 28,},},
	--Minotaur King
	[108] = {["Attack1"] = {["Type"] = const.Damage.Phys, ["DamageDiceCount"] = 9, ["DamageDiceSides"] = 7, ["DamageAdd"] = 36,},},
	--Titan
	[166] = {["Attack1"] = {["Type"] = const.Damage.Elec, ["DamageDiceCount"] = 7, ["DamageDiceSides"] = 20, ["DamageAdd"] = 10,["Missile"] = missiles["Elec"],},["SpellChance"] = 50, ["Spell"] = "Psychic Shock", ["SpellSkill"] = JoinSkill(8, const.Master), },
	--Noble Titan
	[167] = {["Attack1"] = {["Type"] = const.Damage.Elec, ["DamageDiceCount"] = 8, ["DamageDiceSides"] = 20, ["DamageAdd"] = 20,["Missile"] = missiles["Elec"],},["SpellChance"] = 50, ["Spell"] = "Psychic Shock", ["SpellSkill"] = JoinSkill(9, const.Master), },
	--Supreme Titan
	[168] = {["Attack1"] = {["Type"] = const.Damage.Elec, ["DamageDiceCount"] = 11, ["DamageDiceSides"] = 20, ["DamageAdd"] = 30,["Missile"] = missiles["Elec"],},["SpellChance"] = 50, ["Spell"] = "Psychic Shock", ["SpellSkill"] = JoinSkill(13, const.Master), },
	-- Follower of Baa
	[139] = {["SpellChance"] = 10, ["Spell"] = "Mind Blast", ["SpellSkill"] = JoinSkill(1, const.Novice), },
	-- Mystic of Baa
	[140] = {["SpellChance"] = 30, ["Spell"] = "Mind Blast", ["SpellSkill"] = JoinSkill(2, const.Novice), },
	-- Fanatic of Baa
	[141] = {["SpellChance"] = 50, ["Spell"] = "Mind Blast", ["SpellSkill"] = JoinSkill(3, const.Novice), },
	-- Cannibal (female)
	[130] = {["SpellChance"] = 10, ["Spell"] = "Deadly Swarm", ["SpellSkill"] = JoinSkill(1, const.Novice), },
	-- Head Hunter (female)
	[131] = {["SpellChance"] = 20, ["Spell"] = "Deadly Swarm", ["SpellSkill"] = JoinSkill(2, const.Novice), },
	-- Witch Doctor (female)
	[132] = {["SpellChance"] = 30, ["Spell"] = "Deadly Swarm", ["SpellSkill"] = JoinSkill(3, const.Novice), },
	-- Cannibal (male)
	[142] = {["SpellChance"] = 10, ["Spell"] = "Fire Bolt", ["SpellSkill"] = JoinSkill(1, const.Novice), },
	-- Head Hunter (male)
	[143] = {["SpellChance"] = 20, ["Spell"] = "Fire Bolt", ["SpellSkill"] = JoinSkill(2, const.Novice), },
	-- Witch Doctor (male)
	[144] = {["SpellChance"] = 30, ["Spell"] = "Fire Bolt", ["SpellSkill"] = JoinSkill(3, const.Novice), },
	--Malekith rebalance
	--skeleton
	[154] = {["SpellChance"] = 10, ["Spell"] = "Flame Arrow", ["SpellSkill"] = JoinSkill(1, const.Novice), },
	-- Skeleton Knight
	[155] = {["SpellChance"] = 20, ["Spell"] = "Flame Arrow", ["SpellSkill"] = JoinSkill(2, const.Novice), },
	-- Skeleton Lord
	[156] = {["SpellChance"] = 30, ["Spell"] = "Flame Arrow", ["SpellSkill"] = JoinSkill(3, const.Novice), },
	--Magyar
	 [  4] = {["SpellChance"] = 10, ["Spell"] = "Lightning Bolt", ["SpellSkill"] = JoinSkill(4, const.Master), },
	-- Magyar Soldier
	 [  5] = {["SpellChance"] = 20, ["Spell"] = "Lightning Bolt", ["SpellSkill"] = JoinSkill(6, const.Master), },
	-- Goblin
	[ 76] = {["SpellChance"] = 10, ["Spell"] = "Fire Bolt", ["SpellSkill"] = JoinSkill(1, const.Novice), },
	-- Goblin Shaman
	[ 77] = {["SpellChance"] = 20, ["Spell"] = "Fire Bolt", ["SpellSkill"] = JoinSkill(2, const.Novice), },
	-- Goblin King
	[ 78] = {["SpellChance"] = 30, ["Spell"] = "Fire Bolt", ["SpellSkill"] = JoinSkill(3, const.Novice), },
	-- Ghost
	[ 73] = {["SpellChance"] = 10, ["Spell"] = "Spirit Arrow", ["SpellSkill"] = JoinSkill(1, const.Novice), },
	-- Evil Spirit
	[ 74] = {["SpellChance"] = 20, ["Spell"] = "Spirit Arrow", ["SpellSkill"] = JoinSkill(2, const.Novice), },
	-- Specter
	[ 75] = {["SpellChance"] = 30, ["Spell"] = "Spirit Arrow", ["SpellSkill"] = JoinSkill(3, const.Novice), },
	-- steal crash workaround	
	-- Cutpurse
	[127] = {["Bonus"] = 0, ["BonusMul"] = 0},
	-- Bounty Hunter
	[128] = {["Bonus"] = 0, ["BonusMul"] = 0},
	-- Thief
	[163] = {["Bonus"] = 0, ["BonusMul"] = 0},
	-- Burglar
	[164] = {["Bonus"] = 0, ["BonusMul"] = 0},
	-- Rogue
	[165] = {["Bonus"] = 0, ["BonusMul"] = 0},

	--The Unpeasanting
	[103] = {["Name"] = "Manservant", ["Level"] = 4,},
	[104] = {["Name"] = "Craftsman", ["Level"] = 6,},
	[105] = {["Name"] = "Merchantman", ["Level"] = 10, },

	[124] = {["Name"] = "Maidservant", ["Level"] = 2, },
	[125] = {["Name"] = "Craftswoman", ["Level"] = 6, },
	[126] = {["Name"] = "Merchantess", ["Level"] = 10, },
}

function traverseTable(input)
	if not (type(input) == table)
	then
		return input
	else
		output = { }
		for key, value in pairs(input) do
			output[key] = traverseTable(input[key])
		end
		return output
	end
end

function calculateTierLevelOffset(monsterArray)
	id = monsterArray["Id"]
	name = monsterArray["Name"]
	genericArray = Game.MonstersTxt[id]
	if not (name == genericArray["Name"])
	then
		return 10
	else
		pic = genericArray["Picture"]
		tier = string.sub(pic, -1)
		if (tier == "A")
		then
			tierBLev = Game.MonstersTxt[id+1]["Level"]
			return genericArray["Level"] - tierBLev
		elseif (tier == "C")
		then
			tierBLev = Game.MonstersTxt[id-1]["Level"]
			return genericArray["Level"] - tierBLev
		else
		return 0
		end
	end
end

function calculateMonsterArmor(monsterArray)
	oldArmor = monsterArray["ArmorClass"]
	newArmor = oldArmor * baseArmorMultiplier
	return newArmor
end

function calculateMovespeed(monsterArray) 
	speed = monsterArray["MoveSpeed"]
	if (monsterArray["Attack1"]["Missile"] == 0)
	then
		speed = (speed + (400 - speed) / 2 + 100) * 101 / 100
	else
		speed = speed * 99 / 100
	end
	return speed
end

function applyMonsterResistanceAdjustments(MonsterID, easy_flag)
	for k,_ in pairs(resistanceTypes)
	do
		key = k .. "Resistance"
		value = Game.MonstersTxt[MonsterID][key]
		if (easy_flag == true) 
		then
			Game.MonstersTxt[MonsterID][key] = value * resist_cap / 200
		else
			Game.MonstersTxt[MonsterID][key] = math.min(value, resist_cap)
		end
	end
end

function calculatePartyAverage()
	total_exp = 0
	for i=0, 3 
	do
		total_exp = total_exp + Party.Players[i].Experience
	end
	average = total_exp / 4
	level = math.floor((1 + math.sqrt(1 + (4 * average/ 500))) / 2)
	return level
end

function calculateAdjustedAverage(total_levels, total_monsters)
	naive = (total_levels / total_monsters)
	local total = 0
	local sd = 0
	for i = 0, Map.Monsters.High do
		monster = Map.Monsters[i]
		name = monster.Name
		if not (name == "Peasant")
		then
			level = monster.Level
			sd = sd + (level - naive)^2
		end
	end
	return (naive + (sd/total_monsters) ^(1/2) * 0.68)
end

function calculateMapAverage()
	total_levels = 0
	total_monsters = 0
	debug_string = ""

	for i=0, Map.Monsters.High
	do
		if not (Map.Monsters[i].Name == "Peasant")
		then
			total_monsters = total_monsters + 1
			total_levels = total_levels + Map.Monsters[i].Level
		end
	end

	mapAvgLevel = calculateAdjustedAverage(total_levels, total_monsters)
	return mapAvgLevel
end

function getAdaptiveMultiplier(switch)
	if (switch == true)
	then
		mode = "Party"
		output = calculatePartyAverage()
	elseif (switch == false)
	then
		mode = "Map"
		output = calculateMapAverage()
	else
		mode = "Unknown"
		error("Recoverable error - Adaptive Mode ".. tostring(switch) .. " not yet handled.",2) 
		output = 1
	end
	
	return output
end

function calculateDamageMultiplier(level, divisor, constant)
	multiplier = (level + 5) / divisor + constant
	return multiplier
end

function calculateMonsterExperience(monsterArray)
	old_exp = monsterArray["Experience"]
	new_exp = old_exp * baseExperienceMultiplier
	return new_exp
end

function calculateMonsterHealth(monsterArray)
	level = monsterArray["Level"]
	oldHealth = monsterArray["FullHitPoints"]
	
	lookupID = monsterArray["Id"]
	pic = Game.MonstersTxt[lookupID]["Picture"]
	tier = string.sub(pic, -1)
	
	if (tier == "A")
	then
		tier3Level = Game.MonstersTxt[lookupID + 2]["Level"]
	elseif (tier == "B")
	then
		tier3Level = Game.MonstersTxt[lookupID + 1]["Level"]
	else
		tier3Level = level
	end
	
	if (tier3Level >= (level * 2))
	then
		healthMod = tier3Level/(level * 5)
	else
		healthMod = 0
	end
		
	newHealth = level * (3 * level / 10) * (baseHealthMultiplier + healthMod)
	return math.max(newHealth, 1)
end

function calculateMonsterDamageMultipliers(monsterArray, easy_flag)
	lookupID = monsterArray["Id"]
	pic = Game.MonstersTxt[lookupID]["Picture"]
	tier = string.sub(pic, -1)
	
	divisor = 20
	constant = 1.75

	if (easy_flag == true)
	then
		divisor = 25
		constant = 1.25
	end
	
	if (tier == "A")
	then
		Monster2ID = lookupID + 1
	elseif (tier == "C")
	then
		Monster2ID = lookupID - 1
	else
		Monster2ID = lookupID
	end
	monsterLevel = Game.MonstersTxt[Monster2ID]["Level"]
	
	damageMultiplier = calculateDamageMultiplier(monsterLevel, divisor, constant)
	rankMultiplier = calculateDamageMultiplier(monsterLevel, 30, 1)
	return damageMultiplier, rankMultiplier
end

function calculateMonsterTreasures(monsterArray, easy_flag)
	if (easy_flag == true)
	then 
		extraBonus = 1
	else
		extraBonus = 0
	end

	baseDice = math.max(monsterArray["TreasureDiceCount"], extraBonus)
	baseSides = math.max(monsterArray["TreasureDiceSides"], extraBonus)
	
	sides = baseSides
	dice = math.min(baseDice * baseGoldMultiplier,250) 

	return dice, sides
end

function applyMonsterDamageMultipliers(monsterArray, damageMultiplier, rankMultiplier, easy_flag)
	genericForm = Game.MonstersTxt[monsterArray["Id"]]

	for i=1,2 do
		key = "Attack" .. i
		resist = genericForm[key]["Type"]
		sides = genericForm[key]["DamageDiceSides"]
		bonus = genericForm[key]["DamageAdd"] 
		if (resist == const.Damage.Energy)
		then
			if (easy_flag == true)
			then -- if it's easy mode, we don't apply any multipliers to Energy attacks
				sides = sides
				bonus = bonus 
			else -- if it's not easy mode, we apply multipliers and then divide by EnergyMod
				sides = sides * damageMultiplier / EnergyMod
				bonus = math.min(bonus * damageMultiplier / EnergyMod, 250)
			end
		else -- if it's not an energy attack, the usual math applies
			sides = sides * damageMultiplier
			bonus = math.min(bonus * damageMultiplier, 250)
		end
		monsterArray[key]["DamageDiceSides"] = sides
		monsterArray[key]["DamageAdd"] = bonus
	end
	
	if not(genericForm["SpellChance"] == 0)
	then
		local rank, mastery = SplitSkill(genericForm["SpellSkill"])
		
		if (easy_flag == true)
		then
			rank = math.max(1, math.floor(rank * rankMultiplier * 60 / 63))
		else
			rank = math.ceil(math.min(rank * rankMultiplier, 60))
		end
	
		monsterArray["SpellSkill"] = JoinSkill(rank, mastery)
	end
end

function applyStaticMonsterOverrides(monsterID, easy_flag)
	monsterArray = Game.MonstersTxt[monsterID]
	i = monsterArray["Id"]
	
	monsterArray["offset"] = calculateTierLevelOffset(monsterArray)
	offset = monsterArray["offset"]
	
	-- set manual overrides first, so that they get iterated upon
	if not (monsterInfos[i] == nil)
	then
		monsterInfos[i]["Spell"] = spellTxtIds[monsterInfos[i]["Spell"]]
		for k,v in pairs(monsterInfos[i]) do
			if not (type(monsterArray[k]) == table)
			then
				monsterArray[k] = v
			else
				monsterArray[i][k] = traverseTable(v)
			end
		end
	end

	-- resistances
	applyMonsterResistanceAdjustments(monsterID, easy_flag)
	
	-- damage multipliers; calculated using a different level for Adaptive mode
	if ADAPTIVE == nil
	then
		local damageMultiplier, rankMultiplier = calculateMonsterDamageMultipliers(monsterArray, easy_flag)
		applyMonsterDamageMultipliers(monsterArray, damageMultiplier, rankMultiplier, easy_flag)
	end
	
	-- other static adjustments
	monsterArray["Experience"] = calculateMonsterExperience(monsterArray)
	monsterArray["Exp"] = calculateMonsterExperience(monsterArray)
	monsterArray["TreasureDiceCount"], monsterArray["TreasureDiceSides"] = calculateMonsterTreasures(monsterArray, easy_flag)
	monsterArray["FullHitPoints"] = calculateMonsterHealth(monsterArray)
	monsterArray["ArmorClass"] = calculateMonsterArmor(monsterArray)
	
	-- these changes are exclusive to easy mode
	if easy_flag == true
	then
		-- under easy mode, all fliers are melee
		if (monsterArray["Fly"] == 1 and not (monsterArray["Attack1"]["Missile"] == 0))
		then
			monsterArray["Attack1"]["Missile"] = 0
		end
	end
	
	-- always end with movespeed adjustments, since they depend on other adjustments
	monsterArray["MoveSpeed"] = calculateMovespeed(monsterArray)

	for k,v in pairs(monsterArray) do
		if not (type(monsterArray[k]) == table)
		then
			Game.MonstersTxt[monsterID][k] = v
		else
			Game.MonstersTxt[monsterID][k] = traverseTable(v)
		end
	end
end

function applyAdaptiveMonsterOverrides(monsterID, monsterArray, adaptive_level)

	genericForm = Game.MonstersTxt[monsterArray["Id"]]

	oldLevel = math.max(genericForm["Level"],1)
	offset = calculateTierLevelOffset(genericForm)
	newLevel = math.max(1, adaptive_level + offset)
	monsterArray["Level"] = newLevel
	
	levelMultiplier = (newLevel) / (oldLevel)
	
	local damageMultiplier, rankMultiplier = calculateMonsterDamageMultipliers(monsterArray, easy_flag)
	applyMonsterDamageMultipliers(monsterArray, damageMultiplier, rankMultiplier, easy_flag)

	monsterArray["FullHP"] = calculateMonsterHealth(monsterArray)

	monsterArray["HP"] = monsterArray["FullHP"]

	monsterArray["ArmorClass"] = genericForm["ArmorClass"] * levelMultiplier

	monsterArray["Experience"] = genericForm["Experience"] * levelMultiplier
	monsterArray["Exp"] = monsterArray["Exp"] * levelMultiplier

	monsterArray["TreasureDiceCount"] = genericForm["TreasureDiceCount"] * levelMultiplier
	
	if (adaptive_level > genericForm["Level"])
	then
		for k,_ in pairs(resistanceTypes)
		do
			if not (k == "Energy")
			then
				key = k .. "Resistance"
				value = monsterArray[key]
				value = value * (adaptive_level + 100)/(genericForm["Level"] + 100) + (adaptive_level - genericForm["Level"])/2
				monsterArray[key] = value
			end
		end
	end

	for k,v in pairs(monsterArray) do
		if not (type(monsterArray[k]) == table)
		then
			Map.Monsters[monsterID][k] = v
		else
			Map.Monsters[monsterID][k] = traverseTable(v)
		end
	end
end

function events.GameInitialized2()
	for spellTxtId = 1, Game.SpellsTxt.high do
		spellTxtIds[Game.SpellsTxt[spellTxtId].Name] = spellTxtId
	end
	for monsterID = 1, Game.MonstersTxt.high do
		applyStaticMonsterOverrides(monsterID, EASY_OVERRIDES)
	end
end

function events.LoadMap()
	if ((ADAPTIVE == true) or (ADAPTIVE == false))
	then
		adaptive_level = getAdaptiveMultiplier(ADAPTIVE)
		
		if (ADAPTIVE == true) 
		then 
			if not (mapvars["adaptive"] == nil)
			then
				if not (adaptive_level > (mapvars["adaptive"] + 10))
				then
					adaptive_level = mapvars["adaptive"]
				else
					mapvars["adaptive"] = adaptive_level
				end
			else
				mapvars["adaptive"] = adaptive_level
			end
		end
		for monsterID = 0, Map.Monsters.high do
			monsterArray = Map.Monsters[monsterID]
			if not (monsterArray.Name == "Peasant")
			then
				applyAdaptiveMonsterOverrides(monsterID, monsterArray, adaptive_level)
			end
		end
	end
end
