dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function kick(entity_who_kicked)
    local fruit = GetUpdatedEntityID()
    local x, y = EntityGetTransform(fruit)

	if fruit ~= EntityGetRootEntity(fruit) then return end

    AddSouls(ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "pharma_soul") or 0, "value_string"), 1)

    EntityKill(fruit)
end