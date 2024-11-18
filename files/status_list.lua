dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
--dofile_once("data/scripts/status_effects/status_list.lua")

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
	{
		id="PHARMACOKINETICS_W",
		ui_name="Tripping like a klutz",
		ui_description="You're seeing...",
		ui_icon="mods/pharmacokinetics/files/status_indicators/w.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_w/effect.xml",
	},
	{
		id="PHARMACOKINETICS_DATURA",
		ui_name="Feeling shamanic...",
		ui_description="You feel a bit strange...",
		ui_icon="mods/pharmacokinetics/files/status_indicators/datura.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_datura_00/effect.xml",
	},
	{
		id="PHARMACOKINETICS_DATURA",
		ui_name="Feeling shamanic...",
		ui_description="I think we can handle this...",
		ui_icon="mods/pharmacokinetics/files/status_indicators/datura.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_datura_01/effect.xml",
		min_threshold_normalized=0.5,
	},
	{
		id="PHARMACOKINETICS_DATURA",
		ui_name="Feeling shamanic...",
		ui_description="That shadow looks a bit off...",
		ui_icon="mods/pharmacokinetics/files/status_indicators/datura.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_datura_02/effect.xml",
		min_threshold_normalized=1.5,
	},
	{
		id="PHARMACOKINETICS_DATURA",
		ui_name="Feeling shamanic...",
		ui_description="I AM THE WAY THE TRUTH AND THE LIFE.",
		ui_icon="mods/pharmacokinetics/files/status_indicators/datura.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_datura_03/effect.xml",
		min_threshold_normalized=3,
	},
}

for i,v in ipairs(to_insert) do
    table.insert(status_effects, v)
end