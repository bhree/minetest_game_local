Hard Trees [hardtrees]
======================
**License: MIT (see LICENSE)**

hardtrees is a mod with a very simple concept. Trees are made harder, meaning you cannot punch them with your fists. Instead, you must find rocks on cobble, stone, mossy cobble, or sandstone, and make the appropriate rock tool, in this case, an axe. However, to make an axe you must have sticks, for which there are two methods to obtain. When leaves are broken then have a 1 out of 13 chance to drop not only the broken node, but also a stick. Once every day, sticks also drop from trees to the group. The mod uses overrides to make trees unbreakable by hand, and also modifies leaves so that they drop the needed items. Leaves are also modified to act as ladders, so you can climb through the tops of trees.

## Mod Support
hardtrees supports all trees within the moretrees and default mod as of July 7th, 2016. To add support for more trees, use the code below modified to fit the new tree and save it in hardtrees/override.lua.

```lua
-- override tree node
hardtrees.override.tree("modname:treename")
-- override leaves
hardtrees.override.leaf("modname:leavesname", "modname:saplingname")
```

`treename` is the name of the tree node so that it can be overrided to not be `oddly_breakable_by_hand`. The `leavesname` is the name of the leaves node which is modified to drop sticks. `saplingname` is also required to allow the leaves to drop both sticks and saplings.

## Configuration
Within the mod directory, is `conf.txt` within which you can specify many of the settings used within this mod. You can also create world specific configuration files by placing another `conf.txt` file within the world directory. Remember, you do not have to specify all settings in either configuration file, however, only those that you would like to change from the default.

### `config.txt` Example
```lua
-- hardtrees config --

-- require tools to break trees (default: true)
require_tools = true

-- rock tools (default: true)
rock_tools = true

-- generate rocks (default: true)
gen_rocks = true

-- distance between rocks (default: 5)
-- gen_rocks must be true
rock_distance = 5

-- rock generation interval (default: 60)
-- gen_rocks must be true
rock_interval = 60

-- rock abm chance (default: 13)
-- gen_rocks must be true
rock_chance = 13

-- generate sticks (default: true)
gen_sticks = true

-- distance between stick and tree (default: 3)
-- gen_sticks must be true
stick_distance = 3

-- stick generation interval (default: 1440.0)
-- gen_sticks must be true
stick_interval = 1440.0

-- stick abm chance (default: 50)
-- gen_sticks must be true
stick_chance = 50
```

### Installation
Download a ZIP of the mod from Github and unzip it, or clone the repository from the command line. Then, the resulting directory in the `mods` directory of your local Minetest installation. On Linux this is usually `~/.minetest/mods`. You do not have to ensure that the installed mod directory is named `hardtrees` unless it is your personal preference to do so.

You can also install this mod in the `worldmods` folder inside any world directory to use it only within one world.

For further information or help see:
http://wiki.minetest.com/wiki/Installing_Mods
