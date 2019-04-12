local mm = dmobs.multimobs

if mm ~= 0 then

if dmobs.regulars then
	-- friendlies

	mobs:register_spawn("dmobs:nyan", {"default:pine_needles","default:leaves"}, 20, 10, 50000, 2, 31000,true)
	mobs:register_spawn("dmobs:nyan", {"nyanland:meseleaves"}, 20, 10, 15000, 2, 31000,true)

	mobs:register_spawn("dmobs:hedgehog", {"default:dirt_with_grass","default:pine_needles"}, 20, 10, 15000, 2, 2000)
	mobs:register_spawn("dmobs:whale", {"default:water_source"}, 20, 10, 15000, -20, 1000)
	mobs:register_spawn("dmobs:owl", {"default:leaves","default:tree"}, 20, 10, 15000, 2, 2000,false)
	mobs:register_spawn("dmobs:gnorm", {"default:dirt_with_grass","default:wood"}, 20, 10, 32000, 2, 31000)
	mobs:register_spawn("dmobs:tortoise", {"default:clay","default:sand"}, 20, 10, 15000, 2, 2000)
	mobs:register_spawn("dmobs:elephant", {"default:dirt_with_dry_grass","default:desert_sand"}, 20, 10, 15000, 2, 2000,true)
	mobs:register_spawn("dmobs:badger", {"default:dirt_with_grass","default:dirt"}, 20, 10, 15000, 2, 2000)
	mobs:register_spawn("dmobs:pig", {"default:pine_needles","default:leaves", "nyanland:cloudstone"}, 20, 10, 32000, 2, 31000,true)
	mobs:register_spawn("dmobs:panda", {"default:dirt_with_grass","ethereal:bamboo_dirt"}, 20, 10, 15000, 2, 2000,true)

	-- baddies

	mobs:register_spawn("dmobs:wasp", {"default:dirt_with_grass"}, 20, 10, 5000000/mm, 2, 2000)
	mobs:register_spawn("dmobs:wasp", {"dmobs:hive"}, 20, 10, 3200000/mm, 2, 2000)
	mobs:register_spawn("dmobs:wasp_leader", {"default:dirt_with_grass","dmobs:hive"}, 20, 10, 1000000/mm, 2, 2000)

	mobs:register_spawn("dmobs:golem", {"default:stone"}, 7, 0, 160000/mm, 2, 31000)
	mobs:register_spawn("dmobs:pig_evil", {"default:pine_needles","default:leaves"}, 20, 10, 320000/mm, 2, 31000)
	mobs:register_spawn("dmobs:fox", {"default:dirt_with_grass","default:dirt"}, 20, 10, 320000/mm, 2, 2000,false)

	if not dmobs.dragons then
		mobs:register_spawn("dmobs:orc", {"default:snow","default:snow_block", "default:desert_sand"}, 20, 10, 150000/mm, 2, 31000,false)
		mobs:register_spawn("dmobs:ogre", {"default:snow","default:dirt_with_dry_grass", "default:desert_sand"}, 20, 10, 150000/mm, 2, 31000,false)
	else
		mobs:register_spawn("dmobs:orc", {"default:snow","default:snow_block", "default:desert_sand"}, 20, 10, 35000/mm, 2, 31000,false)
		mobs:register_spawn("dmobs:ogre", {"default:snow","default:dirt_with_dry_grass", "default:desert_sand"}, 20, 10, 35000/mm, 2, 31000,false)
	end


	mobs:register_spawn("dmobs:rat", {"default:stone","default:sand"}, 20, 0, 320000/mm, 2, 2000,false)
	mobs:register_spawn("dmobs:treeman", {"default:leaves", "default:pine_needles"}, 7, 0, 160000/mm, 2, 2000)
	mobs:register_spawn("dmobs:skeleton", {"default:stone"}, 7, 0, 160000/mm, 2, 31000,false)
end
end

-- dragons

mobs:register_spawn("dmobs:dragon", {"default:leaves","default:dirt_with_grass"}, 20, 10, 6400000/mm, 2, 2000,true)

mobs:register_spawn("dmobs:dragon", {"space:moon_stone"}, 20, 10, 6400000/mm, 2, 2651, 31000)


if dmobs.dragons then
	mobs:register_spawn("dmobs:dragon2", {"default:pine_needles"}, 20, 10, 6400000/mm, 2, 2000,true)
	mobs:register_spawn("dmobs:dragon3", {"default:acacia_leaves","default:dirt_with_dry_grass"}, 20, 10, 6400000/mm, 2, 2000,true)
	mobs:register_spawn("dmobs:dragon4", {"default:jungleleaves"}, 20, 10, 6400000/mm, 2, 2000,true)
	mobs:register_spawn("dmobs:waterdragon", {"default:water_source"}, 20, 10, 3200000/mm, 1, 2000, false)
	mobs:register_spawn("dmobs:wyvern",	{"default:leaves"}, 20, 10, 3200000/mm, 1, 2000, false)
	mobs:register_spawn("dmobs:dragon_great", {"default:lava_source"}, 20, 0, 6400000/mm, 1, -21000, 1000, false)
	
	mobs:register_spawn("dmobs:wyvern",	{"space:moon_stone"}, 20, 10, 3200000/mm, 1, 2651, 31000)

end
