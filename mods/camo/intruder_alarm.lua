player = {}

local function is_owner(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("camo:intruder_alarm", {
	description = "Intruder Alarm",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.187500,-0.437500,0.451994,0.187500,0.125000,0.500000}, 
			{0.125000,0.125000,0.462374,0.187500,0.500000,0.500000}, 
		},
	},
	tiles = {"computer_side.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=2},
	drop = 'camo:intruder_alarm',
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Intruder Alarm (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos, placer)
		meta:set_string("infotext", "Intruder Alarm")
		meta:set_string("owner", "")
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		return is_owner(meta, player)
	end,
})

minetest.register_abm({
	nodenames = {"camo:intruder_alarm"},
	interval = 2,
	chance = 1,
	action = function(pos, node, meta)
	local meta = minetest.get_meta(pos)
	local objects = minetest.get_objects_inside_radius(pos, 15)
		for _,obj in ipairs(objects) do
		    if obj:is_player() and is_owner(meta, obj) == false then
				local obj_p = obj:getpos()
			    music_handle=minetest.sound_play("intruder_alarm",
				{pos = pos, gain = 6, max_hear_distance = 50,}) 
			end
		end
	end
})
