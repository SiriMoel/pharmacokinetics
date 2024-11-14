dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function kick(entity_who_kicked)
    local fruit = GetUpdatedEntityID()
    local x, y = EntityGetTransform(fruit)

	EntityLoad("mods/pharmacokinetics/files/entities/items/potion_random_magic/item.xml", x, y)

    EntityKill(fruit)
end