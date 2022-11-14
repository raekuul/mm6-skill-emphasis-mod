function events.ModifyItemDamage(t)
local s, m = SplitSkill(t.Player.Skills[const.Skills.Bow])
	if t.Item:T().EquipStat == const.ItemType.Missile - 1 then
		t.Result = t.Result + s * (m <= const.Expert and m or 2)
	end
end