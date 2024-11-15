dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

dofile_once("mods/pharmacokinetics/lib/DialogSystem/init.lua")("mods/pharmacokinetics/lib/DialogSystem")

ModMaterialsFileAdd("mods/pharmacokinetics/files/materials.xml")

-- set & append
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/pharmacokinetics/files/status_list.lua" )

-- nxml
local nxml = dofile_once("mods/pharmacokinetics/lib/nxml.lua")

local materials_files = ModMaterialFilesGet() -- this function does NOT work how its meant to
for i,file in ipairs(materials_files) do
	local materials = ModTextFileGetContent(file)
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
	ModTextFileSetContent(file, tostring(xml))
end

--[[local materials = ModTextFileGetContent("data/materials.xml")
local xml = nxml.parse(materials)
for element in xml:each_child() do
    if element.attr.tags ~= nil and string.find(element.attr.tags, "[^%a]magic_liquid[^%a]") then
       	for child in element:each_of("StatusEffects") do
            for childdos in child:each_of("Ingestion") do
               	childdos:add_child(nxml.parse([[
                    <StatusEffect type="PHARMACOKINETICS_MAGIC_LIQUID_INGESTED" amount="1" />
               	))
           	end
       	end
   	end
end
ModTextFileSetContent("data/materials.xml", tostring(xml))]]



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
	{ 716, -89 - 6, "mods/pharmacokinetics/files/entities/npcs/sormi/npc.xml", false }, -- NOT FINAL POSITION
	{ 0, -150, "mods/pharmacokinetics/files/entities/npcs/mysterious_stranger/npc.xml", false }, -- NOT FINAL POSITION
	{ 0, -100, "mods/pharmacokinetics/files/entities/npcs/shaman/npc.xml", false }, -- NOT FINAL POSITION
}

add_scene(scenes)

-- player
function OnPlayerSpawned( player )

    local px, py = EntityGetTransform(player)

	dofile_once("mods/pharmacokinetics/files/gui.lua")

    if GameHasFlagRun("pharmacokinetics_init") then return end


	-- TESTING (also see pixel scenes, there may be some testing things there)

	--[[for i,v in ipairs(materials_files) do
		print("pharmacokinetics - found materials file:  " .. v)
	end]]

	--EntityLoad("mods/pharmacokinetics/files/entities/plants/magicflasktree/seed/seed.xml", px, py)

	-- END TESTING

    GlobalsSetValue("pharmacokinetics.amount", "0")
	GlobalsSetValue("pharmacokinetics.shopmult", "1")

    EntityAddComponent2(player, "LuaComponent", {
		script_source_file="mods/pharmacokinetics/files/scripts/player_reduce_pharmabar.lua",
		execute_every_n_frame=60,
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