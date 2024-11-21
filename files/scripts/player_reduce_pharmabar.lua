dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local baramount = GetPharmaBarAmount()

local player = GetPlayer()
local x, y = EntityGetTransform(player)

local frame = GameGetFrameNum()
local check_addiction_frame = tonumber(GlobalsGetValue("pharmacokinetics.check_addiction_frame", "0"))
local addiction_level = tonumber(GlobalsGetValue("pharmacokinetics.addiction_level", "0"))
local baramount_old = tonumber(GlobalsGetValue("pharmacokinetics.amount_old", "0"))
local magic_liquid_ingested_frame = tonumber(GlobalsGetValue("pharmacokinetics.magic_liquid_ingested_frame", "0"))

if baramount > 0 then
    IncreasePharmaBarAmount(-1)
end

if frame > check_addiction_frame + 2400 then
    if baramount > 0 then
        if baramount > (baramount_old * 0.8) or baramount >= 450 then
            addiction_level = addiction_level + 1
            if addiction_level > 10 then
                addiction_level = 10
            end
        else
            addiction_level = addiction_level - 1
            if addiction_level < 0 then
                addiction_level = 0
            end
        end
    else
        addiction_level = addiction_level - 1
        if addiction_level < 0 then
            addiction_level = 0
        end
    end
    if addiction_level >= 1 then
        if GameGetGameEffectCount(player, "PHARMACOKINETICS_ADDICTION") < 1 then
            local addiction = EntityLoad("mods/pharmacokinetics/files/entities/misc/effect_addiction/effect.xml", x, y)
            EntityAddChild(player, addiction)
        end
    else
        local targets = EntityGetWithTag("pharma_addiction_effect")
        for i,target in ipairs(targets) do
            EntityKill(target)
        end
    end
    GlobalsSetValue("pharmacokinetics.addiction_level", tostring(addiction_level))
    GlobalsSetValue("pharmacokinetics.check_addiction_frame", tostring(frame))
end

if baramount >= 400 and not GameHasFlagRun("pharma_warned") then
    GamePrint("Watch it!")
    GameAddFlagRun("pharma_warned")
end

if baramount < 400 and GameHasFlagRun("pharma_warned") then
    GameRemoveFlagRun("pharma_warned")
end

if baramount >= 500 and not GameHasFlagRun("pharma_overdose_immunity") then
    EntityInflictDamage(player, 1000000000, "DAMAGE_CURSE", "Overdose :(", "BLOOD_EXPLOSION", x, y, player, x, y, 0) -- will be replaced with death countdown later maybe
end

--GamePrint("addiction level: " .. tostring(addiction_level)) -- TESTING

baramount_old = baramount
GlobalsSetValue("pharmacokinetics.amount_old", tostring(baramount_old))