Config = {}
Config.Locale = 'en'

Config.WhitelistOnly = true -- only whitelist job only if (true) all jobs allowed if (false)

Config.Whitelist1 = 'mafia'  -- whitelist 1
Config.Whitelist2 = 'cartel' -- whitelist 2
Config.Whitelist3 = 'yakuza' -- whitelist 3    -- you can delete slots between 1 - 5 if some are not needed
Config.Whitelist4 = 'gang'   -- whitelist 4
Config.Whitelist5 = 'biker'  -- whitelist 5

Crafting = {}
Config.CraftZones = {
	-- Clip Crafting Location
	Clip = {coords = vector3(-498.29, -1745.46, 18.93)},
    -- Lockpick Crafting Location
	Lockpick = {coords = vector3(-466.99, -1655.05, 18.72)},
	-- Bulletproof vest Crafting Location
	Vest = {coords = vector3(605.38, -3095.37, 6.07)},
}

Crafting.Clip = {
    ["clip"] = {
        label = "Clip",
        needs = {                                           
            ["iron"] = {label = "Iron", count = 4},
            ["gold"] = {label = "Gold", count = 3},
        },
        threshold = 0, -- percentage of success (higher more difficult)
    },
}

Crafting.Lockpick = {
    ["lockpick"] = {
        label = "Lockpick",
        needs = {
            ["iron"] = {label = "Iron", count = 4},
            ["gold"] = {label = "Gold", count = 3},
        },
        threshold = 0, -- percentage of success (higher more difficult)
    },
}

Crafting.Vest = {
    ["bulletproof"] = {
        label = "Armor",
        needs = {                                           
            ["iron"] = {label = "Iron", count = 4},
            ["gold"] = {label = "Gold", count = 3},
        },
        threshold = 0, --percentage of success (higher more difficult)
    },
}