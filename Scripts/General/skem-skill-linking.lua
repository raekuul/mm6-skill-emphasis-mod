-- skill linking code, from Skill Emphasis Mod
-- if using with Skill Emphasis, comment out lines 3737 - 3812 in skill-mod.lua

-- set EASY to true to enable linked Spell groups, and to link Bows/Blasters across the party
local EASY = false

-- Skill groups linked "vertically" - within only one character
local characterLinkedSkillGroups =
{
	["meleeMain"] =
		{
			[const.Skills.Staff] = true,
			[const.Skills.Axe] = true,
			[const.Skills.Spear] = true,
			[const.Skills.Mace] = true,
		},
	["meleeExtra"] =
		{
			[const.Skills.Sword] = true,
			[const.Skills.Dagger] = true,
		},
	["ranged"] =
		{
			[const.Skills.Bow] = not(EASY),
			[const.Skills.Blaster] = not(EASY),
		},
	["armor"] =
		{
			[const.Skills.Leather] = true,
			[const.Skills.Chain] = true,
			[const.Skills.Plate] = true,
			[const.Skills.Bodybuilding] = EASY,
		},
	["elemental"] = 
		{
			[const.Skills.Fire] = EASY,
			[const.Skills.Air] = EASY,
			[const.Skills.Water] = EASY,
			[const.Skills.Earth] = EASY,
			[const.Skills.Dark] = EASY,
			[const.Skills.Learning] = EASY,
		},
	["self"] = 
		{
			[const.Skills.Spirit] = EASY,
			[const.Skills.Mind] = EASY,
			[const.Skills.Body] = EASY,
			[const.Skills.Light] = EASY,
			[const.Skills.Meditation] = EASY,
		},
}

-- Skills linked "Horizontally" - across the entire party

local partyLinkedSkills =
{
	[const.Skills.IdentifyItem] = true,
	[const.Skills.Merchant] = true,
	[const.Skills.Repair] = true,
	[const.Skills.Perception] = true,
	[const.Skills.DisarmTraps] = true,
	[const.Skills.Diplomacy] = true,
	[const.Skills.Bow] = EASY,
	[const.Skills.Blaster] = EASY,
}

function skillAdvance(t)
	-- get current player
	
	local currentPlayer = Party.Players[Party.CurrentPlayer]
	
	-- get skill
	
	local skill = t.Param

	-- check if skill is advanceable
	
	local skillLevel, skillMastery = SplitSkill(currentPlayer.Skills[skill])
	local skillAdvanceable = (currentPlayer.SkillPoints >= skillLevel + 1)

	if skillAdvanceable then
	
		-- character linked skills
		
		for key, characterLinkedSkills in pairs(characterLinkedSkillGroups) do
		
			if ((characterLinkedSkills[skill] ~= nil) and (characterLinkedSkills[skill] == true )) then
		
				-- advance all other skills to at least same level
				
				for characterLinkedSkill, value in pairs(characterLinkedSkills) do
				
					if characterLinkedSkill ~= skill then
					
						local characterLinkedSkillLevel, characterLinkedSkillMastery = SplitSkill(currentPlayer.Skills[characterLinkedSkill])
					
						if characterLinkedSkillMastery ~= 0 and characterLinkedSkillLevel <= skillLevel then
								currentPlayer.Skills[characterLinkedSkill] = JoinSkill(skillLevel + 1, characterLinkedSkillMastery)
						end
						
					end
					
				end
				
			end
			
		end
		
		-- party linked skills
		
		if ((partyLinkedSkills[skill] ~= nil) and (partyLinkedSkills[skill] == true)) then
	
			-- advance same skill for other party members to at least same level
			
			for i = 0, 3 do
			
				if i ~= Party.CurrentPlayer then
				
					local player = Party.Players[i]
				
					local partyLinkedSkillLevel, partyLinkedSkillMastery = SplitSkill(player.Skills[skill])
				
					if partyLinkedSkillMastery ~= 0 and partyLinkedSkillLevel <= skillLevel then
							player.Skills[skill] = JoinSkill(skillLevel + 1, partyLinkedSkillMastery)
					end
					
				end
				
			end
			
		end
		
	end
end 

function events.Action(t)
	-- clicked on skill in skill screen
	if t.Action == 121 then
		skillAdvance(t)
	end
end
