dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

-- libs
dofile_once("mods/pharmacokinetics/lib/DialogSystem/init.lua")("mods/pharmacokinetics/lib/DialogSystem")
dofile_once("mods/pharmacokinetics/lib/injection.lua")

ModMaterialsFileAdd("mods/pharmacokinetics/files/materials.xml")
ModMaterialsFileAdd("mods/pharmacokinetics/files/reactions.xml")

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
	{ 10060, -1201 - 6, "mods/pharmacokinetics/files/entities/npcs/sormi/npc.xml", false },
	{ -15949, -6396, "mods/pharmacokinetics/files/entities/npcs/mysterious_stranger/npc.xml", false },
}

if ModIsEnabled("souls") then
	table.insert(scenes, { 13135, 1649, "mods/pharmacokinetics/files/entities/npcs/soultrader/npc.xml", false })
end

add_scene(scenes)

-- shaders (ty nathan)
inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "// liquid distortion", "mods/pharmacokinetics/files/shaders/pre.frag")
inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "gl_FragColor", "mods/pharmacokinetics/files/shaders/post.frag")
inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "varying vec2 tex_coord_fogofwar;", "mods/pharmacokinetics/files/shaders/global.frag")

GameSetPostFxParameter("pharma_datura_effect_amount", 0, 0, 0, 0)
GameSetPostFxParameter("pharma_pharmadust_effect_amount", 0, 0, 0, 0)
GameSetPostFxParameter("pharma_wizarddust_effect_amount", 0, 0, 0, 0)
GameSetPostFxParameter("pharma_love_effect_amount", 0, 0, 0, 0)

-- player
function OnPlayerSpawned( player )

    local px, py = EntityGetTransform(player)

	dofile_once("mods/pharmacokinetics/files/gui.lua")

    if GameHasFlagRun("pharmacokinetics_init") then return end

	-- TESTING (also see pixel scenes, there may be some testing things there)

	--[[for i,v in ipairs(materials_files) do
		print("pharmacokinetics - found materials file:  " .. v)
	end]]

	--print(ModTextFileGetContent("data/shaders/post_final.frag"))

	--EntityLoad("mods/pharmacokinetics/files/entities/plants/magicflasktree/seed/seed.xml", px, py)
	--EntityLoad("mods/pharmacokinetics/files/entities/npcs/mysterious_stranger/npc.xml", px, py)

	-- END TESTING

    GlobalsSetValue("pharmacokinetics.amount", "0")
	GlobalsSetValue("pharmacokinetics.shopmult", "1")
	GlobalsSetValue("pharmacokinetics.daturatripping", "-1")
	GlobalsSetValue("pharmacokinetics.datura_dream_frame", "0")
	GlobalsSetValue("pharmacokinetics.datura_howhigh", "0")
	GlobalsSetValue("pharmacokinetics.pharmadust_howhigh", "0")
	GlobalsSetValue("pharmacokinetics.wizarddust_howhigh", "0")
	GlobalsSetValue("pharmacokinetics.love_howhigh", "0")

    EntityAddComponent2(player, "LuaComponent", {
		script_source_file="mods/pharmacokinetics/files/scripts/player_reduce_pharmabar.lua",
		execute_every_n_frame=60,
	})

	--[[EntityAddComponent2(player, "LuaComponent", {
		script_source_file="mods/pharmacokinetics/files/scripts/player_everyframe.lua",
		execute_every_n_frame=1,
	})]]

	EntityAddComponent(player, "LuaComponent", {
        script_damage_about_to_be_received="mods/pharmacokinetics/files/scripts/player_damage_handler.lua"
    })

    GameAddFlagRun("pharmacokinetics_init")
end

--translations
local translations = ModTextFileGetContent( "data/translations/common.csv" )
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n","\r\n")
    end
    local new_translations = ModTextFileGetContent(table.concat({"mods/pharmacokinetics/files/translations.csv"}))
    translations = translations .. new_translations
    ModTextFileSetContent( "data/translations/common.csv", translations )
end

function OnModSettingsChanged()

end