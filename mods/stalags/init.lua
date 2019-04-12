minetest.register_node("stalags:stalagtite", {
	description = "Stalagtite",
	drawtype = "plantlike",
	tiles = {"hyrule_mapgen_stalagmite0.png"},
	inventory_image = "hyrule_mapgen_stalagmite0.png",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("stalags:stalagtite1", {
	description = "Stalagtite",
	drawtype = "plantlike",
	tiles = {"hyrule_mapgen_stalagmite1.png"},
	inventory_image = "hyrule_mapgen_stalagmite1.png",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	groups = {crumbly=1, oddly_breakable_by_hand=1},
})

minetest.register_node("stalags:stalagtite2", {
	description = "Stalagtite",
	drawtype = "plantlike",
	tiles = {"hyrule_mapgen_stalagmite2.png"},
	inventory_image = "hyrule_mapgen_stalagmite2.png",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("stalags:stalagtite3", {
	description = "Stalagtite",
	drawtype = "plantlike",
	tiles = {"hyrule_mapgen_stalagmite3.png"},
	inventory_image = "hyrule_mapgen_stalagmite3.png",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("stalags:stalagmite0", {
	description = "Stalagmite",
	drawtype = "plantlike",
	tiles = {"hyrule_mapgen_stalagmite0.png^[transformFY"},
	inventory_image = "hyrule_mapgen_stalagmite0.png^[transformFY",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("stalags:stalagmite1", {
	description = "Stalagmite",
	drawtype = "plantlike",
	visual_scale = 1.5,
	tiles = {"hyrule_mapgen_stalagmite3.png^[transformFY"},
	inventory_image = "hyrule_mapgen_stalagmite3.png^[transformFY",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("stalags:stalagmite2", {
	description = "Stalagmite",
	drawtype = "plantlike",
	visual_scale = 1.5,
	tiles = {"hyrule_mapgen_stalagmite2.png^[transformFY"},
	inventory_image = "hyrule_mapgen_stalagmite2.png^[transformFY",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("stalags:crystal_1", {
	description = "Cave Crystal (Blue)",
	tiles = {
		"hyrule_mapgen_crystal1.png",
	},
	groups = {cracky=1},
	drawtype = "nodebox",
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 6,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.0625, 0.1875, 0.4375, 0.25}, -- NodeBox6
			{0, -0.5, -0.3125, 0.1875, 0.1875, -0.125}, -- NodeBox7
			{-0.3125, -0.5, -0.1875, -0.0625, -0.0625, 0.0625}, -- NodeBox8
			{0.1875, -0.5, 0.0625, 0.3125, 0, 0.1875}, -- NodeBox9
			{-0.25, -0.5, 0.125, 0, 0.0625, 0.375}, -- NodeBox10
		}
	},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_node("stalags:crystal_3", {
	description = "Cave Crystal (Green)",
	tiles = {
		"hyrule_mapgen_crystal3.png",
	},
	groups = {cracky=1},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 6,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.25, 0, 0.1875, -0.0625}, -- NodeBox16
			{0, -0.5, 0.0625, 0.25, 0.5, 0.3125}, -- NodeBox19
			{-0.375, -0.5, 0.0625, -0.1875, -0.0625, 0.25}, -- NodeBox20
		}
	},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_node("stalags:crystal_2", {
	description = "Cave Crystal (Purple)",
	tiles = {
		"hyrule_mapgen_crystal2.png",
	},
	groups = {cracky=1},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 6,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.1875, 0.125, 0.4375, 0.125}, -- NodeBox11
			{0.0625, -0.5, 0.1875, 0.25, 0.1875, 0.375}, -- NodeBox12
			{-0.375, -0.5, -0.25, -0.1875, -0.0625, -0.0625}, -- NodeBox13
			{-0.3125, -0.5, 0.0625, -0.0625, 0.125, 0.3125}, -- NodeBox14
			{0.0625, -0.5, -0.3125, 0.25, 0.25, -0.125}, -- NodeBox15
		}
	},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_on_generated(function(minp, maxp)
	if maxp.y < -50 or maxp.y > 10 then
		return
	end
	local dirt = minetest.find_nodes_in_area(minp, maxp,
		{"default:stone"})
	for n = 1, #dirt do
		if math.random(1, 50) == 1 then
			local pos = {x = dirt[n].x, y = dirt[n].y, z = dirt[n].z }
				if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "air" then
					if math.random(1,2) == 1 then
					minetest.add_node({x=pos.x, y=pos.y-1, z=pos.z}, {name = "stalags:stalagtite"})
					elseif math.random(1,2) == 1 then
					minetest.add_node({x=pos.x, y=pos.y-1, z=pos.z}, {name = "stalags:stalagtite1"})
					elseif math.random(1,2) == 1 then
					minetest.add_node({x=pos.x, y=pos.y-1, z=pos.z}, {name = "stalags:stalagtite2"})
					else
					minetest.add_node({x=pos.x, y=pos.y-1, z=pos.z}, {name = "stalags:stalagtite3"})
					end
				end
		end
	end
end)

minetest.register_on_generated(function(minp, maxp)
	if maxp.y < -150 or maxp.y > 20 then
		return
	end
	local dirt = minetest.find_nodes_in_area(minp, maxp,
		{"default:stone"})
	for n = 1, #dirt do
		if math.random(1, 50) == 1 then
			local pos = {x = dirt[n].x, y = dirt[n].y, z = dirt[n].z }
				if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" and pos.y >= -100 then
					if math.random(1,2) == 1 then
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "stalags:stalagmite0"})
					elseif math.random(1,2) == 1 then
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "stalags:stalagmite1"})
					else
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "stalags:stalagmite2"})
					end
				elseif minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" then
					if math.random(1,2) == 1 then
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "stalags:crystal_1"})
					elseif math.random(1,2) == 1 then
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "stalags:crystal_2"})
					else
					minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "stalags:crystal_3"})
					end
				end
		end
	end
end)