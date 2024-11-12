dofile_once("data/scripts/lib/utilities.lua")

function flipbool(boolean) -- the real function flipbool()
    return not boolean
end

---@param bool boolean
---this is the greatest function of all time, it flips a boolean. true -> false and false -> true.
function flipboolean(bool) -- honestly quite incredible.
    if string.sub(tostring(bool), 1, 1) == "t" then
        bool = false
        return bool
    elseif string.sub(tostring(bool), 1, 1) == "f" then
        bool = true
        return bool
    end
end

function GetPlayer()
    local player = EntityGetWithTag("player_unit")[1]
    return player
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
        return true
    end
end
    return false
end

function SetFileContent(toset, content)
    ModTextFileSetContent(toset, ModTextFileGetContent("mods/souls/files/set/" .. content))
end

function IsInRadiusOf(xa, ya, xb, yb, radius) -- i dont think this works, isnt needed anyway.
    if xa - xb < radius and ya - yb < radius then
        return true
    end
    return false
end

---@param entity_id integer
---@param material_name string
---@return number
function GetAmountOfMaterialInInventory(entity_id, material_name) -- stolen from https://github.com/Priskip/purgatory
    local amount = 0
    local mat_inv_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "MaterialInventoryComponent") or 0
    local count_per_material_type = ComponentGetValue2(mat_inv_comp, "count_per_material_type")

    for i,v in ipairs(count_per_material_type) do
        if v ~= 0 then
            if CellFactory_GetName(i - 1) == material_name then
                amount = v
            end
        end
    end

    return amount
end

function GetMoney()
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    return money
end

function SetMoney(amount)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    ComponentSetValue2(comp_wallet, "money", amount)
end

function CanAfford(amount)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    if money >= amount then
        return true
    else
        return false
    end
end

---@param spent boolean if the player's money_spent should be increased.
-- usage: if ReduceMoney(100, true) then EntityLoad("thing", x, y) end
function ReduceMoney(amount, spent)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    local moneyspent = ComponentGetValue2(comp_wallet, "money_spent")
    if CanAfford(amount) == false then
        GamePrint("You cannot afford that.")
        return false
    end
    money = money - amount
    ComponentSetValue2(comp_wallet, "money", money)
    if spent == true then
        moneyspent = moneyspent + amount
        ComponentSetValue2(comp_wallet, "money_spent", moneyspent)
    end
    return true
end

function AddMoney(amount)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    money = money + amount
    ComponentSetValue2(comp_wallet, "money", money)
end

function HeldItem(player)
    local comp_inv = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component") or 0
    local held_item = ComponentGetValue2(comp_inv, "mActiveItem")
    return held_item
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