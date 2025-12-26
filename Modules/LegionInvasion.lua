	
	local GetAreaPOISecondsLeft = C_AreaPoiInfo.GetAreaPOISecondsLeft

	local name, mct = ...
	local L = mct.L 

	local InvasionIcons = {
		["Legion"] = "legioninvasion-map-icon-portal-large",
		["Legion_Argus"] = "poi-rift1",
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
		--return {zoneIDsLEGION[1], zoneNamesLEGION[1], 600/60}
    end

	
	isGarrisonUIFirstLoad_InvasionWidget = true

	_reprocessa = false

    function drawGarrisonInvasionWidget(_garrisonID)

		--Tratamento para não exibir o componente durante o evento Remix: Legion pois a funcionalidade é indisponível durante o evento.
		local _LegionRemix = C_UnitAuras.GetPlayerAuraBySpellID(1213439)
    	if _LegionRemix then
			return
		end

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

		garrisonUIInvasionsFrame:Hide()

		if(_garrisonID == 3) then
            if (ChromieTimeTrackerDB.ShowLegionInvasionsOnReportWindow or ChromieTimeTrackerDB.ShowLegionInvasionsOnReportWindow == nil) then
				garrisonUIInvasionsFrame:Show()
            else
                garrisonUIInvasionsFrame:Hide()
                return
            end

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
					
					CTT_ShowIconTooltip(GameTooltip, L["Legion_Invasion"] .. leginvasion[2] ..  "." .. getRemainingTimeString(leginvasion[3],true))
                    --CTT_ShowIconTooltip(GameTooltip, L["Legion_Invasion"] .. leginvasion[2] ..  ".\n|cFFFFC90E" .. L["EmissaryMissions_RemainingTime"] .. "|r "  .. math.floor(leginvasion[3]/60) .. " " .. L["EmissaryMissions_RemainingTime_Hours_P"] .. " " .. math.floor(math.fmod(leginvasion[3],60)) .. " " .. L["EmissaryMissions_RemainingTime_Minutes_P"])
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
		end
    end

    hooksecurefunc("ShowGarrisonLandingPage", function(_LandingPageId)
		drawGarrisonInvasionWidget(_LandingPageId)
	end)

	function LegionInvasionTooltipLine(_showIcon)
		local leginvasion = FindInvasionLegion()
		if leginvasion[2] ~= "" then
			if(_showIcon) then
				return CreateInlineIcon(InvasionIcons["Legion"],18,18) .. L["Legion_Invasion"] .. leginvasion[2] ..  ".|cFFFFFFFF" .. getRemainingTimeString(leginvasion[3],true) .. "|r"
			else
				return L["Legion_Invasion"] .. leginvasion[2] ..  ".|cFFFFFFFF" .. getRemainingTimeString(leginvasion[3],true) .. "|r"
			end
		end
		return ""
	end

	function LegionArgusInvasionTooltipLine(_showIcon)
		leginvasion = FindArgusInvasionLegion()
		if leginvasion[1] ~= "" then
			if(_showIcon) then
				local InvasionLine = ""
				for _, legInvasionData in ipairs(leginvasion) do
				    InvasionLine = InvasionLine .. "\n|cFFFFFFFF" .. CreateInlineIcon(InvasionIcons["Legion_Argus"],18,18) .. " " ..  legInvasionData[3] ..  " - "  .. legInvasionData[2] .. ".|r|cFFFFFFFF" .. getRemainingTimeString(legInvasionData[4],true) .. "|r"
				end
				return InvasionLine
			else
				for _, legInvasionData in ipairs(leginvasion) do
				    InvasionLine = InvasionLine .. "\n|cFFFFFFFF" .. legInvasionData[3] ..  " |cFFFFFFFF- "  .. legInvasionData[2] .. ".|r|cFFFFFFFF" .. getRemainingTimeString(legInvasionData[4],true) .. "|r"
				end
			end
		end
		return ""
	end

	FindArgusInvasionLegion = function()
	    local ArgusIvasionTable = {}

	    for mapID in pairs(C_LEGION_INVASION_POINTS) do
	        local poiIDs = C_AreaPoiInfo.GetAreaPOIForMap(mapID)
	        if poiIDs then
	            for _, poiID in ipairs(poiIDs) do
	                local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapID, poiID)
	                if poiInfo and poiInfo.name and (poiInfo.name:find("Invas") or poiInfo.name:find("Invasion")) then
	                    local seconds = C_AreaPoiInfo.GetAreaPOISecondsLeft(poiID)
						local remainingTimeMinutes = 0
						if(seconds ~= nil) then
	                    	remainingTimeMinutes = seconds/60 or ""
						end
	                    local description = poiInfo.description

						local item = {poiInfo.name, C_Map.GetMapInfo(mapID).name, description, remainingTimeMinutes}

						table.insert(ArgusIvasionTable, item)
	                end
	            end
	        end
	    end

		return ArgusIvasionTable

	end