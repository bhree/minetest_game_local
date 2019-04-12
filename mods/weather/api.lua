weather_mod.registered_downfalls = {}

local function check_modname_prefix(name)
	if name:sub(1,1) == ":" then
		-- If the name starts with a colon, we can skip the modname prefix
		-- mechanism.
		return name:sub(2)
	else
		-- Enforce that the name starts with the correct mod name.
		local modname = minetest.get_current_modname()
		if modname == nil then
			modname=name:split(":")[1]
		end
		local expected_prefix = modname .. ":"
		if name:sub(1, #expected_prefix) ~= expected_prefix then
			error("Name " .. name .. " does not follow naming conventions: " ..
				"\"" .. expected_prefix .. "\" or \":\" prefix required")
		end

		-- Enforce that the name only contains letters, numbers and underscores.
		local subname = name:sub(#expected_prefix+1)
		if subname:find("[^%w_]") then
			error("Name " .. name .. " does not follow naming conventions: " ..
				"contains unallowed characters")
		end

		return name
	end
end


function weather_mod.register_downfall(id,def)
	local name = check_modname_prefix(id)
	if name == "none" then error("\"none\" means none, thanks") end
	if weather_mod.registered_downfalls[name]~=nil then error(name.." is already registered") end
	local ndef = table.copy(def)
	if not ndef.min_pos then --minimum starting position
		ndef.min_pos = {x=-9, y=10, z=-9}
	end
	if not ndef.maxp then --maximum starting position
		ndef.max_pos = {x= 9, y=10, z= 9}
	end
	if not ndef.falling_speed then --y falling speed
		ndef.falling_speed = 10
	end
	if not ndef.amount then --number of textures spawned
		ndef.amount = 10
	end
	if not ndef.exptime then
		ndef.exptime = ndef.max_pos.y / (math.sqrt(ndef.falling_acceleration) + ndef.falling_speed)
	end
	if not ndef.texture then
		error("no texture given")
	end
	if not ndef.size then
		ndef.size = 25
	end
	if not ndef.enable_lightning then
		ndef.enable_lightning=false
	end
	weather_mod.registered_downfalls[name]=ndef
end

if minetest.get_modpath("lightning") then
	rawset(lightning,"auto",false)
end

function weather_mod.handle_lightning()
	if not minetest.get_modpath("lightning") then return end
	local current_downfall = weather_mod.registered_downfalls[weather.type]
	if not current_downfall then return end
	rawset(lightning,"auto",current_downfall.enable_lightning)
	if current_downfall.enable_lightning and math.random(1,2) == 1 then
		local time = math.floor(math.random(lightning.interval_low/2,lightning.interval_low))
		minetest.after(time, lightning.strike)
	end
end

minetest.register_globalstep(function()
	if weather.type=="none" then
		for id,_ in pairs(weather_mod.registered_downfalls) do
			if math.random(1, 50000) == 1 then
				weather.wind = {}
				weather.wind.x = math.random(0,10)
				weather.wind.y = 0
				weather.wind.z = math.random(0,10)
				weather.type = id
				weather_mod.handle_lightning()
			end
		end
	else
		if math.random(1, 10000) == 1 then
			weather.type = "none"
			if minetest.get_modpath("lightning") then
				rawset(lightning,"auto",false)
			end
		end
	end
	local current_downfall = weather_mod.registered_downfalls[weather.type]
	if current_downfall == nil then return end
	for _, player in ipairs(minetest.get_connected_players()) do
		local ppos = player:getpos()

		if ppos.y > 120 or ppos.y < -60 then return end

		local wind_pos = vector.multiply(weather.wind,-1)

		local minp = vector.add(vector.add(ppos, current_downfall.min_pos),wind_pos)
		local maxp = vector.add(vector.add(ppos, current_downfall.max_pos),wind_pos)

		local vel = {x=weather.wind.x,y=-current_downfall.falling_speed,z=weather.wind.z}
		local acc = {x=0, y=0, z=0}

		local exp = current_downfall.exptime

		if minetest.get_timeofday()*24000 >= 6000 and minetest.get_timeofday()*24000 <= 19000 then
			player:set_sky({r=111, g=111, b=111}, "plain", nil, true)
		end
		
		if minp.x < -2147480 or maxp.x < -2147480 then return end

		minetest.add_particlespawner({amount=current_downfall.amount, time=0.5,
			minpos=minp, maxpos=maxp,
			minvel=vel, maxvel=vel,
			minacc=acc, maxacc=acc,
			minexptime=exp, maxexptime=exp,
			minsize=current_downfall.size, maxsize=current_downfall.size,
			collisiondetection=true, collision_removal=true,
			vertical=true,
			texture=current_downfall.texture, player=player:get_player_name()})
--[[
		local sky = {}

		sky.bgcolor, sky.type, sky.textures = player:get_sky()
		sky_set = false
		local name = player:get_player_name()
		if ps[name] == nil then
			ps[name] = {p = player, sky = sky}
			player:set_sky(0xffffff, "plain", {})
			minetest.after(0.3, function()
				if player ~= nil then
					player:set_sky(nil, "regular", nil, true)
				end
			end)
		end
--]]
	end
end)
