dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local plant = GetUpdatedEntityID()
local x, y = EntityGetTransform(plant)

math.randomseed(x, y + GameGetFrameNum())

local doigrow = math.random(1,10)

if doigrow == 2 then
    local vscs = EntityGetComponentIncludingDisabled(plant, "VariableStorageComponent") or {}

    local currentstage = ComponentGetValue2(vscs[2], "value_int")
    local stage_up_to = currentstage + 1

    local growthstages = {}

    -- if the plant isnt meant to grow nor die
    if ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage) .."_ttguexf") or 0, "value_int") == -1 then
    

    -- if the plant is on its final stage (kill it)
    elseif ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage) .."_isfinal") or 0, "value_bool") then
        dofile_once(ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage) .."_script_death") or 0, "value_string") or "")
        plant_death(plant, x, y) -- idk how to call this, but that function will be in the file dofile_once()'d above
        EntityKill(plant)

    -- the plant has a stage to grow to and will now do that
    else
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
        })
    
        local vscs_new = EntityGetComponentIncludingDisabled(plant_new, "VariableStorageComponent") or {}
    
        local currentstage_new = ComponentGetValue2(vscs_new[2], "value_int")
    
        if ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant_new, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage_new) .."_isfinal") or 0, "value_bool") then
            EntityAddComponent2(plant_new, "LuaComponent", {
                script_source_file = "mods/pharmacokinetics/files/scripts/plant_fruit.lua",
                execute_every_n_frame = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant_new, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(currentstage_new) .."_ttguexf") or 0, "value_int") * 6
            })
        end
    
        EntityKill(plant)
    end
end