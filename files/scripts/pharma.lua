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
                    text = item.name .. ". " .. item.desc,
                    options = {
                        {
                            text = "Buy. $" .. item.price * shopmult,
                            func = function(dialog)
                                if ReduceMoney(item.price * shopmult, true) then
                                    item.func(x, y)
                                    dialog.show({
                                        text = "Transaction successful."
                                    })
                                else
                                    dialog.show({
                                        text = "You cannot afford this."
                                    })
                                end
                            end,
                        },
                        {
                            text = "Go back.",
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

local example_fruit = {
    name = "Apple",
    desc = "mmm apple",
    sprite = "path",
    sprite_inhand = "path",
    sprite_inworld = "path",
    script_kicked = "path.lua",
}

function Plant(name, x, y, growthstages, fruit) -- run this when a seed is planted
    local plant = EntityCreateNew(name) -- should be no name,
    EntitySetTransform(plant, x, y)
    EntityAddTag(plant, "hittable")
    EntityAddTag(plant, "pharma_plant")
    EntityAddComponent2(plant, "SpriteComponent", {
        image_file = growthstages[1].path,
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
        value_int = 1,
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
            if stage.isfinal then
                EntityAddComponent2(plant, "VariableStorageComponent", {
                    _tags = "pharmaplant_stage_" .. tostring(i) .. "_script_death",
                    name = "pharmaplant_stage_" .. tostring(i) .. "_script_death",
                    value_string = stage.script_death,
                })
            end
        end
    end
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_fruit_name",
        name = "pharmaplant_fruit_name",
        value_string = fruit.name,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_fruit_desc",
        name = "pharmaplant_fruit_desc",
        value_string = fruit.desc,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_fruit_sprite",
        name = "pharmaplant_fruit_sprite",
        value_string = fruit.sprite,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_fruit_sprite_inhand",
        name = "pharmaplant_fruit_sprite_inhand",
        value_string = fruit.sprite_inhand,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_fruit_sprite_inworld",
        name = "pharmaplant_fruit_sprite_inworld",
        value_string = fruit.sprite_inworld,
    })
    EntityAddComponent2(plant, "VariableStorageComponent", {
        _tags = "pharmaplant_fruit_script_kicked",
        name = "pharmaplant_fruit_script_kicked",
        value_string = fruit.script_kicked,
    })
    EntityAddComponent2(plant, "LuaComponent", {
        script_source_file="mods/pharmacokinetics/files/scripts/plant_growup.lua",
        execute_every_n_frame=growthstages[1].ttguexf,
    })
    return plant
end