dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local this = GetUpdatedEntityID()
local player = GetPlayer()
local x, y = EntityGetTransform(player)
local addiction_level = tonumber(GlobalsGetValue("pharmacokinetics.addiction_level", "0"))

local frame = GameGetFrameNum()

GameAddFlagRun("pharma_withdrawals")

if addiction_level < 3 then
    GameRemoveFlagRun("pharma_withdrawals")
    EntityKill(this)
end