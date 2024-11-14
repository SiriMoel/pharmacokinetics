dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function kick(entity_who_kicked)
    local seed = GetUpdatedEntityID()
    local x, y = EntityGetTransform(seed)

    local plant = Plant("Shaman", x, y, {
        {
			name = "1",
			isfinal = false,
			ttguexf = 45,
			sprite = "mods/pharmacokinetics/files/entities/plants/shamanshrub/1.xml",
			offset_x = 0,
			offset_y = 0,
			height = 12,
		},
		{
			name = "2",
			isfinal = true,
			ttguexf = 60,
			script_death = "mods/pharmacokinetics/files/entities/plants/shamanshrub/death.lua",
			sprite = "mods/pharmacokinetics/files/entities/plants/shamanshrub/2.xml",
            offset_x = 0,
			offset_y = 0,
			height = 30,
		},
    }, {
        name = "Dried Husk",
		desc = "It is hollow. Not very edible.",
		sprite = "mods/pharmacokinetics/files/entities/plants/shamanshrub/fruit/sprite.png",
		sprite_inhand = "mods/pharmacokinetics/files/entities/plants/shamanshrub/fruit/sprite_inworld.png",
		sprite_inworld = "mods/pharmacokinetics/files/entities/plants/shamanshrub/fruit/sprite_inworld.png",
		script_kicked = "mods/pharmacokinetics/files/entities/plants/shamanshrub/fruit/script_kick.lua",
    })

    EntityKill(seed)
end