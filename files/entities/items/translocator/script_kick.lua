dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function kick(entity_who_kicked)
    local this = GetUpdatedEntityID()
	local player = GetPlayer()
    local x, y = EntityGetTransform(this)
	local helditem = HeldItem(player)

	if this == EntityGetRootEntity(this) then return end

	if this ~= helditem then return end

	local vsc = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "pharma_translocator_material")
	local vsc2 = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "pharma_translocator_amount")

	if vsc ~= nil and vsc2 ~= nil and entity_who_kicked == player then
		local material = ComponentGetValue2(vsc, "value_int")
		local amount = ComponentGetValue2(vsc2, "value_int")

		local comp_matinv = EntityGetFirstComponentIncludingDisabled(player, "MaterialInventoryComponent", "Ingestion") or 0

		EntityAddTag(player, "pharma_immune")

		EntityIngestMaterial(player, material, amount) -- this doesnt work for berserkium specifically
		ComponentObjectSetValue2(comp_matinv, "count_per_material_type", tostring(material), 0) -- this doesnt work for any material
		GetMaterialIngestionEffect(CellFactory_GetName(material))

		EntityRemoveIngestionStatusEffect(player, "PHARMACOKINETICS_MAGIC_LIQUID_INGESTED")
	

		EntityRemoveTag(player, "pharma_immune")

		IncreasePharmaBarAmount(math.ceil(2 * (amount / 200)))
		EntityKill(this)
	end
end