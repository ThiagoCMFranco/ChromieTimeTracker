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

--------------------------------------------------------------------------------	
--Dependencies and Related Files
--ChromieTimeTracker.lua
--Settings.lua
--Utils\FlashMessage.lua
--Localization\ptBR.lua
--Localization\enUS.lua
--Localization\ruRU.lua
--------------------------------------------------------------------------------	

local name, mct = ...
local L = mct.L 

local playerClass, englishClass = UnitClass("player")
englishFaction, localizedFaction = UnitFactionGroup("player")

local PlayerInfo = {}
PlayerInfo["Name"] = ""
PlayerInfo["Class"] = englishClass
PlayerInfo["Faction"] = englishFaction
PlayerInfo["Timeline"] = ""

zoneInfo = ""
zoneColor = ""

if PlayerInfo["Faction"] == "Horde" then
    	zoneInfo = C_Map.GetMapInfo(85)
        zoneColor = "FFF25252"
end

if PlayerInfo["Faction"] == "Alliance" then
    	zoneInfo = C_Map.GetMapInfo(84)
        zoneColor = "FF3282F6"
end

C_Expansion_ChromieTime_Drop_Level = 70
pLevel = UnitLevel("player")

L["Dialog_Lock_Exp_Message"] = string.gsub(L["Dialog_Lock_Exp_Message"],"_pLevel_",pLevel)
L["Dialog_Lock_Exp_Message"] = string.gsub(L["Dialog_Lock_Exp_Message"],"_dropLevel_",C_Expansion_ChromieTime_Drop_Level)
L["Dialog_Lock_Exp_Message"] = string.gsub(L["Dialog_Lock_Exp_Message"],"_capital_",zoneInfo.name)
L["Dialog_Lock_Exp_Message"] = string.gsub(L["Dialog_Lock_Exp_Message"],"_zoneColor_",zoneColor)
    
StaticPopupDialogs["LOCK_EXP_ALERT"] = {
    text = L["Dialog_Lock_Exp_Message"],
    button1 = L["Dialog_Lock_Exp_Confirm"],
    button2 = L["Dialog_Lock_Exp_Close"],
    OnAccept = function()

    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = false,
    preferredIndex = 3,
}
    
function lockLevelAlert(_level, _event)

    if ChromieTimeTrackerDB.ExperienceAlertLevelFlash == nil then
        ChromieTimeTrackerDB.ExperienceAlertLevelFlash = 65
    end

    if ChromieTimeTrackerDB.ExperienceAlertLevelPopup == nil then
        ChromieTimeTrackerDB.ExperienceAlertLevelPopup = 65
    end

    local _EliminatedExperienceAura = C_UnitAuras.GetPlayerAuraBySpellID(306715)

    if(_EliminatedExperienceAura ~= nil) then
        return
    end

    if(ChromieTimeTrackerDB.ShowExperienceAlertFlash) then
        if _level >= ChromieTimeTrackerDB.ExperienceAlertLevelFlash and _level < C_Expansion_ChromieTime_Drop_Level then
            if (_event == "PLAYER_ENTERING_WORLD" and ChromieTimeTrackerDB.ShowExperienceAlertFlashOnLogin == true) then
                ChromieTimeTrackerUtil:FlashMessage(L["Dialog_Lock_Exp_Message"], 15, 1.5)
            end
            if (_event == "PLAYER_LEVEL_UP" and ChromieTimeTrackerDB.ShowExperienceAlertFlashOnLevelUp == true) then
                ChromieTimeTrackerUtil:FlashMessage(L["Dialog_Lock_Exp_Message"], 15, 1.5)
            end
        end
    end
    if(ChromieTimeTrackerDB.ShowExperienceAlertPopup) then
        if _level >= ChromieTimeTrackerDB.ExperienceAlertLevelPopup and _level < C_Expansion_ChromieTime_Drop_Level then
            if (_event == "PLAYER_ENTERING_WORLD" and ChromieTimeTrackerDB.ShowExperienceAlertPopupOnLogin == true) then
                StaticPopup_Show ("LOCK_EXP_ALERT")
            end
            if (_event == "PLAYER_LEVEL_UP" and ChromieTimeTrackerDB.ShowExperienceAlertPopupOnLevelUp == true) then
                StaticPopup_Show ("LOCK_EXP_ALERT")
            end
        end
    end
end

local E = CreateFrame('Frame')
E:RegisterEvent('PLAYER_ENTERING_WORLD')
E:RegisterEvent('PLAYER_LEVEL_UP')

E:SetScript('OnEvent', function(self, event, ...)

    if event == "PLAYER_ENTERING_WORLD" then
        local isInitialLogin, isReloadingUi = ...
        if isInitialLogin then
            if(ChromieTimeTrackerDB.ShowExperienceAlertFlash or ChromieTimeTrackerDB.ShowExperienceAlertPopup) then
                C_Timer.After(1,function()
                    lockLevelAlert(pLevel, event);
                end);
            end
        end
    end

    if event == "PLAYER_LEVEL_UP" then
        local level = ...
        if(ChromieTimeTrackerDB.ShowExperienceAlertFlash or ChromieTimeTrackerDB.ShowExperienceAlertPopup) then
            C_Timer.After(1,function()
                lockLevelAlert(level, event);
            end);
        end
    end

end);
