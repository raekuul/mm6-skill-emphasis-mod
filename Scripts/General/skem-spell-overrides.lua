--[[ 
	Skill Emphasis Mod - RawSugar's Spell Overrides
	Supersedes various parts of Core; segments list lines to remove from 0.8.2
]]

local spellTxtIds = {}



-- helper functions

local function GetPlayer(p)
	local i = (p - Party.PlayersArray["?ptr"]) / Party.PlayersArray[0]["?size"]
	return i, Party.PlayersArray[i]
end

local function GetMonster(p)
	if p == 0 then
		return
	end
	local i = (p - Map.Monsters["?ptr"]) / Map.Monsters[0]["?size"]
	return i, Map.Monsters[i]
end

local function GetMonsterTxt(p)
	if p == 0 then
		return
	end
	local i = (p - Game.MonstersTxt["?ptr"]) / Game.MonstersTxt[0]["?size"]
	return i, Game.MonstersTxt[i]
end
--[[ for more precise spell description code; need to figure out tech for this
local function getAttackSpellRange(p,spellID)
	player = GetPlayer(p)
	spell = Game.Spells[spellID]
	spellTxt = Game.SpellsTxt[spellID]

	spellGroup = 

	rank, mastery = splitSkill
end
]]
-- randomSpellPower
-- supersedes skill-mod.lua:1095-1101

local function randomSpellPower(spellPower, level)
	local r = math.random(spellPower.fixedMin, spellPower.fixedMax)
	for i = 1, level do
		r = r + math.random(spellPower.variableMin, spellPower.variableMax)
	end
	return r
end

-- Spell Powers
-- supersedes skill-mod.lua:374-637

local protectionSpellExtraMultiplier = 1

local spellResists =
{
	[70] = const.Damage.Phys,
	[76] = const.Damage.Phys,
--	[80] = const.Damage.Energy
}

local spellDelays =
{
	
}

local spellPowers =
{
	-- Flame Arrow
	[2] =
	{
		[const.Novice] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 2, },
		[const.Expert] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 2, },
		[const.Master] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 2, },
	},
	-- Fire Bolt
	[4] =
	{
		[const.Novice] = {fixedMin = 8, fixedMax = 8, variableMin = 1, variableMax = 5, },
		[const.Expert] = {fixedMin = 8, fixedMax = 8, variableMin = 1, variableMax = 5, },
		[const.Master] = {fixedMin = 8, fixedMax = 8, variableMin = 1, variableMax = 5, },
	},
	--Fireball
	[6] =
	{
		[const.Novice] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 6, },
		[const.Expert] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 6, },
		[const.Master] = {fixedMin = 12, fixedMax = 12, variableMin = 1, variableMax = 9, },
	},
	-- Ring of Fire
	[7] =
	{
		[const.Novice] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 3, },
		[const.Expert] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 3, },
		[const.Master] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 3, },
	},
	-- Fire Blast
	[8] =
	{
		[const.Novice] = {fixedMin = 4, fixedMax = 4, variableMin = 1, variableMax = 4, },
		[const.Expert] = {fixedMin = 4, fixedMax = 4, variableMin = 1, variableMax = 4, },
		[const.Master] = {fixedMin = 4, fixedMax = 4, variableMin = 1, variableMax = 4, },
	},
	-- Meteor Shower
	[9] =
	{
		[const.Novice] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 3, },
		[const.Expert] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 3, },
		[const.Master] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 3, },
	},
	-- Inferno
	[10] =
	{
		[const.Novice] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 4, },
		[const.Expert] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 4, },
		[const.Master] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 4, },
	},
	-- Incinerate
	[11] =
	{
		[const.Novice] = {fixedMin = 32, fixedMax = 32, variableMin = 1, variableMax = 21, },
		[const.Expert] = {fixedMin = 32, fixedMax = 32, variableMin = 1, variableMax = 21, },
		[const.Master] = {fixedMin = 32, fixedMax = 32, variableMin = 1, variableMax = 21, },
	},
	-- Static Charge
	[13] =
	{
		[const.Novice] = {fixedMin = 5, fixedMax = 5, variableMin = 1, variableMax = 1, },
		[const.Expert] = {fixedMin = 12, fixedMax = 12, variableMin = 1, variableMax = 1, },
		[const.Master] = {fixedMin = 20, fixedMax = 20, variableMin = 1, variableMax = 1, },
	},
	-- Sparks
	[15] =
	{
		[const.Novice] = {fixedMin = 3, fixedMax = 3, variableMin = 1, variableMax = 2, },
		[const.Expert] = {fixedMin = 3, fixedMax = 3, variableMin = 1, variableMax = 2, },
		[const.Master] = {fixedMin = 3, fixedMax = 3, variableMin = 1, variableMax = 2, },
	},
	-- Lightning Bolt
	[18] =
	{
		[const.Novice] = {fixedMin = 15, fixedMax = 15, variableMin = 1, variableMax = 9, },
		[const.Expert] = {fixedMin = 15, fixedMax = 15, variableMin = 1, variableMax = 9, },
		[const.Master] = {fixedMin = 15, fixedMax = 15, variableMin = 1, variableMax = 9, },
	},
	-- Implosion
	[20] =
	{
		[const.Novice] = {fixedMin = 18, fixedMax = 18, variableMin = 1, variableMax = 13, },
		[const.Expert] = {fixedMin = 18, fixedMax = 18, variableMin = 1, variableMax = 13, },
		[const.Master] = {fixedMin = 18, fixedMax = 18, variableMin = 1, variableMax = 13, },
	},
	-- Cold Beam
	[24] =
	{
		[const.Novice] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 3, },
		[const.Expert] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 3, },
		[const.Master] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 3, },
	},
	-- Poison Spray
	[26] =
	{
		[const.Novice] = {fixedMin = 4, fixedMax = 4, variableMin = 1, variableMax = 2, },
		[const.Expert] = {fixedMin = 4, fixedMax = 4, variableMin = 1, variableMax = 2, },
		[const.Master] = {fixedMin = 4, fixedMax = 4, variableMin = 1, variableMax = 2, },
	},
	-- Ice Bolt
	[28] =
	{
		[const.Novice] = {fixedMin = 12, fixedMax = 12, variableMin = 1, variableMax = 8, },
		[const.Expert] = {fixedMin = 12, fixedMax = 12, variableMin = 1, variableMax = 8, },
		[const.Master] = {fixedMin = 12, fixedMax = 20, variableMin = 1, variableMax = 8, },
	},
	-- Acid Burst
	[30] =
	{
		[const.Novice] = {fixedMin = 20, fixedMax = 20, variableMin = 1, variableMax = 12, },
		[const.Expert] = {fixedMin = 20, fixedMax = 20, variableMin = 1, variableMax = 12, },
		[const.Master] = {fixedMin = 20, fixedMax = 20, variableMin = 1, variableMax = 12, },
	},
	-- Ice Blast
	[32] =
	{
		[const.Novice] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 9, },
		[const.Expert] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 9, },
		[const.Master] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 9, },
	},
	-- Magic Arrow
	[35] =
	{
		[const.Novice] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 1, },
		[const.Expert] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 1, },
		[const.Master] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 1, },
	},
	-- Deadly Swarm
	[37] =
	{
		[const.Novice] = {fixedMin = 8, fixedMax = 8, variableMin = 1, variableMax = 5, },
		[const.Expert] = {fixedMin = 8, fixedMax = 8, variableMin = 1, variableMax = 5, },
		[const.Master] = {fixedMin = 8, fixedMax = 8, variableMin = 1, variableMax = 5, },
	},
	-- Blades
	[39] =
	{
		[const.Novice] = {fixedMin = 12, fixedMax = 12, variableMin = 1, variableMax = 8, },
		[const.Expert] = {fixedMin = 12, fixedMax = 12, variableMin = 1, variableMax = 8, },
		[const.Master] = {fixedMin = 12, fixedMax = 12, variableMin = 1, variableMax = 8, },
	},
	-- Death blossom
	[43] =
	{
		[const.Novice] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 11, },
		[const.Expert] = {fixedMin = 0, fixedMax = 0, variableMin = 2, variableMax = 11, },
		[const.Master] = {fixedMin = 0, fixedMax = 0, variableMin = 2, variableMax = 11, },
	},
	-- Spirit Arrow
	[45] =
	{
		[const.Novice] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 5, },
		[const.Expert] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 5, },
		[const.Master] = {fixedMin = 0, fixedMax = 0, variableMin = 1, variableMax = 5, },
	},
	-- Mind Blast
	[58] =
	{
		[const.Novice] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 6, },
		[const.Expert] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 6, },
		[const.Master] = {fixedMin = 6, fixedMax = 6, variableMin = 1, variableMax = 6, },
	},
	-- Psychic Shock
	[65] =
	{
		[const.Novice] = {fixedMin = 47, fixedMax = 47, variableMin = 1, variableMax = 30, },
		[const.Expert] = {fixedMin = 47, fixedMax = 47, variableMin = 1, variableMax = 30, },
		[const.Master] = {fixedMin = 47, fixedMax = 47, variableMin = 1, variableMax = 30, },
	},
	--[[ Harm
	[70] =
	{
		[const.Novice] = {fixedMin = 8, fixedMax = 8, variableMin = 1, variableMax = 4, },
		[const.Expert] = {fixedMin = 8, fixedMax = 8, variableMin = 1, variableMax = 4, },
		[const.Master] = {fixedMin = 8, fixedMax = 8, variableMin = 1, variableMax = 4, },
	},
	-- Flying Fist
	[76] =
	{
		[const.Novice] = {fixedMin = 30, fixedMax = 30, variableMin = 1, variableMax = 15, },
		[const.Expert] = {fixedMin = 30, fixedMax = 30, variableMin = 1, variableMax = 15, },
		[const.Master] = {fixedMin = 30, fixedMax = 30, variableMin = 1, variableMax = 15, },
	},]]
	-- Destroy Undead
	[82] =
	{
		[const.Novice] = {fixedMin = 50, fixedMax = 50, variableMin = 1, variableMax = 40, },
		[const.Expert] = {fixedMin = 50, fixedMax = 50, variableMin = 1, variableMax = 40, },
		[const.Master] = {fixedMin = 50, fixedMax = 50, variableMin = 1, variableMax = 40, },
	},
	-- Prismatic Light
	[84] =
	{
		[const.Novice] = {fixedMin = 25, fixedMax = 25, variableMin = 1, variableMax = 7, },
		[const.Expert] = {fixedMin = 25, fixedMax = 25, variableMin = 1, variableMax = 7, },
		[const.Master] = {fixedMin = 25, fixedMax = 25, variableMin = 1, variableMax = 7, },
	},
	-- Sun Ray
	[87] =
	{
		[const.Novice] = {fixedMin = 60, fixedMax = 60, variableMin = 1, variableMax = 40, },
		[const.Expert] = {fixedMin = 60, fixedMax = 60, variableMin = 1, variableMax = 40, },
		[const.Master] = {fixedMin = 60, fixedMax = 60, variableMin = 1, variableMax = 40, },
	},
	-- Toxic Cloud
	[90] =
	{
		[const.Novice] = {fixedMin = 20, fixedMax = 20, variableMin = 1, variableMax = 20, },
		[const.Expert] = {fixedMin = 20, fixedMax = 20, variableMin = 1, variableMax = 20, },
		[const.Master] = {fixedMin = 20, fixedMax = 20, variableMin = 1, variableMax = 20, },
	},
	-- Shrapmetal
	[92] =
	{
		[const.Novice] = {fixedMin = 3, fixedMax = 3, variableMin = 1, variableMax = 5, },
		[const.Expert] = {fixedMin = 3, fixedMax = 3, variableMin = 1, variableMax = 5, },
		[const.Master] = {fixedMin = 3, fixedMax = 3, variableMin = 1, variableMax = 5, },
	}, 
}

local spellBuffPowers =
{
	-- Stone Skin
	["StoneSkin"] =
	{
		["fixed"] = 5,
		["proportional"] = 2,
	},
	-- Bless
	["Bless"] =
	{
		["fixed"] = 5,
		["proportional"] = 1,
	},
	-- Heroism
	["Heroism"] =
	{
		["fixed"] = 5,
		["proportional"] = 2,
	},
}
local spellStatsBuffPowers =
{
	["StatsBuff"] =
	{
		["fixed"] = 10,
		["proportional"] = 2,
	},
}

-- Spell Overrides, ASM Patches, set 1
-- supersedes skill-mod.lua:1802-1987

-- all spells always hit

mem.asmpatch(0x0043188D, "jmp     0x23", 2)

-- debuff success rate - level is less important

mem.asmhook(0x421F06, "shr cl, 2")

-- spell damage modification

function events.CalcSpellDamage(t)

	if spellPowers[t.Spell] ~= nil then
	
		-- custom spell power
	
		local spellPower = spellPowers[t.Spell][t.Mastery]
		t.Result = randomSpellPower(spellPower, t.Skill)
		
	end
	
end

-- spell buffs

local function calculateSpellBuffPower(spellBuffName, level)
	return spellBuffPowers[spellBuffName]["fixed"] + level * spellBuffPowers[spellBuffName]["proportional"]
end

-- StoneSkin

local function setStoneSkinPowerNovice(d)
	d.eax = calculateSpellBuffPower("StoneSkin", d.eax - 5)
end
mem.autohook(0x00426284, setStoneSkinPowerNovice, 0x8)
local function setStoneSkinPowerExpert(d)
	d.ecx = calculateSpellBuffPower("StoneSkin", d.ecx - 5)
end
mem.autohook(0x0042617F, setStoneSkinPowerExpert, 0x8)

-- Bless
local function setBlessPowerNovice(d)
	d.eax = calculateSpellBuffPower("Bless", d.eax - 5)
end
mem.autohook(0x0042680C, setBlessPowerNovice, 0x8)
local function setBlessPowerExpert(d)
	d.ecx = calculateSpellBuffPower("Bless", d.ecx - 5)
end
mem.autohook(0x00426712, setBlessPowerExpert, 0x8)

-- Heroism
local function setHeroismPowerNovice(d)
	d.ecx = calculateSpellBuffPower("Heroism", d.ecx - 5)
end
mem.autohook(0x00426D4C, setHeroismPowerNovice, 0x8)
local function setHeroismPowerExpert(d)
	d.ecx = calculateSpellBuffPower("Heroism", d.ecx - 5)
end
mem.autohook(0x00426C4F, setHeroismPowerExpert, 0x8)

-- Healing Touch
mem.asmpatch(0x00426917, "mov     edx, 5", 5)
mem.asmpatch(0x00426926, "add     eax, 25", 3)
mem.asmpatch(0x00426903, "mov     edx, 11", 5)
mem.asmpatch(0x00426912, "add     eax, 65", 3)

-- First Aid
mem.bytecodepatch(0x00427E46, "\005", 1)
mem.bytecodepatch(0x00427E3C, "\010", 1)
mem.bytecodepatch(0x00427E32, "\040", 1)

-- Cure Wounds
mem.asmpatch(0x00427FA2, "lea     edx, [ecx+ecx+10]", 4)
mem.asmpatch(0x00427F94, "lea     eax, [edx+edx*2+20]", 4)
mem.asmpatch(0x00427F86, "lea     ecx, [eax+eax*4+40]", 4)

-- Power Cure
mem.asmpatch(0x00428596, "lea     ecx, [eax+eax*2]", 4)

-- Protection from Fire
mem.asmpatch(
	0x004236E3,
	"mov    eax, DWORD [esp+0x10]\n" ..
	"mov    ecx, esi\n" ..
	string.format("add    ecx,%d\n", protectionSpellExtraMultiplier) ..
	"imul   ecx, eax\n" ..
	"mov    DWORD [esp+0x14], ecx\n",
	0x2D
)
-- duration = skill * 2 hours
-- mem.asmpatch(0x00423719, "shl     eax, 5", 3)

-- Protection from Electricity
mem.asmpatch(
	0x0042439D,
	"mov    eax, DWORD[esp+0x10]\n" ..
	"mov    ecx, esi\n" ..
	"inc    ecx\n" ..
	"inc    ecx\n" ..
	"imul   ecx, eax\n" ..
	"mov    DWORD [esp+0x14], ecx\n",
	0x2D
)

-- duration = skill * 2 hours
-- mem.asmpatch(0x004243D4, "shl     eax, 15", 3)

-- Protection from Cold
mem.asmpatch(
	0x00424F99,
	"mov    eax, DWORD[esp+0x10]\n" ..
	"mov    ecx, esi\n" ..
	string.format("add    ecx,%d\n", protectionSpellExtraMultiplier) ..
	"imul   ecx, eax\n" ..
	"mov    DWORD [esp+0x14], ecx\n",
	0x2D
)

-- duration = skill * 2 hours
-- mem.asmpatch(0x00424FD0, "shl     eax, 5", 3)

-- Protection from Magic
mem.asmpatch(
	0x00426087,
	"mov    eax, DWORD[esp+0x10]\n" ..
	"mov    ecx, esi\n" ..
	string.format("add    ecx,%d\n", protectionSpellExtraMultiplier) ..
	"imul   ecx, eax\n" ..
	"mov    DWORD [esp+0x14], ecx\n",
	0x2D
)

-- duration = skill * 2 hours
-- mem.asmpatch(0x004260BE, "shl     eax, 5", 3)

-- Protection from Poison
mem.asmpatch(
	0x00427EBB,
	"mov    eax, DWORD[esp+0x10]\n" ..
	"mov    ecx, esi\n" ..
	string.format("add    ecx,%d\n", protectionSpellExtraMultiplier) ..
	"imul   ecx, eax\n" ..
	"mov    DWORD [esp+0x14], ecx\n",
	0x2D
)

-- duration = skill * 2 hours
-- mem.asmpatch(0x00427EF1, "shl     eax, 5", 3)

-- Day of Protection

-- Novice power = 2 (same as in vanilla - no change)
-- Expert power = 2
mem.asmpatch(0x0042961A, "lea    edx,[eax+eax*1]", 3)
-- Master power = 2
mem.asmpatch(0x0042960D, "lea    ecx,[eax*2+0x0]", 7)

-- duration = 1 hour * skill
mem.asmpatch(0x0042962E, [[
		lea    eax,[eax+eax*2]
		nop
	]], 4)

-- Day of the Gods

-- Novice power = 05 + skill * 1
mem.asmpatch(0x00428A90, [[
		lea    edx,[ecx+0x5]
		nop
	]], 4)
-- Expert power = 10 + skill * 1
mem.asmpatch(0x00428A7B, [[
		lea    ecx,[ecx+0xa]
		nop
	]], 4)
-- Master power = 15 + skill * 1
mem.asmpatch(0x00428A62, [[
		lea    eax,[ecx+0xf]
		nop
		nop
		nop
		nop
	]], 7)

-- Novice duration = skill * 1 hour
mem.asmpatch(0x00428A9E, "shl     eax, 4", 3)
-- Expert duration = skill * 1 hour
mem.asmpatch(0x00428A75, "imul    eax, 3600", 6)
-- Novice duration = skill * 1 hour
mem.asmpatch(0x00428A5B, "shl     eax, 4", 3)

-- Spell Overrides, ASM Patches, set 2
-- supersedes skill-mod.lua:2560-2596

-- Lucky day does not create pointer
mem.asmpatch(0x004220D5, "test   BYTE [eax+0x70],0xFF", 0x4)
-- Lucky day affects whole party
mem.asmpatch(0x004269CD, "cmp    esi,esi", 0x3)
-- Lucky day multiplier = 5
mem.asmpatch(0x004269B4, "lea     ecx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
mem.asmpatch(0x004269A6, "lea     edx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
mem.asmpatch(0x0042699C, "lea     ecx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
-- Meditation/Precision does not create pointer
mem.asmpatch(0x004220E3, "test   BYTE [eax+0x71],0xFF", 0x4)
-- Meditation affects whole party
mem.asmpatch(0x00427399, "cmp    esi,esi", 0x3)
-- Meditation multiplier = 5
mem.asmpatch(0x00427380, "lea     ecx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
mem.asmpatch(0x00427372, "lea     edx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
mem.asmpatch(0x00427368, "lea     ecx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
-- Precision affects whole party
mem.asmpatch(0x0042760D, "cmp    esi,esi", 0x3)
-- Precision multiplier = 5
mem.asmpatch(0x004275F4, "lea     ecx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
mem.asmpatch(0x004275E6, "lea     edx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
mem.asmpatch(0x004275DC, "lea     ecx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
-- Speed/Power does not create pointer
mem.asmpatch(0x004220F6, "test   BYTE [eax+0x72],0xFF", 0x4)
-- Speed affects whole party
mem.asmpatch(0x00428154, "cmp    esi,esi", 0x3)
-- Speed multiplier = 5
mem.asmpatch(0x0042813B, "lea     ecx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
mem.asmpatch(0x0042812D, "lea     edx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
mem.asmpatch(0x00428123, "lea     ecx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
-- Power affects whole party
mem.asmpatch(0x004283F8, "cmp    esi,esi", 0x3)
-- Power multiplier = 5
mem.asmpatch(0x004283DF, "lea     ecx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
mem.asmpatch(0x004283D1, "lea     edx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)
mem.asmpatch(0x004283C7, "lea     ecx, [eax+eax*" .. (spellStatsBuffPowers["StatsBuff"]["proportional"] - 1) .. "+0Ah]", 0x4)

-- Feeblemind Fixes
-- supersedes skill-mod.lua:2703-2732

local function disableFeeblemindedMonsterCasting(d, def)
	-- get default random value
	local randomRoll = def()
	-- get monster
	local monsterIndex, monster = GetMonster(d.esi)
	
		-- check monster is feebleminded
	if monster.SpellBuffs[const.MonsterBuff.Feeblemind].ExpireTime ~= 0 then
		-- set random roll to 100 to prevent casting
		randomRoll = 99
	end
	return randomRoll
end
mem.hookcall(0x00421C5C, 0, 0, disableFeeblemindedMonsterCasting)

-- Feeblemind prevents monster to do bad things

local function disableFeeblemindedMonsterSpecialAbility(d, def, playerPointer, thing)
	-- get monster
	local monsterIndex, monster = GetMonster(d.edi)
	-- check monster is feebleminded
	if monster.SpellBuffs[const.MonsterBuff.Feeblemind].ExpireTime ~= 0 then
		-- do nothing
	else
		-- do bad thing
		def(playerPointer, thing)
	end
end
mem.hookcall(0x00431DE7, 1, 1, disableFeeblemindedMonsterSpecialAbility)

-- Guardian Angel changes
-- supersedes skill-mod.lua:3316-3359
local function guardianAngelCharacterTrySubtractSpellPoints(d, def, characterPointer, spellPoints)
	-- get caster
	local playerIndex, player = GetPlayer(d.ebp)
	-- get caster skill
	local level, rank = SplitSkill(player.Skills[const.Skills.Spirit])
	-- store spell power
	guardianAngelPower = level
	-- execute original method
	return def(characterPointer, spellPoints)
end
mem.hookcall(0x00426BB0, 1, 1, guardianAngelCharacterTrySubtractSpellPoints)

local function guardianAngelSetSpellBuff(d, def, spellBuffAddress, expireTimeLow, expireTimeHigh, skill, strength, overlay, caster)
	-- set correct duration
	local duration = guardianAngelPower * 300 + 3600
	expireTimeLow = Game.Time + duration * 128 / 30
	-- set spell buff with correct power
	def(spellBuffAddress, expireTimeLow, expireTimeHigh, skill, guardianAngelPower, overlay, caster)
end
mem.hookcall(0x00426C0F, 1, 6, guardianAngelSetSpellBuff)

local guardianAngelEnduranceBonus = 1000
local function changedCharacterCalcStatBonusByItems(d, def, characterPointer, statId)
	-- calculate default bonus
	local statBonus = def(characterPointer, statId)
	-- guardian angel buff
	local guardianAngelBuff = Party.SpellBuffs[const.PartyBuff.GuardianAngel]
	-- increase bonus to make it positive so character doesn't die with guardian angel
	if guardianAngelBuff.ExpireTime ~= 0 then
		statBonus = statBonus + guardianAngelEnduranceBonus
	end
	return statBonus
end
mem.hookcall(0x0047FF37, 1, 1, changedCharacterCalcStatBonusByItems)
mem.hookcall(0x0048875B, 1, 1, changedCharacterCalcStatBonusByItems)

-- modified Monster Calculate Damage
-- supersedes skill-mod.lua:2658-2693
local function modifiedMonsterCalculateDamage(d, def, monsterPointer, attackType)

	-- get monster

	local monsterIndex, monster = GetMonster(d.edi)

	-- execute original code

	local damage = def(monsterPointer, attackType)

	if attackType == 0 then
		-- primary attack is calculated correctly
		return damage
	elseif attackType == 1 then
		-- secondary attach uses attack1 DamageAdd
		-- replace Attack1.DamageAdd with Attack2.DamageAdd
		damage = damage - monster.Attack1.DamageAdd + monster.Attack2.DamageAdd
		return damage
	elseif attackType == 2 and (monster.Spell == 44 or monster.Spell == 95) then
		-- don't recalculate Mass Distortion or Finger of Death
		return damage
	end

	-- calculate spell damage same way as for party

	local spellSkill, spellMastery = SplitSkill(monster.SpellSkill)
	damage = Game.CalcSpellDamage(monster.Spell, spellSkill, spellMastery, 0)

	return damage

end
mem.hookcall(0x00431D4F, 1, 1, modifiedMonsterCalculateDamage)
mem.hookcall(0x00431EE3, 1, 1, modifiedMonsterCalculateDamage)


-- spell overrides that depend on lodfiles/txtfiles loaded
function events.GameInitialized2()
	
	-- Spell Name Resolver
	for spellTxtId = 1, Game.SpellsTxt.high do
		spellTxtIds[Game.SpellsTxt[spellTxtId].Name] = spellTxtId
	end
	
	-- SP Cost Overrides
	-- supersedes skill-mod.lua:1997-2028
	
	--healing spells
	-- Healing Touch
	Game.Spells[47].SpellPointsNormal = 3
	Game.Spells[47].SpellPointsExpert = 6
	Game.Spells[47].SpellPointsMaster = 12
	Game.SpellsTxt[47].SpellPointsNormal = 3
	Game.SpellsTxt[47].SpellPointsExpert = 6
	Game.SpellsTxt[47].SpellPointsMaster = 12

	-- Cure Wounds
	Game.Spells[71].SpellPointsNormal = 5
	Game.Spells[71].SpellPointsExpert = 8
	Game.Spells[71].SpellPointsMaster = 15
	Game.SpellsTxt[71].SpellPointsNormal = 5
	Game.SpellsTxt[71].SpellPointsExpert = 8
	Game.SpellsTxt[71].SpellPointsMaster = 15

	-- Shared Life
	Game.Spells[54].SpellPointsNormal = 10
	Game.Spells[54].SpellPointsExpert = 10
	Game.Spells[54].SpellPointsMaster = 12
	Game.SpellsTxt[54].SpellPointsNormal = 10
	Game.SpellsTxt[54].SpellPointsExpert = 10
	Game.SpellsTxt[54].SpellPointsMaster = 12
	
	--damaging spells
	--Fireball
	Game.Spells[6].SpellPointsMaster = 16
	Game.SpellsTxt[6].SpellPointsMaster = 16
	--Ice Bolt
	Game.Spells[28].SpellPointsMaster = 11
	Game.SpellsTxt[28].SpellPointsMaster = 11
		--Fire Bolt
	Game.Spells[4].SpellPointsMaster = 8
	Game.SpellsTxt[4].SpellPointsMaster = 8
		--Deadly swarm
	Game.Spells[37].SpellPointsMaster = 6
	Game.SpellsTxt[37].SpellPointsMaster = 6
		--mind blast
	Game.Spells[58].SpellPointsMaster = 1
	Game.SpellsTxt[58].SpellPointsMaster = 1
		--lightning bolt
	Game.Spells[18].SpellPointsMaster = 14
	Game.SpellsTxt[18].SpellPointsMaster = 14
	

	----------------------------------------------------------------------------------------------------
	-- spell descriptions
	-- supersedes skill-mod.lua:2280-2389
	----------------------------------------------------------------------------------------------------
	
	-- protections

	Game.SpellsTxt[3].Description = "Increases all your characters' resistance to Fire. Lasts one hour per point of skill in Fire Magic."
	Game.SpellsTxt[3].Normal = string.format("resistance = %d * level", (const.Novice + protectionSpellExtraMultiplier))
	Game.SpellsTxt[3].Expert = string.format("resistance = %d * level", (const.Expert + protectionSpellExtraMultiplier))
	Game.SpellsTxt[3].Master = string.format("resistance = %d * level", (const.Master + protectionSpellExtraMultiplier))
	
	Game.SpellsTxt[14].Description = "Increases all your characters' resistance to Electricity. Lasts one hour per point of skill in Air Magic."
	Game.SpellsTxt[14].Normal = string.format("resistance = %d * level", (const.Novice + protectionSpellExtraMultiplier))
	Game.SpellsTxt[14].Expert = string.format("resistance = %d * level", (const.Expert + protectionSpellExtraMultiplier))
	Game.SpellsTxt[14].Master = string.format("resistance = %d * level", (const.Master + protectionSpellExtraMultiplier))
	
	Game.SpellsTxt[25].Description = "Increases all your characters' resistance to Cold. Lasts one hour per point of skill in Water Magic."
	Game.SpellsTxt[25].Normal = string.format("resistance = %d * level", (const.Novice + protectionSpellExtraMultiplier))
	Game.SpellsTxt[25].Expert = string.format("resistance = %d * level", (const.Expert + protectionSpellExtraMultiplier))
	Game.SpellsTxt[25].Master = string.format("resistance = %d * level", (const.Master + protectionSpellExtraMultiplier))
	
	Game.SpellsTxt[36].Description = "Increases all your characters' resistance to Magic. Lasts one hour per point of skill in Earth Magic."
	Game.SpellsTxt[36].Normal = string.format("resistance = %d * level", (const.Novice + protectionSpellExtraMultiplier))
	Game.SpellsTxt[36].Expert = string.format("resistance = %d * level", (const.Expert + protectionSpellExtraMultiplier))
	Game.SpellsTxt[36].Master = string.format("resistance = %d * level", (const.Master + protectionSpellExtraMultiplier))
	
	Game.SpellsTxt[69].Description = "Increases all your characters' resistance to Poison. Lasts one hour per point of skill in Body Magic."
	Game.SpellsTxt[69].Normal = string.format("resistance = %d * level", (const.Novice + protectionSpellExtraMultiplier))
	Game.SpellsTxt[69].Expert = string.format("resistance = %d * level", (const.Expert + protectionSpellExtraMultiplier))
	Game.SpellsTxt[69].Master = string.format("resistance = %d * level", (const.Master + protectionSpellExtraMultiplier))
	
	-- stats buffs
	
	-- Lucky day
	Game.SpellsTxt[48].Description = string.format("Temporarily increases all party characters' Luck statistic by 10 points plus %d per point of skill in Spirit Magic.", spellStatsBuffPowers["StatsBuff"]["proportional"])
	Game.SpellsTxt[48].Normal = "same"
	Game.SpellsTxt[48].Expert = "same"
	Game.SpellsTxt[48].Master = "same"
	
	-- Meditation
	Game.SpellsTxt[56].Description = string.format("Temporarily increases all party characters' Intellect and Personality statistics by 10 points plus %d per point of skill in Mind Magic.", spellStatsBuffPowers["StatsBuff"]["proportional"])
	Game.SpellsTxt[56].Normal = "same"
	Game.SpellsTxt[56].Expert = "same"
	Game.SpellsTxt[56].Master = "same"
	
	-- Precision
	Game.SpellsTxt[59].Description = string.format("Temporarily increases all party characters' Accuracy statistic by 10 points plus %d per point of skill in Mind Magic.", spellStatsBuffPowers["StatsBuff"]["proportional"])
	Game.SpellsTxt[59].Normal = "same"
	Game.SpellsTxt[59].Expert = "same"
	Game.SpellsTxt[59].Master = "same"
	
	-- Speed
	Game.SpellsTxt[73].Description = string.format("Temporarily increases all party characters' Speed statistic by 10 points plus %d per point of skill in Body Magic.", spellStatsBuffPowers["StatsBuff"]["proportional"])
	Game.SpellsTxt[73].Normal = "same"
	Game.SpellsTxt[73].Expert = "same"
	Game.SpellsTxt[73].Master = "same"
	
	-- Power day
	Game.SpellsTxt[75].Description = string.format("Temporarily increases all party characters' Might and Endurance by 10 points plus %d per point of skill in Body Magic.", spellStatsBuffPowers["StatsBuff"]["proportional"])
	Game.SpellsTxt[75].Normal = "same"
	Game.SpellsTxt[75].Expert = "same"
	Game.SpellsTxt[75].Master = "same"
	
	-- direct buffs
	
	-- Stone Skin
	Game.SpellsTxt[38].Description = string.format("Increases the armor class of a character by %d + %d point per point of skill in Earth Magic.", spellBuffPowers["StoneSkin"]["fixed"], spellBuffPowers["StoneSkin"]["proportional"])
	
	-- Bless
	Game.SpellsTxt[46].Description = string.format("Increases the attack/shoot of a character by %d + %d per point of skill in Spirit Magic.", spellBuffPowers["Bless"]["fixed"], spellBuffPowers["Bless"]["proportional"])
	
	-- Heroism
	Game.SpellsTxt[51].Description = string.format("Increases the damage a character does on a successful attack by %d + %d point per point of skill in Spirit Magic.", spellBuffPowers["Heroism"]["fixed"], spellBuffPowers["Heroism"]["proportional"])
	
	-- healing spells
	
	-- Healing Touch
	Game.SpellsTxt[47].Description = string.format("Cheaply heals a single character. Skill increases the recovery rate of this spell.")
	Game.SpellsTxt[47].Normal = string.format("Heals 3-7 points of damage")
	Game.SpellsTxt[47].Expert = string.format("Casting costs 6 spell points. Heals around 30 points of damage")
	Game.SpellsTxt[47].Master = string.format("Casting costs 12 spell points. Heals around 70 points of damage")

	-- First Aid
	Game.SpellsTxt[68].Description = string.format("Cures single character. Recovery is reduced by an amount equal to the caster's skill in Body Magic.")
	Game.SpellsTxt[68].Normal = string.format("Cures 5 hit points")
	Game.SpellsTxt[68].Expert = string.format("Cures 10 hit points")
	Game.SpellsTxt[68].Master = string.format("Cures 20 hit points")

	-- Cure Wounds
	Game.SpellsTxt[71].Description = string.format("Cures hit points on a single target when cast. The number cured is equal to 10+2 per point of skill in Body Magic.")
	Game.SpellsTxt[71].Normal = string.format("Casting costs 5 spell points. Cures 10+2 hit points per point of skill")
	Game.SpellsTxt[71].Expert = string.format("Casting costs 8 spell points. Cures 20+3 hit points per point of skill")
	Game.SpellsTxt[71].Master = string.format("Casting costs 15 spell points. Cures 40+5 hit points per point of skill")
	-- Power Cure
	Game.SpellsTxt[77].Description = string.format("Cures hit points of all characters in your party at once. The number cured is equal to 3 per point of skill in Body Magic.")
	
	--Fireball
	Game.SpellsTxt[6].Master = string.format("Casting costs 16 spell points. Deals 12+1-9 damage per point of skill")
	-- Ice Bolt
	Game.SpellsTxt[28].Master = string.format("Casting costs 20 spell points. Deals 20+1-13 damage per point of skill")

	-- direct damage spells
	
	for spellIndex, resistType in pairs(spellResists) do
		Game.SpellsTxt[spellIndex].DamageType = resistType
	end
	
	for spellIndex, spellPower in pairs(spellPowers) do
		Game.SpellsTxt[spellIndex].Description = Game.SpellsTxt[spellIndex].Description .. string.format("\n\nmodified damage = %d + %d-%d per point of skill", spellPowers[spellIndex][const.Novice].fixedMin, spellPowers[spellIndex][const.Novice].variableMin, spellPowers[spellIndex][const.Novice].variableMax)
	end
	
	-- guardian angel
	
	Game.SpellsTxt[spellTxtIds["Guardian Angel"]].Description = string.replace(Game.SpellsTxt[spellTxtIds["Guardian Angel"]].Description, "Guardian Angel lasts for 1 hour per point of skill in Spirit Magic", "Guardian Angel lasts for 1 hour plus 5 minutes per point of skill in Spirit Magic") .. string.format("\n\nWhile active Guardian Angel lowers death HP threshold by 1000 for all characters protecting them from dying of HP loss.")
	
end