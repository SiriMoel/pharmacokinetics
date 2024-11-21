--dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local player = GetPlayer()

local frame = GameGetFrameNum()

math.randomseed(frame, frame)

local amount = math.random(10,25)

if GetPharmaBarAmount() - amount > 0 then
    IncreasePharmaBarAmount(amount * -1)
else
    SetPharmaBarAmount(0)
end


EntityRemoveIngestionStatusEffect(player, "PHARMACOKINETICS_REDUCE_PHARMABAR_SMALL")