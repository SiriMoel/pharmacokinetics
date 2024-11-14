dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")
local dialog_system = dofile_once("mods/pharmacokinetics/lib/DialogSystem/dialog_system.lua")

local npc = GetUpdatedEntityID()
local x, y = EntityGetTransform(npc)
local player = GetPlayer()

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    dialog_system.open_dialog({
        name = "???",
        portrait = "mods/pharmacokinetics/files/entities/npcs/mysterious_stranger/portrait.png",
        typing_sound = "two",
        text = "#Hello.#",
        options = {
            {
                text="View stock",
                func = function(dialog)
                    dialog.show({
                        text = "#Yes.#",
                        options = Shop({
                            {
                                name = "???",
                                desc = "???",
                                price = 300000,
                                func = function(x, y)
                                    EntityLoad("mods/pharmacokinetics/files/entities/plants/shamanshrub/seed/seed.xml", x, y)
                                    SetShopMultiplier(GetShopMultiplier() + 0.01)
                                end,
                            },
                            {
                                name = "Reset shop price multiplier",
                                desc = "Resets the item price multiplier for all shops.",
                                price = 300000,
                                func = function(x, y)
                                    SetShopMultiplier(1)
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