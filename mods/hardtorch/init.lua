--[[
	Mod HardTorch para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Inicializador de scripts
  ]]--


-- Tabela Global
hardtorch = {}

-- Tabela de jogadores em loop de tocha acessa
hardtorch.em_loop = {}

-- Requerer fonte de fogo para acender tocha
hardtorch.torch_lighter = (minetest.settings:get("hardtorch_torch_lighter") == "true") or false

-- Nodes que funcionam como fontes de fogo para acender tochas
hardtorch.fontes_de_fogo = {}

-- Nodes para evitar ao colocar tochas
hardtorch.evitar_tool_on_place = {}
-- Mod Anvil
if minetest.get_modpath("anvil") then
	table.insert(hardtorch.evitar_tool_on_place, "anvil:anvil")
end

-- Tempo fixo de duração de uma noite
hardtorch.night_time = tonumber(minetest.settings:get("hardtorch_fixed_night_time") or 0)
if hardtorch.night_time == 0 then
	local time_speed = tonumber(minetest.setting_get("time_speed") or 72)
	if time_speed == 0 then
		time_speed = 72
	end
	hardtorch.night_time = (12*60*60)/time_speed
end

-- Notificador de Inicializador
local notificar = function(msg)
	if minetest.settings:get("log_mods") then
		minetest.debug("[HardTorch]"..msg)
	end
end

-- Modpath
local modpath = minetest.get_modpath("hardtorch")


-- Carregar scripts
notificar("Carregando...")
-- Metodos gerais
dofile(modpath.."/comum.lua")
dofile(modpath.."/luz.lua")
dofile(modpath.."/tool.lua")
dofile(modpath.."/node.lua")
dofile(modpath.."/lighter.lua")
dofile(modpath.."/fuel.lua")
dofile(modpath.."/api.lua")
dofile(modpath.."/torch.lua")
dofile(modpath.."/oil.lua")
dofile(modpath.."/lamp.lua")
notificar("[OK]!")


-- Pré ajustes

-- Acendedor de pederneira
hardtorch.register_lighter("fire:flint_and_steel", {
	wear_by_use = 1000
})

-- Nodes fonte de fogo
hardtorch.fontes_de_fogo["default:furnace_active"] = true
hardtorch.fontes_de_fogo["default:lava_flowing"] = true
hardtorch.fontes_de_fogo["default:lava_source"] = true
hardtorch.fontes_de_fogo["fire:basic_flame"] = true
hardtorch.fontes_de_fogo["fire:permanent_flame"] = true
	
	
