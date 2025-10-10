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
	local name, mct = ...
	local L = mct.L 

function CreateInlineIcon(atlasNameOrTexID, sizeX, sizeY, xOffset, yOffset)
	sizeX = sizeX or 16;
	sizeY = sizeY or sizeX;
	xOffset = xOffset or 0;
	yOffset = yOffset or 0;

	if (type(atlasNameOrTexID) == "number") then
		-- REF.: CreateTextureMarkup(file, fileWidth, fileHeight, width, height, left, right, top, bottom, xOffset, yOffset)
		return CreateTextureMarkup(atlasNameOrTexID, 0, 0, sizeX, sizeY, 0, 0, 0, 0, xOffset, yOffset);  --> keep original color
		-- return string.format("|T%d:%d:%d:%d:%d|t", atlasNameOrTexID, size, size, xOffset, yOffset);
	end
	-- if ( type(atlasNameOrTexID) == "string" or tonumber(atlasNameOrTexID) ~= nil ) then
	if (type(atlasNameOrTexID) == "string") then
		-- REF.: CreateAtlasMarkup(atlasName, width, height, offsetX, offsetY, rVertexColor, gVertexColor, bVertexColor)
		return CreateAtlasMarkup(atlasNameOrTexID, sizeX, sizeY, xOffset, yOffset);  --> keep original color
	end

	return ''
end

function getCovenantData()
    local l_Covenant = "Not_Selected"
    local l_CovenantID = C_Covenants.GetActiveCovenantID()
    local _CovenantData = {}
    local _ActiveCovenantName = "-"
	
        if l_CovenantID == 1 then
            l_Covenant = "Kyrian"
            _CovenantData = C_Covenants.GetCovenantData(l_CovenantID)
            _ActiveCovenantName = "- ".. _CovenantData.name .. " -"
        end
        if l_CovenantID == 2 then
            l_Covenant = "Venthyr"
            _CovenantData = C_Covenants.GetCovenantData(l_CovenantID)
            _ActiveCovenantName = "- ".. _CovenantData.name .. " -"
        end
        if l_CovenantID == 3 then
            l_Covenant = "NightFae"
            _CovenantData = C_Covenants.GetCovenantData(l_CovenantID)
            _ActiveCovenantName = "- ".. _CovenantData.name .. " -"
        end
        if l_CovenantID == 4 then
            l_Covenant = "Necrolord"
            _CovenantData = C_Covenants.GetCovenantData(l_CovenantID)
            _ActiveCovenantName = "- ".. _CovenantData.name .. " -"
        end

    local L_CovenantData = {
        l_Covenant, l_CovenantID, _ActiveCovenantName, _CovenantData
    }
    return L_CovenantData
end

--getFormatedCurrencyById
function getCurrencyById(_currencyId, _showCurrencyName) 
    local warband = ""
    local _currency = {}
    _currency = C_CurrencyInfo.GetCurrencyInfo(_currencyId)
    if(_currency.isAccountWide) then
        warband = CreateInlineIcon("warbands-icon")
    end

    local iconString = CreateInlineIcon(_currency.iconFileID)
    if(_showCurrencyName) then
        return _currency.name .. ": |cFFFFFFFF" .. _currency.quantity .. "|r " .. iconString .. warband
    else
        return "|cFFFFFFFF" .. _currency.quantity .. "|r " .. iconString .. warband
    end
end

function CTT_OpenWorldMap(mapId)

    --627 - Legion - Dalaran
    --1161 - BFA - Estreito Tiragarde
    --862 - BFA - Zuldazar

    local mId = mapId

    if(mapId == 627) then --Legion
        mId = 619
    elseif(mapId == 1161) then --Alliance Battle for Azeroth
        mId = 876
    elseif(mapId == 862) then --Horde Battle for Azeroth
        mId = 875
    else
        mId = mapId
    end

    C_Map.OpenWorldMap(mId)
end

function checkAddonLoaded(_addonName, _addonSlashCommand)
    name, title, notes, loadable, reason, security, newVersion = C_AddOns.GetAddOnInfo(_addonName)
    if(title ~= nil) then
        if(loadable)then
            if(SlashCmdList[_addonSlashCommand] == nil)then
                --print(_addonName .. " not loaded!")
                return false;
            else
                --print(_addonName .. " loaded!")
                return true;
            end
        else
            --print(_addonName .. " indisponível!")
            return false;
        end 
    end
end

--TomTomLoaded = checkAddonLoaded("TomTom", "TOMTOM_WAY")
--MapPinEnhancedLoaded = checkAddonLoaded("MapPinEnhanced", "MapPinEnhanced")

function CTT_addPin(pin, scope)

    TomTomLoaded = checkAddonLoaded("TomTom", "TOMTOM_WAY")
    MapPinEnhancedLoaded = checkAddonLoaded("MapPinEnhanced", "MapPinEnhanced")

    if(scope == 2 and TomTomLoaded) then --"TomTom"
    	local zone = C_Map.GetMapInfo(pin.uiMapID)
    	local TTPIN = SlashCmdList["TOMTOM_WAY"]
            TTPIN(zone.name .. " " .. 100 * pin.position.x .. " " .. 100 * pin.position.y .. " " .. pin.name)
    elseif(scope == 3 and MapPinEnhancedLoaded) then --"MapPinEnhanced"
    	local zone = C_Map.GetMapInfo(pin.uiMapID)
    	local MPEPIN = SlashCmdList["MapPinEnhanced"]
            MPEPIN(zone.name .. " " .. 100 * pin.position.x .. " " .. 100 * pin.position.y .. " " .. pin.name)
    else -- 1 or nil -> "Blizzard"
    	C_Map.SetUserWaypoint(pin);
    	C_SuperTrack.SetSuperTrackedUserWaypoint(true)
    end
end

function addHelpIcon(_LabelHelp, _TooltipText)

    _LabelHelp:SetText("  " .. CreateInlineIcon("glueannouncementpopup-icon-info"))
    _LabelHelp:SetWidth(22)
    _LabelHelp:SetCallback("OnEnter", function(widget, event, text)
        GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR");
		GameTooltip:SetText(
            _TooltipText
            , 1, 1, 1, nil, true);
            GameTooltip:ClearAllPoints()
        local mX, mY = GetCursorPosition()
        local uiScale = UIParent:GetEffectiveScale()
        local tooltipWidth = GameTooltip:GetWidth()
        local tooltipHeight = GameTooltip:GetHeight()
        GameTooltip:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", mX / uiScale + 10 / uiScale, mY / uiScale - tooltipHeight)
		GameTooltip:Show();
    end)
    _LabelHelp:SetCallback("OnLeave", function(widget, event, text)
        GameTooltip:Hide();
    end)

end

	function getRemainingTimeString(_remainingTime, _noTab)
		local hours = math.floor(_remainingTime / 60)
		local days =  math.floor(hours / 24)
		if(days > 0) then
			hours = math.fmod(hours,24)
		end
		local minutes = math.fmod(_remainingTime,60)
	
		local daysText = L["EmissaryMissions_RemainingTime_Days_P"]
		local hoursText = L["EmissaryMissions_RemainingTime_Hours_P"]
		local minutesText = L["EmissaryMissions_RemainingTime_Minutes_P"]
	
		if(days == 1) then
			daysText = L["EmissaryMissions_RemainingTime_Days_S"]
		end
	
		if(hours == 1) then
			hoursText = L["EmissaryMissions_RemainingTime_Hours_S"]
		end
	
		if(minutes == 1) then
			minutesText = L["EmissaryMissions_RemainingTime_Minutes_S"]
		end
		
		if _noTab then
			return "\n|cFFFFC90E" .. L["EmissaryMissions_RemainingTime"] .. "|r " .. days .. daysText .. hours .. hoursText .. math.floor(minutes) .. minutesText
		else
			return "\n  |cFFFFC90E" .. L["EmissaryMissions_RemainingTime"] .. "|r " .. days .. daysText .. hours .. hoursText .. math.floor(minutes) .. minutesText
		end
	end

AllCompletedQuests = {}

function IsQuestOnCompletedList(_questID)
    

    if(QuestsCompleted == nil or QuestsCompletedNeedReaload) then
        QuestsCompleted = C_QuestLog.GetAllCompletedQuestIDs()
        QuestsCompletedNeedReaload = false
        
        for _, quest in ipairs(QuestsCompleted) do
            table.insert(AllCompletedQuests, quest, true)
        end

    end

    if AllCompletedQuests[_questID] then
        return true
    else
        return false
    end
end

function CheckSumaryWindowIsUnlockedForExpansion(_ExpansionID, _questList, _characterDatabase, _sharedDatabase)
    if(_ExpansionID == 9) then
        --Check for Dragonfligh sumary.
        if(_characterDatabase.IsDragonIslesUnlocked) then
            return true
        end
        if(_sharedDatabase.IsDragonIslesUnlocked and _sharedDatabase.ShareWarbandUnlock) then
            return true
        end

        if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(9)) then
            _characterDatabase.IsDragonIslesUnlocked = true
            _sharedDatabase.IsDragonIslesUnlocked = true
            return true
        end

        local questList = _questList[_ExpansionID]
        
        for _, questID in ipairs(questList) do
            if IsQuestOnCompletedList(questID) then
                _characterDatabase.IsDragonIslesUnlocked = true
                _sharedDatabase.IsDragonIslesUnlocked = true
                return true
            end
        end

        return false
    end

    if(_ExpansionID == 10) then
        --Check for The War Within sumary.
        if(_characterDatabase.IsIsleOfDornUnlocked) then
            return true
        end
        if(_sharedDatabase.IsIsleOfDornUnlocked and _sharedDatabase.ShareWarbandUnlock) then
            return true
        end

        if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(10)) then
            _characterDatabase.IsIsleOfDornUnlocked = true
            _sharedDatabase.IsIsleOfDornUnlocked = true
            return true
        end

        local questList = _questList[_ExpansionID]
        
        for _, questID in ipairs(questList) do
            if IsQuestOnCompletedList(questID) then
                _characterDatabase.IsIsleOfDornUnlocked = true
                _sharedDatabase.IsIsleOfDornUnlocked = true
                return true
            end
        end

        return false
    end
end

