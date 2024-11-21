dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local player = GetPlayer()
--local stomach = EntityGetFirstComponent(player, "StatusEffectDataComponent")

if not EntityHasTag(player, "pharma_immune") then
    local frame = GameGetFrameNum()
    local addiction_level = tonumber(GlobalsGetValue("pharmacokinetics.addiction_level", "0"))
    local magic_liquid_ingested_frame = tonumber(GlobalsGetValue("pharmacokinetics.magic_liquid_ingested_frame", "0"))
    if addiction_level > 0 and frame < magic_liquid_ingested_frame + 60 then
        addiction_level = addiction_level + 0.2
    end
    GlobalsSetValue("pharmacokinetics.addiction_level", tostring(addiction_level))
    GlobalsSetValue("pharmacokinetics.magic_liquid_ingested_frame", tostring(frame))
    math.randomseed(frame, frame)
    local amount = math.random(1,40)
    IncreasePharmaBarAmount(amount)
    EntityRemoveIngestionStatusEffect(player, "PHARMACOKINETICS_MAGIC_LIQUID_INGESTED")
end