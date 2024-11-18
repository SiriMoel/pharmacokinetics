dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance )
    local player = GetUpdatedEntityID()
    local helditem = HeldItem(player)

    if damage > 0 then
        if tonumber(GlobalsGetValue("pharmacokinetics.daturatripping", "-1")) > -1 then
            return damage * 0.8, 0
        end
    end

    return damage, critical_hit_chance
end