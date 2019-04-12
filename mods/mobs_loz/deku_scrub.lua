
mobs:register_mob("mobs_loz:deku_scrub", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 2,
	attack_type = "dogfight",
	shoot_offset = 2,
	hp_min = 10,
	hp_max = 25,
	armor = 120,
	collisionbox = {-0.4, 0, -0.2, 0.2, 1, 0.2},
	visual = "mesh",
	mesh = "deku_scrub.b3d",
	textures = {
		{"mobs_deku.png"},
	},
	visual_size = {x=0.6, y=0.6},
	blood_texture = "default_wood.png",
	view_range = 5,
	walk_velocity = 1.5,
	run_velocity = 6,
	runaway = true,
	runaway_timer = 10,
	jump = false,
	jump_height = 5,
	makes_footstep_sound = true,
	drops = {
		{name = "default:stick",
		chance = 9, min = 1, max = 2},
		{name = "nssm:life_energy",
		chance = 1, min = 1, max = 1,},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 20,
		speed_run = 25,
		stand_start = 1,
		stand_end = 40,
		walk_start = 10,
		walk_end = 30,
		run_start = 40,
		run_end = 60,
	},
})

mobs:register_egg("mobs_loz:deku_scrub", "Deku Scrub", "default_leaves.png", 1)



