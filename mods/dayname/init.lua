dayname = {}
local calendar = {}
calendar.week = 1
calendar.month = 1
calendar.currentday = 1

--monster wave
local moonangle = 0
local monsterwave = 1

local monthname = {"Forbidden","Void","Earlygraze","Lastgraze","Earlyfreeze","Lastfreeze","Honour","Scattered","Heat","Raised","Truce","Pilgrimage"}
local daynames = {"Solarday","Lunarday","Fireday","Waterday","Woodday","Metalday","Earthday"}

--local currentday = 1
local check_timer = 5
local check_interval = 300
calendar.yesterday = 1

local function SaveDaynameToFile()
 local data = minetest.serialize(calendar);
 local file = io.open(minetest.get_worldpath().."/dayname.data", "w" );
 file:write(data);
 print("[Mod Dayname] Recorded Dayname.")
 file:close();
end 

local function GetDayname()
 local file = io.open(minetest.get_worldpath().."/dayname.data", "r" );
 if file then local data = file:read("*all");
  calendar = minetest.deserialize(data);
  print("[Mod Dayname] Read Dayname.")
  file:close();
 end
end 

local function SetMonsterWave()
	moonangle = calendar.currentday * 12
	monsterwave = math.floor(1000 * (1 + math.cos(math.rad(moonangle)) * (-1))) + 1
	minetest.settings:set('multimobs', monsterwave)
end

minetest.after(check_timer, function ()
minetest.register_globalstep(function(dtime)
        check_timer = check_timer + dtime
        if check_timer >= check_interval then
            check_timer = 0
            if calendar.yesterday < minetest.get_day_count() then
            	if calendar.currentday < 30 then
            		calendar.currentday = calendar.currentday + 1
            		-- monster wave
					SetMonsterWave()
                    --moonangle = calendar.currentday * 12
                    --monsterwave = math.floor(400 * (1 + math.cos(math.rad(moonangle)) * (-1))) + 1
                    --minetest.settings:set('multimobs', monsterwave)
                                		
            	else
            		calendar.currentday = 1
            		moonangle = 0
            		if calendar.month < 12 then
            			calendar.month = calendar.month + 1
            		else
            			calendar.month = 1
            		end
            	end
            	 
            	if calendar.week < 7 then
            		calendar.week = calendar.week + 1
				else
					calendar.week = 1
					global_exchange:payout()
            	end
				calendar.yesterday = minetest.get_day_count()
     			minetest.chat_send_all("It is " .. daynames[calendar.week] .. " " .. calendar.currentday)
     			SaveDaynameToFile()
				dayname.week = daynames[calendar.week]
				dayname.month = monthname[calendar.month]
				dayname.currentday = calendar.currentday
            end
        end
end)
end)
        

core.register_chatcommand("day", {	
	description = "Show day count since world creation",
	func = function(name, param)
		return true, "It is " .. daynames[calendar.week] .. " " .. calendar.currentday .. ", of The " .. monthname[calendar.month]

	end
})



GetDayname()

dayname.week = daynames[calendar.week]
dayname.month = monthname[calendar.month]
--dayname.currentday = calendar.currentday
SetMonsterWave()

function dayname:get_week()
    return dayname.week
end

function dayname:get_month()
    return dayname.month
end

function dayname:get_day()
    return calendar.currentday
end

minetest.register_on_shutdown(function()
 SaveDaynameToFile()
end)
