dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local player = EntityGetRootEntity(this)
local x, y = EntityGetTransform(player)
local frame = GameGetFrameNum()
math.randomseed(x + frame, y + frame)

if player ~= this then
    if math.random(1, 2) == 2 then
        edit_component( entity_id, "LuaComponent", function(comp,vars)
            ComponentSetValue2(comp, "execute_every_n_frame", math.random(10, 160))
        end)
        
        edit_component( player_id, "PlatformShooterPlayerComponent", function(comp,vars)
            ComponentSetValue2(comp, "mForceFireOnNextUpdate", true)
        end)
    end
end