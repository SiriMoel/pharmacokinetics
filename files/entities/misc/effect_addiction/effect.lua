dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local this = GetUpdatedEntityID()
local player = GetPlayer()
local x, y = EntityGetTransform(player)
local addiction_level = tonumber(GlobalsGetValue("pharmacokinetics.addiction_level", "0"))

local frame = GameGetFrameNum()
local magic_liquid_ingested_frame = tonumber(GlobalsGetValue("pharmacokinetics.magic_liquid_ingested_frame", "0"))

if addiction_level < 1 then
    GameRemoveFlagRun("pharma_withdrawals")
    EntityKillAllWithTag("pharma_addiction_effect")
    EntityKill(this)
end

if addiction_level >= 1 then
    if frame > magic_liquid_ingested_frame + 3600 and frame < magic_liquid_ingested_frame + 36000 then
        math.randomseed(x + frame, y + frame)
        if math.random(1, (600 / addiction_level)) == 2 then
            if GameGetGameEffectCount(player, "PHARMACOKINETICS_WITHDRAWALS") == 0 then
                local entity = EntityLoad("mods/pharmacokinetics/files/entities/misc/effect_withdrawals/effect.xml", x, y)
                EntityAddChild(player, entity)
            end
        end
    end
end