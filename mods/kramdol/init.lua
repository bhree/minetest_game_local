minetest.register_craftitem("krambdol:krambdol", {
	description = "Minegeld credit in cash",
	inventory_image = "krambdol_coin.png",
	stack_max = 10000,
})

minetest.register_craftitem("krambdol:subkrambdol", {
	description = "Quarter Minegeld coin",
	inventory_image = "krambdol_coin_quarter.png",
	stack_max = 10000,
})

minetest.register_craft( {
	type = "shapeless",
	output = "krambdol:krambdol",
	recipe = {"krambdol:subkrambdol", "krambdol:subkrambdol", "krambdol:subkrambdol", "krambdol:subkrambdol"},
})

minetest.register_craft( {
	type = "shapeless",
	output = "krambdol:krambdol 2",
	recipe = {"krambdol:subkrambdol", "krambdol:subkrambdol", "krambdol:subkrambdol", "krambdol:subkrambdol",
			"krambdol:subkrambdol", "krambdol:subkrambdol", "krambdol:subkrambdol", "krambdol:subkrambdol"},
})

minetest.register_craft( {
	type = "shapeless",
	output = "krambdol:subkrambdol 4",
	recipe = {"krambdol:krambdol"},
})