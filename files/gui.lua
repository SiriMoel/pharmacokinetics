dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local baramount = 0
local barvalue = 0

function OnWorldPreUpdate()
    if GetPlayer() ~= nil then
        baramount = GetPharmaBarAmount()
        barvalue = math.max((baramount / 500) * 100, 0)
    end
end

function OnWorldPostUpdate()
    local player = GetPlayer()
    if player ~= nil then
        GuiRender()
    end
end

function GuiProgressBar(gui, x, y, z, value, width, height, barimagepath) -- thankyou gusgui very cool
    if value < 0 or value > 100 then
        return
    end
    GuiImageNinePiece(gui, gui_id, x, y, width * (value * 0.01), math.max(2, height), 1, barimagepath)
    GuiZSetForNextWidget(gui, z + 2)
    GuiImageNinePiece(gui, gui_id, x, y, math.max(15, width), math.max(2, height), 1, "mods/pharmacokinetics/files/gui/bar_bg.png")
end

function GuiRender()
    local gui = GuiCreate()

    local x = 0
    local y = 0

    if ModSettingGet("pharmacokinetics.pharmabar_at_soulsgui") then
        x = 72
        y = 90
    end

    GuiStartFrame(gui)

    GuiImageNinePiece(gui, gui_id, x, y, 45 * (barvalue * 0.01), 6, 1, "mods/pharmacokinetics/files/gui/bar.png")
    GuiZSetForNextWidget(gui, 1000 + 2)
    GuiImageNinePiece(gui, gui_id, x, y, 45, 6, 1, "mods/pharmacokinetics/files/gui/bar_bg.png")

    --GuiLayoutBeginVertical(gui, 72, 90)
        --GuiText(gui, 0, 0, tostring(baramount) .. " / 500")
        --GuiProgressBar(gui, 0, 0, 1000000, barvalue, 15, 2, "mods/pharmacokinetics/files/gui/bar.png")
    --GuiLayoutEnd(gui)
end