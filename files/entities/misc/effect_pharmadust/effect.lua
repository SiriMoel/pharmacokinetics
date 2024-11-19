dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local effect = GetUpdatedEntityID()
local player = GetPlayer()
local stomach = EntityGetFirstComponent(player, "StatusEffectDataComponent")
local x, y = EntityGetTransform(player)

-- adapted from apoth code

if stomach == nil then return end

local amount_consumed = 0

local numuno
local numuno_found = false
for i,v in ipairs(ComponentGetValue2(stomach, "ingestion_effect_causes")) do
    if v == CellFactory_GetType("pharma_pharmadust") then
        numuno = i
        numuno_found = true
    end
end
if numuno_found then
    amount_consumed = amount_consumed + ComponentGetValue2(stomach, "ingestion_effects")[numuno]
end

local numdos
local numdos_found = false
for i,v in ipairs(ComponentGetValue2(stomach, "ingestion_effect_causes")) do
    if v == CellFactory_GetType("pharma_aq_pharmadust") then
        numdos = i
        numdos_found = true
    end
end
if numdos_found then
    amount_consumed = amount_consumed + ComponentGetValue2(stomach, "ingestion_effects")[numdos]
end

local howhigh = tonumber(GlobalsGetValue("pharmacokinetics.pharmadust_howhigh", "0"))


if howhigh >= 6000 then
    howhigh = 6000

elseif amount_consumed >= 1 then
    howhigh = math.min(howhigh + 1, 6000)

else
    howhigh = math.floor(howhigh * 0.95)
end

GlobalsSetValue("pharmacokinetics.pharmadust_howhigh", tostring(howhigh))

GameSetPostFxParameter("pharma_pharmadust_effect_amount", math.min(1, howhigh / 6000), 1, 0, 0)