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

function datura_00_on()

end

function datura_01_on()

end

function datura_02_on()

end

function datura_03_on()

end

if custom_effect_id == "PHARMACOKINETICS_DATURA_00" then
    GlobalsSetValue("pharmacokinetics.daturatripping", "0")
    datura_00_on()
end
if custom_effect_id == "PHARMACOKINETICS_DATURA_01" then
    GlobalsSetValue("pharmacokinetics.daturatripping", "1")
    datura_00_on()
    datura_01_on()
end
if custom_effect_id == "PHARMACOKINETICS_DATURA_02" then
    GlobalsSetValue("pharmacokinetics.daturatripping", "2")
    datura_00_on()
    datura_01_on()
    datura_02_on()
end
if custom_effect_id == "PHARMACOKINETICS_DATURA_03" then
    GlobalsSetValue("pharmacokinetics.daturatripping", "3")
    datura_00_on()
    datura_01_on()
    datura_02_on()
    datura_03_on()
end