dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local effect = GetUpdatedEntityID()
local player = GetPlayer()
local x, y = EntityGetTransform(player)

local comp_gameeffect = EntityGetFirstComponentIncludingDisabled(effect, "GameEffectComponent")

if comp_gameeffect == nil then
    print("PHARMACOKINETICS - could not find game effect component")
    return
end

local custom_effect_id = ComponentGetValue2(comp_gameeffect, "custom_effect_id")

function datura_00_off()

end

function datura_01_off()

end

function datura_02_off()

end

function datura_03_off()

end

if custom_effect_id == "PHARMACOKINETICS_DATURA_00" then
    datura_00_off()
end
if custom_effect_id == "PHARMACOKINETICS_DATURA_01" then
    datura_00_off()
    datura_01_off()
end
if custom_effect_id == "PHARMACOKINETICS_DATURA_02" then
    datura_00_off()
    datura_01_off()
    datura_02_off()
end
if custom_effect_id == "PHARMACOKINETICS_DATURA_03" then
    datura_00_off()
    datura_01_off()
    datura_02_off()
    datura_03_off()
end

GlobalsSetValue("pharmacokinetics.daturatripping", "-1")