dofile_once("data/scripts/lib/mod_settings.lua")
dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

function mod_setting_bool_custom( mod_id, gui, in_main_menu, im_id, setting )
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	local text = setting.ui_name .. " - " .. GameTextGet( value and "$option_on" or "$option_off" )

	if GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text ) then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
	print( tostring(new_value) )
end

local mod_id = "pharmacokinetics"
mod_settings_version = 1
mod_settings = {
	{
        id = "pharmabar_at_soulsgui",
        ui_name = "Pharmabar at Souls GUI location",
        ui_description = "Determines the location of this mod's bar. Bar will also be larger at Souls GUI location.",
        value_default = false,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
	{
        id = "maxfruitamountperfruiting",
        ui_name = "Maximum fruit amount",
        ui_description = "The highest amount of fruit that can be produced by a tree in a single fruiting.",
        value_default = 2,
        value_min = 1,
        value_max = 5,
        value_display_multiplier = 1,
        value_display_formatting = " $0 fruit",
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
	{
        id = "maxfruitamountneartree",
        ui_name = "Maximum fruit amount near tree",
        ui_description = "Trees wont fruit if this amount of fruit is near them already.",
        value_default = 5,
        value_min = 1,
        value_max = 20,
        value_display_multiplier = 1,
        value_display_formatting = " $0 fruit",
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
}

function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id )
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end


function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end