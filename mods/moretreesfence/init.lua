moretreesfence = {}

moretreesfence.treelist = {
	{"beech",			"Beech Tree"},
	{"apple_tree",		"Apple Tree"},
	{"oak",				"Oak Tree",			"acorn",					"Acorn",			{-0.2, -0.5, -0.2, 0.2, 0, 0.2},	0.8 },
	{"sequoia",			"Giant Sequoia"},
	{"birch",			"Birch Tree"},
	{"palm",			"Palm Tree",		"palm_fruit_trunk_gen",		"Palm Tree",		{-0.2, -0.5, -0.2, 0.2, 0, 0.2},	1.0 },
	{"date_palm",		"Date Palm Tree",	"date_palm_fruit_trunk",	"Date Palm Tree",	{0, 0, 0, 0, 0, 0},	0.0 },
	{"spruce",			"Spruce Tree",		"spruce_cone",				"Spruce Cone",		{-0.2, -0.5, -0.2, 0.2, 0, 0.2},	0.8 },
	{"cedar",			"Cedar Tree",		"cedar_cone",				"Cedar Cone",		{-0.2, -0.5, -0.2, 0.2, 0, 0.2},	0.8 },
	{"poplar",			"Poplar Tree"},
	{"poplar_small",	"Poplar Tree"},
	{"willow",			"Willow Tree"},
	{"rubber_tree",		"Rubber Tree"},
	{"fir",				"Douglas Fir",		"fir_cone",					"Fir Cone",			{-0.2, -0.5, -0.2, 0.2, 0, 0.2},	0.8 },
	{"jungletree",		"Jungle Tree",		nil,						nil,				nil,								nil, "default_junglesapling.png"  },
}

for i in ipairs(moretreesfence.treelist) do
	local treename = moretreesfence.treelist[i][1]
	local treedesc = moretrees.treelist[i][2]
	default.register_fence("moretreesfence:fence_" .. treename .. "_wood", {
		description = treedesc.." Fence",
		texture = "moretrees_"..treename.."_wood.png",
		inventory_image = "default_fence_overlay.png^moretrees_"..treename.."_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
		wield_image = "default_fence_overlay.png^moretrees_"..treename.."_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
		material = "moretrees:"..treename.."_planks",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults()
	})

	doors.register_fencegate("moretreesfence:"..treename.."_gate_wood", {
		description = treedesc.." Fence Gate",
		texture = "moretrees_"..treename.."_wood.png",
		material = "moretrees:"..treename.."_planks",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
	})
end