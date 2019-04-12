--[[
    Fallen Trees - Adds tree nodes to the falling_node group.
    Copyright (C) 2018 Hamlet

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]


--
-- Groups to be assigned
--

local trees_groups_a = {
	groups = {
		tree = 1, choppy = 2, oddly_breakable_by_hand = 0, flammable = 2,
		falling_node = 1
	}
}

local trees_groups_b = {
	groups = {
		tree = 1, choppy = 3, oddly_breakable_by_hand = 0, flammable = 3,
		falling_node = 1
	}
}


--
-- Nodes to be overriden
--

local trees_nodes_a = {
	"moretrees:beech_trunk", "moretrees:apple_tree_trunk",
--	"moretrees:palm_trunk", 
	"moretrees:date_palm_trunk",
	"moretrees:spruce_trunk", "moretrees:poplar_trunk",
	"moretrees:fir_trunk", "moretrees:date_palm_fruit_trunk",
	"moretrees:palm_fruit_trunk_gen",
}

local trees_nodes_b = {
	"moretrees:oak_trunk", "moretrees:sequoia_trunk",
	"moretrees:birch_trunk", "moretrees:cedar_trunk",
	"moretrees:willow_trunk", "moretrees:rubber_tree_trunk",
}


--
-- Nodes overriders
--

for n = 1, 8 do
	minetest.override_item(trees_nodes_a[n], trees_groups_a)
end

for n = 1, 6 do
	minetest.override_item(trees_nodes_b[n], trees_groups_b)
end
