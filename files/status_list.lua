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
		ui_name="$status_moldos_rpbs",
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
		min_threshold_normalized=0.35,
	},
	{
		id="PHARMACOKINETICS_DATURA",
		ui_name="$status_moldos_datura_3",
		ui_description="$statusdesc_moldos_datura_3",
		ui_icon="mods/pharmacokinetics/files/status_indicators/datura.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_datura_02/effect.xml",
		min_threshold_normalized=7,
	},
	{
		id="PHARMACOKINETICS_DATURA",
		ui_name="$status_moldos_datura_4",
		ui_description="$statusdesc_moldos_datura_4",
		ui_icon="mods/pharmacokinetics/files/status_indicators/datura.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_datura_03/effect.xml",
		min_threshold_normalized=1.5,
	},
	{
		id="PHARMACOKINETICS_PHARMADUST",
		ui_name="$status_moldos_pharmadust",
		ui_description="$statusdesc_moldos_pharmadust",
		ui_icon="mods/pharmacokinetics/files/status_indicators/pharmadust.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_pharmadust/effect.xml",
	},
	{
		id="PHARMACOKINETICS_WIZARDDUST",
		ui_name="$status_moldos_wizarddust",
		ui_description="$statusdesc_moldos_wizarddust",
		ui_icon="mods/pharmacokinetics/files/status_indicators/wizarddust.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_wizarddust/effect.xml",
	},
	{
		id="PHARMACOKINETICS_OVERDOSE_IMMUNITY",
		ui_name="$status_moldos_overdoseimmunity",
		ui_description="$statusdesc_moldos_overdoseimmunity",
		ui_icon="mods/pharmacokinetics/files/status_indicators/overdose_immunity.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_overdose_immunity/effect.xml",
	},
	{
		id="PHARMACOKINETICS_LOVE",
		ui_name="$status_moldos_love",
		ui_description="$statusdesc_moldos_love",
		ui_icon="mods/pharmacokinetics/files/status_indicators/love.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_love/effect.xml",
	},
	{
		id="PHARMACOKINETICS_ADDICTION",
		ui_name="$status_moldos_addiction",
		ui_description="$statusdesc_moldos_addiction",
		ui_icon="mods/pharmacokinetics/files/status_indicators/addiction.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_addiction/effect.xml",
	},
	{
		id="PHARMACOKINETICS_WITHDRAWALS",
		ui_name="$status_moldos_withdrawals",
		ui_description="$statusdesc_moldos_withdrawals",
		ui_icon="mods/pharmacokinetics/files/status_indicators/addiction.png",
		effect_entity="mods/pharmacokinetics/files/entities/misc/effect_withdrawals/effect.xml",
	},
}

for i,v in ipairs(to_insert) do
    table.insert(status_effects, v)
end