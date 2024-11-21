dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")
local dialog_system = dofile_once("mods/pharmacokinetics/lib/DialogSystem/dialog_system.lua")

local npc = GetUpdatedEntityID()
local x, y = EntityGetTransform(npc)
local player = GetPlayer()

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    dialog_system.open_dialog({
        name = "???",
        portrait = "mods/pharmacokinetics/files/entities/npcs/flaskologist/portrait.png",
        typing_sound = "two",
        text = "Hello.",
        options = {
            {
                text="View stock",
                func = function(dialog)
                    dialog.show({
                        text = "Yes.",
                        options = Shop({
                            {
                                name = "SR-800 Potion",
                                desc = "Won't shatter!",
                                price = 200,
                                func = function(x, y)
                                    EntityLoad("mods/pharmacokinetics/files/entities/items/potion_no_shatter/item.xml", x, y)
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
                                    SetShopMultiplier(GetShopMultiplier() + 0.02)
                                end,
                            },
                            {
                                name = "CAP-2000 Potion",
                                desc = "Twice the capacity, double the... uh...",
                                price = 200,
                                func = function(x, y)
                                    EntityLoad("mods/pharmacokinetics/files/entities/items/potion_big/item.xml", x, y)
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
                                    SetShopMultiplier(GetShopMultiplier() + 0.02)
                                end,
                            },
                            {
                                name = "Demagified pharmadust pouch",
                                desc = "A pouch filled with demagified pharmadust.\n Just add magic (liquid)!",
                                price = 10000,
                                func = function(x, y)
                                    EntityLoad("mods/pharmacokinetics/files/entities/items/pouch_demagified_pharmadust/item.xml", x, y)
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
                        }, x, y),
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