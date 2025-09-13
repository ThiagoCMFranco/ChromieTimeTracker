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

    
function lockLevelAlert(_level, _event)

    if ChromieTimeTrackerDB.ExperienceAlertLevelFlash == nil then
        ChromieTimeTrackerDB.ExperienceAlertLevelFlash = 65
    end

    if ChromieTimeTrackerDB.ExperienceAlertLevelPopup == nil then
        ChromieTimeTrackerDB.ExperienceAlertLevelPopup = 65
    end

    if ChromieTimeTrackerDB.ExperienceAlertLevelChat == nil then
        ChromieTimeTrackerDB.ExperienceAlertLevelChat = 65
    end

    local _EliminatedExperienceAura = C_UnitAuras.GetPlayerAuraBySpellID(306715)

    if(_EliminatedExperienceAura ~= nil) then
        return
    end

    if(ChromieTimeTrackerDB.ShowExperienceAlertFlash) then
        if _level >= ChromieTimeTrackerDB.ExperienceAlertLevelFlash and _level < C_Expansion_ChromieTime_Drop_Level then
            if (_event == "PLAYER_ENTERING_WORLD" and ChromieTimeTrackerDB.ShowExperienceAlertFlashOnLogin == true) then
                --ChromieTimeTrackerUtil:FlashMessage(L["Dialog_Lock_Exp_Message"], 15, 1.5)
                local lockExpMessage = SetExperienceLockAlertMessage(L["Dialog_Lock_Exp_Message"], _level, C_Expansion_ChromieTime_Drop_Level,zoneInfo.name,zoneColor)
                ChromieTimeTrackerUtil:ExtendedFlashMessage(lockExpMessage, 15, 1.5, 15)
            end
            if (_event == "PLAYER_LEVEL_UP" and ChromieTimeTrackerDB.ShowExperienceAlertFlashOnLevelUp == true) then
                --ChromieTimeTrackerUtil:FlashMessage(L["Dialog_Lock_Exp_Message"], 15, 1.5)
                local lockExpMessage = SetExperienceLockAlertMessage(L["Dialog_Lock_Exp_Message"], _level, C_Expansion_ChromieTime_Drop_Level,zoneInfo.name,zoneColor)
                ChromieTimeTrackerUtil:ExtendedFlashMessage(lockExpMessage, 15, 1.5, 15)
                
            end
        end
    end
    if(ChromieTimeTrackerDB.ShowExperienceAlertPopup) then
        if _level >= ChromieTimeTrackerDB.ExperienceAlertLevelPopup and _level < C_Expansion_ChromieTime_Drop_Level then

            local lockExpMessage = SetExperienceLockAlertMessage(L["Dialog_Lock_Exp_Message"], _level, C_Expansion_ChromieTime_Drop_Level,zoneInfo.name,zoneColor)
                StaticPopupDialogs["LOCK_EXP_ALERT" .. "_" .. _level] = {
                    text = lockExpMessage,
                    button1 = L["Dialog_Lock_Exp_Track_Experience_Eliminator"],
                    button2 = L["Dialog_Lock_Exp_Confirm"],
                    OnAccept = function()
                        if(PlayerInfo["Faction"] == "Alliance") then
                	        C_SpecialTrackPinCoordinates["Alliance_Exp_Lock"].name = L["ContextMenuPinsAllianceExpLock"]
                	        CTT_addPin(C_SpecialTrackPinCoordinates["Alliance_Exp_Lock"], ChromieTimeTrackerDB.DefaultTrackerAddon)
                	    end
                	    if(PlayerInfo["Faction"] == "Horde") then
                	        C_SpecialTrackPinCoordinates["Horde_Exp_Lock"].name = L["ContextMenuPinsHordeExpLock"]
                	        CTT_addPin(C_SpecialTrackPinCoordinates["Horde_Exp_Lock"], ChromieTimeTrackerDB.DefaultTrackerAddon)
                	    end
                    end,
                    timeout = 0,
                    whileDead = true,
                    hideOnEscape = false,
                    preferredIndex = 3,
                }

            if (_event == "PLAYER_ENTERING_WORLD" and ChromieTimeTrackerDB.ShowExperienceAlertPopupOnLogin == true) then
                StaticPopup_Show("LOCK_EXP_ALERT" .. "_" .. _level)
            end
            if (_event == "PLAYER_LEVEL_UP" and ChromieTimeTrackerDB.ShowExperienceAlertPopupOnLevelUp == true) then
                StaticPopup_Show("LOCK_EXP_ALERT" .. "_" .. _level)
            end
        end
    end
    if(ChromieTimeTrackerDB.ShowExperienceAlertChat) then
        if _level >= ChromieTimeTrackerDB.ExperienceAlertLevelChat and _level < C_Expansion_ChromieTime_Drop_Level then
            if (_event == "PLAYER_ENTERING_WORLD" and ChromieTimeTrackerDB.ShowExperienceAlertChatOnLogin == true) then
                local lockExpMessage = SetExperienceLockAlertMessage(L["Dialog_Lock_Exp_Message_Chat"], _level, C_Expansion_ChromieTime_Drop_Level,zoneInfo.name,zoneColor)
                print(lockExpMessage)
            end
            if (_event == "PLAYER_LEVEL_UP" and ChromieTimeTrackerDB.ShowExperienceAlertChatOnLevelUp == true) then
                local lockExpMessage = SetExperienceLockAlertMessage(L["Dialog_Lock_Exp_Message_Chat"], _level, C_Expansion_ChromieTime_Drop_Level,zoneInfo.name,zoneColor)
                print(lockExpMessage)
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
            if(ChromieTimeTrackerDB.ShowExperienceAlertFlash or ChromieTimeTrackerDB.ShowExperienceAlertPopup or ChromieTimeTrackerDB.ShowExperienceAlertChat) then
                C_Timer.After(1,function()
                    lockLevelAlert(pLevel, event);
                end);
            end
        end
    end

    if event == "PLAYER_LEVEL_UP" then
        local level = ...
        if(ChromieTimeTrackerDB.ShowExperienceAlertFlash or ChromieTimeTrackerDB.ShowExperienceAlertPopup or ChromieTimeTrackerDB.ShowExperienceAlertChat) then
            C_Timer.After(1,function()
                lockLevelAlert(level, event);
            end);
        end
    end

end);

function SetExperienceLockAlertMessage(_lockExpMessage, _playerLevel, _timeTravelDropLevel, _zoneName, _zoneColor)
    local LockExpMessage = _lockExpMessage

    LockExpMessage = string.gsub(LockExpMessage,"_pLevel_",_playerLevel)
    LockExpMessage = string.gsub(LockExpMessage,"_dropLevel_",_timeTravelDropLevel)
    LockExpMessage = string.gsub(LockExpMessage,"_capital_",_zoneName)
    LockExpMessage = string.gsub(LockExpMessage,"_zoneColor_",_zoneColor)

    return LockExpMessage
end