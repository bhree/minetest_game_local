-- Snow
weather_mod.register_downfall("weather:snow",{
	min_pos = {x=-9, y=7, z=-9},
	max_pos = {x= 9, y=7, z= 9},
	falling_speed=5,
	amount=10,
	exptime=5,
	size=25,
	texture="weather_snow.png"
})

local snow_box =
{
	type  = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
}

-- Snow cover
minetest.register_node("weather:snow_cover", {
	tiles = {"weather_snow_cover.png"},
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = false,
	buildable_to = true,
	node_box = snow_box,
	selection_box = snow_box,
	groups = {dig_immediate=3, not_in_creative_inventory = 1, attached_node = 1},
	drop = {},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.15},
	}),
	on_punch = function(pos)
		minetest.set_node(pos, {name = "air"})
	end
})

-- Snow cover ABM when weather_fast_pc setting is set to `true`
if minetest.is_yes(minetest.settings:get_bool('weather_fast_pc')) then
	minetest.log('action', '[weather] Loaded fast computer ABM (snow covers when weather:snow is set)')
	minetest.register_abm{
		nodenames = {"group:crumbly", "group:snappy", "group:cracky", "group:choppy"},
		neighbors = {"air"},
		interval = 20.0,
		chance = 160,
		action = function (pos, node)
			if weather.type == "weather:snow" and pos.y > -50 and pos.y < 120 then
				if minetest.registered_nodes[node.name].drawtype == "normal"
				or minetest.registered_nodes[node.name].drawtype == "allfaces_optional" 
				or minetest.registered_nodes[node.name].drawtype == "glasslike" 
				or minetest.registered_nodes[node.name].drawtype == "glasslike_framed_optional"
				or minetest.registered_nodes[node.name].drawtype == "glasslike_framed" then
					local np = vector.add(pos, {x=0, y=1, z=0})
					local nb = vector.subtract(pos, {x=0, y=1, z=0})
					if minetest.env:get_node_light(np, 0.5) == 15
					and minetest.env:get_node_light(nb, 0.5) == 15
					and minetest.env:get_node(np).name == "air" then
						minetest.env:add_node(np, {name="weather:snow_cover"})
						return
					end
					if minetest.env:get_node_light(np, 0.5) == 15
					and minetest.env:get_node(np).name == "air" then
						minetest.env:add_node(np, {name="weather:snow_cover"})
					end
				end
			end
		end,
	}
end
