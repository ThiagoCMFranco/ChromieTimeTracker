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
        return _currency.name .. ": |cFFFFFFFF" .. formatNumberWithThousandsSeparator(_currency.quantity) .. "|r " .. iconString .. warband
    else
        return "|cFFFFFFFF" .. formatNumberWithThousandsSeparator(_currency.quantity) .. "|r " .. iconString .. warband
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

function formatNumberWithThousandsSeparator(n)
    local s = tostring(math.floor(n)) -- Convert to string and ensure integer part
    local formatted = ""
    local len = #s

    for i = 1, len do
        local char = s:sub(i, i)
        formatted = formatted .. char
        if (len - i) % 3 == 0 and i ~= len then
            formatted = formatted .. "."
        end
    end
    return formatted
end

function GetInfinitePowerBonuses(_Atribute)

    local spellID = 1232454 -- Infinite Power
    local atributeValue = 0

    -- Verifica se aura ativa no jogador
    local aura = C_UnitAuras.GetPlayerAuraBySpellID(spellID) 
    if not aura then
        return atributeValue
    end

    if(_Atribute == "Versatility") then        
        return aura.points[5]
    end  
    if(_Atribute == "Experience") then
        return aura.points[10]
    end

    return "Unset"
end

function generateBountyList(mapID)

        local bountyList = C_QuestLog.GetBountiesForMapID(mapID)
        local _bountyList = {}

        if bountyList then
            for _, bounty in ipairs(bountyList) do
                local info = {}
                local obj = C_QuestLog.GetQuestObjectives(bounty.questID)
                
                info.text =  C_QuestLog.GetTitleForQuestID(bounty.questID)
                info.objective = obj[1].text
                info.complete = C_QuestLog.IsComplete(bounty.questID)
                info.icon = bounty.icon
                info.value = bounty.questID
                info.checked = info.value == value
                info.remainingTimeMinutes = C_TaskQuest.GetQuestTimeLeftMinutes(bounty.questID)
                local numQuestRewards = GetNumQuestLogRewards(bounty.questID)
                local name, texture, numItems, currencyID
                local hasCurrencyReward = false
                local hasMoneyReward = false

                local money = GetQuestLogRewardMoney(bounty.questID)
                
                if ( money > 0 ) then
                        local gold = floor(money / (10000))
                        info.rewardTexture = "Coin-Gold"
                        info.rewardName = ""
                        info.rewardNumItems = gold
                        hasMoneyReward = true  
                end

                if not ( money > 0 ) then
                for _, currencyInfo in ipairs(C_QuestLog.GetQuestRewardCurrencies(bounty.questID)) do
                        info.rewardName = currencyInfo.name
                        info.rewardTexture = currencyInfo.texture
                        info.rewardNumItems = currencyInfo.totalRewardAmount    
                        info.currencyID = currencyInfo.currencyID
                        hasCurrencyReward = true              
                end
                end
                
                if numQuestRewards > 0 then
                    info.rewardName, info.rewardTexture, info.rewardNumItems, info.rewardQuality, info.rewardIsUsable, info.rewardItemID = GetQuestLogRewardInfo(1, bounty.questID);
                    local rewardList = {}
                    
                    for i = 1, numQuestRewards, 1 do
                        local rewardInfo = {}
                        rewardInfo.rewardName, rewardInfo.rewardTexture, rewardInfo.rewardNumItems, rewardInfo.rewardQuality, rewardInfo.rewardIsUsable, rewardInfo.rewardItemID = GetQuestLogRewardInfo(i, bounty.questID);
                        table.insert(rewardList, rewardInfo)
                    end
                    
                    if(hasMoneyReward) then
                        local rewardGold = {}
                        local rewardSilver = {}
                        
                        local gold = floor(money / (10000))
                        rewardGold.rewardTexture = "Coin-Gold"
                        rewardGold.rewardName = ""
                        rewardGold.rewardNumItems = gold
                        rewardGold.rewardType = "Gold"

                        table.insert(rewardList, rewardGold)

                        local silver = floor((money - (gold)*10000) / (100))
                        rewardSilver.rewardTexture = "Coin-Silver"
                        rewardSilver.rewardName = ""
                        rewardSilver.rewardNumItems = silver
                        rewardSilver.rewardType = "Silver"

                        table.insert(rewardList, rewardSilver)
                    end

                    info.rewardList = rewardList
                    
                elseif hasMoneyReward then
                    --already loaded, do not overwrite
                elseif hasCurrencyReward then
                    --already loaded, do not overwrite
                else
                    info.rewardName = ""
                    info.rewardTexture = ""
                    info.rewardNumItems = ""
                    emissaryMissionRewardLoadedOk = false
                end
                table.insert(_bountyList,info)
            end

            if (table.getn(_bountyList) == 2) then
                table.insert(_bountyList,addDummyEmissaryQuest(L["EmissaryMissions_Inactive"], L["EmissaryMissions_RespawnTime_1_Day"], 0))
            elseif (table.getn(_bountyList) == 1) then
                table.insert(_bountyList,addDummyEmissaryQuest(L["EmissaryMissions_Inactive"], L["EmissaryMissions_RespawnTime_1_Day"], 0))
                table.insert(_bountyList,addDummyEmissaryQuest(L["EmissaryMissions_Inactive"], L["EmissaryMissions_RespawnTime_2_Day"], 0))
            elseif (table.getn(_bountyList) == 0) then
                table.insert(_bountyList,addDummyEmissaryQuest(L["EmissaryMissions_Inactive"], L["EmissaryMissions_RespawnTime_1_Day"], 0)) -- "Missão indisponível", "Retorne amanhã para uma nova missão"
                table.insert(_bountyList,addDummyEmissaryQuest(L["EmissaryMissions_Inactive"], L["EmissaryMissions_RespawnTime_2_Day"], 0)) -- "Missão indisponível", "Retorne em dois dias para uma nova missão"
                table.insert(_bountyList,addDummyEmissaryQuest(L["EmissaryMissions_Inactive"], L["EmissaryMissions_RespawnTime_3_Day"], 0)) -- "Missão indisponível", "Retorne em três dias para uma nova missão"
            end

        end

        return _bountyList
end


function listEmissaryMissions(_showRewards)

    local _bountyList = generateBountyList(627)

    local emissaryMissionDetails = ""
    local skip = false
    local count = 0 

    for _id, _emissaryMission in pairs(_bountyList) do 
                
                count = count + 1

                if(_emissaryMission.complete) then
                    emissaryMissionDetails = emissaryMissionDetails .. CreateInlineIcon("worldquest-tracker-checkmark")   
                end

                if(_emissaryMission.complete or _emissaryMission.text == L["EmissaryMissions_Inactive"]) then
                    
                else
                    if(_emissaryMission.remainingTimeMinutes < 360) then
                        emissaryMissionDetails = emissaryMissionDetails .. CreateInlineIcon("questlog-questtypeicon-clockorange")  
                    end
                end

                if(count > 1) then
                    emissaryMissionDetails = emissaryMissionDetails .. "\n\n"
                end

                if(_emissaryMission.remainingTimeMinutes == 0) then
                    emissaryMissionDetails = emissaryMissionDetails .. _emissaryMission.text .. "\n" .. _emissaryMission.objective
                    skip = true
                end

                if not skip then
                if(_emissaryMission.text ~= nil and _emissaryMission.objective ~= nil and _emissaryMission.rewardName ~= nil and _emissaryMission.rewardNumItems ~= nil and _emissaryMission.rewardTexture ~= nil and _emissaryMission.remainingTimeMinutes ~= nil) then
                    if(days == 0) then
                        emissaryMissionDetails = emissaryMissionDetails .. _emissaryMission.text .. "\n|cFFFFC90E" .. L["EmissaryMissions_Objective"] .. "|r " .. _emissaryMission.objective .. getRemainingTimeString(_emissaryMission.remainingTimeMinutes,true)
                    else
                        emissaryMissionDetails = emissaryMissionDetails .. _emissaryMission.text .. "\n|cFFFFC90E" .. L["EmissaryMissions_Objective"] .. "|r " .. _emissaryMission.objective .. getRemainingTimeString(_emissaryMission.remainingTimeMinutes,true)

                        if (_showRewards) then
                            emissaryMissionDetails = emissaryMissionDetails .. "\n|cFFFFC90E" .. L["EmissaryMissions_Reward"] .. "|r"
                            if _emissaryMission.rewardList then
                                for id, _emissaryMissionRewards in pairs(_emissaryMission.rewardList) do
                                    if(_emissaryMissionRewards.rewardName)then
                                        if(_emissaryMissionRewards.rewardType ~= "Silver") then
                                            emissaryMissionDetails = emissaryMissionDetails .. "\n" .. "   " 
                                        end
                                        emissaryMissionDetails = emissaryMissionDetails .. CreateInlineIcon(_emissaryMissionRewards.rewardTexture) .. " " .. _emissaryMissionRewards.rewardNumItems .. " " .. _emissaryMissionRewards.rewardName
                                    end
                                end
                            end
                        end
                    end
                end
                end

            end

            if(count > 0) then
                return "\n" .. L["EmissaryMissions_Title"] .. "|cFFFFFFFF" .. "\n" .. emissaryMissionDetails .. "|r"    
            else
                return ""
            end
                            
            
end

function CTT_VerifyQuestCompleted(p_questID)

    local isCompleted = false
    local title = nil
    local isAvailable = false
    local zone = {}
    if type(tonumber(p_questID)) == "number" then
        isCompleted = C_QuestLog.IsQuestFlaggedCompleted(p_questID)
	    title = C_QuestLog.GetTitleForQuestID(p_questID)
        isAvailable = C_TaskQuest.IsActive(p_questID)
        zone = C_Map.GetMapInfo(C_WORLD_BOSSES_QUESTS_DATA[p_questID].uiMapID)
    else
        isCompleted = false
        title = ""
        isAvailable = false
        zone = {}
    end

    

    return {title,isCompleted,isAvailable,zone.name}

end