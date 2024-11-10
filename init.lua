dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")

--dofile_once("mods/pharmacokinetics/lib/nxml.lua")
local nxml = dofile_once("mods/pharmacokinetics/lib/nxml.lua")

-- nxml
print("OI WE'RE FUCKIN RUNNING")
--local materials_altered = ""
--local materials = ModTextFileGetContent("data/materials.xml")
--local xml = nxml.parse(materials)
--print(materials)
--[[for element in xml:each_child() do
    print("WE'RE IN THE LOOP")
    --print("moldos " .. type(element.attr.tags))
    --[[if string.find(element.attr.tags, "[magic_liquid]") then
        local children = element:all_of("StatusEffects")
        for child in children:each_child() do
            if child.name == "Ingestion" then
                print("Ingestion found!")
            end
        end
        materials_altered = materials_altered .. "," .. element.attr.name
    end
end]]
--print(materials_altered)

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

	-- gui here

    if GameHasFlagRun("pharmacokinetics_init") then return end

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