	local name, mct = ...
	local L = mct.L 

    local C_THE_MAW_MAP_NAME = C_Map.GetMapInfo(1543).name

local InvasionIcons = {
		["SL_Kyrian"] = "KyrianAssaults-64x64",
		["SL_Vanthyr"] = "VenthyrAssaults-64x64",
		["SL_Maldraxxus"] = "NecrolordAssaults-64x64",
		["SL_NightFae"] = "NightFaeAssaults-64x64",
		["None"] = ""
		
	}

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

	function drawGarrisonInvasionWidget_Covenants(_garrisonID)
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

		if(_garrisonID == 111) then

			if(ChromieTimeTrackerDB.ShowCovenantInvasionsOnReportWindow) then

				garrisonUIInvasionsFrame:Show()

					covenantInvasion = FindInvasionCovenant()

					if covenantInvasion[2] ~= "" then
					invasionsIconButton_1:Show()
					invasionsIconButton_1:SetNormalTexture(covenantInvasion[5]) --AllianceAssaultsMapBanner --HordeAssaultsMapBanner --legioninvasion-map-icon-portal-large
					invasionsIconButton_1:SetHighlightTexture(covenantInvasion[5])
					invasionsIconButton_1:GetHighlightTexture():SetAlpha(0.5)
					invasionsIconButton_1:SetPoint('CENTER', 0,0)

					garrisonUIInvasionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "TOPLEFT", 175, -25)
					invasionsIconButton_1:SetSize(38,38)
					garrisonUIInvasionsFrame:Show()

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
	end

	
	hooksecurefunc("ShowGarrisonLandingPage", function(_LandingPageId)
		drawGarrisonInvasionWidget_Covenants(_LandingPageId)
	end)