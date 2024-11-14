dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function kick(entity_who_kicked)
    local fruit = GetUpdatedEntityID()
    local x, y = EntityGetTransform(fruit)

    EntityKill(fruit)
end