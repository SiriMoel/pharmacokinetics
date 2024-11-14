dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function kick(entity_who_kicked)
    local seed = GetUpdatedEntityID()
    local x, y = EntityGetTransform(seed)

    local plant = Plant("Magic Flask Tree", x, y, {
        {
			name = "1",
			isfinal = false,
			ttguexf = 480,
			sprite = "mods/pharmacokinetics/files/entities/plants/magicflasktree/1.xml",
			offset_x = 0,
			offset_y = 0,
			height = 12,
		},
		{
			name = "2",
			isfinal = false,
			ttguexf = 480,
			sprite = "mods/pharmacokinetics/files/entities/plants/magicflasktree/2.xml",
			offset_x = 0,
			offset_y = 0,
			height = 32,
		},
		{
			name = "3",
			isfinal = true,
			ttguexf = 500,
			script_death = "mods/pharmacokinetics/files/entities/plants/magicflasktree/death.lua",
			sprite = "mods/pharmacokinetics/files/entities/plants/magicflasktree/3.xml",
            offset_x = 0,
			offset_y = 0,
			height = 64,
		},
    }, {
        name = "Suspicious Fruit",
		desc = "Something is enclosed within...",
		sprite = "mods/pharmacokinetics/files/entities/plants/magicflasktree/fruit/sprite.png",
		sprite_inhand = "mods/pharmacokinetics/files/entities/plants/magicflasktree/fruit/sprite_inworld.png",
		sprite_inworld = "mods/pharmacokinetics/files/entities/plants/magicflasktree/fruit/sprite_inworld.png",
		script_kicked = "mods/pharmacokinetics/files/entities/plants/magicflasktree/fruit/script_kick.lua",
    })

    EntityKill(seed)
end