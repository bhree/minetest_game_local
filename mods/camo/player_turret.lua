ARROW_DAMAGE = 6
ARROW_VELOCITY = 4

player = {}

local function is_owner(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

camo = {}

camo.get_member_list = function(meta)
	local s = meta:get_string("members")
	local list = s:split(" ")
	return list
end

camo.set_member_list = function(meta, list)
	meta:set_string("members", table.concat(list, " "))
end

camo.is_member = function (meta, name)
	local list = camo.get_member_list(meta)
	for _, n in ipairs(list) do
		if n == name then
			return true
		end
	end
	return false
end

camo.add_member = function(meta, name)
	if camo.is_member(meta, name) then return end
	local list = camo.get_member_list(meta)
	table.insert(list,name)
	camo.set_member_list(meta,list)
end

camo.del_member = function(meta,name)
	local list = camo.get_member_list(meta)
	for i, n in ipairs(list) do
		if n == name then
			table.remove(list, i)
			break
		end
	end
	camo.set_member_list(meta,list)
end

-- Interface:

camo.generate_formspec = function(meta)
	if meta:get_int("page") == nil then meta:set_int("page", 0) end
	local formspec = "size[8,7]"
		.. "label[0,1.75;Members:]"
		.. "label[0,2;(ENTER to add)]"
	members = camo.get_member_list(meta)
	
	local npp = 12 -- Was 15 names per page, for the moment it's 4 * 4 (-1 for the + button).
	local s = 0
	local i = 0
	for _, member in ipairs(members) do
		if s < meta:get_int("page") * 15 then s = s + 1 else
			if i < npp then
				formspec = formspec .. "button["..(i % 4 * 2)..","
				..math.floor(i / 4 + 3)..";1.5,.5;camo_member;"..member.."]"
				formspec = formspec .. "button["..(i % 4 * 2 + 1.25)..","
				..math.floor(i / 4 + 3)..";.75,.5;camo_del_member_"..member..";X]"
			end
			i = i + 1
		end
	end
	local add_i = i
	if add_i < npp then
		formspec = formspec
		.. "field[" .. (add_i % 4 * 2 + 1 / 3) .. "," .. (math.floor(add_i / 4 + 3) + 1 / 3) .. ";1.433,.5;camo_add_member;;]"
	end
		formspec = formspec.."button_exit[1,6.2;2,0.5;close_me;OK]"
	return formspec
end

minetest.register_node("camo:turret_computer", {
	description = "Turret Computer",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"computer_top.png",
	         "computer_side.png",
	         "computer_side.png",
			 "computer_side.png",
			 "computer_back.png",
			 "computer_front.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=2},
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
	drop = 'camo:turret_computer',
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos, placer)
		meta:set_string("owner", "")
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Player Computer (owned by "..
				meta:get_string("owner")..")")
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		return is_owner(meta, player)
	end,
})

minetest.register_node("camo:player_turret", {
	description = "Anti Player Turret",
	tiles = {
		{
			name = "marssurvive_cam1.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	drawtype = "nodebox",
	walkable=false,
	groups = {dig_immediate = 3, stone = 1},
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {type="fixed",
		fixed={	{-0.2, -0.5, -0.2, 0.2, -0.4, 0.2},
			{-0.1, -0.2, -0.1, 0.1, -0.4, 0.1}}
	},
	drop = 'camo:player_turret',
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Player Turret (owned by "..
				meta:get_string("owner")..")")
		meta:set_string("members", "")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos, placer)
		meta:set_string("infotext", "Player Turret")
		meta:set_string("owner", "")
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		return is_owner(meta, player)
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		local meta = minetest.get_meta(pos)
		if is_owner(meta, clicker) == true then
			minetest.show_formspec(clicker:get_player_name(), 
			"camo_"..minetest.pos_to_string(pos), camo.generate_formspec(meta)
			)
		end
	end,
})

minetest.register_abm({
	nodenames = {"camo:player_turret"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
	local meta = minetest.get_meta(pos)
	local objects = minetest.env:get_objects_inside_radius(pos, 10)
	if minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).name == 'camo:turret_computer' then return end
		for _,obj in ipairs(objects) do
		    if obj:is_player() and is_owner(meta, obj) == false and camo.is_member(meta,obj:get_player_name()) == false then
				print("Turret shooting at player!")
				local obj_p = obj:getpos()
				local calc = {x=obj_p.x - pos.x,y=obj_p.y+0.5 - pos.y,z=obj_p.z - pos.z}
				local bullet=minetest.env:add_entity({x=pos.x,y=pos.y,z=pos.z}, "camo:arrow_entity")
				bullet:setvelocity({x=calc.x * ARROW_VELOCITY,y=calc.y * ARROW_VELOCITY,z=calc.z * ARROW_VELOCITY})
			    music_handle=minetest.sound_play("gun",
				{pos = pos, gain = 1.0, max_hear_distance = 15,})
			end
		end
	end
})

minetest.register_abm({
	nodenames = {"camo:player_turret"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
	local meta = minetest.get_meta(pos)
	local objects = minetest.env:get_objects_inside_radius(pos, 20)
	if minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).name ~= 'camo:turret_computer' then return end
		for _,obj in ipairs(objects) do
		    if obj:is_player() and is_owner(meta, obj) == false and camo.is_member(meta,obj:get_player_name()) == false then
				print("Turret with Computer shooting at player!")
				local obj_p = obj:getpos()
				local calc = {x=obj_p.x - pos.x,y=obj_p.y+0.5 - pos.y,z=obj_p.z - pos.z}
				local bullet=minetest.env:add_entity({x=pos.x,y=pos.y,z=pos.z}, "camo:arrow_entity")
				bullet:setvelocity({x=calc.x * ARROW_VELOCITY,y=calc.y * ARROW_VELOCITY,z=calc.z * ARROW_VELOCITY})
			    music_handle=minetest.sound_play("gun",
				{pos = pos, gain = 1.0, max_hear_distance = 25,}) 
			end
		end
	end
})

-- If name entered into camo formspec

minetest.register_on_player_receive_fields(function(player,formname,fields)
	if string.sub(formname, 0,string.len("camo_")) == "camo_" then
		local pos_s = string.sub(formname,string.len("camo_")+1)
		local pos = minetest.string_to_pos(pos_s)
		local meta = minetest.get_meta(pos)

		if meta:get_int("page") == nil then meta:set_int("page", 0) end

		if fields.camo_add_member then
			for _, i in ipairs(fields.camo_add_member:split(" ")) do
				camo.add_member(meta,i)
			end
		end

		for field, value in pairs(fields) do
			if string.sub(field, 0, string.len("camo_del_member_")) == "camo_del_member_" then
				camo.del_member(meta, string.sub(field,string.len("camo_del_member_")+1))
			end
		end

		if fields.camo_page_prev then
			meta:set_int("page",meta:get_int("page")-1)
		end

		if fields.camo_page_next then
			meta:set_int("page",meta:get_int("page")+1)
		end

		if fields.close_me then
			meta:set_int("page",meta:get_int("page"))
			else minetest.show_formspec(player:get_player_name(), formname,	camo.generate_formspec(meta))
		end
	end
end)

--Arrow stuff--

THROWING_ARROW_ENTITY={
	physical = false,
	timer=0,
	visual_size = {x=0.5, y=0.5},
	textures = {"bullet.png"},
	lastpos={},
	collisionbox = {-0.17,-0.17,-0.17,0.17,0.17,0.17},
}
-- Arrow_entity.on_step()--> called when arrow is moving
THROWING_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)
	if self.timer > 5 then
		self.object:remove()
	end
	-- When arrow is away from player (after 0.2 seconds): Cause damage to players
	if self.timer>0.2 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 5)
		for k, obj in pairs(objs) do
			if obj:is_player() then
				obj:set_hp(obj:get_hp()-ARROW_DAMAGE)
				self.object:remove()
			end
		end
	end

	-- Become item when hitting a node
	if self.lastpos.x~=nil then --If there is no lastpos for some reason
		if node.name ~= "air" and node.name ~= "camo:player_turret" then
			minetest.env:add_item(self.lastpos, 'throwing:arrow')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z} -- Set lastpos-->Item will be added at last pos outside the node
end

minetest.register_entity("camo:arrow_entity", THROWING_ARROW_ENTITY)
