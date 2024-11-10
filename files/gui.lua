dofile_once("mods/pharmacokinetics/files/scripts/utils.lua")
dofile_once("mods/pharmacokinetics/files/scripts/pharma.lua")

local baramount = 0

function OnWorldPreUpdate()
    if GetPlayer() ~= nil then
        baramount = GetPharmaBarAmount()
    end
end

function OnWorldPostUpdate()
    local player = GetPlayer()
    if player ~= nil then
        GuiRender()
    end
end

function GuiRender()
    local gui = GuiCreate()
    GuiStartFrame(gui)

    GuiLayoutBeginVertical(gui, 72, 90)
        GuiText(gui, 0, 0, tostring(baramount) .. " / 300")
        -- bar here (replacing text)
    GuiLayoutEnd(gui)
end

--[[

TO DECIPHER SOON

function ProgressBarDraw(guiobj, x, y, zIndex, currentValue, width, height, barImagePath)

    if currentValue < 0 or currentValue > 100 then
        error('ProgressBar value was not between 0 and 100')
    end

    GuiImageNinePiece(guiobj, NEXTID(), x, y, width * (currentValue * 0.01), math.max(2, height), 1, barImagePath)
    GuiZSetForNextWidget(guiobj, zIndex + 2)
    GuiImageNinePiece(guiobj, NEXTID(), x, y, math.max(15, width), math.max(2, height), 1, GUSGUI_FILEPATH("img/pbarbg.png"))
    
end

you will need to replace NEXTID() with whatever next gui ID function you are using
and GUSGUI_FILEPATH("img/pbarbg.png") with the path to the bar background image
the gusgui repo should have all of the bar images which you can just copy

]]