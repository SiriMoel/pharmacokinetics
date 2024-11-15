dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function kick(entity_who_kicked)
    local seed = GetUpdatedEntityID()
    local x, y = EntityGetTransform(seed)

	if seed ~= EntityGetRootEntity(seed) then return end

    local plant = Plant("Shaman", x, y, {
        {
			name = "1",
			isfinal = false,
			ttguexf = 10,
			sprite = "mods/pharmacokinetics/files/entities/plants/shamanshrub/1.xml",
			offset_x = 0,
			offset_y = 0,
			height = 12,
		},
		{
			name = "2",
			isfinal = true,
			ttguexf = 20,
			script_death = "mods/pharmacokinetics/files/entities/plants/shamanshrub/death.lua",
			sprite = "mods/pharmacokinetics/files/entities/plants/shamanshrub/2.xml",
            offset_x = 0,
			offset_y = 0,
			height = 30,
		},
    })

	GamePrint("Seed planted!")

    EntityKill(seed)
end