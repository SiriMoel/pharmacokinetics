dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local nxml = dofile_once("mods/pharmacokinetics/lib/nxml.lua")

-- nxml
local materials = ModTextFileGetContent("data/materials.xml")
local xml = nxml.parse(materials)
for element in xml:each_child() do
    if element.attr.tags ~= nil and string.find(element.attr.tags, "[^%a]magic_liquid[^%a]") then
        for child in element:each_of("StatusEffects") do
            for childdos in child:each_of("Ingestion") do
                childdos:add_child(nxml.parse([[
                    <StatusEffect type="PHARMACOKINETICS_MAGIC_LIQUID_INGESTED" amount="1" />
                ]]))
            end
        end
    end
end
ModTextFileSetContent("data/materials.xml", tostring(xml))

-- set & append
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/pharmacokinetics/files/status_list.lua" )

-- pixel scenes (thanks graham)
local function add_scene(table)
	local biome_path = ModIsEnabled("noitavania") and "mods/noitavania/data/biome/_pixel_scenes.xml" or "data/biome/_pixel_scenes.xml"
	local content = ModTextFileGetContent(biome_path)
	local string = "<mBufferedPixelScenes>"
	local worldsize = ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840
	for i = 1, #table do
		string = string .. [[<PixelScene pos_x="]] .. table[i][1] .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
		if table[i][4] then
			-- make things show up in first 2 parallel worlds
			-- hopefully this won't cause too much lag when starting a run
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] + worldsize .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] - worldsize .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] + worldsize * 2 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] - worldsize * 2 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
		end
	end
	content = content:gsub("<mBufferedPixelScenes>", string)
	ModTextFileSetContent(biome_path, content)
end

local scenes = {

}

add_scene(scenes)

-- player
function OnPlayerSpawned( player )

    local px, py = EntityGetTransform(player)

	dofile_once("mods/pharmacokinetics/files/gui.lua")

    if GameHasFlagRun("pharmacokinetics_init") then return end

    GlobalsSetValue("pharmacokinetics.amount", "0")

    EntityAddComponent2(player, "LuaComponent", {
		script_source_file="mods/pharmacokinetics/files/scripts/player_reduce_pharmabar.lua",
		execute_every_n_frame=50,
	})

    GameAddFlagRun("pharmacokinetics_init")
end

--translations
local translations = ModTextFileGetContent( "data/translations/common.csv" );
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n","\r\n");
    end

    local new_translations = ModTextFileGetContent( table.concat({"mods/pharmacokinetics/files/translations.csv"}) );
    translations = translations .. new_translations;

    ModTextFileSetContent( "data/translations/common.csv", translations );
end

function OnModSettingsChanged()

end