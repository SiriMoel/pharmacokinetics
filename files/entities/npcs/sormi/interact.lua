dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")
local dialog_system = dofile_once("mods/pharmacokinetics/lib/DialogSystem/dialog_system.lua")

local npc = GetUpdatedEntityID()
local x, y = EntityGetTransform(npc)
local player = GetPlayer()

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    dialog_system.open_dialog({
        name = "Sormi",
        portrait = "mods/pharmacokinetics/files/entities/npcs/sormi/portrait.png",
        typing_sound = "two",
        text = "Hello Mina.",
        options = {
            {
                text="View stock",
                func = function(dialog)
                    --GlobalsSetValue("pharmacokinetics.shopamount", tostring(1))
                    dialog.show({
                        text = "Okay.",
                        options = Shop({
                            {
                                name = "Alchemy Guide",
                                desc = "Contains some hints about the world around us.",
                                price = 100,
                                func = function(x, y)
                                    EntityLoad("mods/pharmacokinetics/files/entities/items/sormitablet/item.xml", x, y)
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
                                    SetShopMultiplier(GetShopMultiplier() + 0.5) -- try kindness!
                                end,
                            },
                            --[[{
                                name = "Mystery magical liquid flask",
                                desc = "A normal flask filled with a random magical liquid.",
                                price = 300,
                                func = function(x, y)
                                    EntityLoad("mods/pharmacokinetics/files/entities/items/potion_random_magical/item.xml", x, y)
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
                            },]]
                            {
                                name = "Translocator: A better way to consume materials!",
                                desc = "Takes your current held material carrying item and turns it \ninto a translocator. \nKick it to consume the material contained within.",
                                price = 250,
                                func = function(x, y)
                                    local helditem = HeldItem(player)
                                    if EntityHasTag(helditem, "potion") or EntityHasTag(helditem, "powder_stash")then
                                        local material_id = GetMaterialInventoryMainMaterial(helditem)
                                        local amount = GetAmountOfMaterialInInventory(helditem, CellFactory_GetName(material_id))
                                        local item = EntityLoad("mods/pharmacokinetics/files/entities/items/translocator/item.xml", x, y)
                                        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(item, "ItemComponent") or 0, "ui_description", GameTextGetTranslatedOrNot(ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(item, "ItemComponent") or 0, "ui_description")) .. GameTextGetTranslatedOrNot("$mat_" .. CellFactory_GetName(material_id)) .. ".")
                                        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "pharma_translocator_material") or 0, "value_int", material_id)
                                        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "pharma_translocator_amount") or 0, "value_int", amount)
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
                                        GameKillInventoryItem(player, helditem)
                                    else
                                        dialog.show({
                                            text = "That wasn't a material carrying item. You have not been charged.",
                                            func = function(dialog)
                                                AddMoney(100 * GetShopMultiplier())
                                            end,
                                            options = {
                                                {
                                                    text="Close",
                                                    func = function(dialog)
                                                        dialog.close()
                                                    end,
                                                },
                                            },
                                        })
                                    end
                                end,
                            },
                            {
                                name = "Magical liquid flask tree seed",
                                desc = "Grow a tree that produces magical liquid flasks!",
                                price = 2000,
                                func = function(x, y)
                                    EntityLoad("mods/pharmacokinetics/files/entities/plants/magicflasktree/seed/seed.xml", x, y)
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