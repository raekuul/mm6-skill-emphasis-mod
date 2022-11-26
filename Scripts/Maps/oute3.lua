local TXT = Localize{
	[0] = " ",
	[1] = "New Sorpigal",
	[2] = "Welcome to New Sorpigal",
	[3] = "New Sorpigal Temple",
	[4] = "GoblinWatch",
	[5] = "Abbey of the Sun",
	[6] = "Crate",
	[7] = "Drink from Fountain",
	[8] = "Refreshing!",
	[9] = "Your purse feels much lighter as you foolishly throw your money into the well.",
	[10] = "Well",
	[11] = "There doesn't seem to be anymore apples.",
	[12] = "You pick an apple.",
	[13] = "Tree",
	[14] = "+5 Hit points restored.",
	[15] = "+5 Spell points restored.",
	[16] = "+10 Might temporary.",
	[17] = "Rock",
	[18] = "The door is locked.",
	[19] = "The Sword won't budge!",
	[20] = "+2 Luck permanent",
	[21] = "It's your Lucky Day!  +100 gold.",
	[22] = "Gharik's Forge",
	[23] = "Shrine of Luck",
	[24] = "You pray at the shrine.",
	[25] = "+10 Luck permanent",
	[26] = "+3 Luck permanent",
	[27] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _nrh__tf__cehr__",
	[28] = "Obelisk",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[1]  -- "New Sorpigal"
Game.LoadSound(26)

evt.hint[2] = evt.str[2]  -- "Welcome to New Sorpigal"
evt.HouseDoor(3, 69)  -- "New Sorpigal Temple"
evt.house[4] = 69  -- "New Sorpigal Temple"
evt.HouseDoor(5, 15)  -- "The Common Defense"
evt.house[6] = 15  -- "The Common Defense"
evt.HouseDoor(7, 113)  -- "Savings House"
evt.house[8] = 113  -- "Savings House"
evt.HouseDoor(9, 42)  -- "Traveler's Supply"
evt.house[10] = 42  -- "Traveler's Supply"
evt.HouseDoor(11, 92)  -- "A Lonely Knight"
evt.house[12] = 92  -- "A Lonely Knight"
evt.HouseDoor(13, 29)  -- "The Seeing Eye"
evt.house[14] = 29  -- "The Seeing Eye"
evt.HouseDoor(15, 48)  -- "New Sorpigal Coach Company"
evt.house[16] = 48  -- "New Sorpigal Coach Company"
evt.HouseDoor(17, 1)  -- "The Knife Shoppe"
evt.house[18] = 1  -- "The Knife Shoppe"
evt.HouseDoor(19, 141)  -- "Blades' End"
evt.house[20] = 141  -- "Blades' End"
evt.HouseDoor(21, 137)  -- "Initiate Guild of the Elements"
evt.house[22] = 137  -- "Initiate Guild of the Elements"
evt.HouseDoor(23, 79)  -- "New Sorpigal Training Grounds"
evt.house[24] = 79  -- "New Sorpigal Training Grounds"
evt.HouseDoor(25, 139)  -- "Initiate Guild of the Self"
evt.house[26] = 139  -- "Initiate Guild of the Self"
evt.HouseDoor(27, 147)  -- "Buccaneers' Lair"
evt.HouseDoor(28, 89)  -- "Town Hall"
evt.HouseDoor(29, 57)  -- "Odyssey"
evt.HouseDoor(50, 465)  -- "House"
evt.HouseDoor(51, 466)  -- "House"
evt.HouseDoor(52, 467)  -- "House"
evt.HouseDoor(53, 468)  -- "House"
evt.HouseDoor(54, 469)  -- "House"
evt.HouseDoor(55, 477)  -- "House"
evt.HouseDoor(56, 478)  -- "House"
evt.HouseDoor(57, 480)  -- "House"
evt.HouseDoor(58, 481)  -- "House"
evt.HouseDoor(59, 482)  -- "House"
evt.HouseDoor(60, 483)  -- "House"
evt.HouseDoor(61, 484)  -- "House"
evt.HouseDoor(62, 485)  -- "House"
evt.HouseDoor(63, 486)  -- "House"
evt.HouseDoor(64, 487)  -- "House"
evt.HouseDoor(65, 470)  -- "House"
evt.HouseDoor(66, 471)  -- "House"
evt.HouseDoor(67, 472)  -- "House"
evt.HouseDoor(68, 473)  -- "House"
evt.HouseDoor(69, 474)  -- "House"
evt.HouseDoor(70, 475)  -- "House"
evt.HouseDoor(71, 476)  -- "House"
evt.hint[75] = evt.str[6]  -- "Crate"
evt.map[75] = function()
	evt.OpenChest(1)
end

-- remove stats fountain
Game.MapEvtLines:RemoveEvent(110)

-- configure shrine event
configureShrineEvent(261, 6, "BaseLuck", 23, 24, 25, 26)

--repoint devdoor to Abdul's Discount Oasis Resort instead of Shrine of the Gods
evt.map[104] = function()
	evt.MoveToMap{X = -9678, Y = -13013, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutB3.Odm"}
end

evt.map[225] = function()
	if not evt.Cmp("MapVar59", 1) then
		evt.Add("Inventory", 218)         -- "Jump"
		evt.FaceExpression{Player = "All", Frame = 44}
		evt.Set("MapVar59", 1)
	end
end
