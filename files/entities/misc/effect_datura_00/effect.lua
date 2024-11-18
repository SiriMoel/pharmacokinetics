dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

--[[

all of the numbers need tweaking, including the effect amount in materials.xml (possibly steal apoth numbers)

]]

local effect = GetUpdatedEntityID()
local player = GetPlayer()
local stomach = EntityGetFirstComponent(player, "StatusEffectDataComponent")
local x, y = EntityGetTransform(player)

-- adapted from apoth code, trying to work out how shaders work

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

if howhigh > 2000 then
    howhigh = 2000

elseif amount_consumed >= 300 then
    howhigh = howhigh + 1
    GameAddFlagRun("pharmacokinetics.datura_dreaming")

elseif amount_consumed >= 200 then
    howhigh = math.min(howhigh + 1, 1500)

elseif amount_consumed >= 100 then
    howhigh = math.min(howhigh + 1, 750)

elseif amount_consumed >= 1 then
    howhigh = math.min(howhigh + 1, 250)

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