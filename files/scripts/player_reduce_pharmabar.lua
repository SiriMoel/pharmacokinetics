dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local baramount = GetPharmaBarAmount()

local player = GetPlayer()
local x, y = EntityGetTransform(player)

if baramount > 0 then
    IncreasePharmaBarAmount(-1)
end

if baramount >= 400 and not GameHasFlagRun("pharma_warned") then
    GamePrint("Watch it!")
    GameAddFlagRun("pharma_warned")
end

if baramount < 400 and GameHasFlagRun("pharma_warned") then
    GameRemoveFlagRun("pharma_warned")
end

if baramount >= 500 and not GameHasFlagRun("pharma_overdose_immunity") then
    EntityInflictDamage(player, 1000000000, "DAMAGE_CURSE", "Overdose :(", "BLOOD_EXPLOSION", x, y, player, x, y, 0) -- will be replaced with death countdown later maybe
end
