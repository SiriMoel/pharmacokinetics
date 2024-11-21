dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local player = GetPlayer()
--local stomach = EntityGetFirstComponent(player, "StatusEffectDataComponent")

if not EntityHasTag(player, "pharma_immune") then
    local frame = GameGetFrameNum()
    GlobalsSetValue("pharmacokinetics.magic_liquid_ingested_frame", tostring(GameGetFrameNum()))
    math.randomseed(frame, frame)
    local amount = math.random(1,40)
    IncreasePharmaBarAmount(amount)
    EntityRemoveIngestionStatusEffect(player, "PHARMACOKINETICS_MAGIC_LIQUID_INGESTED")
    --if stomach == nil then return end

    --[[for i,v in ipairs(ComponentGetValue2(stomach, "ingestion_effect_causes")) do
        if v ~= 0 then
            if CellFactory_HasTag(v, "[magic_liquid]") then
                GlobalsSetValue("pharmacokinetics.magic_liquid_ingested", "1")
            end
        end
    end]]
end