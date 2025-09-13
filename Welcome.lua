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

local AceGUI = LibStub("AceGUI-3.0")

-- Create a container frame
local welcomeFrame = AceGUI:Create("Frame")
welcomeFrame:SetCallback("OnClose",function(widget) ChromieTimeTrackerDB.Version_UID = C_CTT_VERSION_UID; ChromieTimeTrackerSharedDB.Version_UID = C_CTT_VERSION_UID end)
welcomeFrame:SetTitle(L["AddonName"] .. " - " .. L["Welcome"])
welcomeFrame:SetWidth(610)
welcomeFrame:SetHeight(330)
welcomeFrame:SetLayout("Flow")

local btnOpenSettings = AceGUI:Create("Button")
local btnResetSettings = AceGUI:Create("Button")
local btnKeepSettings = AceGUI:Create("Button")
local btnSkipSettings = AceGUI:Create("Button")

--"Gambiarra da Braba - Início" - 01/03/2025
--This next lines were the only way found to resize texts on ACE3 widgets since it's a poorly documented lib that get almost no feature update in a long time.
--If someone knows a diferent way to do this or by the time you read this there are any changes in ACE3 label widget concerning font sizing ou allowing to get
--current font style, feel free to try and push a commit on GitHub project page.
local auxFontScaleFrame = CreateFrame("Frame", "auxFontScaleFrame", UIParent, "BasicFrameTemplateWithInset")
auxFontScaleFrame.dummyTextLabel = auxFontScaleFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
local font, size, style = auxFontScaleFrame.dummyTextLabel:GetFont() --Essas 3 variáveis são utilizadas para ajustar a escala de textos dentro dos widgets do ACE3.
auxFontScaleFrame:Hide()

function CTT_setACE3WidgetFontSize(_widget, _size)
    _widget:SetFont(font, _size, style)
end
--"Gambiarra da Braba - Fim"

StaticPopupDialogs["POPUP_DIALOG_CONFIRM_RESET_SETTINGS"] = {
    text = L["Dialog_ResetSettings_Message"],
    button1 = L["Dialog_Yes"],
    button2 = L["Dialog_No"],
    OnAccept = function()
        --Set initial values for all settings

        --General
        ChromieTimeTrackerDB.Mode = 2;
        ChromieTimeTrackerDB.MainWindowVisibility = 1;
        ChromieTimeTrackerDB.WelcomeMessageVisibility = 1;
        ChromieTimeTrackerDB.ToastVisibility = 1;
        ChromieTimeTrackerDB.LockDragDrop = false;
        ChromieTimeTrackerDB.DefaultMiddleClickOption = "";
        ChromieTimeTrackerDB.LockMiddleClickOption = false;
        ChromieTimeTrackerDB.HideMinimapIcon = false;
        --ChromieTimeTrackerSharedDB.WelcomeWindowShowOnlyOnce = false;
        ChromieTimeTrackerDB.HideWelcomeWindowInFutureVersionChanges = false;
        ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips = false;

        --Set initial values for Context Menu settings
        ChromieTimeTrackerDB.ContextMenuShowGarrison = true;
        ChromieTimeTrackerDB.ContextMenuShowClassHall = true;
        ChromieTimeTrackerDB.ContextMenuShowWarEffort = true;
        ChromieTimeTrackerDB.ContextMenuShowCovenant = true;
        ChromieTimeTrackerDB.ContextMenuShowDragonIsles = true;
        ChromieTimeTrackerDB.ContextMenuShowKhazAlgar = true;
        ChromieTimeTrackerDB.ContextMenuShowUnlockedOnly = false;

        ChromieTimeTrackerDB.DefaultTrackerAddon = 1;
        ChromieTimeTrackerDB.ContextMenuShowPinChromie = true;
        ChromieTimeTrackerDB.ContextMenuShowPinExperienceLock = true;

        --Set initial values for Avanced Mode settings
        ChromieTimeTrackerDB.AdvButtonsPosition = 2;
        ChromieTimeTrackerDB.AdvButtonsAlignment = 2;
        ChromieTimeTrackerDB.AdvShowGarrison = true;
        ChromieTimeTrackerDB.AdvShowClassHall = true;
        ChromieTimeTrackerDB.AdvShowWarEffort = true;
        ChromieTimeTrackerDB.AdvShowCovenant = true;
        ChromieTimeTrackerDB.AdvShowDragonIsles = true;
        ChromieTimeTrackerDB.AdvShowKhazAlgar = true;
        ChromieTimeTrackerDB.AdvShowUnlockedOnly = false;
        ChromieTimeTrackerDB.AdvHideTimelineBox = false;

        --Alternate Mode
        ChromieTimeTrackerDB.AlternateModeShowIconOnly = false;

        --Set initial values for Enhancement settings
        ChromieTimeTrackerDB.ShowCurrencyOnReportWindow = true;
        ChromieTimeTrackerDB.ShowCurrencyOnTooltips = true;
        ChromieTimeTrackerDB.ShowReportTabsOnReportWindow = true;
        ChromieTimeTrackerDB.ShowMissionExpirationTimeOnReportWindow = true;
        ChromieTimeTrackerDB.ShowEmissaryMissionsOnReportWindow = true;

        --Experience Alerts
        ChromieTimeTrackerDB.ShowExperienceAlertPopup = false;
        ChromieTimeTrackerDB.ExperienceAlertLevelPopup = 65;
        ChromieTimeTrackerDB.ShowExperienceAlertPopupOnLogin = false;
        ChromieTimeTrackerDB.ShowExperienceAlertPopupOnLevelUp = false;

        ChromieTimeTrackerDB.ShowExperienceAlertFlash = false;
        ChromieTimeTrackerDB.ExperienceAlertLevelFlash = 65;
        ChromieTimeTrackerDB.ShowExperienceAlertFlashOnLogin = false;
        ChromieTimeTrackerDB.ShowExperienceAlertFlashOnLevelUp = false;

        ChromieTimeTrackerDB.ShowExperienceAlertChat = false;
        ChromieTimeTrackerDB.ExperienceAlertLevelChat = 65;
        ChromieTimeTrackerDB.ShowExperienceAlertChatOnLogin = false;
        ChromieTimeTrackerDB.ShowExperienceAlertChatOnLevelUp = false;

        ChromieTimeTrackerDB.AlreadyUsed = true

        welcomeFrame:Hide()

        CTT_updateChromieTime()
        CTT_showMainFrame()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
  }

function CTT_LoadWelcome()
    local scrollContainerWelcome = AceGUI:Create("SimpleGroup")
    scrollContainerWelcome:SetFullWidth(true)
    scrollContainerWelcome:SetFullHeight(true)
    scrollContainerWelcome:SetLayout("Fill")
    
    welcomeFrame:AddChild(scrollContainerWelcome)
    
    local scrollFrameWelcome = AceGUI:Create("ScrollFrame")
    scrollFrameWelcome:SetLayout("Flow")
    scrollContainerWelcome:AddChild(scrollFrameWelcome)

    local LabelWelcome_Title = AceGUI:Create("Label")
    LabelWelcome_Title:SetText("|cFFFFC90E" .. L["Welcome_Title"] .. " " .. L["AddonName"] .. "!|r")
    CTT_setACE3WidgetFontSize(LabelWelcome_Title, 20)
    LabelWelcome_Title:SetWidth(575)
    scrollFrameWelcome:AddChild(LabelWelcome_Title)

    local LabelWelcome = AceGUI:Create("Label")
    C_Timer.After(2, function()
    
    if(ChromieTimeTrackerDB.Version_UID ~= nil) then

        --Atualização de Versão
        if(ChromieTimeTrackerDB.Version_UID < C_CTT_VERSION_UID) then
            LabelWelcome:SetText("|cFFFFC90E" .. L["About_Version"] .. "|r\n\n" .. L["Welcome_Upgrade_Line1"] .. "\n\n" .. L["Welcome_Upgrade_Line2"] .. "\n\n" .. L["Welcome_Upgrade_Line3"] .. "\n\n")
            welcomeFrame:SetHeight(370)
        end

        --Reeversão de Versão
        if(ChromieTimeTrackerDB.Version_UID > C_CTT_VERSION_UID) then
            LabelWelcome:SetText("|cFFFFC90E" .. L["About_Version"] .. "|r" .. "\n\n|cFFF25252" .. L["Welcome_Downgrade_Line1"] .. "|r\n\n" .. L["Welcome_Downgrade_Line2"] .. "\n\n" .. L["Welcome_Downgrade_Line3"] .. "\n\n")
            welcomeFrame:SetHeight(345)
        end

        --Nova Instalação
        if(not ChromieTimeTrackerDB.AlreadyUsed) then
            LabelWelcome:SetText("|cFFFFC90E" .. L["About_Version"] .. "|r\n\n" .. L["Welcome_New_Line1"] .. "\n\n" .. L["Welcome_New_Line2"] .. "\n\n" .. L["Welcome_New_Line3"] .. "\n\n")
            welcomeFrame:SetHeight(360)
        end
    else
        if(not ChromieTimeTrackerDB.AlreadyUsed) then
            LabelWelcome:SetText("|cFFFFC90E" .. L["About_Version"] .. "|r\n\n" .. L["Welcome_New_Line1"] .. "\n\n" .. L["Welcome_New_Line2"] .. "\n\n" .. L["Welcome_New_Line3"] .. "\n\n")
            welcomeFrame:SetHeight(360)
        else
            LabelWelcome:SetText("|cFFFFC90E" .. L["About_Version"] .. "|r\n\n" .. L["Welcome_Upgrade_Line1"] .. "\n\n" .. L["Welcome_Upgrade_Line2"] .. "\n\n" .. L["Welcome_Upgrade_Line3"] .. "\n\n")
            welcomeFrame:SetHeight(370)
        end
    end

    CTT_setACE3WidgetFontSize(LabelWelcome, 13)
    LabelWelcome:SetWidth(575)
    scrollFrameWelcome:AddChild(LabelWelcome)
    
    local headingWelcome = AceGUI:Create("Heading")
    headingWelcome:SetRelativeWidth(1)
    scrollFrameWelcome:AddChild(headingWelcome)

    local chkHideWelcomeWindowInFutureVersionChanges = AceGUI:Create("CheckBox")
    chkHideWelcomeWindowInFutureVersionChanges:SetLabel(L["chkHideWelcomeWindowInFutureVersionChanges"])
    chkHideWelcomeWindowInFutureVersionChanges:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.HideWelcomeWindowInFutureVersionChanges = chkHideWelcomeWindowInFutureVersionChanges:GetValue()
    end)
    chkHideWelcomeWindowInFutureVersionChanges:SetWidth(575)
    scrollFrameWelcome:AddChild(chkHideWelcomeWindowInFutureVersionChanges)

    local chkWelcomeWindowShowOnlyOnce = AceGUI:Create("CheckBox")
    chkWelcomeWindowShowOnlyOnce:SetLabel(L["chkWelcomeWindowShowOnlyOnce"])
    chkWelcomeWindowShowOnlyOnce:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerSharedDB.WelcomeWindowShowOnlyOnce = chkWelcomeWindowShowOnlyOnce:GetValue()
    end)
    chkWelcomeWindowShowOnlyOnce:SetWidth(575)
    scrollFrameWelcome:AddChild(chkWelcomeWindowShowOnlyOnce)
    
    local headingWelcome2 = AceGUI:Create("Heading")
    headingWelcome2:SetRelativeWidth(1)
    scrollFrameWelcome:AddChild(headingWelcome2)

    btnOpenSettings:SetText(L["buttonOpenSettings"])
    btnOpenSettings:SetWidth(180)
    btnOpenSettings:SetCallback("OnClick", function() 
        ChromieTimeTracker:ToggleSettingsFrame();
        welcomeFrame:Hide()
        ChromieTimeTrackerDB.Version_UID = C_CTT_VERSION_UID
        ChromieTimeTrackerSharedDB.Version_UID = C_CTT_VERSION_UID
    end)
    
    btnResetSettings:SetText(L["buttonResetSettings"])
    btnResetSettings:SetWidth(200)
    btnResetSettings:SetCallback("OnClick", function() 
        StaticPopup_Show ("POPUP_DIALOG_CONFIRM_RESET_SETTINGS")
        ChromieTimeTrackerDB.Version_UID = C_CTT_VERSION_UID
        ChromieTimeTrackerSharedDB.Version_UID = C_CTT_VERSION_UID
    end)
    
    btnKeepSettings:SetText(L["buttonKeepSettings"])
    btnKeepSettings:SetWidth(180)
    btnKeepSettings:SetCallback("OnClick", function() 
        welcomeFrame:Hide()
        ChromieTimeTrackerDB.Version_UID = C_CTT_VERSION_UID
        ChromieTimeTrackerSharedDB.Version_UID = C_CTT_VERSION_UID
    end)
    
    btnSkipSettings:SetText(L["buttonSkipSettings"])
    btnSkipSettings:SetWidth(180)
    btnSkipSettings:SetCallback("OnClick", function() 
        welcomeFrame:Hide()
        ChromieTimeTrackerDB.Version_UID = C_CTT_VERSION_UID
        ChromieTimeTrackerSharedDB.Version_UID = C_CTT_VERSION_UID
    end)

    if(ChromieTimeTrackerDB.AlreadyUsed) then
        scrollFrameWelcome:AddChild(btnOpenSettings)
        scrollFrameWelcome:AddChild(btnResetSettings)    
        scrollFrameWelcome:AddChild(btnKeepSettings)
    else
        scrollFrameWelcome:AddChild(btnOpenSettings)
        scrollFrameWelcome:AddChild(btnSkipSettings)
    end

    end)
end

welcomeFrame:Hide()

CTT_LoadWelcome()

function ChromieTimeTracker:ToggleWelcomeFrame()
    if not welcomeFrame:IsShown() then
        welcomeFrame:Show()
    else
        welcomeFrame:Hide()
    end
end

C_Timer.After(2, function()
    if ((ChromieTimeTrackerDB.Version_UID ~= C_CTT_VERSION_UID or ChromieTimeTrackerDB.Version_UID == nil) and not ChromieTimeTrackerDB.HideWelcomeWindowInFutureVersionChanges) then
        if(ChromieTimeTrackerSharedDB.WelcomeWindowShowOnlyOnce and ChromieTimeTrackerSharedDB.Version_UID == C_CTT_VERSION_UID) then
            ChromieTimeTrackerDB.Version_UID = C_CTT_VERSION_UID
            ChromieTimeTrackerSharedDB.Version_UID = C_CTT_VERSION_UID
        else
            ChromieTimeTracker:ToggleWelcomeFrame()
        end
    end
end)