mobs = {}
function mobs:register_mob(name, def)
	minetest.register_entity(name, {
		hp_max = def.hp_max,
		physical = true,
		collisionbox = def.collisionbox,
		stepheight = def.stepheight,
		visual = def.visual,
		visual_size = def.visual_size,
		mesh = def.mesh,
		textures = def.textures,
		makes_footstep_sound = def.makes_footstep_sound,
		view_range = def.view_range,
		walk_velocity = def.walk_velocity,
		run_velocity = def.run_velocity,
		damage = def.damage,
		light_damage = def.light_damage,
		water_damage = def.water_damage,
		lava_damage = def.lava_damage,
		disable_fall_damage = def.disable_fall_damage,
		drops = def.drops,
		armor = def.armor,
		drawtype = def.drawtype,
		on_rightclick = def.on_rightclick,
		type = def.type,
		attack_type = def.attack_type,
		arrow = def.arrow,
		shoot_interval = def.shoot_interval,
		sounds = def.sounds,
		animation = def.animation,

		timer = 0,
		env_damage_timer = 0, -- only if state = "attack"
		attack = {player=nil, dist=nil},
		state = "stand",
		v_start = false,
		old_y = nil,


		set_velocity = function(self, v)
			local yaw = self.object:getyaw()
			if self.drawtype == "side" then
				yaw = yaw+(math.pi/2)
			end
			local x = math.sin(yaw) * -v
			local z = math.cos(yaw) * v
			self.object:setvelocity({x=x, y=self.object:getvelocity().y, z=z})
		end,

		get_velocity = function(self)
			local v = self.object:getvelocity()
			return (v.x^2 + v.z^2)^(0.5)
		end,

		set_animation = function(self, type)
			if not self.animation then
				return
			end
			if not self.animation.current then
				self.animation.current = ""
			end
			if type == "stand" and self.animation.current ~= "stand" then
				if
					self.animation.stand_start
					and self.animation.stand_end
					and self.animation.speed_normal
				then
					self.object:set_animation(
						{x=self.animation.stand_start,y=self.animation.stand_end},
						self.animation.speed_normal, 0
					)
					self.animation.current = "stand"
				end
			elseif type == "walk" and self.animation.current ~= "walk"  then
				if
					self.animation.walk_start
					and self.animation.walk_end
					and self.animation.speed_normal
				then
					self.object:set_animation(
						{x=self.animation.walk_start,y=self.animation.walk_end},
						self.animation.speed_normal, 0
					)
					self.animation.current = "walk"
				end
			elseif type == "run" and self.animation.current ~= "run"  then
				if
					self.animation.run_start
					and self.animation.run_end
					and self.animation.speed_run
				then
					self.object:set_animation(
						{x=self.animation.run_start,y=self.animation.run_end},
						self.animation.speed_run, 0
					)
					self.animation.current = "run"
				end
			elseif type == "punch" and self.animation.current ~= "punch"  then
				if
					self.animation.punch_start
					and self.animation.punch_end
					and self.animation.speed_normal
				then
					self.object:set_animation(
						{x=self.animation.punch_start,y=self.animation.punch_end},
						self.animation.speed_normal, 0
					)
					self.animation.current = "punch"
				end
			end
		end,

		on_step = function(self, dtime)
			if self.type == "monster" and minetest.setting_getbool("only_peaceful_mobs") then
				self.object:remove()
			end

			if self.object:getvelocity().y > 0.1 then
				local yaw = self.object:getyaw()
				if self.drawtype == "side" then
					yaw = yaw+(math.pi/2)
				end
				local x = math.sin(yaw) * -2
				local z = math.cos(yaw) * 2
				self.object:setacceleration({x=x, y=-10, z=z})
			else
				self.object:setacceleration({x=0, y=-10, z=0})
			end

			if self.disable_fall_damage and self.object:getvelocity().y == 0 then
				if not self.old_y then
					self.old_y = self.object:getpos().y
				else
					local d = self.old_y - self.object:getpos().y
					if d > 5 then
						local damage = d-5
						self.object:set_hp(self.object:get_hp()-damage)
						if self.object:get_hp() == 0 then
							self.object:remove()
						end
					end
					self.old_y = self.object:getpos().y
				end
			end

			self.timer = self.timer+dtime
			if self.state ~= "attack" then
				if self.timer < 1 then
					return
				end
				self.timer = 0
			end

			if self.sounds and self.sounds.random and math.random(1, 100) <= 1 then
				minetest.sound_play(self.sounds.random, {object = self.object})
			end

			local do_env_damage = function(self)
				local pos = self.object:getpos()
				local n = minetest.get_node(pos)

				if self.light_damage and self.light_damage ~= 0
					and pos.y>0
					and minetest.get_node_light(pos)
					and minetest.get_node_light(pos) > 4
					and minetest.get_timeofday() > 0.2
					and minetest.get_timeofday() < 0.8
				then
					self.object:set_hp(self.object:get_hp()-self.light_damage)
					if self.object:get_hp() == 0 then
						self.object:remove()
					end
				end

				if self.water_damage and self.water_damage ~= 0 and
					minetest.get_item_group(n.name, "water") ~= 0
				then
					self.object:set_hp(self.object:get_hp()-self.water_damage)
					if self.object:get_hp() == 0 then
						self.object:remove()
					end
				end

				if self.lava_damage and self.lava_damage ~= 0 and
					minetest.get_item_group(n.name, "lava") ~= 0
				then
					self.object:set_hp(self.object:get_hp()-self.lava_damage)
					if self.object:get_hp() == 0 then
						self.object:remove()
					end
				end
			end

			self.env_damage_timer = self.env_damage_timer + dtime
			if self.state == "attack" and self.env_damage_timer > 1 then
				self.env_damage_timer = 0
				do_env_damage(self)
			elseif self.state ~= "attack" then
				do_env_damage(self)
			end

			if self.type == "monster" and minetest.setting_getbool("enable_damage") then
				for _,player in pairs(minetest.get_connected_players()) do
					local s = self.object:getpos()
					local p = player:getpos()
					local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
					if dist < self.view_range then
						if self.attack.dist then
							if self.attack.dist < dist then
								self.state = "attack"
								self.attack.player = player
								self.attack.dist = dist
							end
						else
							self.state = "attack"
							self.attack.player = player
							self.attack.dist = dist
						end
					end
				end
			end

			if self.state == "stand" then
				if math.random(1, 4) == 1 then
					self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/180*math.pi))
				end
				self.set_velocity(self, 0)
				self.set_animation(self, "stand")
				if math.random(1, 100) <= 50 then
					self.set_velocity(self, self.walk_velocity)
					self.state = "walk"
					self.set_animation(self, "walk")
				end
			elseif self.state == "walk" then
				if math.random(1, 100) <= 30 then
					self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/180*math.pi))
				end
				if self.get_velocity(self) <= 0.5 and self.object:getvelocity().y == 0 then
					local v = self.object:getvelocity()
					v.y = 6
					self.object:setvelocity(v)
				end
				self:set_animation("walk")
				self.set_velocity(self, self.walk_velocity)
				if math.random(1, 100) <= 10 then
					self.set_velocity(self, 0)
					self.state = "stand"
					self:set_animation("stand")
				end
			elseif self.state == "attack" and self.attack_type == "dogfight" then
				if not self.attack.player or not self.attack.player:is_player() then
					self.state = "stand"
					self:set_animation("stand")
					return
				end
				local s = self.object:getpos()
				local p = self.attack.player:getpos()
				local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
				if dist > self.view_range or self.attack.player:get_hp() <= 0 then
					self.state = "stand"
					self.v_start = false
					self.set_velocity(self, 0)
					self.attack = {player=nil, dist=nil}
					self:set_animation("stand")
					return
				else
					self.attack.dist = dist
				end

				local vec = {x=p.x-s.x, y=p.y-s.y, z=p.z-s.z}
				local yaw = math.atan(vec.z/vec.x)+math.pi/2
				if self.drawtype == "side" then
					yaw = yaw+(math.pi/2)
				end
				if p.x > s.x then
					yaw = yaw+math.pi
				end
				self.object:setyaw(yaw)
				if self.attack.dist > 2 then
					if not self.v_start then
						self.v_start = true
						self.set_velocity(self, self.run_velocity)
					else
						if self.get_velocity(self) <= 0.5 and self.object:getvelocity().y == 0 then
							local v = self.object:getvelocity()
							v.y = 6
							self.object:setvelocity(v)
						end
						self.set_velocity(self, self.run_velocity)
					end
					self:set_animation("run")
				else
					self.set_velocity(self, 0)
					self:set_animation("punch")
					self.v_start = false
					if self.timer > 1 then
						self.timer = 0
						if self.sounds and self.sounds.attack then
							minetest.sound_play(self.sounds.attack, {object = self.object})
						end
						self.attack.player:punch(self.object, 1.0,  {
							full_punch_interval=1.0,
							damage_groups = {fleshy=self.damage}
						}, vec)
					end
				end
			elseif self.state == "attack" and self.attack_type == "shoot" then
				if not self.attack.player or not self.attack.player:is_player() then
					self.state = "stand"
					self:set_animation("stand")
					return
				end
				local s = self.object:getpos()
				local p = self.attack.player:getpos()
				local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
				if dist > self.view_range or self.attack.player:get_hp() <= 0 then
					self.state = "stand"
					self.v_start = false
					self.set_velocity(self, 0)
					self.attack = {player=nil, dist=nil}
					self:set_animation("stand")
					return
				else
					self.attack.dist = dist
				end

				local vec = {x=p.x-s.x, y=p.y-s.y, z=p.z-s.z}
				local yaw = math.atan(vec.z/vec.x)+math.pi/2
				if self.drawtype == "side" then
					yaw = yaw+(math.pi/2)
				end
				if p.x > s.x then
					yaw = yaw+math.pi
				end
				self.object:setyaw(yaw)
				self.set_velocity(self, 0)

				if self.timer > self.shoot_interval and math.random(1, 100) <= 60 then
					self.timer = 0

					self:set_animation("punch")

					if self.sounds and self.sounds.attack then
						minetest.sound_play(self.sounds.attack, {object = self.object})
					end

					local p = self.object:getpos()
					p.y = p.y + (self.collisionbox[2]+self.collisionbox[5])/2
					local obj = minetest.add_entity(p, self.arrow)
					local amount = (vec.x^2+vec.y^2+vec.z^2)^0.5
					local v = obj:get_luaentity().velocity
					vec.y = vec.y+1
					vec.x = vec.x*v/amount
					vec.y = vec.y*v/amount
					vec.z = vec.z*v/amount
					obj:setvelocity(vec)
				end
			end
		end,

		on_activate = function(self, staticdata)
			self.object:set_armor_groups({fleshy=self.armor})
			self.object:setacceleration({x=0, y=-10, z=0})
			self.state = "stand"
			self.object:setvelocity({x=0, y=self.object:getvelocity().y, z=0})
			self.object:setyaw(math.random(1, 360)/180*math.pi)
			if self.type == "monster" and minetest.setting_getbool("only_peaceful_mobs") then
				self.object:remove()
			end
		end,

		on_punch = function(self, hitter)
			if self.object:get_hp() <= 0 then
				if hitter and hitter:is_player() and hitter:get_inventory() then
					for _,drop in ipairs(self.drops) do
						if math.random(1, drop.chance) == 1 then
							hitter:get_inventory():add_item("main", ItemStack(drop.name.." "..math.random(drop.min, drop.max)))
						end
					end
				end
			end
		end,

	})
end

local function min(x, y)
	if x < y then return x else return y end
end

local function distance(a, b)
	return (a.x - b.x)^2 + (a.y - b.y)^2 + (a.z - b.z)^2
end

local function distance_to_next_player(pos)
	local min_dist = 200000 -- longer than minetest world diagonal
	for _, p in pairs(minetest.get_connected_players()) do
		min_dist = min(min_dist, distance(pos, p:getpos()))
	end
	return min_dist
end

mobs.spawning_mobs = {}
function mobs:register_spawn(name, nodes, max_light, min_light, chance, active_object_count, max_height)
	mobs.spawning_mobs[name] = true
	minetest.register_abm({
		nodenames = nodes,
		neighbors = {"air"},
		interval = 30,
		chance = chance,
		action = function(pos, node, _, active_object_count_wider)
			if active_object_count_wider > active_object_count then
				return
			end
			if not mobs.spawning_mobs[name] then
				return
			end
			if distance_to_next_player(pos) < 45 then
				return -- TODO: do not use magic value!
			end
			pos.y = pos.y+1
			if not minetest.get_node_light(pos) then
				return
			end
			if minetest.get_node_light(pos) > max_light then
				return
			end
			if minetest.get_node_light(pos) < min_light then
				return
			end
			if pos.y > max_height then
				return
			end
			if minetest.get_node(pos).name ~= "air" then
				return
			end
			pos.y = pos.y+1
			if minetest.get_node(pos).name ~= "air" then
				return
			end

			if minetest.setting_getbool("display_mob_spawn") then
				minetest.chat_send_all("[mobs] Add "..name.." at "..minetest.pos_to_string(pos))
			end
			minetest.add_entity(pos, name)
		end
	})
end

function mobs:register_spawning_mob(mob)
	mobs:register_mob(mob.resource_name, mob)
	mobs:register_spawn(
		mob.resource_name,
		mob.spawn_ground,
		mob.spawn_max_light,
		mob.spawn_min_light,
		mob.spawn_inverse_chance,
		mob.spawn_max_active_objects,
		mob.spawn_max_height)
	-- activate and deactivate in waves
	local deactivate
	local activate
	activate = function ()
		mobs.spawning_mobs[mob.resource_name] = true
		minetest.after(mob.spawn_wave_active_time, deactivate)
		--minetest.chat_send_all("wave active")
	end
	deactivate = function ()
		mobs.spawning_mobs[mob.resource_name] = false
		minetest.after(mob.spawn_wave_inactive_time, activate)
		--minetest.chat_send_all("wave inactive")
	end
	deactivate()
end


--Green Soldier--

mobs:register_spawning_mob({
	resource_name = "camo:green_soldier",
	type = "npc",
	hp_max = 20,
	follow = "default:torch",
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	stepheight = 20,
	visual = "mesh",
	mesh = "camo_soldier.x",
	textures = {"soldier_green.png"},
	visual_size = {x=1,y=1},
	makes_footstep_sound = true,
	view_range = 50,
	walk_velocity = 1.0,
	run_velocity = 6,
	drops = {},
	light_resistant = true,
	armor = 80,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 197,
		punch_start = 189,
		punch_end = 198,
	},
	spawn_ground = {
		"default:stone_with_diamond",
	},
	spawn_min_light = 8,
	spawn_max_light = 15,
	spawn_inverse_chance = 400000,
	spawn_max_active_objects = 1,
	spawn_max_height = -30999,
	spawn_wave_inactive_time = 200,
	spawn_wave_active_time = 50,
		on_rightclick = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		self.object:remove()
		if puncher and puncher:is_player() then
			puncher:get_inventory():add_item("main", "camo:green_soldier")
		end
	end,
})

minetest.register_craftitem("camo:green_soldier" ,{
	description = "Green Soldier NPC Spawnegg",
	inventory_image = "soldier_green_inv.png",
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return
			end
			pointed_thing.under.y = pointed_thing.under.y + 3
			minetest.env:add_entity(pointed_thing.under, "camo:green_soldier")
			itemstack:take_item()
			return itemstack
		end,
})

--Yellow Soldier--

mobs:register_spawning_mob({
	resource_name = "camo:yellow_soldier",
	type = "npc",
	hp_max = 20,
	follow = "default:torch",
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	stepheight = 20,
	visual = "mesh",
	mesh = "camo_soldier.x",
	textures = {"soldier_yellow.png"},
	visual_size = {x=1,y=1},
	makes_footstep_sound = true,
	view_range = 50,
	walk_velocity = 1.0,
	run_velocity = 6,
	drops = {},
	light_resistant = true,
	armor = 80,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 197,
		punch_start = 189,
		punch_end = 198,
	},
	spawn_ground = {
		"default:stone_with_diamond",
	},
	spawn_min_light = 8,
	spawn_max_light = 15,
	spawn_inverse_chance = 400000,
	spawn_max_active_objects = 1,
	spawn_max_height = -30999,
	spawn_wave_inactive_time = 200,
	spawn_wave_active_time = 50,
		on_rightclick = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		self.object:remove()
		if puncher and puncher:is_player() then
			puncher:get_inventory():add_item("main", "camo:yellow_soldier")
		end
	end,
})

minetest.register_craftitem("camo:yellow_soldier" ,{
	description = "Yellow Soldier NPC Spawnegg",
	inventory_image = "soldier_yellow_inv.png",
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return
			end
			pointed_thing.under.y = pointed_thing.under.y + 3
			minetest.env:add_entity(pointed_thing.under, "camo:yellow_soldier")
			itemstack:take_item()
			return itemstack
		end,
})

--Red Soldier--

mobs:register_spawning_mob({
	resource_name = "camo:red_soldier",
	type = "npc",
	hp_max = 20,
	follow = "default:torch",
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	stepheight = 20,
	visual = "mesh",
	mesh = "camo_soldier.x",
	textures = {"soldier_red.png"},
	visual_size = {x=1,y=1},
	makes_footstep_sound = true,
	view_range = 50,
	walk_velocity = 1.0,
	run_velocity = 6,
	drops = {},
	light_resistant = true,
	armor = 80,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 197,
		punch_start = 189,
		punch_end = 198,
	},
	spawn_ground = {
		"default:stone_with_diamond",
	},
	spawn_min_light = 8,
	spawn_max_light = 15,
	spawn_inverse_chance = 400000,
	spawn_max_active_objects = 1,
	spawn_max_height = -30999,
	spawn_wave_inactive_time = 200,
	spawn_wave_active_time = 50,
		on_rightclick = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		self.object:remove()
		if puncher and puncher:is_player() then
			puncher:get_inventory():add_item("main", "camo:red_soldier")
		end
	end,
})

minetest.register_craftitem("camo:red_soldier" ,{
	description = "Red Soldier NPC Spawnegg",
	inventory_image = "soldier_red_inv.png",
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return
			end
			pointed_thing.under.y = pointed_thing.under.y + 3
			minetest.env:add_entity(pointed_thing.under, "camo:red_soldier")
			itemstack:take_item()
			return itemstack
		end,
})

--Blue Soldier--

mobs:register_spawning_mob({
	resource_name = "camo:blue_soldier",
	type = "npc",
	hp_max = 20,
	follow = "default:torch",
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	stepheight = 20,
	visual = "mesh",
	mesh = "camo_soldier.x",
	textures = {"soldier_blue.png"},
	visual_size = {x=1,y=1},
	makes_footstep_sound = true,
	view_range = 50,
	walk_velocity = 1.0,
	run_velocity = 6,
	drops = {},
	light_resistant = true,
	armor = 80,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 197,
		punch_start = 189,
		punch_end = 198,
	},
	spawn_ground = {
		"default:stone_with_diamond",
	},
	spawn_min_light = 8,
	spawn_max_light = 15,
	spawn_inverse_chance = 400000,
	spawn_max_active_objects = 1,
	spawn_max_height = -30999,
	spawn_wave_inactive_time = 200,
	spawn_wave_active_time = 50,
		on_rightclick = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		self.object:remove()
		if puncher and puncher:is_player() then
			puncher:get_inventory():add_item("main", "camo:blue_soldier")
		end
	end,
})

minetest.register_craftitem("camo:blue_soldier" ,{
	description = "Blue Soldier NPC Spawnegg",
	inventory_image = "soldier_blue_inv.png",
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return
			end
			pointed_thing.under.y = pointed_thing.under.y + 3
			minetest.env:add_entity(pointed_thing.under, "camo:blue_soldier")
			itemstack:take_item()
			return itemstack
		end,
})