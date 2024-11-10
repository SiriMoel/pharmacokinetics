dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")

local to_insert = {
	{
		id="PHARMACOKINETICS_MAGIC_LIQUID_INGESTED",
		ui_name="Magic liquid ingested!",
		ui_description="Magic liquid ingested!",
		ui_icon="data/ui_gfx/status_indicators/ingestion_damage.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_magic_liquid_ingested/effect.xml",
	},
}

for i,v in ipairs(to_insert) do
    table.insert(status_effects, v)
end