dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

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
                                name = "10 souls",
                                desc = "10 random souls. Cannot be gilded or boss souls.",
                                price = 20000,
                                func = function(x, y)
                                    for i=1,10 do
                                        local type = ""
                                        type = GetRandomSoulType(false)
                                        while type == "gilded" do
                                            type = GetRandomSoulType(false)
                                        end
                                        AddSouls(type, 1)
                                    end
                                    dialog.show({
                                        text = "#Transaction successful.#",
                                        options = {
                                            {
                                                text="Close",
                                                func = function(dialog)
                                                    dialog.close()
                                                end,
                                            },
                                        },
                                    })
                                    SetShopMultiplier(GetShopMultiplier() + 0.1)
                                end,
                            },
                            {
                                name = "100 souls",
                                desc = "100 random souls. Cannot be gilded or boss souls.",
                                price = 200000,
                                func = function(x, y)
                                    for i=1,10 do
                                        local type = ""
                                        type = GetRandomSoulType(false)
                                        while type == "gilded" do
                                            type = GetRandomSoulType(false)
                                        end
                                        AddSouls(type, 10)
                                    end
                                    dialog.show({
                                        text = "#Transaction successful.#",
                                        options = {
                                            {
                                                text="Close",
                                                func = function(dialog)
                                                    dialog.close()
                                                end,
                                            },
                                        },
                                    })
                                    SetShopMultiplier(GetShopMultiplier() + 0.1)
                                end,
                            },
                            {
                                name = "Soul Tree Seed",
                                desc = "The seed of an immortal tree that produces souls out of the very essence of magic.",
                                price = 250000,
                                func = function(x, y)
                                    EntityLoad("mods/pharmacokinetics/files/entities/plants/soultree/seed/seed.xml", x, y)
                                    dialog.show({
                                        text = "#Transaction successful.#",
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
    })
end