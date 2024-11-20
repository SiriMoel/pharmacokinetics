dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local effect = GetUpdatedEntityID()
local player = GetPlayer()
local stomach = EntityGetFirstComponent(player, "StatusEffectDataComponent")
local x, y = EntityGetTransform(player)

-- adapted from apoth code

if stomach == nil then return end

local datura_num
for i,v in ipairs(ComponentGetValue2(stomach, "ingestion_effect_causes")) do
    if v == CellFactory_GetType("pharma_daturadust") then
        datura_num = i
    end
end

if datura_num == nil then return end

local amount_consumed = ComponentGetValue2(stomach, "ingestion_effects")[datura_num]

local howhigh = tonumber(GlobalsGetValue("pharmacokinetics.datura_howhigh", "0"))

local frame = GameGetFrameNum()
local last_frame = tonumber(GlobalsGetValue("pharmacokinetics.datura_dream_frame", "0"))

if howhigh >= 2000 then
    howhigh = 2000
    GameAddFlagRun("pharmacokinetics.datura_dreaming")
end

if amount_consumed > 10 then
    howhigh = math.min(howhigh + 1, 2000)
else
    howhigh = math.floor(howhigh * 0.95)
    GameRemoveFlagRun("pharmacokinetics.datura_dreaming")
end

if GameHasFlagRun("pharmacokinetics.datura_dreaming") then
    if frame > last_frame + 240 then
        GlobalsSetValue("pharmacokinetics.datura_dream_frame", tostring(frame))
    end
end

GlobalsSetValue("pharmacokinetics.datura_howhigh", tostring(howhigh))

GameSetPostFxParameter("pharma_datura_effect_amount", math.min(1, howhigh / 2000), 1, 0, 0) -- SHADER TIME!!!