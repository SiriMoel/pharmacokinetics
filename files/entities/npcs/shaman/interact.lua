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
                    dialog.show({
                        text = "Yes.",
                        options = Shop({

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