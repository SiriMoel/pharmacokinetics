dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")

local to_insert = {
	{
		id="PHARMACOKINETICS_MAGIC_LIQUID_INGESTED",
		ui_name="Magic liquid ingested!",
		ui_description="Magic liquid ingested!",
		ui_icon="data/ui_gfx/status_indicators/ingestion_damage.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_magic_liquid_ingested/effect.xml",
	},
	{
		id="PHARMACOKINETICS_REDUCE_PHARMABAR_SMALL",
		ui_name="Your stomach calms...",
		ui_description="Your stomach calms...",
		ui_icon="data/ui_gfx/status_indicators/ingestion_damage.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_reduce_pharmabar_small/effect.xml",
	},
}

for i,v in ipairs(to_insert) do
    table.insert(status_effects, v)
end