dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local effect = GetUpdatedEntityID()
local player = GetPlayer()
local x, y = EntityGetTransform(player)