kill_list = {}
hp_list = {}

minetest.register_privilege("kill", {
    description = "The player will be killed immediately", 
    give_to_singleplayer = true
  })

minetest.register_chatcommand("kill", {
    params = "<playername> | leave playername empty to see help message",
    description = "The player will be klled immediately",
    privs = {kill=true},
    func = function(name, param)
        if param == "" then
            minetest.chat_send_player(name, "Usage: /kill <playername>")
            return
        end
        if minetest.env:get_player_by_name(param) then
            table.insert(kill_list, param)
            minetest.chat_send_player(name, param .. " is killed.")
            minetest.log("action", name .. " has killed " .. param .. ".")
            return
        end
    end
})

minetest.register_globalstep(
   function(dtime)
           for j,kill in ipairs(kill_list) do
               minetest.env:get_player_by_name(kill):set_hp(0)
               minetest.log("action", name .. " was instantly killed.")                               
               table.remove(kill_list,j)
           end
   end
)

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


minetest.register_craftitem("kill_mod:deathnote", {
	description = "Death Note",
	image = "death_note.png",
	stack_max=1,
	on_use = function(itemstack, user, pointed_thing)
		name =  user:get_player_name()
		local inv = user:get_inventory()
		local nextitem = inv:get_stack("main", user:get_wield_index()+1 ):get_name()
		if day_or_night() then
			minetest.chat_send_player(name,"Dark magic only works at night!!")
			return 
		end

		if nextitem ~= "nssm:death_scythe" then
			minetest.chat_send_player(name,"I need my scythe to work!!")
			return
		end
		
        	minetest.show_formspec(name,"kill_mod:dn_form",
                "size[4,3]" ..
                "label[0,0;Who do you wish to kill?]" ..
                "field[1,1.5;3,1;name;Name;]" ..
                "button_exit[1,2;2,1;exit;Kill]")
    	end,
})

minetest.register_on_player_receive_fields(function(player,
        formname, fields)
    if formname ~= "kill_mod:dn_form" then
        -- Formname is not mymod:form,
        -- exit callback.
        return false
    end
    name = player:get_player_name()

    -- Send message to player.
--    minetest.chat_send_player(player:get_player_name(),
--            "You said: " .. fields.name .. "!")
   if fields.name == nil then return end
   if fields.name == "" then
            minetest.chat_send_player(name, "Write active player name!!")
            return
   end
   if minetest.env:get_player_by_name(fields.name) then
            table.insert(kill_list, fields.name)
            minetest.chat_send_player(name, fields.name .. " is killed.")
            minetest.log("action", name .. " has killed " .. fields.name .. ".")
	    player:set_hp(player:get_hp()-15)
            return
   end

    -- Return true to stop other callbacks from
    -- receiving this submission.
    return true
end)