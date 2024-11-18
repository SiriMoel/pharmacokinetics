dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

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

local howhigh = 0

local frame = GameGetFrameNum()
local last_frame = tonumber(GlobalsGetValue("pharmacokinetics.datura_dream_frame", "0"))

if amount_consumed >= 1000 then
    howhigh = math.min(howhigh + 1, 1000)

elseif amount_consumed >= 500 then
    howhigh = math.min(howhigh + 1, 500)
    --GameAddFlagRun("pharmacokinetics.datura_dreaming")

elseif amount_consumed >= 250 then
    howhigh = math.min(howhigh + 1, 250)

elseif amount_consumed >= 100 then
    howhigh = math.min(howhigh + 1, 100)
    --GameRemoveFlagRun("pharmacokinetics.datura_dreaming")

elseif amount_consumed >= 50 then
    howhigh = math.min(howhigh + 1, 50)

elseif amount_consumed >= 30 then
    howhigh = math.min(howhigh + 1, 30)

elseif amount_consumed >= 1 then
    howhigh = math.min(howhigh + 1, 10)

else
    howhigh = math.floor(howhigh * 0.95)
end

if GameHasFlagRun("pharmacokinetics.datura_dreaming") then
    if frame > last_frame + 240 then
        GlobalsSetValue("pharmacokinetics.datura_dream_frame", tostring(frame))
    end
end

--GameSetPostFxParameter() -- SHADER TIME!!!

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