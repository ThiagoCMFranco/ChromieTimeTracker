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


-- Criação do banco de dados.

if not ChromieTimeTrackerDB then
    ChromieTimeTrackerDB = {}
end

local name, mct = ...
local L = mct.L 
local C = {}
C[2] = "FF00AA00" --BC
C[3] = "FF07DAF7" --WotLK
C[4] = "FFEB8A0E" --Cata
C[5] = "FF00FF98" --MoP
C[6] = "FFA1481D" --WoD
C[7] = "FF00FF00" --Legion
C[8] = "FF056AC4" --BfA
C[9] = "FF888888" --SL
C[10] = "FFC90A67" --DF
C[11] = "FF7F27" --TWW

local ExpansionGarrisonID = {}
ExpansionGarrisonID[2] = 0 --BC
ExpansionGarrisonID[3] = 0 --WotLK
ExpansionGarrisonID[4] = 0 --Cata
ExpansionGarrisonID[5] = 0 --MoP
ExpansionGarrisonID[6] = 2 --WoD
ExpansionGarrisonID[7] = 3 --Legion
ExpansionGarrisonID[8] = 9 --BfA
ExpansionGarrisonID[9] = 111 --SL
ExpansionGarrisonID[10] = "DF" --DF
ExpansionGarrisonID[11] = "TWW" --TWW

local ExpansionGarrisonMiddleClickOptions = {}
ExpansionGarrisonMiddleClickOptions[1] = 6 --WoD
ExpansionGarrisonMiddleClickOptions[2] = 7 --Legion
ExpansionGarrisonMiddleClickOptions[3] = 8 --Missions
ExpansionGarrisonMiddleClickOptions[4] = 9 --Covenant
ExpansionGarrisonMiddleClickOptions[5] = 10 --Dragon Isles
ExpansionGarrisonMiddleClickOptions[6] = 11 --Khaz Algar

local Summaries = {}
Summaries[1] = L["MiddleClickOption_Warlords"] --WoD
Summaries[2] = L["MiddleClickOption_Legion"] --Legion
Summaries[3] = L["MiddleClickOption_Missions"] --Missions
Summaries[4] = L["MiddleClickOption_Covenant"] --Covenant
Summaries[5] = L["MiddleClickOption_DragonIsles"] --Dragon Isles
Summaries[6] = L["MiddleClickOption_KhazAlgar"] --Khaz Algar

CurrentGarrisonID = 0

-- Instanciação da função principal do Addon
ChromieTimeTracker = ChromieTimeTracker or {}

function CTT_SetupFirstAccess(arg)
    if ChromieTimeTrackerDB.AlreadyUsed == nil or ChromieTimeTrackerDB.AlreadyUsed == false or arg == "resetAll" then
        --Set initial position for main window
        ChromieTimeTrackerDB.BasePoint = "CENTER"
        ChromieTimeTrackerDB.RelativePoint = "CENTER"
        ChromieTimeTrackerDB.OffsetX = 0
        ChromieTimeTrackerDB.OffsetY = 0

        --Set initial position for icon window
        ChromieTimeTrackerDB.BasePointIcon = "CENTER"
        ChromieTimeTrackerDB.RelativePointIcon = "CENTER"
        ChromieTimeTrackerDB.OffsetXIcon = 0
        ChromieTimeTrackerDB.OffsetYIcon = 0

        --Set initial value for all settings
        ChromieTimeTrackerDB.Mode = 2;
        ChromieTimeTrackerDB.HideWhenNotTimeTraveling = false;
        ChromieTimeTrackerDB.LockDragDrop = false;
        ChromieTimeTrackerDB.AlternateModeShowIconOnly = false;
        ChromieTimeTrackerDB.DefaultMiddleClickOption = "";
        ChromieTimeTrackerDB.LockMiddleClickOption = false;

        ChromieTimeTrackerDB.AlreadyUsed = true
    end
end

CTT_SetupFirstAccess()

-- Criação dos frames.
--Principal
local mainFrame = CreateFrame("Frame", "ChromieTimeTrackerMainFrame", UIParent, "TooltipBorderedFrameTemplate")
local iconFrame = CreateFrame("Frame", "ChromieTimeTrackerMainIconFrame", UIParent, "TooltipBorderedFrameTemplate")

function CTT_setupMainFrame()

mainFrame:ClearAllPoints()
mainFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

mainFrame:EnableMouse(true)
mainFrame:SetMovable(true)
mainFrame:RegisterForDrag("LeftButton")
mainFrame:SetScript("OnDragStart", function(self)
    if(not ChromieTimeTrackerDB.LockDragDrop)then
        mainFrame:StartMoving()
    end
    
end)
mainFrame:SetScript("OnMouseDown", function(self, btn)
    if btn == 'MiddleButton' then 
        CTT_MouseMiddleButtonClick()
    elseif btn == "RightButton" then
        PlaySound(808)
        ChromieTimeTracker:ToggleSettingsFrame()
    end
end)


mainFrame:SetScript("OnDragStop", function(self)
	mainFrame:StopMovingOrSizing()
    
    ChromieTimeTrackerDB.Point = {mainFrame:GetPoint()}
    
    ChromieTimeTrackerDB.BasePoint = ChromieTimeTrackerDB.Point[1]
    ChromieTimeTrackerDB.RelativePoint = ChromieTimeTrackerDB.Point[3]
    ChromieTimeTrackerDB.OffsetX = ChromieTimeTrackerDB.Point[4]
    ChromieTimeTrackerDB.OffsetY = ChromieTimeTrackerDB.Point[5]

end)

mainFrame:SetScript("OnShow", function()
    PlaySound(808)
    CTT_updateChromieTime()
end)

mainFrame:SetScript("OnHide", function()
        PlaySound(808)
end)

mainFrame.playerTimeline = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")

mainFrame.playerTimeline:SetPoint("CENTER", mainFrame, "CENTER", 0, 0)

end

CTT_setupMainFrame()

function CTT_getChromieTime()
    local expansionOptions = C_ChromieTime.GetChromieTimeExpansionOptions();
    local currentExpansionName = L["currentExpansionLabel"]

    canEnter = C_PlayerInfo.CanPlayerEnterChromieTime()

    if(canEnter) then
        for _, ChromieTimeItem in pairs(expansionOptions) do
            if(ChromieTimeItem.alreadyOn) then
                currentExpansionName = "|c" .. C[ChromieTimeItem.sortPriority] .. ChromieTimeItem.name .. "|r"
                CurrentGarrisonID = ChromieTimeItem.sortPriority
            end
        end
    end
    return currentExpansionName
end


function CTT_updateChromieTime()
    
    currentExpansionName = CTT_getChromieTime()

    if ChromieTimeTrackerDB.Mode == 1 then
        mainFrame:SetSize(180, 24)
        iconFrame:Hide()
    elseif ChromieTimeTrackerDB.Mode == 2 then
        mainFrame:SetSize(280, 35)
        iconFrame:Hide()
    elseif ChromieTimeTrackerDB.Mode == 3 then
        if ChromieTimeTrackerDB.AlternateModeShowIconOnly then
            iconFrame:SetSize(32,32)
            iconFrame:Show()
            mainFrame:Hide()
        else 
            mainFrame:SetSize(280, 35)
            iconFrame:Hide()
        end
    else
        mainFrame:SetSize(280, 35)
        iconFrame:Hide()
    end

    if ChromieTimeTrackerDB.Mode == 1 then
        mainFrame.playerTimeline:SetText(currentExpansionName)
    elseif ChromieTimeTrackerDB.Mode == 3 then
        if ChromieTimeTrackerDB.AlternateModeShowIconOnly then
            iconFrame.playerTimeline:SetText("")
            iconFrame.icon = iconFrame:CreateTexture()
            iconFrame.icon:SetAllPoints()
            --iconFrame.icon:SetTexture("Interface\\AddOns\\ChromieTimeTracker\\Chromie.png", false) --Interface\\Icons\\Ability_Ambush Interface\\Icons\\Inv_dragonwhelp3_bronze
            iconFrame.icon:SetTexture("Interface\\Icons\\Inv_dragonwhelp3_bronze", false)
            --Interface\\Garrison\\OrderHallLandingButtonDruid

        else 
            mainFrame.playerTimeline:SetText(Summaries[ChromieTimeTrackerDB.DefaultMiddleClickOption])
        end
    else
        mainFrame.playerTimeline:SetText(L["Timeline"] .. currentExpansionName ..".")
    end

    if ChromieTimeTrackerDB.HideWhenNotTimeTraveling and currentExpansionName == L["currentExpansionLabel"] and ChromieTimeTrackerDB.Mode ~= 3 then
        mainFrame:Hide()
    end

    mainFrame:ClearAllPoints()
    iconFrame:ClearAllPoints()

    mainFrame:SetPoint(ChromieTimeTrackerDB.BasePoint or "CENTER", UIParent, ChromieTimeTrackerDB.RelativePoint or "CENTER", ChromieTimeTrackerDB.OffsetX or 0, ChromieTimeTrackerDB.OffsetY or 0)    
    iconFrame:SetPoint(ChromieTimeTrackerDB.BasePointIcon or "CENTER", UIParent, ChromieTimeTrackerDB.RelativePointIcon or "CENTER", ChromieTimeTrackerDB.OffsetXIcon or 0, ChromieTimeTrackerDB.OffsetYIcon or 0)    
    
end

--Icon

function CTT_setupIconFrame()

iconFrame:ClearAllPoints()
iconFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

iconFrame:EnableMouse(true)
iconFrame:SetMovable(true)
iconFrame:RegisterForDrag("LeftButton")
iconFrame:SetScript("OnDragStart", function(self)
    if(not ChromieTimeTrackerDB.LockDragDrop)then
        iconFrame:StartMoving()

        GameTooltip:Hide()
    end
    
end)
iconFrame:SetScript("OnMouseDown", function(self, btn)
    if btn == 'MiddleButton' then 
        CTT_MouseMiddleButtonClick()
    elseif btn == "RightButton" then
        PlaySound(808)
        ChromieTimeTracker:ToggleSettingsFrame()
    end
end)

iconFrame:SetScript("OnDragStop", function(self)
	iconFrame:StopMovingOrSizing()
    
    GameTooltip:Show()

    ChromieTimeTrackerDB.PointIcon = {iconFrame:GetPoint()}
    
    ChromieTimeTrackerDB.BasePointIcon = ChromieTimeTrackerDB.PointIcon[1]
    ChromieTimeTrackerDB.RelativePointIcon = ChromieTimeTrackerDB.PointIcon[3]
    ChromieTimeTrackerDB.OffsetXIcon = ChromieTimeTrackerDB.PointIcon[4]
    ChromieTimeTrackerDB.OffsetYIcon = ChromieTimeTrackerDB.PointIcon[5]

end)

iconFrame:SetScript("OnEnter", function(self)

    local _ttpPoint = {iconFrame:GetPoint()}

    if(_ttpPoint[1] == "TOPLEFT") then
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    elseif(_ttpPoint[1] == "TOPRIGHT") then
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
    elseif(_ttpPoint[1] == "BOTTOMLEFT") then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    elseif(_ttpPoint[1] == "BOTTOMRIGHT") then
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        GameTooltip:SetOwner(self, "ANCHOR_LEFT") --ANCHOR_CURSOR
    end

        CTT_ShowToolTip(GameTooltip, "Alternate")
        GameTooltip:Show()
        iconFrame:SetSize(34,34)
end)

iconFrame:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
    iconFrame:SetSize(32,32)
end)

iconFrame:SetScript("OnShow", function()
        PlaySound(808)
end)

iconFrame:SetScript("OnHide", function()
        PlaySound(808)
end)

iconFrame.playerTimeline = iconFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
iconFrame.playerTimeline:SetPoint("CENTER", iconFrame, "CENTER", 0, 0)

end

CTT_setupIconFrame()

function ChromieTimeTracker:ToggleMainFrame()
    if not mainFrame:IsShown() then
        mainFrame:Show()
    else
        mainFrame:Hide()
    end
end

print(L["ChatAddonLoadedMessage"] .. CTT_getChromieTime() .. ".")
CTT_updateChromieTime()


-- Adição do ícone de minimapa.
local addon = LibStub("AceAddon-3.0"):NewAddon("ChromieTimeTracker")
ChromieTimeTrackerMinimapButton = LibStub("LibDBIcon-1.0", true)

local miniButton = LibStub("LibDataBroker-1.1"):NewDataObject("ChromieTimeTracker", {
	type = "data source",
	text = L["AddonName"],
	icon = "Interface\\AddOns\\ChromieTimeTracker\\Chromie.png",
	OnClick = function(self, btn)
        if btn == "LeftButton" then
            if mainFrame:IsShown() then
                mainFrame:Hide()
            else
                mainFrame:Show()
            end
        elseif btn == "RightButton" then
            PlaySound(808)
            ChromieTimeTracker:ToggleSettingsFrame()
        elseif btn == "MiddleButton" then

            CTT_MouseMiddleButtonClick()
            
        end
	end,

	OnTooltipShow = function(tooltip)
		if not tooltip or not tooltip.AddLine then
			return
		end

        CTT_ShowToolTip(tooltip,"MinimapIcon")

        CTT_updateChromieTime()
	end,
})

ChromieTimeTrackerMinimapButton:Show(L["AddonName"])

--Monitor de eventos
local eventListenerFrame = CreateFrame("Frame", "ChromieTimeTrackerEventListenerFrame", UIParent)

eventListenerFrame:RegisterEvent("PLAYER_LOGIN")
eventListenerFrame:RegisterEvent("QUEST_LOG_UPDATE")

eventListenerFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        CTT_updateChromieTime()
    end
    if event == "QUEST_LOG_UPDATE" then
        CTT_updateChromieTime()
    end
end)

function addon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("ChromieTimeTrackerMinimapPOS", {
		profile = {
			minimap = {
				hide = false,
			},
		},
	})

	ChromieTimeTrackerMinimapButton:Register(L["AddonName"], miniButton, self.db.profile.minimap)
end

--Funções Principais

function CTT_showMainFrame()
    mainFrame:Show()
end

function CTT_flashMessage(_message, _duration, _fontScale)
                        duration = _duration
                        elapsed = 0
                        totalRepeat = 0

                        PlaySound(847)

                        local msgFrame = CreateFrame("FRAME", nil, UIParent)
                        msgFrame:SetWidth(1)
                        msgFrame:SetHeight(1)
                        msgFrame:SetPoint("CENTER")
                        msgFrame:SetFrameStrata("TOOLTIP")
                        msgFrame.text = msgFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                        msgFrame.text:SetPoint("CENTER")
                        msgFrame.text:SetText(_message)
                        local font, size, style = msgFrame.text:GetFont()
                        msgFrame.text:SetFont(font, _fontScale*size, style)

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

function CTT_MouseMiddleButtonClick()

            if ChromieTimeTrackerDB.LockMiddleClickOption or currentExpansionName == L["currentExpansionLabel"] then
                local selected = ExpansionGarrisonID[ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]]
                if selected == 111 then
                    if C_Covenants.GetActiveCovenantID() ~= 0 and C_Covenants.GetActiveCovenantID() ~= nil then
                        ShowGarrisonLandingPage(selected)
                    else
                        requisito = L["UndiscoveredContentUnlockRequirement_Covenant"]
                        CTT_flashMessage(L["UndiscoveredContent"]  .. L["UndiscoveredContent_Covenant"] .. requisito, 5, 1.5)
                    end
                elseif selected == 2 or selected == 3 or selected == 9 then
                    if not not (C_Garrison.GetGarrisonInfo(selected or 0)) then
                        ShowGarrisonLandingPage(selected)
                    else
                        local funcionalidade = ""
                        if (selected == 2) then
                            funcionalidade = L["UndiscoveredContent_Warlords"]
                            requisito = L["UndiscoveredContentUnlockRequirement_Warlords"]
                            CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
                        elseif (selected == 3) then
                            funcionalidade = L["UndiscoveredContent_Legion"]
                            requisito = L["UndiscoveredContentUnlockRequirement_Legion"]
                            CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
                        elseif (selected == 9) then
                            funcionalidade = L["UndiscoveredContent_Missions"]
                            requisito = L["UndiscoveredContentUnlockRequirement_Missions"]
                            CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
                        else
                            funcionalidade = ""
                            CTT_flashMessage(L["ConfigurationMissing"], 5, 1.5)
                        end
                        
                    end
                else

                    if selected == "DF" then
                        local funcionalidade = ""
                        if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(9)) then
                            CTT_OpenExpansionLandingPage(selected);
                        else
                            funcionalidade = L["UndiscoveredContent_DragonIsles"]
                            requisito = L["UndiscoveredContentUnlockRequirement_DragonIsles"]
                            CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
                        end
                    elseif selected == "TWW" then
                        local funcionalidade = ""
                        if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(10)) then
                            CTT_OpenExpansionLandingPage(selected);
                        else
                            funcionalidade = L["UndiscoveredContent_KhazAlgar"]
                            requisito = L["UndiscoveredContentUnlockRequirement_KhazAlgar"]
                            CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
                        end
                    else
                        CTT_flashMessage(L["ConfigurationMissing"], 5, 1.5)
                    end
                end
            else
                if not (ExpansionGarrisonID[CurrentGarrisonID] == 0) then
                    local selected = ExpansionGarrisonID[CurrentGarrisonID]
                    if selected == 2 or selected == 3 or selected == 9 or selected == 111 then
                    ShowGarrisonLandingPage(ExpansionGarrisonID[CurrentGarrisonID])
                    elseif selected == "DF" or selected == "TWW" then
                        local funcionalidade = ""
                        if selected == "DF" then
                            if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(9)) then
                                CTT_OpenExpansionLandingPage(selected);
                            else
                                funcionalidade = L["UndiscoveredContent_DragonIsles"]
                                requisito = L["UndiscoveredContentUnlockRequirement_DragonIsles"]
                                CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
                            end
                        elseif selected == "TWW" then
                            if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(10)) then
                                CTT_OpenExpansionLandingPage(selected);
                            else
                                funcionalidade = L["UndiscoveredContent_KhazAlgar"]
                                requisito = L["UndiscoveredContentUnlockRequirement_KhazAlgar"]
                                CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
                            end
                        else
                            CTT_flashMessage(L["ConfigurationMissing"], 5, 1.5)
                        end
                    else
                        CTT_flashMessage(L["ConfigurationMissing"], 5, 1.5)
                    end
                end
            end
end

function CTT_ShowToolTip(tooltip, mode)
   local LClickAction = ""
   local MClickAction = ""
    if(mode == "Alternate") then
        LClickAction = L["LClickAction_Alternate"]
    else
        LClickAction = L["LClickAction"]
    end


    if ChromieTimeTrackerDB.LockMiddleClickOption or currentExpansionName == L["currentExpansionLabel"] then
        
        if ExpansionGarrisonID[ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]] == 2 then
            MClickAction = L["MClickAction_Warlords"]
        elseif ExpansionGarrisonID[ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]] == 3 then
            MClickAction = L["MClickAction_Legion"]
        elseif ExpansionGarrisonID[ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]] == 9 then
            MClickAction = L["MClickAction_Missions"]
        elseif ExpansionGarrisonID[ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]] == 111 then
            MClickAction = L["MClickAction_Covenant"]
        elseif ExpansionGarrisonID[ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]] == "DF" then
            MClickAction = L["MClickAction_DragonIsles"]
        elseif ExpansionGarrisonID[ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]] == "TWW" then
            MClickAction = L["MClickAction_KhazAlgar"]
        else
            MClickAction = L["MClickAction"]
        end

        tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. LClickAction .. "\n" .. MClickAction .. "\n" .. L["RClickAction"] .. "\n\n".. L["DevelopmentTeamCredit"] .."", nil, nil, nil, nil)
else
    if not (ExpansionGarrisonID[CurrentGarrisonID] == 0) then

        if ExpansionGarrisonID[CurrentGarrisonID] == 2 then
            MClickAction = L["MClickAction_Warlords"]
        elseif ExpansionGarrisonID[CurrentGarrisonID] == 3 then
            MClickAction = L["MClickAction_Legion"]
        elseif ExpansionGarrisonID[CurrentGarrisonID] == 9 then
            MClickAction = L["MClickAction_Missions"]
        elseif ExpansionGarrisonID[CurrentGarrisonID] == 111 then
            MClickAction = L["MClickAction_Covenant"]
        elseif ExpansionGarrisonID[CurrentGarrisonID] == "DF" then
            MClickAction = L["MClickAction_DragonIsles"]
        elseif ExpansionGarrisonID[CurrentGarrisonID] == "TWW" then
            MClickAction = L["MClickAction_KhazAlgar"]
        else
            MClickAction = L["MClickAction"]
        end

        tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. LClickAction .. "\n" .. MClickAction .. "\n" .. L["RClickAction"] .. "\n\n".. L["DevelopmentTeamCredit"] .."", nil, nil, nil, nil)
    else
        tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. LClickAction .. "\n" .. L["RClickAction"] .. "\n\n".. L["DevelopmentTeamCredit"] .."", nil, nil, nil, nil)
    end
end

end

function CTT_OpenExpansionLandingPage(_expansion)
 
    local overlay = CreateFromMixins(DragonflightLandingOverlayMixin)

    if(_expansion == "DF") then
        overlay = CreateFromMixins(DragonflightLandingOverlayMixin)
    elseif (_expansion == "TWW") then
        overlay = CreateFromMixins(WarWithinLandingOverlayMixin)
    end

    if ExpansionLandingPage.overlayFrame then
        ExpansionLandingPage.overlayFrame:Hide();
    end

    ExpansionLandingPage.overlayFrame = overlay.CreateOverlay(ExpansionLandingPage.Overlay);
    ExpansionLandingPage.overlayFrame:Show();

    ToggleExpansionLandingPage();

end

function CTT_setupSlashCommands()
    -- Criação dos slash comands.
    
    SLASH_ChromieTimeTracker1 = "/ChromieTimeTracker"
    SLASH_ChromieTimeTracker2 = "/ctt"
    SlashCmdList["ChromieTimeTracker"] = function(arg)
        if(arg == "config") then
            PlaySound(808)
            ChromieTimeTracker:ToggleSettingsFrame()
            
        elseif(arg == "DF" or arg == "TWW") then
            CTT_OpenExpansionLandingPage(arg)
        elseif(arg == "commands") then
            print(L["SlashCommands"])
        elseif(arg == "resetPosition") then
            mainFrame:ClearAllPoints()
            mainFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    
            ChromieTimeTrackerDB.Point = {mainFrame:GetPoint()}
        
            ChromieTimeTrackerDB.BasePoint = ChromieTimeTrackerDB.Point[1]
            ChromieTimeTrackerDB.RelativePoint = ChromieTimeTrackerDB.Point[3]
            ChromieTimeTrackerDB.OffsetX = ChromieTimeTrackerDB.Point[4]
            ChromieTimeTrackerDB.OffsetY = ChromieTimeTrackerDB.Point[5]
    
            iconFrame:ClearAllPoints()
            iconFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    
            ChromieTimeTrackerDB.PointIcon = {iconFrame:GetPoint()}
        
            ChromieTimeTrackerDB.BasePointIcon = ChromieTimeTrackerDB.PointIcon[1]
            ChromieTimeTrackerDB.RelativePointIcon = ChromieTimeTrackerDB.PointIcon[3]
            ChromieTimeTrackerDB.OffsetXIcon = ChromieTimeTrackerDB.PointIcon[4]
            ChromieTimeTrackerDB.OffsetYIcon = ChromieTimeTrackerDB.PointIcon[5]
    
            CTT_updateChromieTime();
    
            mainFrame:Show()

            print(L["RunCommandMessage_ResetPosition"])
    
        elseif(arg == "resetSettings") then
            ChromieTimeTrackerDB.Mode = 2;
            ChromieTimeTrackerDB.HideWhenNotTimeTraveling = false;
            ChromieTimeTrackerDB.LockDragDrop = false;
            ChromieTimeTrackerDB.AlternateModeShowIconOnly = false;
            ChromieTimeTrackerDB.DefaultMiddleClickOption = "";
            ChromieTimeTrackerDB.LockMiddleClickOption = false;
            CTT_updateChromieTime();

            print(L["RunCommandMessage_ResetSettings"])

        elseif(arg == "resetAll") then
            CTT_SetupFirstAccess("resetAll")
            CTT_updateChromieTime()

            print(L["RunCommandMessage_ResetAll"])
        else
            if mainFrame:IsShown() then
                mainFrame:Hide()
            else
                mainFrame:Show()
            end
        end
    end
    end
    
    CTT_setupSlashCommands()


