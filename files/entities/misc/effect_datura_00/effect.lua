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

if amount_consumed >= 800 then
    howhigh = math.min(howhigh + 1, 800)
    --GamePrint("8")

elseif amount_consumed >= 400 then
    howhigh = math.min(howhigh + 1, 400)
    --GameAddFlagRun("pharmacokinetics.datura_dreaming")
    --GamePrint("7")

elseif amount_consumed >= 250 then
    howhigh = math.min(howhigh + 1, 250)
    --GamePrint("6")

elseif amount_consumed >= 100 then
    howhigh = math.min(howhigh + 1, 100)
    --GameRemoveFlagRun("pharmacokinetics.datura_dreaming")
    --GamePrint("5")

elseif amount_consumed >= 50 then
    howhigh = math.min(howhigh + 1, 50)
    --GamePrint("4")

elseif amount_consumed >= 30 then
    howhigh = math.min(howhigh + 1, 30)
    --GamePrint("3")

elseif amount_consumed >= 1 then
    howhigh = math.min(howhigh + 1, 10)
    --GamePrint("2")

else
    howhigh = math.floor(howhigh * 0.95)
    --GamePrint("1")
end

if GameHasFlagRun("pharmacokinetics.datura_dreaming") then
    if frame > last_frame + 240 then
        GlobalsSetValue("pharmacokinetics.datura_dream_frame", tostring(frame))
    end
end

--GameSetPostFxParameter() -- SHADER TIME!!!