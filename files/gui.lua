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

    GuiStartFrame(gui)

    local screen_width,screen_height = GuiGetScreenDimensions(gui)

    -- this isnt consistent across resolutions wtf nolla
    local x = 559
    local y = 43
    --x = screen_width - (0.972 * (screen_width / 9))
    --y = screen_height - (2.7 * (screen_height / 3) )

    local height = 1
    local width = 40

    if ModSettingGet("pharmacokinetics.pharmabar_at_soulsgui") then
        x = 455
        y = 320
        height = 6
        width = 45
    end

    GuiImageNinePiece(gui, gui_id, x, y, width * (barvalue * 0.01), height, 1, "mods/pharmacokinetics/files/gui/bar.png")
    GuiZSetForNextWidget(gui, 1000 + 2)
    GuiImageNinePiece(gui, gui_id, x, y, width, height, 1, "mods/pharmacokinetics/files/gui/bar_bg.png")

    --GuiLayoutBeginVertical(gui, 72, 90)
        --GuiText(gui, 0, 0, tostring(baramount) .. " / 500")
        --GuiProgressBar(gui, 0, 0, 1000000, barvalue, 15, 2, "mods/pharmacokinetics/files/gui/bar.png")
    --GuiLayoutEnd(gui)

    GuiDestroy(gui)
end