dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local plant = GetUpdatedEntityID()
local x, y = EntityGetTransform(plant)

local comp_fruit_path = EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_path")

if comp_fruit_path == nil then return end

local fruit_path = ComponentGetValue2(comp_fruit_path, "value_string")

math.randomseed(x + GameGetFrameNum(), y + GameGetFrameNum())

local currentstage = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_current_stage") or 0, "value_int")

local height = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage) .."_height") or 0, "value_int")

local fruit_x = x + math.random(-10, 10)
local fruit_y = y - height

local amount = math.random(0, 2)

if #EntityGetInRadiusWithTag(x, y, 80, "pharma_fruit") >= 5 then return end -- to not lag the game with too many entities

for i=1,amount do
    fruit_x = x + math.random(-15, 15)
    local fruit = EntityLoad(fruit_path, fruit_x, fruit_y)
end