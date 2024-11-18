dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")
local dialog_system = dofile_once("mods/pharmacokinetics/lib/DialogSystem/dialog_system.lua")

local npc = GetUpdatedEntityID()
local x, y = EntityGetTransform(npc)
local player = GetPlayer()

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    dialog_system.open_dialog({
        name = "Shaman",
        portrait = "mods/pharmacokinetics/files/entities/npcs/shaman/portrait.png",
        typing_sound = "two",
        text = "Hello magic one.",
        options = {
            {
                text="View stock",
                func = function(dialog)
                    local shoptions = {
                        {
                            name = "Datura Seed",
                            desc = "A mystical and dangerous plant.",
                            price = 10000,
                            func = function(x, y)
                                EntityLoad("mods/pharmacokinetics/files/entities/plants/datura/seed/seed.xml", x, y)
                                dialog.show({
                                    text = "Transaction successful.",
                                    options = {
                                        {
                                            text="Close",
                                            func = function(dialog)
                                                dialog.close()
                                            end,
                                        },
                                    },
                                })
                                SetShopMultiplier(GetShopMultiplier() + 0.01)
                            end,
                        },
                    }
                    if ModIsEnabled("forsdel") then
                        table.insert(shoptions, 
                        {
                            name = "Crossgourd Seed",
                            desc = "This truly is a forsaken delicacy.",
                            price = 5000,
                            func = function(x, y)
                                EntityLoad("mods/forsdel/files/corssgourd_seed.xml", x, y)
                                dialog.show({
                                    text = "Transaction successful.",
                                    options = {
                                        {
                                            text="Close",
                                            func = function(dialog)
                                                dialog.close()
                                            end,
                                        },
                                    },
                                })
                                SetShopMultiplier(GetShopMultiplier() + 0.01)
                            end,
                        })
                    end
                    dialog.show({
                        text = "Yes.",
                        options = Shop(shoptions, x, y),
                    })
                end,
            },
            {
                text="Close",
                func = function(dialog)
                    dialog.close()
                end,
            },
        },
    })
end