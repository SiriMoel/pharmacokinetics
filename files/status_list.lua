dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
--dofile_once("data/scripts/status_effects/status_list.lua")

local to_insert = {
	{
		id="PHARMACOKINETICS_MAGIC_LIQUID_INGESTED",
		ui_name="$status_moldos_mlingested",
		ui_description="$statusdesc_moldos_mlingested",
		ui_icon="data/ui_gfx/status_indicators/ingestion_damage.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_magic_liquid_ingested/effect.xml",
	},
	{
		id="PHARMACOKINETICS_REDUCE_PHARMABAR_SMALL",
		ui_name="$status_moldos_rpbs.",
		ui_description="$statusdesc_moldos_rpbs",
		ui_icon="data/ui_gfx/status_indicators/ingestion_damage.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_reduce_pharmabar_small/effect.xml",
	},
	{
		id="PHARMACOKINETICS_W",
		ui_name="$status_moldos_w",
		ui_description="$statusdesc_moldos_w",
		ui_icon="mods/pharmacokinetics/files/status_indicators/w.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_w/effect.xml",
	},
	{
		id="PHARMACOKINETICS_DATURA",
		ui_name="$status_moldos_datura_1",
		ui_description="$statusdesc_moldos_datura_1",
		ui_icon="mods/pharmacokinetics/files/status_indicators/datura.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_datura_00/effect.xml",
	},
	{
		id="PHARMACOKINETICS_DATURA",
		ui_name="$status_moldos_datura_2",
		ui_description="$statusdesc_moldos_datura_2",
		ui_icon="mods/pharmacokinetics/files/status_indicators/datura.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_datura_01/effect.xml",
		min_threshold_normalized=0.5,
	},
	{
		id="PHARMACOKINETICS_DATURA",
		ui_name="$status_moldos_datura_3",
		ui_description="$statusdesc_moldos_datura_3",
		ui_icon="mods/pharmacokinetics/files/status_indicators/datura.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_datura_02/effect.xml",
		min_threshold_normalized=1.5,
	},
	{
		id="PHARMACOKINETICS_DATURA",
		ui_name="$status_moldos_datura_4",
		ui_description="$statusdesc_moldos_datura_4",
		ui_icon="mods/pharmacokinetics/files/status_indicators/datura.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_datura_03/effect.xml",
		min_threshold_normalized=2.5,
	},
}

for i,v in ipairs(to_insert) do
    table.insert(status_effects, v)
end