dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local player = GetPlayer()

if not EntityHasTag(player, "pharma_immune") then
    local x, y = EntityGetTransform(player)
    local frame = GameGetFrameNum()
    math.randomseed(frame, frame)
    local addiction_level = tonumber(GlobalsGetValue("pharmacokinetics.addiction_level", "0"))
    local magic_liquid_ingested_frame = tonumber(GlobalsGetValue("pharmacokinetics.magic_liquid_ingested_frame", "0"))
    local amount = math.random(1, 5)
    local drank_from_flask = false
    local targets = EntityGetAllChildren(player, "potion") or {}
    for i=1,#targets do
        local comp = EntityGetFirstComponentIncludingDisabled(targets[i], "MaterialInventoryComponent")
        if comp == nil then return end
        local last_frame_drank = ComponentGetValue2(comp, "last_frame_drank")
        if frame < last_frame_drank + 5 then
            drank_from_flask = true
            GamePrint("flask drank from") -- TESTING
            break
        end
    end
    if drank_from_flask then
        amount = amount * 4 -- 4 to 20
    end
    GamePrint(tostring(amount))
    if addiction_level >= 1 and frame < magic_liquid_ingested_frame + 20 then
        addiction_level = addiction_level + 0.2
    end
    if frame > magic_liquid_ingested_frame + 600 and frame < magic_liquid_ingested_frame + 3600 then
        addiction_level = addiction_level + 0.2
    end
    GlobalsSetValue("pharmacokinetics.addiction_level", tostring(addiction_level))
    GlobalsSetValue("pharmacokinetics.magic_liquid_ingested_frame", tostring(frame))
    IncreasePharmaBarAmount(amount)
    EntityRemoveIngestionStatusEffect(player, "PHARMACOKINETICS_MAGIC_LIQUID_INGESTED")
end