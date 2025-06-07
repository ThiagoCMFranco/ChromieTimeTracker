--------------------------------------------------------------------------------
--[[ Chromie Time Tracker ]]--
--
-- by ThiagoCMFranco <https://github.com/ThiagoCMFranco>
--
--Copyright (C) 2025  Thiago de C. M. Franco
--
--This program is free software: you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU General Public License
--along with this program.  If not, see <https://www.gnu.org/licenses/>.
--
--------------------------------------------------------------------------------

ChromieTimeTrackerUtil = ChromieTimeTrackerUtil or {}

-- Create Base Frame
local toast = CreateFrame("FRAME","CTT_ToastFrame",UIParent)
toast:SetPoint("TOP",UIParent,"TOP",0,-260)
toast:SetWidth(350)
toast:SetHeight(165)
toast:Hide()

-- Create Background Texture
toast.texture = toast:CreateTexture(nil,"BACKGROUND")
toast.texture:SetPoint("TOPLEFT",toast,"TOPLEFT",-6,0)
toast.texture:SetPoint("BOTTOMRIGHT",toast,"BOTTOMRIGHT",4,0)
toast.texture:SetTexture("interface/scenarios/scenarioevergreen2x")
toast.texture:SetTexCoord(0,.68,.023,.34)

-- Create Title Text
toast.title = toast:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
toast.title:SetPoint("TOPLEFT",toast,"TOPLEFT",23,-60)
toast.title:SetWidth(302)
toast.title:SetHeight(16)
toast.title:SetJustifyV("MIDDLE")
toast.title:SetJustifyH("CENTER")

-- Create Timeline Text
toast.description = toast:CreateFontString(nil,"ARTWORK","GameFontHighlightLarge")
toast.description:SetPoint("TOPLEFT",toast.title,"TOPLEFT",1,-18)
toast.description:SetWidth(300)
toast.description:SetHeight(32)
toast.description:SetJustifyV("MIDDLE")
toast.description:SetJustifyH("CENTER")

-- Chromie Time Tracker, Track your timewalking campaign!, 1

function ChromieTimeTrackerUtil:ShowToast(name,text,extraTime)
    PlaySound(44295,"master",true)
    toast:EnableMouse(false)
    toast.title:SetText(name)
    toast.title:SetAlpha(0)
    toast.description:SetText(text)
    toast.description:SetAlpha(0)
    C_Timer.After(extraTime + 0.1,function()
        UIFrameFadeIn(toast,.5,0,1)
    end)
    C_Timer.After(extraTime + .75,function()
        UIFrameFadeIn(toast.title,.5,0,1)
    end)
    C_Timer.After(extraTime + .75,function()
        UIFrameFadeIn(toast.description,.5,0,1)
    end)
    C_Timer.After(extraTime + 5,function()
        UIFrameFadeOut(toast,1,1,0)
    end)
end
