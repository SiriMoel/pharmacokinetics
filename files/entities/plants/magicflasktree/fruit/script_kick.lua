dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function kick(entity_who_kicked)
    local fruit = GetUpdatedEntityID()
    local x, y = EntityGetTransform(fruit)

	if fruit ~= EntityGetRootEntity(fruit) then return end

    EntityLoad("mods/pharmacokinetics/files/entities/items/potion_random_magical/item.xml", x, y)

    EntityKill(fruit)
end