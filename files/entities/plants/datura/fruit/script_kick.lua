dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function kick(entity_who_kicked)
    local fruit = GetUpdatedEntityID()
    local x, y = EntityGetTransform(fruit)

	if fruit ~= EntityGetRootEntity(fruit) then return end

    EntityConvertToMaterial(fruit, "pharma_daturadust", true, false)

    EntityKill(fruit)
end