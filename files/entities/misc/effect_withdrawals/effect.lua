dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local this = GetUpdatedEntityID()
local player = GetPlayer()
local x, y = EntityGetTransform(player)
local addiction_level = tonumber(GlobalsGetValue("pharmacokinetics.addiction_level", "0"))
local magic_liquid_ingested_frame = tonumber(GlobalsGetValue("pharmacokinetics.magic_liquid_ingested_frame", "0"))
local frame = GameGetFrameNum()

GameAddFlagRun("pharma_withdrawals")

if frame < magic_liquid_ingested_frame + 10 then -- drink to quell withdrawals
    GameRemoveFlagRun("pharma_withdrawals")
    EntityKill(this)
end

if addiction_level < 1 then
    GameRemoveFlagRun("pharma_withdrawals")
    EntityKill(this)
end