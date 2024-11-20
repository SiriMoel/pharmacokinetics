dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local effect = GetUpdatedEntityID()
local player = GetPlayer()
local stomach = EntityGetFirstComponent(player, "StatusEffectDataComponent")
local x, y = EntityGetTransform(player)

if stomach == nil then return end

local num
for i,v in ipairs(ComponentGetValue2(stomach, "ingestion_effect_causes")) do
    if v == CellFactory_GetType("pharma_love") then
        num = i
    end
end

if num == nil then return end

local amount_consumed = ComponentGetValue2(stomach, "ingestion_effects")[num]

local howhigh = tonumber(GlobalsGetValue("pharmacokinetics.love_howhigh", "0"))

if howhigh >= 1000 then
    howhigh = 1000
    IncreaseFlightLeft(player, 0.1)

end

if amount_consumed >= 10 then
    howhigh = math.min(howhigh + 1, 1000)
else
    howhigh = math.floor(howhigh * 0.95)
end

GlobalsSetValue("pharmacokinetics.love_howhigh", tostring(howhigh))

GameSetPostFxParameter("pharma_love_effect_amount", math.min(1, howhigh / 1000), 1, 0, 0) -- SHADER TIME!!!