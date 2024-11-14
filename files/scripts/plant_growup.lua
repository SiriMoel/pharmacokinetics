dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local plant = GetUpdatedEntityID()
local x, y = EntityGetTransform(plant)

math.randomseed(x, y + GameGetFrameNum())

local doigrow = math.random(1,10) -- unsure what this should be

if doigrow == 2 then
    Plant_GrowUp(plant, x, y)
end