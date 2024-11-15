dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local plant = GetUpdatedEntityID()
local x, y = EntityGetTransform(plant)

math.randomseed(x + GameGetFrameNum(), y + GameGetFrameNum())

local doigrow = math.random(1,9) -- unsure what this should be
GamePrint(tostring(doigrow))

if doigrow == 2 then
    Plant_GrowUp(plant, x, y)
end