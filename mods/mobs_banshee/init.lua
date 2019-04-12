--[[
	
	Mobs Banshee - Adds banshees.
	Copyright © 2018 Hamlet <hamlatmesehub@riseup.net>

	Licensed under the EUPL, Version 1.2 or – as soon they will be
	approved by the European Commission – subsequent versions of the
	EUPL (the "Licence");
	You may not use this work except in compliance with the Licence.
	You may obtain a copy of the Licence at:

	https://joinup.ec.europa.eu/software/page/eupl
	https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32017D0863

	Unless required by applicable law or agreed to in writing,
	software distributed under the Licence is distributed on an
	"AS IS" basis,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
	implied.
	See the Licence for the specific language governing permissions
	and limitations under the Licence.

--]]


--
-- General variable
--

local banshee_daytime_check = minetest.settings:get_bool("banshee_daytime_check")

if (banshee_daytime_check == nil) then
	banshee_daytime_check = false
end


--
-- Function
--

local function day_or_night()
	local daytime = false
	local time = minetest.get_timeofday() * 24000

	if (time >= 4700) and (time <= 19250) then
		daytime = true

	else
		daytime = false

	end

	return daytime
end


--
-- Glowing node
--

minetest.register_node("mobs_banshee:glowing_node", {
	description = "Banshee's Glowing Node",
	groups = {not_in_creative_inventory = 1},
	drawtype = "airlike",
	walkable = false,
	pointable = false,
	diggable = false,
	climbable = false,
	buildable_to = true,
	floodable = true,
	light_source = 6,
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(15)
	end,
	on_timer = function(pos, elapsed)
		local daytime = day_or_night()

		if (daytime == true) then
			minetest.get_node_timer(pos):stop()
			minetest.swap_node(pos, {name = "air"})
		end

		return true
	end
})


--
-- Entity definition
--

mobs:register_mob("mobs_banshee:banshee", {
	type = "monster",
	hp_min = 20,
	hp_max = 20,
	armor = 100,
	walk_velocity = 1,
	run_velocity = 5.2,
	walk_chance = 1,
	jump = false,
	view_range = 15,
	damage = 9999,
	water_damage = 0,
	lava_damage = 0,
	light_damage = 9999,
	suffocation = false,
	floats = 0,
	reach = 15,
	attack_type = "dogfight",
	specific_attack = {"player", "mobs_humans:human"},
	blood_amount = 0,
	immune_to = {
		{"all"}
	},
	makes_footstep_sound = false,
	sounds = {
		distance = 30,
		random = "mobs_banshee_1",
		war_cry = "mobs_banshee_2",
		attack = "mobs_banshee_2"
	},
	visual = "mesh",
	visual_size = {x=3, y=3.6},
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.75, 0.4},
	textures = {
		{"horror_ghost.png"}
--		{"mobs_banshee_2.png"}
	},
	mesh = "ghost.b3d",
	animation = {
		stand_start = 81,
		stand_end = 160,
		stand_speed = 30,
		walk_start = 168,
		walk_end = 187,
		walk_speed = 30,
		run_start = 168,
		run_end = 187,
		run_speed = 30,
	},

	on_spawn = function(self)
		self.spawned = true
		self.counter = 0
		self.object:set_properties({
			counter = self.counter,
			spawned = self.spawned
		})

		local position = self.object:get_pos()
		minetest.place_node(position, {name = "mobs_banshee:glowing_node"})
	end,

	on_rightclick =function(self,clicker)
		local mobname = "kill_mod:deathnote"
		if clicker:get_wielded_item():get_name() == "animalmaterials:sword_deamondeath" and clicker:get_inventory():room_for_item("main", mobname) then
			local new_stack = ItemStack(mobname)
			local inv = clicker:get_inventory()

			if inv:room_for_item("main", new_stack) then
				inv:add_item("main", new_stack)
			else
				minetest.add_item(clicker:get_pos(), new_stack)
			end

			self.object:remove()
		end
	end,

	do_custom = function(self, dtime)
		if (banshee_daytime_check == true) then

			if (self.light_damage ~= 0) then
				self.light_damage = 0

				self.object:set_properties({
					light_damage = self.light_damage
				})
			end

			if (self.spawned == true) then
				local daytime = day_or_night()

				if (daytime == true) then
					self.object:remove()

				else
					self.spawned = false
					self.object:set_properties({
						spawned = self.spawned
					})

				end

			else
				if (self.counter < 15.0) then
					self.counter = self.counter + dtime

					self.object:set_properties({
						counter = self.counter
					})

				else
					local daytime = day_or_night()

					if (daytime == true) then
						self.object:remove()

					else
						self.counter = 0

						self.object:set_properties({
							counter = self.counter
						})

					end
				end
			end
		else
			if (self.light_damage ~= 9999) then
				self.light_damage = 9999

				self.object:set_properties({
					light_damage = self.light_damage
				})
			end
		end
	end
})


--
-- Entity spawners
--

mobs:spawn({
	name = "mobs_banshee:banshee",
	nodes = {"bones:bones", "mobs_humans:human_bones"},
	neighbors = {"air"},
	max_light = 4,
	min_light = 0,
	interval = 60,
	chance = 7,
	active_object_count = 1,
	min_height = -30912,
	max_height = 31000,
	day_toggle = false
})

mobs:register_egg("mobs_banshee:banshee",
	"Banshee",
	"default_stone.png", -- the texture displayed for the egg in inventory
	1, -- egg image in front of your texture (1 = yes, 0 = no)
	false -- if set to true this stops spawn egg appearing in creative
)


--
-- Alias
--

mobs:alias_mob("mobs:banshee", "mobs_banshee:banshee")


--
-- Minetest engine debug logging
--

if (minetest.settings:get("debug_log_level") == nil)
or (minetest.settings:get("debug_log_level") == "action")
or (minetest.settings:get("debug_log_level") == "info")
or (minetest.settings:get("debug_log_level") == "verbose")
then
	minetest.log("action", "[Mod] Mobs Banshee [v0.3.1] loaded.")
end
