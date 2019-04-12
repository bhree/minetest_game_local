minetest.register_node("camo:manual_alarm", {
	description = "Manually Operated Alarm",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	tiles = {"computer_back.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=2},
	drop = 'camo:manual_alarm',
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,-0.375000,0.500000,-0.375000}, 
			{-0.500000,-0.500000,0.375000,-0.375000,0.500000,0.500000}, 
			{0.375000,-0.500000,-0.500000,0.500000,0.500000,-0.375000},
			{0.375000,-0.500000,0.375000,0.500000,0.500000,0.500000},
			{-0.375000,-0.500000,-0.375000,0.375000,0.500000,0.375000}, 
			{-0.500000,-0.500000,-0.500000,0.500000,-0.437500,0.500000}, 
			{-0.500000,0.451557,-0.500000,0.500000,0.500000,0.500000}, 
		},
	},
	sounds = default.node_sound_stone_defaults(),
    on_rightclick = function (pos, node, puncher)
        node.name = "camo:manual_alarm_active"
        minetest.set_node(pos, node)
    end,
})

minetest.register_node("camo:manual_alarm_active", {
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	tiles = {"computer_back.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=2},
	drop = 'camo:manual_alarm',
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,-0.375000,0.500000,-0.375000}, 
			{-0.500000,-0.500000,0.375000,-0.375000,0.500000,0.500000}, 
			{0.375000,-0.500000,-0.500000,0.500000,0.500000,-0.375000},
			{0.375000,-0.500000,0.375000,0.500000,0.500000,0.500000},
			{-0.375000,-0.500000,-0.375000,0.375000,0.500000,0.375000}, 
			{-0.500000,-0.500000,-0.500000,0.500000,-0.437500,0.500000}, 
			{-0.500000,0.451557,-0.500000,0.500000,0.500000,0.500000}, 
		},
	},
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Manual Alarm (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos, placer)
		meta:set_string("infotext", "Manual Alarm")
		meta:set_string("owner", "")
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		return is_owner(meta, player)
	end,
})


minetest.register_abm({
	nodenames = {"camo:manual_alarm_active"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
	local meta = minetest.get_meta(pos)
	local objects = minetest.env:get_objects_inside_radius(pos, 5)
		for _,obj in ipairs(objects) do
		    if obj:is_player() and is_owner(meta, obj) == false then
				local obj_p = obj:getpos()
			    music_handle=minetest.sound_play("manual_alarm",
				{pos = pos, gain = 6.0, max_hear_distance = 50,})
			end
		end
	end
})