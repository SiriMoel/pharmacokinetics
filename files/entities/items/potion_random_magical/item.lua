dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	math.randomseed(x, y + GameGetFrameNum())
	-- so that all the potions will be the same in every position with the same seed
	-- local potion = random_from_array( potions )
	local materials = {
        "magic_liquid_movement_faster",
        "magic_liquid_protection_all",
        "magic_liquid_berserk",
        "magic_liquid_mana_regeneration",
        "material_confusion",
        "magic_liquid_faster_levitation",
        "magic_liquid_polymorph",
        "magic_liquid_teleportation",
        "magic_liquid_worm_attractor",
    }

	local which = materials[math.random(1,#materials)]

	AddMaterialInventoryMaterial( entity_id, which, 1000 )
end