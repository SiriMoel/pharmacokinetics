dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local effect = GetUpdatedEntityID()
local player = GetPlayer()
local stomach = EntityGetFirstComponent(player, "StatusEffectDataComponent")
local x, y = EntityGetTransform(player)

-- adapted from apoth code

if stomach == nil then return end

local amount_consumed = 0

local num
local num_found = false
for i,v in ipairs(ComponentGetValue2(stomach, "ingestion_effect_causes")) do
    if v == CellFactory_GetType("pharma_wizarddust") then
        num = i
        num_found = true
    end
end
if num_found then
    amount_consumed = amount_consumed + ComponentGetValue2(stomach, "ingestion_effects")[num]
end

local howhigh = tonumber(GlobalsGetValue("pharmacokinetics.wizarddust_howhigh", "0"))

if howhigh >= 4000 then
    howhigh = 4000

elseif amount_consumed >= 1 then
    howhigh = math.min(howhigh + 1, 4000)

else
    howhigh = math.floor(howhigh * 0.95)
end

GlobalsSetValue("pharmacokinetics.wizarddust_howhigh", tostring(howhigh))

GameSetPostFxParameter("pharma_wizarddust_effect_amount", math.min(1, howhigh / 6000), 1, 0, 0)