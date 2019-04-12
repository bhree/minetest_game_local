minetest.register_node("camo:small_spike", {
	description = "Small Spike",
	paramtype = "light",
	drawtype = "plantlike",
	tiles = {"camo_small_spike.png"},
	is_ground_content = false,
	damage_per_second = 4,
	drop = "camo:small_spike",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:large_spike", {
	description = "Large Spike",
	paramtype = "light",
	drawtype = "plantlike",
	tiles = {"camo_large_spike.png"},
	is_ground_content = false,
	damage_per_second = 8,
	drop = "camo:large_spike",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:spike_grass", {
	description = "Spike Grass",
	paramtype = "light",
	drawtype = "plantlike",
	tiles = {"default_grass_5.png"},
	is_ground_content = false,
	damage_per_second = 8,
	drop = "camo:spike_grass",
	walkable = false,
	groups = {oddly_breakable_by_hand=1},
})

minetest.register_node("camo:catapulter", {
	description = "Entity Catapulter",
	drawtype = "normal",
	tiles = {"default_grass.png",
	         "default_dirt.png",
			 "default_dirt.png^default_grass_side.png",
			 "default_dirt.png^default_grass_side.png",
			 "default_dirt.png^default_grass_side.png",
			 "default_dirt.png^default_grass_side.png"},
	is_ground_content = false,
	drop = "camo:catapulter",
	groups = {oddly_breakable_by_hand=1,bouncy=500},
})