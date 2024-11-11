dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")

function GetPharmaBarAmount()
    return tonumber(GlobalsGetValue("pharmacokinetics.amount", "0"))
end

function IncreasePharmaBarAmount(amount)
    local baramount = GetPharmaBarAmount()
    if baramount - amount <= 0 then
        GlobalsSetValue("pharmacokinetics.amount", "0")
    end
    GlobalsSetValue("pharmacokinetics.amount", tostring(baramount + amount))
end

function SetPharmaBarAmount(amount)
    GlobalsSetValue("pharmacokinetics.amount", tostring(amount))
end