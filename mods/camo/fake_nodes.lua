minetest.register_node("camo:fake_dirt", {
	description = "Fake Dirt",
	tiles = {"default_dirt.png"},
	is_ground_content = false,
	drop = "camo:fake_dirt",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_dirt_with_grass", {
	description = "Fake Dirt With Grass",
	tiles = {"default_grass.png",
	         "default_dirt.png",
			 "default_dirt.png^default_grass_side.png",
			 "default_dirt.png^default_grass_side.png",
			 "default_dirt.png^default_grass_side.png",
			 "default_dirt.png^default_grass_side.png"},
	is_ground_content = false,
	drop = "camo:fake_dirt_with_grass",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_stone", {
	description = "Fake Stone",
	tiles = {"default_stone.png"},
	is_ground_content = false,
	drop = "camo:fake_stone",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_cobble", {
	description = "Fake Cobblestone",
	tiles = {"default_cobble.png"},
	is_ground_content = false,
	drop = "camo:fake_cobble",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_sand", {
	description = "Fake Sand",
	tiles = {"default_sand.png"},
	is_ground_content = false,
	drop = "camo:fake_sand",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_sandstone", {
	description = "Fake Sand Stone",
	tiles = {"default_sandstone.png"},
	is_ground_content = false,
	drop = "camo:fake_sandstone",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_desert_sand", {
	description = "Fake Desert Sand",
	tiles = {"default_desert_sand.png"},
	is_ground_content = false,
	drop = "camo:fake_desert_sand",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_desert_stone", {
	description = "Fake Desert Stone",
	tiles = {"default_desert_stone.png"},
	is_ground_content = false,
	drop = "camo:fake_desert_stone",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_gravel", {
	description = "Fake Gravel",
	tiles = {"default_gravel.png"},
	is_ground_content = false,
	drop = "camo:fake_gravel",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_bookshelf", {
	description = "Fake Bookshelf",
	tiles = {"default_wood.png",
	         "default_wood.png",
			 "default_bookshelf.png",
			 "default_bookshelf.png",
			 "default_bookshelf.png",
			 "default_bookshelf.png",},
	is_ground_content = false,
	drop = "camo:fake_bookshelf",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_wood", {
	description = "Fake Wooden Planks",
	tiles = {"default_wood.png"},
	is_ground_content = false,
	drop = "camo:fake_wood",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_tree", {
	description = "Fake Tree",
	tiles = {"default_tree_top.png",
	         "default_tree_top.png",
			 "default_tree.png",
			 "default_tree.png",
			 "default_tree.png",
			 "default_tree.png"},
	is_ground_content = false,
	drop = "camo:fake_tree",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_leaves", {
	description = "Fake leaves",
	drawtype = "glasslike",
	paramtype = "light",
	tiles = {"default_leaves.png"},
	is_ground_content = false,
	drop = "camo:fake_leaves",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_furnace", {
	description = "Fake Furnace",
	paramtype2 = 'facedir',
	tiles = {"default_furnace_top.png",
	         "default_furnace_bottom.png",
			 "default_furnace_side.png",
			 "default_furnace_side.png",
			 "default_furnace_side.png",
			 "default_furnace_front.png"},
	is_ground_content = false,
	drop = "camo:fake_furnace",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_chest", {
	description = "Fake Chest",
	paramtype2 = 'facedir',
	tiles = {"default_chest_top.png",
	         "default_chest_top.png",
			 "default_chest_side.png",
			 "default_chest_side.png",
			 "default_chest_side.png",
			 "default_chest_front.png"},
	is_ground_content = false,
	drop = "camo:fake_chest",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_glass", {
	description = "Fake Glass",
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"default_glass.png"},
	is_ground_content = false,
	drop = "camo:fake_glass",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_clay", {
	description = "Fake Clay",
	tiles = {"default_clay.png"},
	is_ground_content = false,
	drop = "camo:fake_clay",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:fake_brick", {
	description = "Fake Brick",
	tiles = {"default_brick.png"},
	is_ground_content = false,
	drop = "camo:fake_brick",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})