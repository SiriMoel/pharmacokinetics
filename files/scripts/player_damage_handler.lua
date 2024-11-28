dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance )
    local player = GetUpdatedEntityID()
    local helditem = HeldItem(player)

    if damage > 0 then
        local addiction_level = tonumber(GlobalsGetValue("pharmacokinetics.addiction_level", "0"))

        if tonumber(GlobalsGetValue("pharmacokinetics.daturatripping", "-1")) > -1 then
            return damage * 0.8, 0
        end

        if GameHasFlagRun("pharma_withdrawals") then
            damage = damage * 2
        end

        if addiction_level >= 3 then
            return damage * (1 + (0.03 * addiction_level)), critical_hit_chance
        end
    end

    return damage, critical_hit_chance
end