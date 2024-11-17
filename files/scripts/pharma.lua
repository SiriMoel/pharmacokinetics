dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")

function GetPharmaBarAmount()
    return tonumber(GlobalsGetValue("pharmacokinetics.amount", "0"))
end

function IncreasePharmaBarAmount(amount)
    local baramount = GetPharmaBarAmount()
    if baramount - amount <= 0 then
        GlobalsSetValue("pharmacokinetics.amount", "0")
    end
    GlobalsSetValue("pharmacokinetics.amount", tostring(baramount + amount))
end

function SetPharmaBarAmount(amount)
    GlobalsSetValue("pharmacokinetics.amount", tostring(amount))
end

local example_shopitem = {
    {
        name = "Item name",
        desc = "Item desc",
        price = 100,
        func = function(x, y)
            EntityLoad("data/entities/items/pickup/chest_random.xml", x, y)
        end,
    },
}

function GetShopMultiplier()
    return tonumber(GlobalsGetValue("pharmacokinetics.shopmult", "1"))
end

function SetShopMultiplier(mult)
    GlobalsSetValue("pharmacokinetics.shopmult", tostring(mult))
end

function Shop(forsale, x, y)
    local shoptions = {}
    local shopmult = GetShopMultiplier()
    for i=1,#forsale do
        local item = forsale[i]
        table.insert(shoptions, {
            text = item.name .. " $" .. item.price * shopmult,
            func = function(dialog)
                dialog.show({
                    text = item.name .. ". \n" .. item.desc,
                    options = {
                        {
                            text = "Buy. $" .. item.price * shopmult,
                            func = function(dialog)
                                if ReduceMoney(item.price * shopmult, true) then
                                    item.func(x, y)
                                else
                                    dialog.show({
                                        text = "You cannot afford this."
                                    })
                                end
                            end,
                        },
                        {
                            text = "Go back",
                            func = function(dialog)
                                dialog.back()
                            end,
                        },
                    }
                })
            end,
        })
    end
    table.insert(shoptions, {
        text="Close",
        func = function(dialog)
            dialog.close()
        end,
    })
    return shoptions
end

function Shop2(forsale, x, y) -- Shop() with support for buying specific amounts, currently wip
    local shoptions = {}
    local shopmult = GetShopMultiplier()
    for i=1,#forsale do
        local item = forsale[i]
        table.insert(shoptions, {
            text = item.name .. " $" .. item.price * shopmult,
            func = function(dialog)
                amount = tonumber(GlobalsGetValue("pharmacokinetics.shopamount", "1"))
                dialog.show({
                    text = item.name .. ". \n" .. item.desc,
                    options = {
                        {
                            text = "Buy. " .. tonumber(GlobalsGetValue("pharmacokinetics.shopamount", "1")) .. "x $" .. (item.price * shopmult) * tonumber(GlobalsGetValue("pharmacokinetics.shopamount", "1")),
                            func = function(dialog)
                                if ReduceMoney((item.price * shopmult) * tonumber(GlobalsGetValue("pharmacokinetics.shopamount", "1")), true) then
                                    for i=1,tonumber(GlobalsGetValue("pharmacokinetics.shopamount", "1")) do
                                        item.func(x, y)
                                        y = y - 1
                                    end
                                else
                                    dialog.show({
                                        text = "You cannot afford this."
                                    })
                                end
                            end,
                        },
                        {
                            text = "Increase amount. (Currently: " .. tonumber(GlobalsGetValue("pharmacokinetics.shopamount", "1")) .. ")",
                            func = function(dialog)
                                GlobalsSetValue("pharmacokinetics.shopamount", tostring(tonumber(GlobalsGetValue("pharmacokinetics.shopamount", "1")) + 1))
                                dialog.show({
                                    text = "Amount increased!",
                                    options = {
                                        {
                                            text = "Go back",
                                            func = function(dialog)
                                                dialog.back()
                                            end,
                                        },
                                    },
                                })
                            end,
                        },
                        {
                            text = "Decrease amount. (Currently: " .. tonumber(GlobalsGetValue("pharmacokinetics.shopamount", "1")) .. ")",
                            func = function(dialog)
                                if amount > 1 then
                                    GlobalsSetValue("pharmacokinetics.shopamount", tostring(tonumber(GlobalsGetValue("pharmacokinetics.shopamount", "1")) - 1))
                                end
                                dialog.show({
                                    text = "Amount decreased!",
                                    options = {
                                        {
                                            text = "Go back",
                                            func = function(dialog)
                                                dialog.back()
                                            end,
                                        },
                                    },
                                })
                            end,
                        },
                        {
                            text = "Go back",
                            func = function(dialog)
                                dialog.back()
                            end,
                        },
                    }
                })
            end,
        })
    end
    table.insert(shoptions, {
        text="Close",
        func = function(dialog)
            dialog.close()
        end,
    })
    return shoptions
end

local example_growthstages = {
    {
        name = "Seedling",
        isfinal = false,
        ttguexf = 480, -- try to grow up every x frames
        script_death = "path.lua",
        sprite = "path.xml",
        offset_x = 0,
        offset_y = 0,
        height = 8,
    },
    {
        name = "Adult",
        isfinal = true,
        ttguexf = -1, -- if -1, wont grow. if isfinal then the plant will die upon growing up.
        script_death = "path.lua",
        sprite = "path.xml",
        height = 48,
    },
}

function Plant(name, x, y, growthstages, fruit, stageupto, final) -- run this when a seed is planted
    local plant = EntityLoad("mods/pharmacokinetics/files/entities/plants/plant.xml", x, y)
    if stageupto == nil or stageupto == 0 then
        stageupto = 1
    end
    if final == nil then
        final = false
    end
    EntitySetName(plant, name)
    EntityAddComponent2(plant, "SpriteComponent", {
        image_file = growthstages[1].sprite,
        offset_x = growthstages[1].offset_x,
        offset_y = growthstages[1].offset_y,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_number_of_stages",
        name = "pharmaplant_number_of_stages",
        value_int = #growthstages,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_current_stage",
        name = "pharmaplant_current_stage",
        value_int = stageupto,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_stage_" .. tostring(stageupto) .. "_isfinal",
        name = "pharmaplant_stage_" .. tostring(stageupto) .. "_isfinal",
        value_bool = growthstages[1].isfinal,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_stage_" .. tostring(stageupto) .. "_ttguexf",
        name = "pharmaplant_stage_" .. tostring(stageupto) .. "_ttguexf",
        value_int = growthstages[1].ttguexf,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_stage_" .. tostring(stageupto) .. "_script_death",
        name = "pharmaplant_stage_" .. tostring(stageupto) .. "_script_death",
        value_string = growthstages[1].script_death,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_stage_" .. tostring(stageupto) .. "_offset_x",
        name = "pharmaplant_stage_" .. tostring(stageupto) .. "_offset_x",
        value_int = growthstages[1].offset_x,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_stage_" .. tostring(stageupto) .. "_offset_y",
        name = "pharmaplant_stage_" .. tostring(stageupto) .. "_offset_y",
        value_int = growthstages[1].offset_y,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_stage_" .. tostring(stageupto) .. "_height",
        name = "pharmaplant_stage_" .. tostring(stageupto) .. "_height",
        value_int = growthstages[1].height,
    })
    for i,stage in ipairs(growthstages) do
        if i ~= 1 then
            EntityAddComponent2(plant, "VariableStorageComponent", {
                _tags = "pharmaplant_stage_" .. tostring(i) .. "_name",
                name = "pharmaplant_stage_" .. tostring(i) .. "_name",
                value_string = stage.name,
            })
            EntityAddComponent2(plant, "VariableStorageComponent", {
                _tags = "pharmaplant_stage_" .. tostring(i) .. "_isfinal",
                name = "pharmaplant_stage_" .. tostring(i) .. "_isfinal",
                value_bool = stage.isfinal,
            })
            EntityAddComponent2(plant, "VariableStorageComponent", {
                _tags = "pharmaplant_stage_" .. tostring(i) .. "_ttguexf",
                name = "pharmaplant_stage_" .. tostring(i) .. "_ttguexf",
                value_int = stage.ttguexf,
            })
            EntityAddComponent2(plant, "VariableStorageComponent", {
                _tags = "pharmaplant_stage_" .. tostring(i) .. "_sprite",
                name = "pharmaplant_stage_" .. tostring(i) .. "_sprite",
                value_string = stage.sprite,
            })
            EntityAddComponent2(plant, "VariableStorageComponent", {
                _tags = "pharmaplant_stage_" .. tostring(i) .. "_offset_x",
                name = "pharmaplant_stage_" .. tostring(i) .. "_offset_x",
                value_int = stage.offset_x,
            })
            EntityAddComponent2(plant, "VariableStorageComponent", {
                _tags = "pharmaplant_stage_" .. tostring(i) .. "_offset_y",
                name = "pharmaplant_stage_" .. tostring(i) .. "_offset_y",
                value_int = stage.offset_y,
            })
            EntityAddComponent2(plant, "VariableStorageComponent", {
                _tags = "pharmaplant_stage_" .. tostring(i) .. "_height",
                name = "pharmaplant_stage_" .. tostring(i) .. "_height",
                value_int = stage.height,
            })
            EntityAddComponent2(plant, "VariableStorageComponent", {
                _tags = "pharmaplant_stage_" .. tostring(i) .. "_script_death",
                name = "pharmaplant_stage_" .. tostring(i) .. "_script_death",
                value_string = stage.script_death,
            })
        end
    end
    if fruit ~= nil then
        EntityAddComponent2(plant, "VariableStorageComponent", {
            _tags = "pharmaplant_fruit_path",
            name = "pharmaplant_fruit_path",
            value_string = fruit,
        })
    end
    if final then
        EntityAddTag(plant, "pharma_plant_final")
        EntityAddComponent2(plant, "LuaComponent", {
            _tags = "pharmaplant_script_fruit",
            script_source_file = "mods/pharmacokinetics/files/scripts/plant_fruit.lua",
            execute_every_n_frame = math.ceil(growthstages[1].ttguexf / 6)
        })
    end
    EntityAddComponent2(plant, "LuaComponent", {
        _tags = "pharmaplant_script_growup",
        script_source_file = "mods/pharmacokinetics/files/scripts/plant_growup.lua",
        execute_every_n_frame = growthstages[1].ttguexf,
    })
    return plant
end

function Plant_GrowUp(plant, x, y)
    local currentstage = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_current_stage") or 0, "value_int")
    currentstage = currentstage + 1

    local comp_currentstage_name = EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage) .. "_name")
    local comp_nextstage_name = EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 1) .. "_name")

    if comp_currentstage_name ~= nil and ComponentGetValue2(comp_currentstage_name, "value_string") ~= nil then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(plant, "SpriteComponent") or 0, "image_file", ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage) .. "_sprite") or 0, "value_string"))
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(plant, "LuaComponent", "pharmaplant_script_growup") or 0, "execute_every_n_frame", ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage) .. "_ttguexf") or 0, "value_int"))
        if ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage) .. "_isfinal") or 0, "value_bool") or comp_nextstage_name == nil then
            EntityAddTag(plant, "pharma_plant_final")
            EntityAddComponent2(plant, "LuaComponent", {
                _tags = "pharmaplant_script_fruit",
                script_source_file = "mods/pharmacokinetics/files/scripts/plant_fruit.lua",
                execute_every_n_frame = math.ceil(ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage) .. "_ttguexf") or 0, "value_int") / 6)
            })
        end
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_current_stage") or 0, "value_int", currentstage)
    else
        dofile_once(ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage - 1) .."_script_death") or 0, "value_string") or "")
        plant_death(plant, x, y)
        EntityKill(plant)
    end
end

--[[function Plant_GrowUp(plant, x, y) -- rip old system (it never worked)
    local currentstage = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_current_stage") or 0, "value_int")

    GamePrint(tostring(currentstage + 1))
    
    local plant_immortal = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage) .. "_ttguexf") or 0, "value_int") == -1
    
    local growthstages = {}

    if plant_immortal then
        
    elseif EntityHasTag(plant, "pharma_plant_final") then
        GamePrint("meow 1")
        dofile_once(ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage) .."_script_death") or 0, "value_string") or "")
        plant_death(plant, x, y)
        EntityKill(plant)
    elseif EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 2) .. "_name") == nil then --ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 1) .. "_isfinal") or 0, "value_bool") or ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage) .. "_isfinal") or 0, "value_bool") then
        GamePrint("meow 2")
        table.insert(growthstages, {
            name = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 1) .."_name") or 0, "value_string"),
            isfinal = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 1) .."_isfinal") or 0, "value_bool"),
            ttguexf = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 1) .."_ttguexf") or 0, "value_int"),
            script_death = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 1) .."_script_death") or 0, "value_string") or "",
            sprite = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 1) .."_sprite") or 0, "value_string"),
            offset_x = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 1) .."_offset_x") or 0, "value_int"),
            offset_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 1) .."_offset_y") or 0, "value_int"),
            height = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 1) .."_height") or 0, "value_int"),
        })

        local plant_new = Plant(EntityGetName(plant), x, y, growthstages, {
            name = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_name") or 0, "value_string"),
            desc = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_name") or 0, "value_string"),
            sprite = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_sprite") or 0, "value_string"),
            sprite_inhand = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_sprite_inhand") or 0, "value_string"),
            sprite_inworld = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_sprite_inworld") or 0, "value_string"),
            script_kicked = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_script_kicked") or 0, "value_string"),
        }, currentstage + 1, true)
    
        EntityKill(plant)
    elseif EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 1) .. "_name") ~= nil and not ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage + 1) .. "_isfinal") or 0, "value_bool") then
        GamePrint("meow 3")
        local stage_up_to = currentstage + 1
        while EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(stage_up_to) .. "_name") ~= nil do
            table.insert(growthstages, {
                name = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(stage_up_to) .."_name") or 0, "value_string"),
                isfinal = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(stage_up_to) .."_isfinal") or 0, "value_bool"),
                ttguexf = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(stage_up_to) .."_ttguexf") or 0, "value_int"),
                script_death = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(stage_up_to) .."_script_death") or 0, "value_string") or "",
                sprite = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(stage_up_to) .."_sprite") or 0, "value_string"),
                offset_x = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(stage_up_to) .."_offset_x") or 0, "value_int"),
                offset_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(stage_up_to) .."_offset_y") or 0, "value_int"),
                height = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(stage_up_to) .."_height") or 0, "value_int"),
            })
            stage_up_to = stage_up_to + 1
        end
    
        local plant_new = Plant(EntityGetName(plant), x, y, growthstages, {
            name = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_name") or 0, "value_string"),
            desc = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_name") or 0, "value_string"),
            sprite = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_sprite") or 0, "value_string"),
            sprite_inhand = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_sprite_inhand") or 0, "value_string"),
            sprite_inworld = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_sprite_inworld") or 0, "value_string"),
            script_kicked = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_script_kicked") or 0, "value_string"),
        }, currentstage + 1, false)

        EntityKill(plant)
    else
        GamePrint("meow 4")
        print("PHARMACOKINETICS - plant went wrong :(")
    end
end]]