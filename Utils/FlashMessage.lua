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

local msgFrame = CreateFrame("FRAME", "CTT_FlashMessageFrame", UIParent)
    msgFrame:SetWidth(1)
    msgFrame:SetHeight(1)
    msgFrame:SetPoint("CENTER")
    msgFrame:SetFrameStrata("TOOLTIP")
    msgFrame.text = msgFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    msgFrame.text:SetPoint("CENTER")
    msgFrame.text:SetText("")
    msgFrame:Hide()

local font, size, style = msgFrame.text:GetFont()

function ChromieTimeTrackerUtil:FlashMessage(_message, _duration, _fontScale)
    duration = _duration
    elapsed = 0
    totalRepeat = 0

    msgFrame:Show()

    msgFrame.text:SetFont(font, _fontScale*size, style)

    msgFrame.text:SetText(_message)

    PlaySound(847)   

    msgFrame:SetScript("OnUpdate", function(self, e)
        elapsed = elapsed + e
        if elapsed >= duration then
            if totalRepeat == 0 then
                self:Hide()
                return
            end
            elapsed = 0
            totalRepeat = totalRepeat - 1
            self:SetAlpha(0)
            return
        end
        self:SetAlpha(-(elapsed / (duration / 2) - 1) ^ 2 + 1)
    end)
end