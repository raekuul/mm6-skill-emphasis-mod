-- Add a bit of sp regeneration by meditation skill

function calculateMeditationSPRegen(rank, mastery, fullSP)
	fixed = mastery
	scaled = math.ceil(fullSP^0.5 * mastery^2/400)
	output = math.max(fixed, scaled)
	return math.floor(output)
end

function events.Regeneration(t)
	v = Party[t.PlayerIndex]
	
	r,m = SplitSkill(v.Skills[const.Skills.Meditation])
	cap = v:GetFullSP()
	cur = v.SpellPoints
	gain = t.SP + calculateMeditationSPRegen(r, m, cap)
	v.SpellPoints = math.min(cap,cur+gain)
end
