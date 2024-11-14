dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function plant_death(plant, x, y)
    EntityLoad("data/entities/items/pickup/chest_random", x, y)
    GamePrint("plant died :(")
end