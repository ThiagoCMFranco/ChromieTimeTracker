	
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
--Utils\Functions.lua
--Localization\ptBR.lua
--Localization\enUS.lua
--Localization\ruRU.lua
--------------------------------------------------------------------------------	

	local GetAreaPOISecondsLeft = C_AreaPoiInfo.GetAreaPOISecondsLeft

	local name, mct = ...
	local L = mct.L 

    local faction = UnitFactionGroup("player")
    if faction == "Neutral" then return end

	L["Alliance"] = "A Aliança"
	L["Horde"] = "A Horda"
	L["Invasion_strike"] = " está atacando "

	local factionNames = {
		["BFA_Alliance"] = L["Alliance"],
		["BFA_Horde"] = L["Horde"],
	}

	local InvasionIcons = {
		["BFA_Alliance"] = "AllianceAssaultsMapBanner",
		["BFA_Horde"] = "HordeAssaultsMapBanner",
		["BFA_NZoth"] = "poi-nzothvision", --worldquest-icon-nzoth
		["Legion"] = "legioninvasion-map-icon-portal-large",
		["SL_Kyrian"] = "KyrianAssaults-64x64",
		["SL_Vanthyr"] = "VenthyrAssaults-64x64",
		["SL_Maldraxxus"] = "NecrolordAssaults-64x64",
		["SL_NightFae"] = "NightFaeAssaults-64x64",
		["None"] = ""
		
	}
	
	local zonePOIIdsLEGION = {
		5177, -- Highmountain
		5178, -- Stormheim
		5210, -- Val'Sharah
		5175, -- Azsuna
	}

	local zoneIDsLEGION = {
		650, -- Highmountain
		634, -- Stormheim
		641, -- Val'Sharah
		630, -- Azsuna
	}

	local zoneNamesLEGION = {
		C_Map.GetMapInfo(650).name, -- Highmountain
		C_Map.GetMapInfo(634).name, -- Stormheim
		C_Map.GetMapInfo(641).name, -- Val'Sharah
		C_Map.GetMapInfo(630).name, -- Azsuna
	}

	local questIdsLEGION = {
		45840, -- Highmountain
		45839, -- Stormheim
		45812, -- Val'Sharah
		45838, -- Azsuna
	}

	FindInvasionLegion = function()
		for i = 1, #zonePOIIdsLEGION do
			local timeLeftSeconds = GetAreaPOISecondsLeft(zonePOIIdsLEGION[i])
			-- On some realms timeLeftSeconds can return massive values during the initialization of a new event
			if timeLeftSeconds and timeLeftSeconds > 60 and timeLeftSeconds < 21601 then -- 6 hours: (6*60)*60 = 21600
				return {zoneIDsLEGION[i], zoneNamesLEGION[i], timeLeftSeconds/60}
            end
        end
		return {"", "", 0}
    end

    local zoneIDsBFA = {
	864, -- Vol'dun
	896, -- Drustvar
	862, -- Zuldazar
	895, -- Tiragarde Sound
	863, -- Nazmir
	942, -- Stormsong Valley
    }

    local zoneNamesBFA = {
	C_Map.GetMapInfo(864).name, -- Vol'dun
	C_Map.GetMapInfo(896).name, -- Drustvar
	C_Map.GetMapInfo(862).name, -- Zuldazar
	C_Map.GetMapInfo(895).name, -- Tiragarde Sound
	C_Map.GetMapInfo(863).name, -- Nazmir
	C_Map.GetMapInfo(942).name, -- Stormsong Valley
    }

    local quests = faction == "Horde" and {
		[54137] = true, -- Drustvar
		[53883] = true, -- Zuldazar
		[53939] = true, -- Tiragarde Sound
		[53885] = true, -- Vol'dun
		[54135] = true, -- Nazmir
		[54132] = true, -- Stormsong Valley
	} or {
		[53701] = true, -- Drustvar
		[54138] = true, -- Zuldazar
		[53711] = true, -- Tiragarde Sound
		[54134] = true, -- Vol'dun
		[54136] = true, -- Nazmir
		[51982] = true, -- Stormsong Valley
	}

    local zonePOIIdsBFA = {
		5970, -- Vol'dun
		5964, -- Drustvar
		5973, -- Zuldazar
		5896, -- Tiragarde Sound
		5969, -- Nazmir
		5966, -- Stormsong Valley
	}

	local questIds = faction == "Horde" and {
		53885, -- Vol'dun
		54137, -- Drustvar
		53883, -- Zuldazar
		53939, -- Tiragarde Sound
		54135, -- Nazmir
		54132, -- Stormsong Valley
	} or {
		54134, -- Vol'dun
		53701, -- Drustvar
		54138, -- Zuldazar
		53711, -- Tiragarde Sound
		54136, -- Nazmir
		51982, -- Stormsong Valley
	}

	FindInvasionBFA = function()
		for i = 1, #zonePOIIdsBFA do
			local timeLeftSeconds = GetAreaPOISecondsLeft(zonePOIIdsBFA[i])
			if timeLeftSeconds and timeLeftSeconds > 60 and timeLeftSeconds < 25201 then -- 7 hours: (7*60)*60 = 25200
				local _faction
				if zonePOIIdsBFA[i] == 5970 or zonePOIIdsBFA[i] == 5973 or zonePOIIdsBFA[i] == 5969 then
					_faction = "BFA_Alliance"
				else
					_faction = "BFA_Horde"
				end
				return {zoneIDsBFA[i], zoneNamesBFA[i], _faction, timeLeftSeconds/60, InvasionIcons[_faction], factionNames[_faction]}
            end
        end
		return {"", "", "", "", "", ""}
    end


	L["HorrificVisions"] = "Visões Horrendas"

	local zoneIdsNZoth = {
			1527, 1530
	}

	local C_ULDUM_MAP_NAME = C_Map.GetMapInfo(1527).name
	local C_VALE_MAP_NAME = C_Map.GetMapInfo(1530).name

	--key: MapTextureID
	--items: UIMapId, MapTextureID, MapName, IconTexture, MissionID
	local NZothStrikes = {
		[3165083] = {1527, 3165083, C_ULDUM_MAP_NAME, InvasionIcons["BFA_NZoth"], 56308}, -- Uldum - Aqir
		[3165092] = {1527, 3165092, C_ULDUM_MAP_NAME, InvasionIcons["BFA_NZoth"], 57157}, -- Uldum - Black Empire
		[3165098] = {1527, 3165098, C_ULDUM_MAP_NAME, InvasionIcons["BFA_NZoth"], 55350}, -- Uldum - Amathet
		[3155826] = {1530, 3155826, C_VALE_MAP_NAME, InvasionIcons["BFA_NZoth"], 57728}, -- Vale of Eternal Blossoms - Mantid
		[3155832] = {1530, 3155832, C_VALE_MAP_NAME, InvasionIcons["BFA_NZoth"], 57008}, -- Vale of Eternal Blossoms - Mogu
		[3155841] = {1530, 3155841, C_VALE_MAP_NAME, InvasionIcons["BFA_NZoth"], 56064}, -- Vale of Eternal Blossoms - Black Empire
	}

	--key: MapTextureID (Nzoth Invasion Sync: Uldum - Stormwind | Vale of Eternal Blossoms - Orgrimmar)
	--items: Vision Map Name
	local NzothHorrificVisions = {
		[3165092] = {1470, C_Map.GetMapInfo(1470).name}, -- Horrific Visions - Stormwind
		[3155841] = {1469, C_Map.GetMapInfo(1469).name}, -- Horrific Visions - Orgrimmar
	}

local function GetAssault(uiMapID)
    local textures = C_MapExplorationInfo.GetExploredMapTextures(uiMapID)

	if textures then
		local r = NZothStrikes[textures[1].fileDataIDs[1]]
		return r
	end
end

	FindInvasionNZoth = function()

		local inv = {}

		for i = 1, #zoneIdsNZoth do

			table.insert(inv, GetAssault(zoneIdsNZoth[i]))

			--return GetAssault(zoneIdsNZoth[i])
        end

		return inv

		--return {"", "", "", "", ""}
    end

--____________________________________________________________________________________________________________________
local C_THE_MAW_MAP_NAME = C_Map.GetMapInfo(1543).name

local ConvenantStrikes = {
		[1] = {63824, C_THE_MAW_MAP_NAME, InvasionIcons["SL_Kyrian"]},
		[2] = {63822, C_THE_MAW_MAP_NAME, InvasionIcons["SL_Vanthyr"]},
		[3] = {63543, C_THE_MAW_MAP_NAME, InvasionIcons["SL_Maldraxxus"]},
		[4] = {63823, C_THE_MAW_MAP_NAME, InvasionIcons["SL_NightFae"]},
	}

	FindInvasionCovenant = function()
		for i = 1, #ConvenantStrikes do
			if C_TaskQuest.IsActive(ConvenantStrikes[i][1]) then
				local timeLeftSeconds = C_TaskQuest.GetQuestTimeLeftSeconds(ConvenantStrikes[i][1])
				_questInfo = C_TaskQuest.GetQuestInfoByQuestID(ConvenantStrikes[i][1])
				if(timeLeftSeconds == nil) then
					return {1543, ConvenantStrikes[i][2], _questInfo, 0, ConvenantStrikes[i][3]}	
				end
				return {1543, ConvenantStrikes[i][2], _questInfo, timeLeftSeconds/60, ConvenantStrikes[i][3]}
			end
        end
		return {"", "", "", "", ""}
    end

--____________________________________________________________________________________________________________________

	L["Zidormi_Past"] = "passado"
	L["Zidormi_Present"] = "presente"

	local zoneNamesZidormi = {
		C_Map.GetMapInfo(249).name, -- Uldum
		C_Map.GetMapInfo(1527).name, -- Uldum
    }

	zoneIdsZidormi = {
		{249, L["Zidormi_Past"]}, -- Uldum-Zidormi-Cataclysm (249, 6549)
		{1527, L["Zidormi_Present"]}, -- Uldum-Zidormi-BFA-NZoth (1527, 6548)
	}

	zonePOIIdsZidormi = {
		6549, -- Uldum-Zidormi-Cataclysm (249, 6549)
		6548, -- Uldum-Zidormi-BFA-NZoth (1527, 6548)
	}

	FindZidormiTimeline = function()
		local _z = C_Map.GetBestMapForUnit("player");
		for i = 1, #zonePOIIdsZidormi do
			if(_z == zoneIdsZidormi[i][1]) then
				_poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(zoneIdsZidormi[i][1], zonePOIIdsZidormi[i])
				if(_poiInfo ~= nil) then
					print ("Você está na linha temporal do " .. zoneIdsZidormi[i][2] .. " de " .. zoneNamesZidormi[i])
				end
			end
        end
    end

	C_Timer.After(5, FindZidormiTimeline)
    
	hooksecurefunc("ShowGarrisonLandingPage", function(_LandingPageId)
		drawGarrisonInvasionWidget(_LandingPageId)
	end)


	L["Legion_Invasion"] = "Invasão da Legião ocorrendo em "

	function getTaskQuestRemainingTime(_TaskQuestId)
		local status, result = pcall(C_TaskQuest.GetQuestTimeLeftMinutes, _TaskQuestId)

		if(status)then
			return status, result
		else
			return status, 0
		end
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


	isGarrisonUIFirstLoad_InvasionWidget = true

	_reprocessa = false

	function drawGarrisonInvasionWidget(_garrisonID)
	    if(isGarrisonUIFirstLoad_InvasionWidget) then
	        isGarrisonUIFirstLoad_InvasionWidget = false
			garrisonUIInvasionsFrame = CreateFrame("Frame", "ChromieTimeTrackerGarrisonUIInvasionsFrame", GarrisonLandingPageReport, "")
			garrisonUIInvasionsFrame:ClearAllPoints()
			if ChromieTimeTrackerDB.ShowEmissaryMissionsOnReportWindow then
				garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "BOTTOMLEFT", 40, 200)
			else
				garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "BOTTOMLEFT", 40, 120)
			end
    		garrisonUIInvasionsFrame:SetSize(290, 80)
    		garrisonUIInvasionsFrame:SetFrameLevel(5)

			invasionsIconButton_1 = CreateFrame('CheckButton', nil, garrisonUIInvasionsFrame, 'UIButtonTemplate')
			invasionsIconButton_1:SetPoint('CENTER', 0,0)
    		invasionsIconButton_1:SetSize(58,58)
    		invasionsIconButton_1:SetFrameLevel(12)

			invasionsIconButton_2 = CreateFrame('CheckButton', nil, garrisonUIInvasionsFrame, 'UIButtonTemplate')
			invasionsIconButton_2:SetPoint('CENTER', 0,0)
    		invasionsIconButton_2:SetSize(58,58)
    		invasionsIconButton_2:SetFrameLevel(12)

		end

		_reprocessa = false

		if(_garrisonID == 3) then
				garrisonUIInvasionsFrame:Show()

				local leginvasion = FindInvasionLegion()

				if leginvasion[2] ~= "" then
				invasionsIconButton_1:Show()
				invasionsIconButton_1:SetNormalTexture(InvasionIcons["Legion"]) --AllianceAssaultsMapBanner --HordeAssaultsMapBanner --legioninvasion-map-icon-portal-large
				invasionsIconButton_1:SetHighlightTexture(InvasionIcons["Legion"])
				invasionsIconButton_1:GetHighlightTexture():SetAlpha(0.5)
				invasionsIconButton_1:SetPoint('CENTER', 0,0)
				invasionsIconButton_1:SetSize(58,58)
				if ChromieTimeTrackerDB.ShowEmissaryMissionsOnReportWindow then
					garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "BOTTOMLEFT", 40, 200)
				else
					garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "BOTTOMLEFT", 40, 120)
				end
				invasionsIconButton_1:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
                    CTT_ShowIconTooltip(GameTooltip, L["Legion_Invasion"] .. leginvasion[2] ..  ".\n|cFFFFC90E" .. L["EmissaryMissions_RemainingTime"] .. "|r "  .. math.floor(leginvasion[3]/60) .. " horas " .. math.floor(math.fmod(leginvasion[3],60)) .. " minutos.")
                    GameTooltip:Show()
                end)
    	        invasionsIconButton_1:SetScript("OnLeave", function(self)
    	            GameTooltip:Hide()
    	        end)
				invasionsIconButton_1:SetScript('OnClick',function(self)
                    CTT_OpenWorldMap(leginvasion[1])
                end)
				invasionsIconButton_2:Hide()
			else
				invasionsIconButton_1:Hide()
				invasionsIconButton_2:Hide()
			end

		elseif(_garrisonID == 9) then
					garrisonUIInvasionsFrame:Show()

					local bfainvasion = FindInvasionBFA()
					local tooltip = ""
					if bfainvasion[3] ~= "" then
						invasionsIconButton_1:SetNormalTexture(bfainvasion[5])
						tooltip = bfainvasion[6] .. L["Invasion_strike"] .. bfainvasion[2] ..  ".\n|cFFFFC90E" .. L["EmissaryMissions_RemainingTime"] .. "|r "  .. math.floor(bfainvasion[4]/60) .. " horas " .. math.floor(math.fmod(bfainvasion[4],60)) .. " minutos."
						invasionsIconButton_1:SetHighlightTexture(bfainvasion[5])
						invasionsIconButton_1:GetHighlightTexture():SetAlpha(0.5)
						invasionsIconButton_1:SetSize(58,58)
						if ChromieTimeTrackerDB.ShowEmissaryMissionsOnReportWindow then
							garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "BOTTOMLEFT", 40, 200)
						else
							garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "BOTTOMLEFT", 40, 120)
						end
						invasionsIconButton_1:Show()
					else
						invasionsIconButton_1:SetNormalTexture(InvasionIcons["None"]) --AllianceAssaultsMapBanner --HordeAssaultsMapBanner --legioninvasion-map-icon-portal-large	
						invasionsIconButton_1:Hide()
					end
					
					invasionsIconButton_1:SetScript("OnEnter", function(self)
                        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
                        CTT_ShowIconTooltip(GameTooltip, tooltip)
                        GameTooltip:Show()
                    end)
                    invasionsIconButton_1:SetScript("OnLeave", function(self)
                        GameTooltip:Hide()
                    end)
					invasionsIconButton_1:SetScript('OnClick',function(self)
                        CTT_OpenWorldMap(bfainvasion[1])
                	end)


					local nzothinvasion = FindInvasionNZoth()
					local tooltip = ""
					local HorrificVisions = ""
					local _remainingTime = 0
					local status

					if (#nzothinvasion > 0) then
						for i = 1, #nzothinvasion do
							if nzothinvasion[i][3] ~= "" then
								local iconCompleted = ""
								isCompleted = C_QuestLog.IsQuestFlaggedCompleted(nzothinvasion[i][5])
								if isCompleted then
									iconCompleted = CreateInlineIcon("Tracker-Check")
								else
									iconCompleted = ""
								end
								invasionsIconButton_2:SetNormalTexture(nzothinvasion[i][4])
								tooltip = tooltip .. "|cFFFFC90E" .. nzothinvasion[i][3] .. "|r\n  " .. iconCompleted .. C_QuestLog.GetTitleForQuestID(nzothinvasion[i][5])

								status, _remainingTime = getTaskQuestRemainingTime(nzothinvasion[i][5])

								if _remainingTime == nil then
									_remainingTime = 0
									tooltip = tooltip
									_reprocessa = true
								else
									tooltip = tooltip .. getRemainingTimeString(_remainingTime)
								end
								
								
								if i < #nzothinvasion then
									tooltip = tooltip .. "\n\n"
								end
								invasionsIconButton_2:SetHighlightTexture(nzothinvasion[i][4])
								invasionsIconButton_2:GetHighlightTexture():SetAlpha(0.5)
								if ChromieTimeTrackerDB.ShowEmissaryMissionsOnReportWindow then
									garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "BOTTOMLEFT", 40, 200)
								else
									garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "BOTTOMLEFT", 40, 120)
								end
								invasionsIconButton_2:Show()
							else
								invasionsIconButton_2:SetNormalTexture(InvasionIcons["None"])
								invasionsIconButton_2:Hide()
							end

							if nzothinvasion[i][2] == 3165092 then
								HorrificVisions = 3165092
							elseif nzothinvasion[i][2] == 3155841 then
								HorrificVisions = 3155841
							end

						end

						tooltip = tooltip .. "\n\n|cFFFFC90E" .. L["HorrificVisions"] .. "|r\n  " .. NzothHorrificVisions[HorrificVisions][2]

						invasionsIconButton_2:SetScript("OnEnter", function(self)
							GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
							if(_reprocessa) then
								Reproc = false
								drawGarrisonInvasionWidget(_garrisonID)
							end
							CTT_ShowIconTooltip(GameTooltip, tooltip)
							GameTooltip:Show()
						end)
						invasionsIconButton_2:SetScript("OnLeave", function(self)
							GameTooltip:Hide()
						end)
						invasionsIconButton_2:SetScript('OnClick',function(self)
							if ChromieTimeTrackerDB.LastClickedNZothInvasion == 2 then
								CTT_OpenWorldMap(nzothinvasion[1][1])								
								ChromieTimeTrackerDB.LastClickedNZothInvasion = 1
							else
								CTT_OpenWorldMap(nzothinvasion[2][1])
								ChromieTimeTrackerDB.LastClickedNZothInvasion = 2
							end
						end)
					end

					if(#nzothinvasion > 0 and bfainvasion[1] ~= "") then
						invasionsIconButton_1:SetPoint('CENTER', -30, 0)
						invasionsIconButton_2:SetPoint('CENTER', 30, 0)
					elseif(#nzothinvasion > 0 and bfainvasion[1] == "") then
						invasionsIconButton_2:SetPoint('CENTER', 0,0)
					elseif(#nzothinvasion == 0 and bfainvasion[1] ~= "") then
						invasionsIconButton_1:SetPoint('CENTER', 0,0)
					else
						
					end

				elseif(_garrisonID == 111) then

					covenantInvasion = FindInvasionCovenant()

					if covenantInvasion[2] ~= "" then
					invasionsIconButton_1:Show()
					invasionsIconButton_1:SetNormalTexture(covenantInvasion[5]) --AllianceAssaultsMapBanner --HordeAssaultsMapBanner --legioninvasion-map-icon-portal-large
					invasionsIconButton_1:SetHighlightTexture(covenantInvasion[5])
					invasionsIconButton_1:GetHighlightTexture():SetAlpha(0.5)
					invasionsIconButton_1:SetPoint('CENTER', 0,0)
					if ChromieTimeTrackerDB.ShowEmissaryMissionsOnReportWindow then
						--garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "BOTTOMLEFT", 40, 200)
						garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "TOPLEFT", 175, -25)
						invasionsIconButton_1:SetSize(38,38)
					else
						--garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "BOTTOMLEFT", 40, 120)
						garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "TOPLEFT", 175, -25)
						invasionsIconButton_1:SetSize(38,38)
					end
					invasionsIconButton_1:SetScript("OnEnter", function(self)
                	    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
                	    --CTT_ShowIconTooltip(GameTooltip, covenantInvasion[3] ..  ".\n|cFFFFC90E" .. L["EmissaryMissions_RemainingTime"] .. "|r "  .. math.floor(covenantInvasion[4]/60) .. " horas " .. math.floor(math.fmod(covenantInvasion[4],60)) .. " minutos.")
						CTT_ShowIconTooltip(GameTooltip, covenantInvasion[3] .. getRemainingTimeString(covenantInvasion[4], true))
                	    GameTooltip:Show()
                	end)
    	        	invasionsIconButton_1:SetScript("OnLeave", function(self)
    	        	    GameTooltip:Hide()
    	        	end)
					invasionsIconButton_1:SetScript('OnClick',function(self)
                	    CTT_OpenWorldMap(covenantInvasion[1])
                	end)
					invasionsIconButton_2:Hide()
					else
						invasionsIconButton_1:Hide()
						invasionsIconButton_2:Hide()
					end
					
		else
			garrisonUIInvasionsFrame:Hide()
		end
	end

