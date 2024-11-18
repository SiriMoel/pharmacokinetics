dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function kick(entity_who_kicked)
    local seed = GetUpdatedEntityID()
    local x, y = EntityGetTransform(seed)

	if seed ~= EntityGetRootEntity(seed) then return end

    Plant("Datura", x, y, {
        {
			name = "1",
			isfinal = false,
			ttguexf = 400,
			script_death = "mods/pharmacokinetics/files/entities/plants/datura/death.lua",
			sprite = "mods/pharmacokinetics/files/entities/plants/datura/1.xml",
			offset_x = 0,
			offset_y = 0,
			height = 12,
		},
		{
			name = "2",
			isfinal = false,
			ttguexf = 800,
			script_death = "mods/pharmacokinetics/files/entities/plants/datura/death.lua",
			sprite = "mods/pharmacokinetics/files/entities/plants/datura/2.xml",
			offset_x = 0,
			offset_y = 0,
			height = 24,
		},
		{
			name = "3",
			isfinal = true,
			ttguexf = 3000,
			script_death = "mods/pharmacokinetics/files/entities/plants/datura/death.lua",
			sprite = "mods/pharmacokinetics/files/entities/plants/datura/3.xml",
            offset_x = 0,
			offset_y = 0,
			height = 44,
		},
    }, "mods/pharmacokinetics/files/entities/plants/datura/fruit/fruit.xml")

	GamePrint("Seed planted!")

    EntityKill(seed)
end