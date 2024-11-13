dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local plant = GetUpdatedEntityID()
local x, y = EntityGetTransform(plant)

math.randomseed(x, y + GameGetFrameNum())

local vscs = EntityGetComponentIncludingDisabled(plant, "VariableStorageComponent") or {}

local stage = ComponentGetValue2(vscs[2], "value_int")

local height = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_stage_" .. tostring(stage) .."_height") or 0, "value_int")

local fruit_x = x + math.random(-5, 5)
local fruit_y = y - height

for i=1,math.random(1,3) do
    local fruit = EntityCreateNew("fruit")

    fruit_x = x + math.random(-5, 5)

    EntitySetTransform(fruit, fruit_x, fruit_y)

    EntityAddComponent2(plant, "UIInfoComponent", {
        name = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_name") or 0, "value_string")
    })
    EntityAddComponent2(fruit, "PhysicsBodyComponent", {
        -- idk what half of these do, all stolen from tablet atm
        _tags = "enabled_in_world",
		uid = 1,
		allow_sleep = true,
		angular_damping = false,
		fixed_rotation = false,
		is_bullet = true,
		linear_damping = false,
		auto_clean = true,
		hax_fix_going_through_ground = true,
		on_death_leave_physics_body = false,
		on_death_really_leave_body = false,
    })
    EntityAddComponent2(fruit, "PhysicsImageShapeComponent", {
        body_id = 1,
		centered = true,
		image_file = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_sprite_inworld") or 0, "value_string"),
		material = "meat_fruit",
    })
    EntityAddComponent2(fruit, "PhysicsThrowableComponent", {
        max_throw_speed = 150,
        throw_force_coeff = 1.5,
    })
    EntityAddComponent2(fruit, "ProjectileComponent", {
        _tags = "enabled_in_world",
        lifetime = -1,
        penetrate_entities = true,
        never_hit_player = true,
    })
    EntityAddComponent2(fruit, "VelocityComponent", {
        _tags = "enabled_in_world",
    })
    EntityAddComponent2(fruit, "ItemComponent", {
        _tags = "enabled_in_world",
        max_child_items = 0,
        is_pickable = true,
        is_equipable_forced = true,
        ui_sprite = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_sprite_") or 0, "value_string"),
        preferred_inventory = QUICK,
        item_name = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_name") or 0, "value_string"),
        ui_description = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_desc") or 0, "value_string"),
    })
    EntityAddComponent2(fruit, "SpriteComponent", {
        _tags = "enabled_in_hand",
        _enabled = false,
        offset_x = 4,
        offset_y = 4,
		image_file = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_sprite_inhand") or 0, "value_string"),
    })
    EntityAddComponent2(fruit, "HitboxComponent", {
        _tags = "enabled_in_world",
        aabb_min_x = -3,
        aabb_max_x = 3,
        aabb_min_y = -5,
        aabb_max_y = 0,
    })
    local comp_ability = EntityAddComponent2(fruit, "AbilityComponent", {
        ui_name = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_name") or 0, "value_string"),
        throw_as_item = true,
    })
    --[[ may need to add:

        ><gun_config
			deck_capacity="0"
		></gun_config>

        to ability comp idk
    ]]
    EntityAddComponent2(fruit, "LuaComponent", {
        script_kicked = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(plant, "VariableStorageComponent", "pharmaplant_fruit_script_kicked") or 0, "value_string"),
    })
end