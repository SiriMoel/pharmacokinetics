dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")
dofile("data/scripts/gun/gun_actions.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local frame = GameGetFrameNum()

math.randomseed(x + frame, y + frame)

local card = {}
local which = 0
local valid = false

--[[while card.id == nil do
    which = math.random(1, #actions)
    local card = actions[which]
    if card.spawn_requires_flag ~= nil and string.len(card.spawn_requires_flag) > 0 then
        local status = HasFlagPersistent(card.spawn_requires_flag)
        if status then
            break
        end
    else
        card = {}
    end
end]]

card = actions[math.random(1,#actions)] -- this can spawn ANY card, may cause issues but oh well

if card.id ~= nil then
    local entity = CreateItemActionEntity(string.lower(card.id), x, y)
else
    print("PHARMACOKINETICS - could not assign card to spell shrub fruit")
end

EntityKill(this)