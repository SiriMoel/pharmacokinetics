local dialog_system = dofile_once("mods/pharmacokinetics/lib/DialogSystem/dialog_system.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local player = EntityGetInRadiusWithTag(x, y, 10, "player_unit")[1]

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
                        text = "WIP!!!"
                    })
                end,
            },
            {
                text="Close",
                func = function(dialog)
                    
                end,
            },
        },
    } )
end