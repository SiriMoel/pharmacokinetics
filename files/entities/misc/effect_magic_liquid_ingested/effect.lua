--dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

--local this = GetUpdatedEntityID()
local player = GetPlayer()

if not EntityHasTag(player, "pharma_immune") then
    local frame = GameGetFrameNum()
    math.randomseed(frame, frame)
    local amount = math.random(1,30)
    IncreasePharmaBarAmount(amount)
    EntityRemoveIngestionStatusEffect(player, "PHARMACOKINETICS_MAGIC_LIQUID_INGESTED")
end

--EntityKill(this)

--[[local comp = GameGetGameEffect(player, "PHARMACOKINETICS_MAGIC_LIQUID_INGESTED")
EntityRemoveComponent(player, comp)

EntityKill(this)]]