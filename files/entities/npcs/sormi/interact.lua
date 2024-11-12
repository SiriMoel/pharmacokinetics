dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")
local dialog_system = dofile_once("mods/pharmacokinetics/lib/DialogSystem/dialog_system.lua")

local npc = GetUpdatedEntityID()
local x, y = EntityGetTransform(npc)
local player = GetPlayer()

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    dialog_system.open_dialog( {
        name = "Sormi",
        portrait = "mods/pharmacokinetics/files/entities/npcs/sormi/portrait.png",
        typing_sound = "two",
        text = "Hello Mina.",
        options = {
            {
                text="View stock",
                func = function(dialog)
                    dialog.show({
                        text = "Okay.",
                        options = Shop({
                            -- mystery magical liquid flask
                            {
                                name = "Mystery magical liquid flask",
                                desc = "A normal flask filled with a random magical liquid!",
                                price = 300,
                                func = function(x, y)
                                    EntityLoad("mods/pharmacokinetics/files/entities/items/potion_random_magic/item.xml", x, y)
                                    SetShopMultiplier(GetShopMultiplier() * 1.01)
                                end,
                            },
                            -- impressionable seed (grow plant)
                            -- 
                        }),
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
    } )
end