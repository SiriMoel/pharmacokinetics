dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function plant_death(plant, x, y)
    EntityLoad("mods/pharmacokinetics/files/entities/npcs/shaman/npc.xml", x, y - 6)
    EntityKill(plant)
end