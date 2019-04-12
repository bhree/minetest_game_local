-- Needed variables
local pvptable = {}
local olditems = {{}}
local olditemscraft = {{}}
local olditemsprev = {{}}
--[[
local function pvp_toggle(player)
	localname = player:get_player_name()
	if pvptable[localname] == 0 then

		pvptable[localname] = 1

		minetest.chat_send_player(localname,
			"PvP was enabled for "..localname)

			player:hud_remove(pvpdisabled)

			player:hud_remove(nopvppic)

			pvpenabled = player:hud_add({
				hud_elem_type = "text",
				position = {x = 1, y = 0},
				offset = {x=-125, y = 20},
				scale = {x = 100, y = 100},
				text = "PvP is enabled for you!",
				number = 0xFF0000 -- Red
			})
			pvppic = player:hud_add({
				hud_elem_type = "image",
				position = {x = 1, y = 0},
				offset = {x=-210, y = 20},
				scale = {x = 1, y = 1},
				text = "pvp.png"
			})
		return

	else

		pvptable[localname] = 0

		minetest.chat_send_player(localname,
			"PvP was disabled for "..localname)

			player:hud_remove(pvpenabled)

			player:hud_remove(pvppic)
			
			pvpdisabled = player:hud_add({
				hud_elem_type = "text",
				position = {x = 1, y = 0},
				offset = {x=-125, y = 20},
				scale = {x = 100, y = 100},
				text = "PvP is disabled for you!",
				number = 0x7DC435
			})
			nopvppic = player:hud_add({
				hud_elem_type = "image",
				position = {x = 1, y = 0},
				offset = {x = -210, y = 20},
				scale = {x = 1, y = 1},
				text = "nopvp.png"
			})
		return
	end
end
--]]
--unified_inventory.register_button("pvp", {
--	type = "image",
--	image = "pvp.png",
--	action = pvp_toggle
--})

minetest.register_on_joinplayer(function(player)

	local pos = player:getpos()
	if (pos.x < -24974 and pos.x > -25003) and
		(pos.y > -3 and pos.y < 19) and
		(pos.z < -25029 and pos.z > -25049) then
			pvpdisabled = player:hud_add({
				hud_elem_type = "text",
				position = {x = 1, y = 0},
				offset = {x=-125, y = 20},
				scale = {x = 100, y = 100},
				text = "PvP is disabled for you!",
				number = 0x7DC435
			})
			nopvppic = player:hud_add({
				hud_elem_type = "image",
				position = {x = 1, y = 0},
				offset = {x = -210, y = 20},
				scale = {x = 1, y = 1},
				text = "nopvp.png"
			})
			localname = player:get_player_name()
			pvptable[localname] = 0
	else
--[[
			pvpenabled = player:hud_add({
				hud_elem_type = "text",
				position = {x = 1, y = 0},
				offset = {x=-125, y = 20},
				scale = {x = 100, y = 100},
				text = "PvP is enabled for you!",
				number = 0xFF0000 -- Red
			})
			pvppic = player:hud_add({
				hud_elem_type = "image",
				position = {x = 1, y = 0},
				offset = {x=-210, y = 20},
				scale = {x = 1, y = 1},
				text = "pvp.png"
			})
--]]
			localname = player:get_player_name()
			pvptable[localname] = 1
	end
end)

minetest.register_on_dieplayer(function(player)

	player:hud_remove(pvpdisabled)

	player:hud_remove(nopvppic)

--[[
	pvpenabled = player:hud_add({
				hud_elem_type = "text",
				position = {x = 1, y = 0},
				offset = {x=-125, y = 20},
				scale = {x = 100, y = 100},
				text = "PvP is enabled for you!",
				number = 0xFF0000 -- Red
	})
	pvppic = player:hud_add({
				hud_elem_type = "image",
				position = {x = 1, y = 0},
				offset = {x=-210, y = 20},
				scale = {x = 1, y = 1},
				text = "pvp.png"
	})
--]]

	localname = player:get_player_name()	
	pvptable[localname] = 1
end)

if minetest.setting_getbool("enable_pvp") then
	if minetest.register_on_punchplayer then
		minetest.register_on_punchplayer(
			function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage, pvp)
			
			if not hitter:is_player() then
				return false
			end
			
			local localname = player:get_player_name()
			local hittername = hitter:get_player_name()
			
				if pvptable[localname] == 1 and pvptable[hittername] == 1 then
					return false
				else
					--minetest.chat_send_player(localname,
					--"The player "..hittername.." is trying to attack you.")
					minetest.chat_send_player(hittername,
					"The player "..localname.." does not have PvP activated.")
					return true
				end
		end)
	end
end

	
minetest.register_chatcommand("tutorial", {
	description = "Tutorial and features showcase",
	privs = {interact = true},
	func = function(name)

		local player = minetest.get_player_by_name(name)		
		local pos = player:getpos()
		localname = name

		if (pos.x < -24974 and pos.x > -25003) and
			(pos.y > -3 and pos.y < 19) and
			(pos.z < -25029 and pos.z > -25049) then
				minetest.chat_send_player(localname, "Here you are")
				return
		end		

		pvptable[localname] = 0
		minetest.chat_send_player(localname,
			"PvP was disabled for "..localname)

--		player:hud_remove(pvpenabled)

--		player:hud_remove(pvppic)
			
		pvpdisabled = player:hud_add({
				hud_elem_type = "text",
				position = {x = 1, y = 0},
				offset = {x=-125, y = 20},
				scale = {x = 100, y = 100},
				text = "PvP is disabled for you!",
				number = 0x7DC435
			})
		nopvppic = player:hud_add({
				hud_elem_type = "image",
				position = {x = 1, y = 0},
				offset = {x = -210, y = 20},
				scale = {x = 1, y = 1},
				text = "nopvp.png"
			})
		local pos = {x = -24978, y = 2, z = -25047}
		player:set_pos(pos)
		olditems[localname] = player:get_inventory():get_list("main")
		olditemscraft[localname] = player:get_inventory():get_list("craft")
		olditemsprev[localname] = player:get_inventory():get_list("craftpreview")
		player:get_inventory():set_list("main", {"default:torch", 
			"farming:bread", "thirsty:wooden_bowl", 
			"firearms:medkit"})
		player:get_inventory():set_list("craft", {})
		player:get_inventory():set_list("craftpreview", {})

	end,
})


minetest.register_chatcommand("spawn", {
	description = "Return to spawn",
	privs = {interact = true},
	func = function(name)
		local player = minetest.get_player_by_name(name)		
		local pos = player:getpos()
		localname = name

		if (pos.x < -24974 and pos.x > -25003) and
			(pos.y > -3 and pos.y < 19) and
			(pos.z < -25029 and pos.z > -25049) then
				player:get_inventory():set_list("main", olditems[localname])
				player:get_inventory():set_list("craft", olditemscraft[localname])
				player:get_inventory():set_list("craftpreview", olditemsprev[localname])
		end

		pvptable[localname] = 1
		minetest.chat_send_player(localname,
			"PvP was enabled for "..localname)

		player:hud_remove(pvpdisabled)

		player:hud_remove(nopvppic)
--[[
		pvpenabled = player:hud_add({
				hud_elem_type = "text",
				position = {x = 1, y = 0},
				offset = {x=-125, y = 20},
				scale = {x = 100, y = 100},
				text = "PvP is enabled for you!",
				number = 0xFF0000 -- Red
			})
		pvppic = player:hud_add({
				hud_elem_type = "image",
				position = {x = 1, y = 0},
				offset = {x=-210, y = 20},
				scale = {x = 1, y = 1},
				text = "pvp.png"
			})
--]]		
		spawnusher.on_respawn_player(player)

	end,
})

minetest.register_chatcommand("gather", {
	description = "Go to gather point",
	privs = {interact = true},
	func = function(name)
		local player = minetest.get_player_by_name(name)		
		local pos = player:getpos()
		localname = name

		if (pos.x < -24974 and pos.x > -25003) and
			(pos.y > -3 and pos.y < 19) and
			(pos.z < -25029 and pos.z > -25049) then
				player:get_inventory():set_list("main", olditems[localname])
				player:get_inventory():set_list("craft", olditemscraft[localname])
				player:get_inventory():set_list("craftpreview", olditemsprev[localname])
		end
		
		local gpos = {x = -4, y = 3, z = -20}
		player:set_pos(gpos)

		pvptable[localname] = 1
		minetest.chat_send_player(localname,
			"PvP was enabled for "..localname)

		player:hud_remove(pvpdisabled)

		player:hud_remove(nopvppic)

--[[
		pvpenabled = player:hud_add({
				hud_elem_type = "text",
				position = {x = 1, y = 0},
				offset = {x=-125, y = 20},
				scale = {x = 100, y = 100},
				text = "PvP is enabled for you!",
				number = 0xFF0000 -- Red
			})
		pvppic = player:hud_add({
				hud_elem_type = "image",
				position = {x = 1, y = 0},
				offset = {x=-210, y = 20},
				scale = {x = 1, y = 1},
				text = "pvp.png"
			})
--]]
	end,

})

unified_inventory.register_button("home_gui_set", {
	type = "image",
	image = "ui_sethome_icon.png",
	tooltip = "Go to Gather",
	hide_lite=true,
	action = function(player)
		local pos = player:getpos()
		localname = player:get_player_name()

		if (pos.x < -24974 and pos.x > -25003) and
			(pos.y > -3 and pos.y < 19) and
			(pos.z < -25029 and pos.z > -25049) then
				player:get_inventory():set_list("main", olditems[localname])
				player:get_inventory():set_list("craft", olditemscraft[localname])
				player:get_inventory():set_list("craftpreview", olditemsprev[localname])
		end
		
		local gpos = {x = -4, y = 3, z = -20}
		player:set_pos(gpos)

		pvptable[localname] = 1
		minetest.chat_send_player(localname,
			"PvP was enabled for "..localname)

		player:hud_remove(pvpdisabled)

		player:hud_remove(nopvppic)

	end,
})

unified_inventory.register_button("home_gui_go", {
	type = "image",
	image = "ui_gohome_icon.png",
	tooltip = "Go to Spawn",
	hide_lite=true,
	action = function(player)
		local pos = player:getpos()
		localname = player:get_player_name()

		if (pos.x < -24974 and pos.x > -25003) and
			(pos.y > -3 and pos.y < 19) and
			(pos.z < -25029 and pos.z > -25049) then
				player:get_inventory():set_list("main", olditems[localname])
				player:get_inventory():set_list("craft", olditemscraft[localname])
				player:get_inventory():set_list("craftpreview", olditemsprev[localname])
		end

		pvptable[localname] = 1
		minetest.chat_send_player(localname,
			"PvP was enabled for "..localname)

		player:hud_remove(pvpdisabled)

		player:hud_remove(nopvppic)
	
		spawnusher.on_respawn_player(player)

	end,
})