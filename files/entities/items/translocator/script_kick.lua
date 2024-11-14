dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function kick(entity_who_kicked)
    local this = GetUpdatedEntityID()
	local player = GetPlayer()
    local x, y = EntityGetTransform(this)

	local vsc = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "pharma_translocator_material")
	local vsc2 = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "pharma_translocator_amount")

	if vsc ~= nil and vsc2 ~= nil and entity_who_kicked == player then
		local material = ComponentGetValue2(vsc, "value_int")
		local amount = ComponentGetValue2(vsc2, "value_int")

		EntityAddTag(player, "pharma_immune")
		EntityIngestMaterial(player, material, amount)
		EntityRemoveIngestionStatusEffect(player, "PHARMACOKINETICS_MAGIC_LIQUID_INGESTED")
		EntityRemoveTag(player, "pharma_immune")

		IncreasePharmaBarAmount(math.ceil(2 * (amount / 200)))

		EntityKill(this)
	end
end