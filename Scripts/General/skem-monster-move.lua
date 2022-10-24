-- monster assignment readjustment for Skill Emphasis Mod
-- 2022-07-11
--
-- Replaces Priests in T1 and Sewer with Monks
--

function monsterSubstitutions()
	Game.MapStats[7].Monster3Pic = "Ogre"
	Game.MapStats[7].Monster2Pic = "Archer"
	Game.MapStats[36].Monster1Pic = "Monk"
	Game.MapStats[45].Monster3Pic = "KnightPlate"
	Game.MapStats[47].Monster2Pic = "Monk"
	
end

function events.GameInitialized2()
	monsterSubstitutions()
end
