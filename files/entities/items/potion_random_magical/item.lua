dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function init( entity_id )
	local x, y = EntityGetTransform( entity_id )
    local frame = GameGetFrameNum()
	math.randomseed(x + frame, y + frame)

    local materials = {
        { probability = 0.9, id = "magic_liquid_movement_faster", },
        { probability = 0.2, id = "magic_liquid_protection_all", },
        { probability = 0.7, id = "magic_liquid_berserk", },
        { probability = 0.8, id = "magic_liquid_mana_regeneration", },
        { probability = 0.2, id = "material_confusion", },
        { probability = 0.9, id = "magic_liquid_faster_levitation", },
        { probability = 0.6, id = "magic_liquid_polymorph", },
        { probability = 0.6, id = "magic_liquid_teleportation", },
        { probability = 0.7, id = "magic_liquid_worm_attractor", },
        { probability = 0.5, id = "blood_worm", },
        { probability = 0.6, id = "magic_liquid_invisibilty", },
        { probability = 0.9, id = "magic_liquid_charm", },
        { probability = 0.01, id = "magic_liquid_hp_regeneration", },
        { probability = 0.01, id = "midas_precursor", },
        { probability = 0.01, id = "pharma_daturadust", },
    }

	local which = PickRandomFromTableWeighted(x + frame, y + frame, materials) or {}

	AddMaterialInventoryMaterial( entity_id, which.id, 1000 )
end