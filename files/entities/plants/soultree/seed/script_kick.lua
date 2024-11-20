dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function kick(entity_who_kicked)
    local seed = GetUpdatedEntityID()
    local x, y = EntityGetTransform(seed)

	if seed ~= EntityGetRootEntity(seed) then return end

    Plant("Soul Tree", x, y, {
        {
			name = "1",
			isfinal = false,
			ttguexf = 600,
			script_death = "mods/pharmacokinetics/files/entities/plants/soultree/death.lua",
			sprite = "mods/pharmacokinetics/files/entities/plants/soultree/1.xml",
			offset_x = 0,
			offset_y = 0,
			height = 12,
		},
		{
			name = "2",
			isfinal = false,
			ttguexf = 1800,
			script_death = "mods/pharmacokinetics/files/entities/plants/soultree/death.lua",
			sprite = "mods/pharmacokinetics/files/entities/plants/soultree/2.xml",
			offset_x = 0,
			offset_y = 0,
			height = 32,
		},
		{
			name = "3",
			isfinal = true,
			ttguexf = -1, -- immortal, surely wont cause issues
			script_death = "mods/pharmacokinetics/files/entities/plants/soultree/death.lua",
			sprite = "mods/pharmacokinetics/files/entities/plants/soultree/3.xml",
            offset_x = 0,
			offset_y = 0,
			height = 64,
		},
    }, "mods/pharmacokinetics/files/entities/plants/soultree/fruit/fruit.xml")

	GamePrint("Seed planted!")

    EntityKill(seed)
end