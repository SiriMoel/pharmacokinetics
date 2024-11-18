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

if custom_effect_id == "PHARMACOKINETICS_DATURA_00" then
    
end
if custom_effect_id == "PHARMACOKINETICS_DATURA_01" then
    
end
if custom_effect_id == "PHARMACOKINETICS_DATURA_02" then
    
end
if custom_effect_id == "PHARMACOKINETICS_DATURA_03" then
    
end

-- GameSetPostFxParameter() (what parameters are there???)

--[[
WHAT DO I WANT TO HAPPEN (accurate to high dose datura?)

- 00
take less damage

- 01
cannot recharge mana

- 02
shadowy shadows

- 03
"dream-like sequences"
more intense visuals

]]