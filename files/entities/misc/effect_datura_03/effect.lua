--dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local addiction_level = tonumber(GlobalsGetValue("pharmacokinetics.addiction_level", "0"))

local amount = 1

if GetPharmaBarAmount() - amount > 0 then
    IncreasePharmaBarAmount(amount * -1)
else
    SetPharmaBarAmount(0)
end

addiction_level = addiction_level - 1
if addiction_level < 1 then
    addiction_level = 0
end

GlobalsSetValue("pharmacokinetics.addiction_level", tostring(addiction_level))