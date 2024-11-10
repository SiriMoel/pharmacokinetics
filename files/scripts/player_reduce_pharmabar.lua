dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local baramount = GetPharmaBarAmount()

local player = GetPlayer()
local x, y = EntityGetTransform(player)

if baramount > 0 then
    IncreasePharmaBarAmount(-1)
end

if baramount > 250 then
    GamePrint("Watch it!")
end

if baramount >= 300 then
    EntityInflictDamage(player, 1000000000, "DAMAGE_CURSE", "Overdose :(", "BLOOD_EXPLOSION", x, y, player, x, y, 0) -- will be replaced with death countdown later maybe
end
