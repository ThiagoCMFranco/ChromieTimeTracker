	local GetAreaPOISecondsLeft = C_AreaPoiInfo.GetAreaPOISecondsLeft

	local name, mct = ...
	local L = mct.L 

    local faction = UnitFactionGroup("player")
    if faction == "Neutral" then return end

	local factionNames = {
		["BFA_Alliance"] = L["Alliance"],
		["BFA_Horde"] = L["Horde"],
	}

	local InvasionIcons = {
		["BFA_Alliance"] = "AllianceAssaultsMapBanner",
		["BFA_Horde"] = "HordeAssaultsMapBanner",
		["BFA_NZoth"] = "poi-nzothvision", --worldquest-icon-nzoth
		["None"] = ""
		
	}

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
		--return {"Teste", zoneNamesBFA[1], "BFA_Alliance", "1200", InvasionIcons["BFA_Alliance"], factionNames["BFA_Alliance"]}
    end

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
        end

		return inv
    end

	function getTaskQuestRemainingTime(_TaskQuestId)
		local status, result = pcall(C_TaskQuest.GetQuestTimeLeftMinutes, _TaskQuestId)

		if(status)then
			return status, result
		else
			return status, 0
		end
	end

	function drawGarrisonInvasionWidget_bfa(_garrisonID)
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

		if(_garrisonID == 9) then
			garrisonUIInvasionsFrame:Show()
		else
			garrisonUIInvasionsFrame:Hide()
		end

		if(_garrisonID == 9) then
					local bfainvasion = FindInvasionBFA()
					local tooltip = ""

					if(ChromieTimeTrackerDB.ShowBattleForAzerothInvasionsOnReportWindow) then
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
				else
					invasionsIconButton_1:Hide()
				end

				

					local nzothinvasion = FindInvasionNZoth()
					local tooltip = ""
					local HorrificVisions = ""
					local _remainingTime = 0
					local status

				if(ChromieTimeTrackerDB.ShowNzothInvasionsOnReportWindow) then
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

				else
					invasionsIconButton_2:Hide()
				end
				
					if(not ChromieTimeTrackerDB.ShowBattleForAzerothInvasionsOnReportWindow) then
						bfainvasion[1] = ""
					end

					if(not ChromieTimeTrackerDB.ShowNzothInvasionsOnReportWindow) then
						nzothinvasion = {}
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
			end
		end

	hooksecurefunc("ShowGarrisonLandingPage", function(_LandingPageId)
		drawGarrisonInvasionWidget_bfa(_LandingPageId)
	end)