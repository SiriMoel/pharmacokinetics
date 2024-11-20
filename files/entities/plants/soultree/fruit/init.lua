dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()

local soul = GetRandomSoulType(false)

ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "pharma_soul") or 0, "value_string", soul)
ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(this, "PhysicsImageShapeComponent") or 0, "image_file", "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png")
ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(this, "ItemComponent") or 0, "ui_sprite", "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png")
ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(this, "SpriteComponent") or 0, "image_file", "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png")