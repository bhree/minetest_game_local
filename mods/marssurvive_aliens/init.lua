minetest.register_entity("marssurvive_aliens:bullet3",{
	hp_max = 1,
	physical = false,
	weight = 5,
	collisionbox = {-0.17,-0.17,-0.17, 0.17,0.17,0.17},
	--collisionbox = {0,0,0, 0,0,0},
	visual = "sprite",
	visual_size = {x=0, y=0},
	textures = {"default_mese_block.png"},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = false,
	makes_footstep_sound = false,
	automatic_rotate = false,
	timer=0,
	--timer2=0,
	bullet=1,
	on_step= function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer > 5 then
			self.object:remove()
		end	
		if self.timer<0.2 then return self end
		local pos=self.object:getpos()
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 2)) do
			if ob:get_luaentity() and ob:get_luaentity().type=="monster" then
				--if not ob:get_armor_groups().immortal then
					--ob:set_hp(ob:get_hp()-3)
					ob:punch(self.object, 1.0, {full_punch_interval=1.0,damage_groups={fleshy=6, knockback=3},}, nil)
					--self.timer2=2
					--print("OUCH!!")
					self.object:remove()
					return self
				--end
			end
		end
		self.timer=0
		--self.timer2=self.timer2+dtime
		--if self.timer2>1 or minetest.registered_nodes[minetest.get_node(self.object:getpos()).name].walkable then self.object:remove() end
	end,
})


minetest.register_node("marssurvive_aliens:secam_off", {
	description = "Security cam (off)" ,
	tiles = {"marssurvive_cam2.png"},
	drawtype = "nodebox",
	walkable=false,
	groups = {dig_immediate = 3,stone=1,},
	sounds = default.node_sound_glass_defaults(),
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {type="fixed",
		fixed={	{-0.2, -0.5, -0.2, 0.2, -0.4, 0.2},
			{-0.1, -0.2, -0.1, 0.1, -0.4, 0.1}}

	},
	drop = "marssurvive_aliens:secam_off",
	on_place = minetest.rotate_node,
	on_construct = function(pos)
		minetest.get_meta(pos):set_string("infotext","click to activate and secure")
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		minetest.set_node(pos, {name ="marssurvive_aliens:secam", param1 = node.param1, param2 = node.param2})
		minetest.get_node_timer(pos):start(3)
	end,
})

minetest.register_node("marssurvive_aliens:secam", {
	description = "Security cam",
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
	groups = {dig_immediate = 3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {type="fixed",
		fixed={	{-0.2, -0.5, -0.2, 0.2, -0.4, 0.2},
			{-0.1, -0.2, -0.1, 0.1, -0.4, 0.1}}
	},
	drop = "marssurvive_aliens:secam_off",
	on_timer=function(pos, elapsed)
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 30)) do
			if ob:get_luaentity() and ob:get_luaentity().type=="monster" then
				local v=ob:getpos()
				
				if not ob:get_luaentity() then v.y=v.y+1 end
				
				local s={x=(v.x-pos.x)*3,y=(v.y-pos.y)*3,z=(v.z-pos.z)*3}
				local m=minetest.add_entity(pos, "marssurvive_aliens:bullet3")
				m:setvelocity(s)
				minetest.sound_play("rangedweapons_machinegun", {pos=pos, gain = 1, max_hear_distance = 15,})
				minetest.after((math.random(1,9)*0.1), function(pos,s,v)
					local m=minetest.add_entity(pos, "marssurvive_aliens:bullet3")
					m:setvelocity(s)
					minetest.sound_play("rangedweapons_machinegun", {pos=pos, gain = 1, max_hear_distance = 15,})
					end, pos, s, v)
				return true
			end
		end
		return true
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		minetest.set_node(pos, {name ="marssurvive_aliens:secam_off", param1 = node.param1, param2 = node.param2})
	end,
	on_construct = function(pos)
		minetest.get_meta(pos):set_string("infotext","click to activate and secure")
		minetest.get_node_timer(pos):start(3)
	end,
})

minetest.register_craft({
	output = "marssurvive_aliens:secam_off",
	recipe = {
		{"default:tin_ingot", "dye:black", "default:tin_ingot"},
		{"default:glass", "rangedweapons:gun_power_core", "default:gold_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})
