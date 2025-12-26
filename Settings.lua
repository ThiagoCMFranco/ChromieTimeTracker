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

local C_LanguageContributors = {}

local modes = {L["CompactMode"], L["StandardMode"], L["AlternateMode"], L["AdvancedMode"]}
local visibilityOptions = {L["Visibility_Always_Show"], L["Visibility_Hide_Current_Timeline"], L["Visibility_Never_Show"]}
local buttonAlignments = {L["alignLeft"],L["alignCenter"],L["alignRight"]}
local buttonPositions = {L["positionAbove"], L["positionBelow"]}
local MiddleClickOptions = {L["MiddleClickOption_Warlords"], L["MiddleClickOption_Legion"],L["MiddleClickOption_Missions"],string.format(L["MiddleClickOption_Covenant"], "-"),L["MiddleClickOption_DragonIsles"],L["MiddleClickOption_KhazAlgar"]}

local AceGUI = LibStub("AceGUI-3.0")

-- Create a container frame
local settingsFrame = AceGUI:Create("Frame")
settingsFrame:SetCallback("OnClose",function(widget)  end)
settingsFrame:SetTitle(L["AddonName"] .. " - " .. L["Settings"])
settingsFrame:SetStatusText(L["DevelopmentTeamCredit"])
settingsFrame:SetWidth(880)
settingsFrame:SetHeight(540)
settingsFrame:SetLayout("Flow")

-- Add the frame as a global variable under the name `CTTSettingsFrameName`
_G["CTTSettingsFrameName"] = settingsFrame.frame
-- Register the global variable `CTTSettingsFrameName` as a "special frame"
-- so that it is closed when the escape key is pressed.
tinsert(UISpecialFrames, "CTTSettingsFrameName")

local treeW = AceGUI:Create("TreeGroup")

function CTT_LoadCredits()

    treeW:ReleaseChildren()

    scrollContainerCredits = AceGUI:Create("SimpleGroup")
    scrollContainerCredits:SetFullWidth(true)
    scrollContainerCredits:SetFullHeight(true)
    scrollContainerCredits:SetLayout("Fill")
    
    treeW:AddChild(scrollContainerCredits)
    
    scrollFrameCredits = AceGUI:Create("ScrollFrame")
    scrollFrameCredits:SetLayout("Flow")
    scrollContainerCredits:AddChild(scrollFrameCredits)

    local LabelCredits = AceGUI:Create("Label")
    LabelCredits:SetText(L["lblCreditColabList"])
    SetACE3WidgetFontSize(LabelCredits, 13)
    LabelCredits:SetWidth(580)
    scrollFrameCredits:AddChild(LabelCredits)

end

function CTT_LoadAbout()
    treeW:ReleaseChildren()

    scrollContainerAbout = AceGUI:Create("SimpleGroup")
    scrollContainerAbout:SetFullWidth(true)
    scrollContainerAbout:SetFullHeight(true)
    scrollContainerAbout:SetLayout("Fill")
    
    treeW:AddChild(scrollContainerAbout)
    
    scrollFrameAbout = AceGUI:Create("ScrollFrame")
    scrollFrameAbout:SetLayout("Flow")
    scrollContainerAbout:AddChild(scrollFrameAbout)

    local LabelAbout_Title = AceGUI:Create("Label")
    LabelAbout_Title:SetText("|cFFFFC90E" .. L["AddonName"] .. "|r")
    SetACE3WidgetFontSize(LabelAbout_Title, 20)
    LabelAbout_Title:SetWidth(640)
    scrollFrameAbout:AddChild(LabelAbout_Title)

    local LabelAbout = AceGUI:Create("Label")
    LabelAbout:SetText("|cFFFFC90E" .. L["About_Version"] .. "|r\n\n" .. L["About_Title"] .. "\n\n" .. L["About_Line1"] .. "\n\n" .. L["About_Line2"] .. "\n\n" .. L["About_Line3"] .. "\n\n")
    SetACE3WidgetFontSize(LabelAbout, 13)
    LabelAbout:SetWidth(620)
    scrollFrameAbout:AddChild(LabelAbout)
    
    local headingAbout1 = AceGUI:Create("Heading")
    headingAbout1:SetRelativeWidth(1)
    scrollFrameAbout:AddChild(headingAbout1)

    local LabelAboutLocalizationDisclaimer = AceGUI:Create("Label")
    LabelAboutLocalizationDisclaimer:SetText(L["About_Line4"])
    SetACE3WidgetFontSize(LabelAboutLocalizationDisclaimer, 13)
    LabelAboutLocalizationDisclaimer:SetWidth(620)
    scrollFrameAbout:AddChild(LabelAboutLocalizationDisclaimer)
end

function CTT_LoadAlternateModeSettings()
    treeW:ReleaseChildren()

    scrollContainerAlternateMode = AceGUI:Create("SimpleGroup")
    scrollContainerAlternateMode:SetFullWidth(true)
    scrollContainerAlternateMode:SetFullHeight(true)
    scrollContainerAlternateMode:SetLayout("Fill")
    
    treeW:AddChild(scrollContainerAlternateMode)
    
    scrollFrameAlternateMode = AceGUI:Create("ScrollFrame")
    scrollFrameAlternateMode:SetLayout("Flow")
    scrollContainerAlternateMode:AddChild(scrollFrameAlternateMode)

    local chkAlternateModeShowIconOnly = AceGUI:Create("CheckBox")
    chkAlternateModeShowIconOnly:SetLabel(L["AlternateMode_ShowIconOnly"])
    chkAlternateModeShowIconOnly:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.AlternateModeShowIconOnly = chkAlternateModeShowIconOnly:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
    end)
    chkAlternateModeShowIconOnly:SetWidth(700)
    scrollFrameAlternateMode:AddChild(chkAlternateModeShowIconOnly)

    chkAlternateModeShowIconOnly:SetValue(ChromieTimeTrackerDB.AlternateModeShowIconOnly)
end

function CTT_LoadExperienceSettings()
    treeW:ReleaseChildren()

    scrollContainerExperience = AceGUI:Create("SimpleGroup")
    scrollContainerExperience:SetFullWidth(true)
    scrollContainerExperience:SetFullHeight(true)
    scrollContainerExperience:SetLayout("Fill")
    
    treeW:AddChild(scrollContainerExperience)
    
    scrollFrameExperience = AceGUI:Create("ScrollFrame")
    scrollFrameExperience:SetLayout("Flow")
    scrollContainerExperience:AddChild(scrollFrameExperience)

    local description = ""
    local _EliminatedExperienceAura = C_UnitAuras.GetPlayerAuraBySpellID(306715)

    if(_EliminatedExperienceAura ~= nil) then
        description = L["Experience_AlertDescription"] .. "\n\n|cffff0000" .. L["Experience_GainDisabled"] .. "|r"
    else
        description = L["Experience_AlertDescription"]
    end

    local lblExperienceAlertDescription = AceGUI:Create("Label")
    
    lblExperienceAlertDescription:SetText(description)
    SetACE3WidgetFontSize(lblExperienceAlertDescription, 12)
    lblExperienceAlertDescription:SetWidth(580)
    scrollFrameExperience:AddChild(lblExperienceAlertDescription)

    local headingExp = AceGUI:Create("Heading")
    headingExp:SetRelativeWidth(1)
    scrollFrameExperience:AddChild(headingExp)

    local lblExperienceShowPopup = AceGUI:Create("Label")
    lblExperienceShowPopup:SetText("|cFFD6AE12" .. L["Experience_PopupLabel"] .. "|r")
    SetACE3WidgetFontSize(lblExperienceShowPopup, 12)
    lblExperienceShowPopup:SetWidth(580)
    scrollFrameExperience:AddChild(lblExperienceShowPopup)

    local chkShowExperienceAlertPopup = AceGUI:Create("CheckBox")
    chkShowExperienceAlertPopup:SetLabel(L["Experience_ShowAlert"])
    chkShowExperienceAlertPopup:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowExperienceAlertPopup = chkShowExperienceAlertPopup:GetValue()
    end)
    chkShowExperienceAlertPopup:SetWidth(700)
    scrollFrameExperience:AddChild(chkShowExperienceAlertPopup)

    local txtExperienceAlertLevelPopup = AceGUI:Create("Slider")
    txtExperienceAlertLevelPopup:SetLabel(L["Experience_AlertMinLevelLabel"])
    txtExperienceAlertLevelPopup:SetSliderValues(1,69,1)
    txtExperienceAlertLevelPopup:SetCallback("OnMouseUp", function(widget, event, text) 
        ChromieTimeTrackerDB.ExperienceAlertLevelPopup = tonumber(txtExperienceAlertLevelPopup:GetValue())
        if ChromieTimeTrackerDB.ExperienceAlertLevelPopup == nil then
            ChromieTimeTrackerDB.ExperienceAlertLevelPopup = 65
            txtExperienceAlertLevelPopup:SetValue(65)
        end
    end)
    scrollFrameExperience:AddChild(txtExperienceAlertLevelPopup)

    local LabelExperienceLockAlertHelp = AceGUI:Create("InteractiveLabel")

    scrollFrameExperience:AddChild(LabelExperienceLockAlertHelp)
    local tooltipText = L["ExperienceLockAlertHelp"]
    addHelpIcon(LabelExperienceLockAlertHelp, tooltipText)

    local chkShowExperienceAlertPopupOnLogin = AceGUI:Create("CheckBox")
    chkShowExperienceAlertPopupOnLogin:SetLabel(L["Experience_ShowAlertOnLogin"])
    chkShowExperienceAlertPopupOnLogin:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowExperienceAlertPopupOnLogin = chkShowExperienceAlertPopupOnLogin:GetValue()
    end)
    chkShowExperienceAlertPopupOnLogin:SetWidth(700)
    scrollFrameExperience:AddChild(chkShowExperienceAlertPopupOnLogin)

    local chkShowExperienceAlertPopupOnLevelUp = AceGUI:Create("CheckBox")
    chkShowExperienceAlertPopupOnLevelUp:SetLabel(L["Experience_ShowAlertOnLevelUp"])
    chkShowExperienceAlertPopupOnLevelUp:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowExperienceAlertPopupOnLevelUp = chkShowExperienceAlertPopupOnLevelUp:GetValue()
    end)
    chkShowExperienceAlertPopupOnLevelUp:SetWidth(700)
    scrollFrameExperience:AddChild(chkShowExperienceAlertPopupOnLevelUp)

    local headingExp1 = AceGUI:Create("Heading")
    headingExp1:SetRelativeWidth(1)
    scrollFrameExperience:AddChild(headingExp1)

    local lblExperienceShowFlash = AceGUI:Create("Label")
    lblExperienceShowFlash:SetText("|cFFD6AE12" .. L["Experience_FlashLabel"] .. "|r")
    SetACE3WidgetFontSize(lblExperienceShowFlash, 12)
    lblExperienceShowFlash:SetWidth(580)
    scrollFrameExperience:AddChild(lblExperienceShowFlash)

    local chkShowExperienceAlertFlash = AceGUI:Create("CheckBox")
    chkShowExperienceAlertFlash:SetLabel(L["Experience_ShowAlert"])
    chkShowExperienceAlertFlash:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowExperienceAlertFlash = chkShowExperienceAlertFlash:GetValue()
    end)
    chkShowExperienceAlertFlash:SetWidth(700)
    scrollFrameExperience:AddChild(chkShowExperienceAlertFlash)

    local txtExperienceAlertLevelFlash = AceGUI:Create("Slider")
    txtExperienceAlertLevelFlash:SetLabel(L["Experience_AlertMinLevelLabel"])
    txtExperienceAlertLevelFlash:SetSliderValues(1,69,1)
    txtExperienceAlertLevelFlash:SetCallback("OnMouseUp", function(widget, event, text) 
        ChromieTimeTrackerDB.ExperienceAlertLevelFlash = tonumber(txtExperienceAlertLevelFlash:GetValue())
        if ChromieTimeTrackerDB.ExperienceAlertLevelFlash == nil then
            ChromieTimeTrackerDB.ExperienceAlertLevelFlash = 65
            txtExperienceAlertLevelFlash:SetValue(65)
        end
    end)
    scrollFrameExperience:AddChild(txtExperienceAlertLevelFlash)

    local LabelExperienceLockAlertFlashHelp = AceGUI:Create("InteractiveLabel")

    scrollFrameExperience:AddChild(LabelExperienceLockAlertFlashHelp)
    local tooltipText = L["ExperienceLockAlertHelp"]
    addHelpIcon(LabelExperienceLockAlertFlashHelp, tooltipText)

    local chkShowExperienceAlertFlashOnLogin = AceGUI:Create("CheckBox")
    chkShowExperienceAlertFlashOnLogin:SetLabel(L["Experience_ShowAlertOnLogin"])
    chkShowExperienceAlertFlashOnLogin:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowExperienceAlertFlashOnLogin = chkShowExperienceAlertFlashOnLogin:GetValue()
    end)
    chkShowExperienceAlertFlashOnLogin:SetWidth(700)
    scrollFrameExperience:AddChild(chkShowExperienceAlertFlashOnLogin)


    local chkShowExperienceAlertFlashOnLevelUp = AceGUI:Create("CheckBox")
    chkShowExperienceAlertFlashOnLevelUp:SetLabel(L["Experience_ShowAlertOnLevelUp"])
    chkShowExperienceAlertFlashOnLevelUp:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowExperienceAlertFlashOnLevelUp = chkShowExperienceAlertFlashOnLevelUp:GetValue()
    end)
    chkShowExperienceAlertFlashOnLevelUp:SetWidth(700)
    scrollFrameExperience:AddChild(chkShowExperienceAlertFlashOnLevelUp)

    chkShowExperienceAlertPopup:SetValue(ChromieTimeTrackerDB.ShowExperienceAlertPopup)
    if ChromieTimeTrackerDB.ExperienceAlertLevelPopup ~= nil then
        txtExperienceAlertLevelPopup:SetValue(ChromieTimeTrackerDB.ExperienceAlertLevelPopup)
    end
    chkShowExperienceAlertPopupOnLogin:SetValue(ChromieTimeTrackerDB.ShowExperienceAlertPopupOnLogin)
    chkShowExperienceAlertPopupOnLevelUp:SetValue(ChromieTimeTrackerDB.ShowExperienceAlertPopupOnLevelUp)

    chkShowExperienceAlertFlash:SetValue(ChromieTimeTrackerDB.ShowExperienceAlertFlash)
    if ChromieTimeTrackerDB.ExperienceAlertLevelFlash ~= nil then
        txtExperienceAlertLevelFlash:SetValue(ChromieTimeTrackerDB.ExperienceAlertLevelFlash)
    end
    chkShowExperienceAlertFlashOnLogin:SetValue(ChromieTimeTrackerDB.ShowExperienceAlertFlashOnLogin)
    chkShowExperienceAlertFlashOnLevelUp:SetValue(ChromieTimeTrackerDB.ShowExperienceAlertFlashOnLevelUp)

    local headingExp2 = AceGUI:Create("Heading")
    headingExp2:SetRelativeWidth(1)
    scrollFrameExperience:AddChild(headingExp2)

    local lblExperienceShowChat = AceGUI:Create("Label")
    lblExperienceShowChat:SetText("|cFFD6AE12" .. L["Experience_ChatLabel"] .. "|r")
    SetACE3WidgetFontSize(lblExperienceShowChat, 12)
    lblExperienceShowChat:SetWidth(580)
    scrollFrameExperience:AddChild(lblExperienceShowChat)

    local chkShowExperienceAlertChat = AceGUI:Create("CheckBox")
    chkShowExperienceAlertChat:SetLabel(L["Experience_ShowAlert"])
    chkShowExperienceAlertChat:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowExperienceAlertChat = chkShowExperienceAlertChat:GetValue()
    end)
    chkShowExperienceAlertChat:SetWidth(700)
    scrollFrameExperience:AddChild(chkShowExperienceAlertChat)

    local txtExperienceAlertLevelChat = AceGUI:Create("Slider")
    txtExperienceAlertLevelChat:SetLabel(L["Experience_AlertMinLevelLabel"])
    txtExperienceAlertLevelChat:SetSliderValues(1,69,1)
    txtExperienceAlertLevelChat:SetCallback("OnMouseUp", function(widget, event, text) 
        ChromieTimeTrackerDB.ExperienceAlertLevelChat = tonumber(txtExperienceAlertLevelChat:GetValue())
        if ChromieTimeTrackerDB.ExperienceAlertLevelChat == nil then
            ChromieTimeTrackerDB.ExperienceAlertLevelChat = 65
            txtExperienceAlertLevelChat:SetValue(65)
        end
    end)
    scrollFrameExperience:AddChild(txtExperienceAlertLevelChat)

    local LabelExperienceLockAlertChatHelp = AceGUI:Create("InteractiveLabel")

    scrollFrameExperience:AddChild(LabelExperienceLockAlertChatHelp)
    local tooltipText = L["ExperienceLockAlertHelp"]
    addHelpIcon(LabelExperienceLockAlertChatHelp, tooltipText)

    local chkShowExperienceAlertChatOnLogin = AceGUI:Create("CheckBox")
    chkShowExperienceAlertChatOnLogin:SetLabel(L["Experience_ShowAlertOnLogin"])
    chkShowExperienceAlertChatOnLogin:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowExperienceAlertChatOnLogin = chkShowExperienceAlertChatOnLogin:GetValue()
    end)
    chkShowExperienceAlertChatOnLogin:SetWidth(700)
    scrollFrameExperience:AddChild(chkShowExperienceAlertChatOnLogin)


    local chkShowExperienceAlertChatOnLevelUp = AceGUI:Create("CheckBox")
    chkShowExperienceAlertChatOnLevelUp:SetLabel(L["Experience_ShowAlertOnLevelUp"])
    chkShowExperienceAlertChatOnLevelUp:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowExperienceAlertChatOnLevelUp = chkShowExperienceAlertChatOnLevelUp:GetValue()
    end)
    chkShowExperienceAlertChatOnLevelUp:SetWidth(700)
    scrollFrameExperience:AddChild(chkShowExperienceAlertChatOnLevelUp)

    chkShowExperienceAlertPopup:SetValue(ChromieTimeTrackerDB.ShowExperienceAlertPopup)
    if ChromieTimeTrackerDB.ExperienceAlertLevelPopup ~= nil then
        txtExperienceAlertLevelPopup:SetValue(ChromieTimeTrackerDB.ExperienceAlertLevelPopup)
    end
    chkShowExperienceAlertPopupOnLogin:SetValue(ChromieTimeTrackerDB.ShowExperienceAlertPopupOnLogin)
    chkShowExperienceAlertPopupOnLevelUp:SetValue(ChromieTimeTrackerDB.ShowExperienceAlertPopupOnLevelUp)

    chkShowExperienceAlertChat:SetValue(ChromieTimeTrackerDB.ShowExperienceAlertChat)
    if ChromieTimeTrackerDB.ExperienceAlertLevelChat ~= nil then
        txtExperienceAlertLevelChat:SetValue(ChromieTimeTrackerDB.ExperienceAlertLevelChat)
    end
    chkShowExperienceAlertChatOnLogin:SetValue(ChromieTimeTrackerDB.ShowExperienceAlertChatOnLogin)
    chkShowExperienceAlertChatOnLevelUp:SetValue(ChromieTimeTrackerDB.ShowExperienceAlertChatOnLevelUp)
    
end

function CTT_LoadRemixSettings()
treeW:ReleaseChildren()

    scrollContainerRemixSettings = AceGUI:Create("SimpleGroup")
    scrollContainerRemixSettings:SetFullWidth(true)
    scrollContainerRemixSettings:SetFullHeight(true)
    scrollContainerRemixSettings:SetLayout("Fill")
    
    treeW:AddChild(scrollContainerRemixSettings)
    
    scrollFrameRemixSettings = AceGUI:Create("ScrollFrame")
    scrollFrameRemixSettings:SetLayout("Flow")
    scrollContainerRemixSettings:AddChild(scrollFrameRemixSettings)

    local chkShowHeroicWorldTier = AceGUI:Create("CheckBox")
    chkShowHeroicWorldTier:SetLabel(L["chkShowHeroicWorldTier"])
    chkShowHeroicWorldTier:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowHeroicWorldTier = chkShowHeroicWorldTier:GetValue()
        CTT_updateChromieTime()
    end)
    chkShowHeroicWorldTier:SetWidth(700)

    local chkHideHeroicWorldTierButton = AceGUI:Create("CheckBox")
    chkHideHeroicWorldTierButton:SetLabel(L["chkHideHeroicWorldTierButton"])
    chkHideHeroicWorldTierButton:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.HideHeroicWorldTierButton = chkHideHeroicWorldTierButton:GetValue()
        CTT_updateChromieTime()
    end)
    chkHideHeroicWorldTierButton:SetWidth(700)

    local lblRemixCUrrencyTitle = AceGUI:Create("Label")
    lblRemixCUrrencyTitle:SetText("|cFFD6AE12" .. L["Remix_Legion_Currency"] .. "|r")
    SetACE3WidgetFontSize(lblRemixCUrrencyTitle, 12)
    lblRemixCUrrencyTitle:SetWidth(580)
    

    local chkShowBronze = AceGUI:Create("CheckBox")
    chkShowBronze:SetLabel(L["chkShowBronze"])
    chkShowBronze:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowBronze = chkShowBronze:GetValue()
    end)
    chkShowBronze:SetWidth(700)

    local chkShowInfiniteKnowledge = AceGUI:Create("CheckBox")
    chkShowInfiniteKnowledge:SetLabel(L["chkShowInfiniteKnowledge"])
    chkShowInfiniteKnowledge:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowInfiniteKnowledge = chkShowInfiniteKnowledge:GetValue()
    end)
    chkShowInfiniteKnowledge:SetWidth(700)

    local chkShowInfinitePower = AceGUI:Create("CheckBox")
    chkShowInfinitePower:SetLabel(L["chkShowInfinitePower"])
    chkShowInfinitePower:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowInfinitePower = chkShowInfinitePower:GetValue()
    end)
    chkShowInfinitePower:SetWidth(700)

    local lblRemixBonusTitle = AceGUI:Create("Label")
    lblRemixBonusTitle:SetText("|cFFD6AE12" .. L["Remix_Legion_Bonus"] .. "|r")
    SetACE3WidgetFontSize(lblRemixBonusTitle, 12)
    lblRemixBonusTitle:SetWidth(580)
    

    local chkShowVersatility = AceGUI:Create("CheckBox")
    chkShowVersatility:SetLabel(L["chkShowVersatility"])
    chkShowVersatility:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowVersatilityBonus = chkShowVersatility:GetValue()
    end)
    chkShowVersatility:SetWidth(700)

    local chkShowExperience = AceGUI:Create("CheckBox")
    chkShowExperience:SetLabel(L["chkShowExperience"])
    chkShowExperience:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowExperienceBonus = chkShowExperience:GetValue()
    end)
    chkShowExperience:SetWidth(700)

    local chkShowLegionInvasionTracker = AceGUI:Create("CheckBox")
    chkShowLegionInvasionTracker:SetLabel(L["chkShowLegionInvasionTracker"])
    chkShowLegionInvasionTracker:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowLegionInvasionTracker = chkShowLegionInvasionTracker:GetValue()
    end)
    chkShowLegionInvasionTracker:SetWidth(700)

    local chkShowLegionArgusInvasionTracker = AceGUI:Create("CheckBox")
    chkShowLegionArgusInvasionTracker:SetLabel(L["chkShowLegionArgusInvasionTracker"])
    chkShowLegionArgusInvasionTracker:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowLegionArgusInvasionTracker = chkShowLegionArgusInvasionTracker:GetValue()
    end)
    chkShowLegionArgusInvasionTracker:SetWidth(700)

    local chkShowLegionEmissaryMissions = AceGUI:Create("CheckBox")
    chkShowLegionEmissaryMissions:SetLabel(L["chkShowLegionEmissaryMissions"])
    chkShowLegionEmissaryMissions:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowLegionEmissaryMissions = chkShowLegionEmissaryMissions:GetValue()
    end)
    chkShowLegionEmissaryMissions:SetWidth(700)

    local chkShowEmissaryMissionsRewards = AceGUI:Create("CheckBox")
    chkShowEmissaryMissionsRewards:SetLabel(L["chkShowEmissaryMissionsRewards"])
    chkShowEmissaryMissionsRewards:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowEmissaryMissionsRewards = chkShowEmissaryMissionsRewards:GetValue()
    end)
    chkShowEmissaryMissionsRewards:SetWidth(700)

    local chkShowWorldBosses = AceGUI:Create("CheckBox")
    chkShowWorldBosses:SetLabel(L["chkShowWorldBosses"])
    chkShowWorldBosses:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowWorldBosses = chkShowWorldBosses:GetValue()
    end)
    chkShowWorldBosses:SetWidth(700)

    scrollFrameRemixSettings:AddChild(chkShowHeroicWorldTier)
    scrollFrameRemixSettings:AddChild(chkHideHeroicWorldTierButton)
    scrollFrameRemixSettings:AddChild(chkShowLegionInvasionTracker)
    scrollFrameRemixSettings:AddChild(chkShowLegionArgusInvasionTracker)    
    scrollFrameRemixSettings:AddChild(chkShowLegionEmissaryMissions)
    scrollFrameRemixSettings:AddChild(chkShowEmissaryMissionsRewards)
    scrollFrameRemixSettings:AddChild(chkShowWorldBosses)
    

    local headingRemix1 = AceGUI:Create("Heading")
    headingRemix1:SetRelativeWidth(1)
    scrollFrameRemixSettings:AddChild(headingRemix1)

    scrollFrameRemixSettings:AddChild(lblRemixCUrrencyTitle)

    scrollFrameRemixSettings:AddChild(chkShowBronze)
    scrollFrameRemixSettings:AddChild(chkShowInfiniteKnowledge)
    scrollFrameRemixSettings:AddChild(chkShowInfinitePower)

    local headingRemix2 = AceGUI:Create("Heading")
    headingRemix2:SetRelativeWidth(1)
    scrollFrameRemixSettings:AddChild(headingRemix2)

    scrollFrameRemixSettings:AddChild(lblRemixBonusTitle)

    scrollFrameRemixSettings:AddChild(chkShowVersatility)
    scrollFrameRemixSettings:AddChild(chkShowExperience)

    local headingRemix3 = AceGUI:Create("Heading")
    headingRemix3:SetRelativeWidth(1)
    scrollFrameRemixSettings:AddChild(headingRemix3)

    
    
    chkShowHeroicWorldTier:SetValue(ChromieTimeTrackerDB.ShowHeroicWorldTier)
    chkHideHeroicWorldTierButton:SetValue(ChromieTimeTrackerDB.HideHeroicWorldTierButton)
    chkShowBronze:SetValue(ChromieTimeTrackerDB.ShowBronze)
    chkShowInfiniteKnowledge:SetValue(ChromieTimeTrackerDB.ShowInfiniteKnowledge)
    chkShowInfinitePower:SetValue(ChromieTimeTrackerDB.ShowInfinitePower)
    chkShowVersatility:SetValue(ChromieTimeTrackerDB.ShowVersatilityBonus)
    chkShowExperience:SetValue(ChromieTimeTrackerDB.ShowExperienceBonus)
    chkShowLegionInvasionTracker:SetValue(ChromieTimeTrackerDB.ShowLegionInvasionTracker)
    chkShowLegionArgusInvasionTracker:SetValue(ChromieTimeTrackerDB.ShowLegionArgusInvasionTracker)
    chkShowLegionEmissaryMissions:SetValue(ChromieTimeTrackerDB.ShowLegionEmissaryMissions)
    chkShowEmissaryMissionsRewards:SetValue(ChromieTimeTrackerDB.ShowEmissaryMissionsRewards)
    chkShowWorldBosses:SetValue(ChromieTimeTrackerDB.ShowWorldBosses)

end

function CTT_LoadReportEnhancementSettings()
    treeW:ReleaseChildren()

    scrollContainerReportEnhancementSettings = AceGUI:Create("SimpleGroup")
    scrollContainerReportEnhancementSettings:SetFullWidth(true)
    scrollContainerReportEnhancementSettings:SetFullHeight(true)
    scrollContainerReportEnhancementSettings:SetLayout("Fill")
    
    treeW:AddChild(scrollContainerReportEnhancementSettings)
    
    scrollFrameReportEnhancementSettings = AceGUI:Create("ScrollFrame")
    scrollFrameReportEnhancementSettings:SetLayout("Flow")
    scrollContainerReportEnhancementSettings:AddChild(scrollFrameReportEnhancementSettings)

    local chkShowReportTabsOnReportWindow = AceGUI:Create("CheckBox")
    chkShowReportTabsOnReportWindow:SetLabel(L["chkShowReportTabsOnReportWindow"])
    chkShowReportTabsOnReportWindow:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowReportTabsOnReportWindow = chkShowReportTabsOnReportWindow:GetValue()
        if(garrisonTabs) then
            for _, _garTab in pairs(garrisonTabs) do
                if ChromieTimeTrackerDB.ShowReportTabsOnReportWindow then
                    _garTab:Show();
                else
                    _garTab:Hide();
                end
            end
        end
    end)
    chkShowReportTabsOnReportWindow:SetWidth(700)

    local chkShowEmissaryMissionsOnReportWindow = AceGUI:Create("CheckBox")
    chkShowEmissaryMissionsOnReportWindow:SetLabel(L["chkShowEmissaryMissionsOnReportWindow"])
    chkShowEmissaryMissionsOnReportWindow:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowEmissaryMissionsOnReportWindow = chkShowEmissaryMissionsOnReportWindow:GetValue()
        if (GarrisonLandingPage and GarrisonLandingPage:IsShown()) then
        local _garrisonId = GarrisonLandingPage.garrTypeID
        if(_garrisonId == 3 or _garrisonId == 9) then
                if ChromieTimeTrackerDB.ShowEmissaryMissionsOnReportWindow then
                    if (garrisonUIEmissaryMissionsFrame) then
                        garrisonUIEmissaryMissionsFrame:Show();
                    end
                else
                    if (garrisonUIEmissaryMissionsFrame) then
                        garrisonUIEmissaryMissionsFrame:Hide();
                    end
                end
                    HideUIPanel(GarrisonLandingPage);
                    ShowGarrisonLandingPage(_garrisonId)
                end
            end
        end)
    chkShowEmissaryMissionsOnReportWindow:SetWidth(700)

    local chkShowMissionExpirationTimeOnReportWindow = AceGUI:Create("CheckBox")
    chkShowMissionExpirationTimeOnReportWindow:SetLabel(L["chkShowMissionExpirationTimeOnReportWindow"])
    chkShowMissionExpirationTimeOnReportWindow:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowMissionExpirationTimeOnReportWindow = chkShowMissionExpirationTimeOnReportWindow:GetValue()
        if GarrisonLandingPageReportList ~= nil then
            GarrisonLandingPageReportList.ScrollBox.ReinitializeFrames(GarrisonLandingPageReportList.ScrollBox)
        end
    end)
    chkShowMissionExpirationTimeOnReportWindow:SetWidth(700)

    local chkShowCurrencyOnReportWindow = AceGUI:Create("CheckBox")
    chkShowCurrencyOnReportWindow:SetLabel(L["chkShowCurrencyOnReportWindow"])
    chkShowCurrencyOnReportWindow:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowCurrencyOnReportWindow = chkShowCurrencyOnReportWindow:GetValue()
        if(garrisonUIResourcesFrame) then
            if(ChromieTimeTrackerDB.ShowCurrencyOnReportWindow) then
                garrisonUIResourcesFrame:Show()
            else
                garrisonUIResourcesFrame:Hide()
            end
        end
    end)
    chkShowCurrencyOnReportWindow:SetWidth(700)

    local chkShowCurrencyOnTooltips = AceGUI:Create("CheckBox")
    chkShowCurrencyOnTooltips:SetLabel(L["chkShowCurrencyOnTooltips"])
    chkShowCurrencyOnTooltips:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowCurrencyOnTooltips = chkShowCurrencyOnTooltips:GetValue()
    end)
    chkShowCurrencyOnTooltips:SetWidth(700)

    local chkShowLegionInvasionsOnReportWindow = AceGUI:Create("CheckBox")
    chkShowLegionInvasionsOnReportWindow:SetLabel(L["chkShowLegionInvasionsOnReportWindow"])
    chkShowLegionInvasionsOnReportWindow:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowLegionInvasionsOnReportWindow = chkShowLegionInvasionsOnReportWindow:GetValue()
        if (GarrisonLandingPage and GarrisonLandingPage:IsShown()) then
        local _garrisonId = GarrisonLandingPage.garrTypeID
        if(_garrisonId == 3) then
                if ChromieTimeTrackerDB.ShowLegionInvasionsOnReportWindow then
                    if (garrisonUIInvasionsFrame) then
                        garrisonUIInvasionsFrame:Show();
                    end
                else
                    if (garrisonUIInvasionsFrame) then
                        garrisonUIInvasionsFrame:Hide();
                    end
                end
                    HideUIPanel(GarrisonLandingPage);
                    ShowGarrisonLandingPage(_garrisonId)
                end
            end
        end)
    chkShowLegionInvasionsOnReportWindow:SetWidth(700)

    scrollFrameReportEnhancementSettings:AddChild(chkShowCurrencyOnTooltips)
    scrollFrameReportEnhancementSettings:AddChild(chkShowCurrencyOnReportWindow)
    scrollFrameReportEnhancementSettings:AddChild(chkShowReportTabsOnReportWindow)
    scrollFrameReportEnhancementSettings:AddChild(chkShowMissionExpirationTimeOnReportWindow)
    scrollFrameReportEnhancementSettings:AddChild(chkShowEmissaryMissionsOnReportWindow)
    scrollFrameReportEnhancementSettings:AddChild(chkShowLegionInvasionsOnReportWindow)

    chkShowReportTabsOnReportWindow:SetValue(ChromieTimeTrackerDB.ShowReportTabsOnReportWindow)
    chkShowMissionExpirationTimeOnReportWindow:SetValue(ChromieTimeTrackerDB.ShowMissionExpirationTimeOnReportWindow)
    chkShowCurrencyOnReportWindow:SetValue(ChromieTimeTrackerDB.ShowCurrencyOnReportWindow)
    chkShowCurrencyOnTooltips:SetValue(ChromieTimeTrackerDB.ShowCurrencyOnTooltips)
    chkShowEmissaryMissionsOnReportWindow:SetValue(ChromieTimeTrackerDB.ShowEmissaryMissionsOnReportWindow)
    chkShowLegionInvasionsOnReportWindow:SetValue(ChromieTimeTrackerDB.ShowLegionInvasionsOnReportWindow)
    
end

function CTT_LoadAdvancedModeSettings()
    treeW:ReleaseChildren()

    scrollContainerAdvancedMode = AceGUI:Create("SimpleGroup")
    scrollContainerAdvancedMode:SetFullWidth(true)
    scrollContainerAdvancedMode:SetFullHeight(true)
    scrollContainerAdvancedMode:SetLayout("Fill")
    
    treeW:AddChild(scrollContainerAdvancedMode)
    
    scrollFrameAdvancedMode = AceGUI:Create("ScrollFrame")
    scrollFrameAdvancedMode:SetLayout("Flow")
    scrollContainerAdvancedMode:AddChild(scrollFrameAdvancedMode)

--Advanced Mode Options
local ddlButtonPosition = AceGUI:Create("Dropdown")
local ddlButtonAlignment = AceGUI:Create("Dropdown")
local lblSelectAdvancedModeOptions = AceGUI:Create("Label")
local chkAdvShowGarrison = AceGUI:Create("CheckBox")
local chkAdvShowClassHall = AceGUI:Create("CheckBox")
local chkAdvShowWarEffort = AceGUI:Create("CheckBox")
local chkAdvShowCovenant = AceGUI:Create("CheckBox")
local chkAdvShowDragonIsles = AceGUI:Create("CheckBox")
local chkAdvShowKhazAlgar = AceGUI:Create("CheckBox")
local chkAdvShowUnlockedOnly = AceGUI:Create("CheckBox")
local chkAdvHideTimelineBox = AceGUI:Create("CheckBox")
local heading5 = AceGUI:Create("Heading")

ddlButtonPosition:SetList(buttonPositions)
ddlButtonPosition:SetLabel(L["ddlButtonPosition"])
ddlButtonPosition:SetWidth(200)
ddlButtonPosition:SetCallback("OnValueChanged", function(widget, event, text)
    textStore = text
    ChromieTimeTrackerDB.AdvButtonsPosition = ddlButtonPosition.value
    CTT_updateChromieTime()
    CTT_showMainFrame()
    if (ChromieTimeTrackerDB.Mode == 4) then
        CTT_LoadAvancedModeIcons()
    end
end)
scrollFrameAdvancedMode:AddChild(ddlButtonPosition)

ddlButtonAlignment:SetList(buttonAlignments)
ddlButtonAlignment:SetLabel(L["ddlButtonAlignment"])
ddlButtonAlignment:SetWidth(200)
ddlButtonAlignment:SetCallback("OnValueChanged", function(widget, event, text)
    textStore = text
    ChromieTimeTrackerDB.AdvButtonsAlignment = ddlButtonAlignment.value
    CTT_updateChromieTime()
    CTT_showMainFrame()
    if (ChromieTimeTrackerDB.Mode == 4) then
        CTT_LoadAvancedModeIcons()
    end
end)
scrollFrameAdvancedMode:AddChild(ddlButtonAlignment)

lblSelectAdvancedModeOptions:SetText("\n" .. L["lblSelectAdvancedModeOptions"])
SetACE3WidgetFontSize(lblSelectAdvancedModeOptions, 12)
lblSelectAdvancedModeOptions:SetWidth(580)
scrollFrameAdvancedMode:AddChild(lblSelectAdvancedModeOptions)
    
    chkAdvShowGarrison:SetLabel(L["MiddleClickOption_Warlords"])
    chkAdvShowGarrison:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.AdvShowGarrison = chkAdvShowGarrison:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkAdvShowGarrison:SetWidth(700)
    scrollFrameAdvancedMode:AddChild(chkAdvShowGarrison)

    chkAdvShowClassHall:SetLabel(L["MiddleClickOption_Legion"])
    chkAdvShowClassHall:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.AdvShowClassHall = chkAdvShowClassHall:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkAdvShowClassHall:SetWidth(700)
    scrollFrameAdvancedMode:AddChild(chkAdvShowClassHall)

    chkAdvShowWarEffort:SetLabel(L["MiddleClickOption_Missions"])
    chkAdvShowWarEffort:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.AdvShowWarEffort = chkAdvShowWarEffort:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkAdvShowWarEffort:SetWidth(700)
    scrollFrameAdvancedMode:AddChild(chkAdvShowWarEffort)

    chkAdvShowCovenant:SetLabel(string.format(L["MiddleClickOption_Covenant"], "-"))
    chkAdvShowCovenant:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.AdvShowCovenant = chkAdvShowCovenant:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkAdvShowCovenant:SetWidth(700)
    scrollFrameAdvancedMode:AddChild(chkAdvShowCovenant)

    chkAdvShowDragonIsles:SetLabel(L["MiddleClickOption_DragonIsles"])
    chkAdvShowDragonIsles:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.AdvShowDragonIsles = chkAdvShowDragonIsles:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkAdvShowDragonIsles:SetWidth(700)
    scrollFrameAdvancedMode:AddChild(chkAdvShowDragonIsles)

    chkAdvShowKhazAlgar:SetLabel(L["MiddleClickOption_KhazAlgar"])
    chkAdvShowKhazAlgar:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.AdvShowKhazAlgar = chkAdvShowKhazAlgar:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkAdvShowKhazAlgar:SetWidth(700)
    scrollFrameAdvancedMode:AddChild(chkAdvShowKhazAlgar)

    heading5:SetRelativeWidth(1)
    scrollFrameAdvancedMode:AddChild(heading5)

    chkAdvShowUnlockedOnly:SetLabel(L["chkAdvShowUnlockedOnly"])
    chkAdvShowUnlockedOnly:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.AdvShowUnlockedOnly = chkAdvShowUnlockedOnly:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkAdvShowUnlockedOnly:SetWidth(700)
    scrollFrameAdvancedMode:AddChild(chkAdvShowUnlockedOnly)

    chkAdvHideTimelineBox:SetLabel(L["chkAdvHideTimelineBox"])
    chkAdvHideTimelineBox:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.AdvHideTimelineBox = chkAdvHideTimelineBox:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkAdvHideTimelineBox:SetWidth(700)
    scrollFrameAdvancedMode:AddChild(chkAdvHideTimelineBox)

    ddlButtonPosition:SetValue(ChromieTimeTrackerDB.AdvButtonsPosition)
    ddlButtonAlignment:SetValue(ChromieTimeTrackerDB.AdvButtonsAlignment)
    chkAdvShowGarrison:SetValue(ChromieTimeTrackerDB.AdvShowGarrison)
    chkAdvShowClassHall:SetValue(ChromieTimeTrackerDB.AdvShowClassHall)
    chkAdvShowWarEffort:SetValue(ChromieTimeTrackerDB.AdvShowWarEffort)
    chkAdvShowCovenant:SetValue(ChromieTimeTrackerDB.AdvShowCovenant)
    chkAdvShowDragonIsles:SetValue(ChromieTimeTrackerDB.AdvShowDragonIsles)
    chkAdvShowKhazAlgar:SetValue(ChromieTimeTrackerDB.AdvShowKhazAlgar)
    chkAdvShowUnlockedOnly:SetValue(ChromieTimeTrackerDB.AdvShowUnlockedOnly)
    chkAdvHideTimelineBox:SetValue(ChromieTimeTrackerDB.AdvHideTimelineBox)
end

---
function CTT_LoadContextMenuSettings()
    treeW:ReleaseChildren()

    local trackerOptions = {L["ContextMenu_DefeultAddonOptions_Blizzard"]}

    local TomTomLoaded = checkAddonLoaded("TomTom", "TOMTOM_WAY")
    local MapPinEnhancedLoaded = checkAddonLoaded("MapPinEnhanced", "MapPinEnhanced")

    if (TomTomLoaded) then
        table.insert(trackerOptions, L["ContextMenu_DefeultAddonOptions_TomTom"])
    else
        table.insert(trackerOptions, L["ContextMenu_DefeultAddonOptions_TomTom"] .. " (" .. ADDON_DISABLED .. ")")
    end
    if (MapPinEnhancedLoaded) then
        table.insert(trackerOptions, L["ContextMenu_DefeultAddonOptions_MapPinEnhanced"])
    else
        table.insert(trackerOptions, L["ContextMenu_DefeultAddonOptions_MapPinEnhanced"] .. " (" .. ADDON_DISABLED .. ")")
    end

    scrollContainerContextManu = AceGUI:Create("SimpleGroup")
    scrollContainerContextManu:SetFullWidth(true)
    scrollContainerContextManu:SetFullHeight(true)
    scrollContainerContextManu:SetLayout("Fill")
    
    treeW:AddChild(scrollContainerContextManu)
    
    scrollFrameContewxtMenu = AceGUI:Create("ScrollFrame")
    scrollFrameContewxtMenu:SetLayout("Flow")
    scrollContainerContextManu:AddChild(scrollFrameContewxtMenu)

--ContextMenu Options
local lblSelectContextMenuOptions = AceGUI:Create("Label")
local chkContextMenuShowGarrison = AceGUI:Create("CheckBox")
local chkContextMenuShowClassHall = AceGUI:Create("CheckBox")
local chkContextMenuShowWarEffort = AceGUI:Create("CheckBox")
local chkContextMenuShowCovenant = AceGUI:Create("CheckBox")
local chkContextMenuShowDragonIsles = AceGUI:Create("CheckBox")
local chkContextMenuShowKhazAlgar = AceGUI:Create("CheckBox")
local chkContextMenuShowUnlockedOnly = AceGUI:Create("CheckBox")
local heading5 = AceGUI:Create("Heading")
local heading6 = AceGUI:Create("Heading")

lblSelectContextMenuOptions:SetText("\n" .. L["lblSelectContextMenuOptions"])
SetACE3WidgetFontSize(lblSelectContextMenuOptions, 12)
lblSelectContextMenuOptions:SetWidth(580)
scrollFrameContewxtMenu:AddChild(lblSelectContextMenuOptions)
    
    chkContextMenuShowGarrison:SetLabel(L["MiddleClickOption_Warlords"])
    chkContextMenuShowGarrison:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.ContextMenuShowGarrison = chkContextMenuShowGarrison:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkContextMenuShowGarrison:SetWidth(700)
    scrollFrameContewxtMenu:AddChild(chkContextMenuShowGarrison)

    chkContextMenuShowClassHall:SetLabel(L["MiddleClickOption_Legion"])
    chkContextMenuShowClassHall:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.ContextMenuShowClassHall = chkContextMenuShowClassHall:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkContextMenuShowClassHall:SetWidth(700)
    scrollFrameContewxtMenu:AddChild(chkContextMenuShowClassHall)

    chkContextMenuShowWarEffort:SetLabel(L["MiddleClickOption_Missions"])
    chkContextMenuShowWarEffort:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.ContextMenuShowWarEffort = chkContextMenuShowWarEffort:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkContextMenuShowWarEffort:SetWidth(700)
    scrollFrameContewxtMenu:AddChild(chkContextMenuShowWarEffort)

    chkContextMenuShowCovenant:SetLabel(string.format(L["MiddleClickOption_Covenant"], "-"))
    chkContextMenuShowCovenant:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.ContextMenuShowCovenant = chkContextMenuShowCovenant:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkContextMenuShowCovenant:SetWidth(700)
    scrollFrameContewxtMenu:AddChild(chkContextMenuShowCovenant)

    chkContextMenuShowDragonIsles:SetLabel(L["MiddleClickOption_DragonIsles"])
    chkContextMenuShowDragonIsles:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.ContextMenuShowDragonIsles = chkContextMenuShowDragonIsles:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkContextMenuShowDragonIsles:SetWidth(700)
    scrollFrameContewxtMenu:AddChild(chkContextMenuShowDragonIsles)

    chkContextMenuShowKhazAlgar:SetLabel(L["MiddleClickOption_KhazAlgar"])
    chkContextMenuShowKhazAlgar:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.ContextMenuShowKhazAlgar = chkContextMenuShowKhazAlgar:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkContextMenuShowKhazAlgar:SetWidth(700)
    scrollFrameContewxtMenu:AddChild(chkContextMenuShowKhazAlgar)

    heading5:SetRelativeWidth(1)
    scrollFrameContewxtMenu:AddChild(heading5)

    chkContextMenuShowUnlockedOnly:SetLabel(L["chkAdvShowUnlockedOnly"])
    chkContextMenuShowUnlockedOnly:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.ContextMenuShowUnlockedOnly = chkContextMenuShowUnlockedOnly:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkContextMenuShowUnlockedOnly:SetWidth(700)
    scrollFrameContewxtMenu:AddChild(chkContextMenuShowUnlockedOnly)

    heading6:SetRelativeWidth(1)
    scrollFrameContewxtMenu:AddChild(heading6)

    local ddlTrackerAddon = AceGUI:Create("Dropdown")

    ddlTrackerAddon:SetList(trackerOptions)
    ddlTrackerAddon:SetLabel(L["ddlTrackerAddon"])
    ddlTrackerAddon:SetWidth(200)
    ddlTrackerAddon:SetCallback("OnValueChanged", function(widget, event, text)
        ChromieTimeTrackerDB.DefaultTrackerAddon = ddlTrackerAddon.value
    end)
    scrollFrameContewxtMenu:AddChild(ddlTrackerAddon)

    local LabelDefeultTrackerAddonHelp = AceGUI:Create("InteractiveLabel")

    scrollFrameContewxtMenu:AddChild(LabelDefeultTrackerAddonHelp)
    local tooltipText = L["DefeultTrackerAddonHelp"]
    addHelpIcon(LabelDefeultTrackerAddonHelp, tooltipText)

    local chkShowPinChromie = AceGUI:Create("CheckBox")
    chkShowPinChromie:SetLabel(L["ContextMenu_ShowPinChromie"])
    chkShowPinChromie:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ContextMenuShowPinChromie = chkShowPinChromie:GetValue()
    end)
    chkShowPinChromie:SetWidth(700)
    scrollFrameContewxtMenu:AddChild(chkShowPinChromie)

    local chkShowPinExperienceLock = AceGUI:Create("CheckBox")
    chkShowPinExperienceLock:SetLabel(L["ContextMenu_ShowPinExperienceLock"])
    chkShowPinExperienceLock:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ContextMenuShowPinExperienceLock = chkShowPinExperienceLock:GetValue()
    end)
    chkShowPinExperienceLock:SetWidth(700)
    scrollFrameContewxtMenu:AddChild(chkShowPinExperienceLock)
    

    chkContextMenuShowGarrison:SetValue(ChromieTimeTrackerDB.ContextMenuShowGarrison)
    chkContextMenuShowClassHall:SetValue(ChromieTimeTrackerDB.ContextMenuShowClassHall)
    chkContextMenuShowWarEffort:SetValue(ChromieTimeTrackerDB.ContextMenuShowWarEffort)
    chkContextMenuShowCovenant:SetValue(ChromieTimeTrackerDB.ContextMenuShowCovenant)
    chkContextMenuShowDragonIsles:SetValue(ChromieTimeTrackerDB.ContextMenuShowDragonIsles)
    chkContextMenuShowKhazAlgar:SetValue(ChromieTimeTrackerDB.ContextMenuShowKhazAlgar)
    chkContextMenuShowUnlockedOnly:SetValue(ChromieTimeTrackerDB.ContextMenuShowUnlockedOnly)
    chkShowPinChromie:SetValue(ChromieTimeTrackerDB.ContextMenuShowPinChromie)
    chkShowPinExperienceLock:SetValue(ChromieTimeTrackerDB.ContextMenuShowPinExperienceLock)
    ddlTrackerAddon:SetValue(ChromieTimeTrackerDB.DefaultTrackerAddon)
end
---

function CTT_LoadSettings()

treeW:ReleaseChildren()

scrollContainerMainSettings = AceGUI:Create("SimpleGroup")
scrollContainerMainSettings:SetFullWidth(true)
scrollContainerMainSettings:SetFullHeight(true)
scrollContainerMainSettings:SetLayout("Fill")

treeW:AddChild(scrollContainerMainSettings)

scrollFrameMainSettings = AceGUI:Create("ScrollFrame")
scrollFrameMainSettings:SetLayout("Flow")
scrollContainerMainSettings:AddChild(scrollFrameMainSettings)

--Geral
local dropdown = AceGUI:Create("Dropdown")
local LabelAddonModesHelp = AceGUI:Create("InteractiveLabel")
local ddlChatWelcomeMessageVisibility = AceGUI:Create("Dropdown")
local ddlMainWindowVisibility = AceGUI:Create("Dropdown")
local ddlToastVisibility = AceGUI:Create("Dropdown")
local chkLockDragDrop = AceGUI:Create("CheckBox")
local ddlDefaultMiddleClickOption = AceGUI:Create("Dropdown")
local LabelDefaultMiddleClickHelp = AceGUI:Create("InteractiveLabel")
local chkLockMiddleClickOption = AceGUI:Create("CheckBox")
local chkShareWarbandUnlock = AceGUI:Create("CheckBox")
local LabelShareWarbandUnlockHelp = AceGUI:Create("InteractiveLabel")
local chkHideMinimapIcon = AceGUI:Create("CheckBox")
local chkWelcomeWindowShowOnlyOnce = AceGUI:Create("CheckBox")
local chkHideWelcomeWindowInFutureVersionChanges = AceGUI:Create("CheckBox")
local chkHideDeveloperCreditOnTooltips = AceGUI:Create("CheckBox")
local btnSave = AceGUI:Create("Button")
local btnResetPosition = AceGUI:Create("Button")
local btnResetSettings = AceGUI:Create("Button")
local btnContributors = AceGUI:Create("Button")
local heading1 = AceGUI:Create("Heading")
local heading2 = AceGUI:Create("Heading")
local heading3 = AceGUI:Create("Heading")

dropdown:SetList(modes)
dropdown:SetLabel(L["lblModeSelect"])
dropdown:SetWidth(200)
dropdown:SetCallback("OnValueChanged", function(widget, event, text)
    textStore = text
    ChromieTimeTrackerDB.Mode = dropdown.value
    CTT_updateChromieTime()
    CTT_showMainFrame()
    if (ChromieTimeTrackerDB.Mode == 4) then
        CTT_LoadAvancedModeIcons()
    end
end)
scrollFrameMainSettings:AddChild(dropdown)

   scrollFrameMainSettings:AddChild(LabelAddonModesHelp)
   local tooltipText = "|cFFD6AE12" .. L["CompactMode"] .. ":|r " .. L["CompactModeDescription"] ..
                       "\n\n|cFFD6AE12" .. L["StandardMode"] .. ":|r " .. L["StandardModeDescription"] ..
                       "\n\n|cFFD6AE12" .. L["AlternateMode"] .. ":|r " .. L["AlternateModeDescription"] ..
                       "\n\n|cFFD6AE12" .. L["AdvancedMode"] .. ":|r " .. L["AdvancedModeDescription"]
   addHelpIcon(LabelAddonModesHelp, tooltipText)

AddLineSkip(scrollFrameMainSettings)

ddlMainWindowVisibility:SetList(visibilityOptions)
ddlMainWindowVisibility:SetLabel(L["ddlMainWindowVisibility"])
ddlMainWindowVisibility:SetWidth(280)
ddlMainWindowVisibility:SetCallback("OnValueChanged", function(widget, event, text)
    textStore = text
    ChromieTimeTrackerDB.MainWindowVisibility = ddlMainWindowVisibility.value
    if (ddlMainWindowVisibility.value == 1 or ddlMainWindowVisibility.value == 3) then
        ChromieTimeTrackerDB.MainWindowVisibilityToggle = 1
        CTT_updateChromieTime()
        CTT_showMainFrame()
    else
        ChromieTimeTrackerDB.MainWindowVisibilityToggle = 2
        CTT_updateChromieTime()
        CTT_showMainFrame()
    end
end)
scrollFrameMainSettings:AddChild(ddlMainWindowVisibility)

AddLineSkip(scrollFrameMainSettings)

ddlChatWelcomeMessageVisibility:SetList(visibilityOptions)
ddlChatWelcomeMessageVisibility:SetLabel(L["ddlChatWelcomeMessageVisibility"])
ddlChatWelcomeMessageVisibility:SetWidth(280)
ddlChatWelcomeMessageVisibility:SetCallback("OnValueChanged", function(widget, event, text)
    textStore = text
    ChromieTimeTrackerDB.WelcomeMessageVisibility = ddlChatWelcomeMessageVisibility.value
end)
scrollFrameMainSettings:AddChild(ddlChatWelcomeMessageVisibility)

AddLineSkip(scrollFrameMainSettings)

ddlToastVisibility:SetList(visibilityOptions)
ddlToastVisibility:SetLabel(L["ddlToastVisibility"])
ddlToastVisibility:SetWidth(280)
ddlToastVisibility:SetCallback("OnValueChanged", function(widget, event, text)
    textStore = text
    ChromieTimeTrackerDB.ToastVisibility = ddlToastVisibility.value
end)
scrollFrameMainSettings:AddChild(ddlToastVisibility)

chkLockDragDrop:SetLabel(L["LockDragDrop"])
chkLockDragDrop:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.LockDragDrop = chkLockDragDrop:GetValue()
    CTT_updateChromieTime()
    CTT_showMainFrame()
end)
chkLockDragDrop:SetWidth(700)
scrollFrameMainSettings:AddChild(chkLockDragDrop)

heading2:SetRelativeWidth(1)
scrollFrameMainSettings:AddChild(heading2)

chkShareWarbandUnlock:SetLabel(L["chkShareWarbandUnlock"])
chkShareWarbandUnlock:SetCallback("OnValueChanged", function(widget, event, text) 
ChromieTimeTrackerSharedDB.ShareWarbandUnlock = chkShareWarbandUnlock:GetValue()
    CTT_updateChromieTime()
    CTT_showMainFrame()
    if (ChromieTimeTrackerDB.Mode == 4) then
        CTT_LoadAvancedModeIcons()
    end
end)
chkShareWarbandUnlock:SetWidth(600)
scrollFrameMainSettings:AddChild(chkShareWarbandUnlock)

scrollFrameMainSettings:AddChild(LabelShareWarbandUnlockHelp)
addHelpIcon(LabelShareWarbandUnlockHelp, L["ShareWarbandUnlockHelp"])

ddlDefaultMiddleClickOption:SetList(MiddleClickOptions)
ddlDefaultMiddleClickOption:SetLabel(L["lblDefaultMiddleClickOption"])
ddlDefaultMiddleClickOption:SetWidth(280)
ddlDefaultMiddleClickOption:SetCallback("OnValueChanged", function(widget, event, text)
    textStore = text 
    ChromieTimeTrackerDB.DefaultMiddleClickOption = ddlDefaultMiddleClickOption.value
    CTT_updateChromieTime()
    CTT_showMainFrame()
end)
scrollFrameMainSettings:AddChild(ddlDefaultMiddleClickOption)

scrollFrameMainSettings:AddChild(LabelDefaultMiddleClickHelp)
local tooltipText = L["MiddleClickOptionDescription"]
addHelpIcon(LabelDefaultMiddleClickHelp, tooltipText)

chkLockMiddleClickOption:SetLabel(L["LockMiddleClickOption"])
chkLockMiddleClickOption:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.LockMiddleClickOption = chkLockMiddleClickOption:GetValue()
    CTT_updateChromieTime()
    CTT_showMainFrame()
end)
chkLockMiddleClickOption:SetWidth(700)
scrollFrameMainSettings:AddChild(chkLockMiddleClickOption)

heading3:SetRelativeWidth(1)
scrollFrameMainSettings:AddChild(heading3)

chkHideMinimapIcon:SetLabel(L["chkHideMinimapIcon"])
chkHideMinimapIcon:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.HideMinimapIcon = chkHideMinimapIcon:GetValue()
    CTT_ToggleMinimapButton(chkHideMinimapIcon:GetValue())
end)
chkHideMinimapIcon:SetWidth(575)
scrollFrameMainSettings:AddChild(chkHideMinimapIcon)

chkWelcomeWindowShowOnlyOnce:SetLabel(L["chkWelcomeWindowShowOnlyOnce"])
chkWelcomeWindowShowOnlyOnce:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerSharedDB.WelcomeWindowShowOnlyOnce = chkWelcomeWindowShowOnlyOnce:GetValue()
end)
chkWelcomeWindowShowOnlyOnce:SetWidth(575)
scrollFrameMainSettings:AddChild(chkWelcomeWindowShowOnlyOnce)

chkHideWelcomeWindowInFutureVersionChanges:SetLabel(L["chkHideWelcomeWindowInFutureVersionChanges"])
chkHideWelcomeWindowInFutureVersionChanges:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.HideWelcomeWindowInFutureVersionChanges = chkHideWelcomeWindowInFutureVersionChanges:GetValue()
end)
chkHideWelcomeWindowInFutureVersionChanges:SetWidth(575)
scrollFrameMainSettings:AddChild(chkHideWelcomeWindowInFutureVersionChanges)

chkHideDeveloperCreditOnTooltips:SetLabel(L["HideDeveloperCreditOnTooltips"])
chkHideDeveloperCreditOnTooltips:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips = chkHideDeveloperCreditOnTooltips:GetValue()
    CTT_updateChromieTime()
    CTT_showMainFrame()
 end)
chkHideDeveloperCreditOnTooltips:SetWidth(700)
scrollFrameMainSettings:AddChild(chkHideDeveloperCreditOnTooltips)


StaticPopupDialogs["POPUP_DIALOG_CONFIRM_RESET"] = {
    text = L["Dialog_ResetPosition_Message"],
    button1 = L["Dialog_Yes"],
    button2 = L["Dialog_No"],
    OnAccept = function()
        ChromieTimeTrackerDB.BasePoint = "CENTER"
        ChromieTimeTrackerDB.RelativePoint = "CENTER"
        ChromieTimeTrackerDB.OffsetX = 0
        ChromieTimeTrackerDB.OffsetY = 0
        CTT_updateChromieTime()
        CTT_showMainFrame()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
  }

btnResetPosition:SetText(L["buttonResetPosition"])
btnResetPosition:SetWidth(200)
btnResetPosition:SetCallback("OnClick", function() 
    StaticPopup_Show ("POPUP_DIALOG_CONFIRM_RESET")
end)
scrollFrameMainSettings:AddChild(btnResetPosition)

    dropdown:SetValue(ChromieTimeTrackerDB.Mode)
    ddlToastVisibility:SetValue(ChromieTimeTrackerDB.ToastVisibility)
    ddlChatWelcomeMessageVisibility:SetValue(ChromieTimeTrackerDB.WelcomeMessageVisibility)
    ddlMainWindowVisibility:SetValue(ChromieTimeTrackerDB.MainWindowVisibility)
    chkLockDragDrop:SetValue(ChromieTimeTrackerDB.LockDragDrop)
    chkShareWarbandUnlock:SetValue(ChromieTimeTrackerSharedDB.ShareWarbandUnlock)
    ddlDefaultMiddleClickOption:SetValue(ChromieTimeTrackerDB.DefaultMiddleClickOption)
    chkLockMiddleClickOption:SetValue(ChromieTimeTrackerDB.LockMiddleClickOption)
    chkHideMinimapIcon:SetValue(ChromieTimeTrackerDB.HideMinimapIcon)
    chkWelcomeWindowShowOnlyOnce:SetValue(ChromieTimeTrackerSharedDB.WelcomeWindowShowOnlyOnce)
    chkHideWelcomeWindowInFutureVersionChanges:SetValue(ChromieTimeTrackerDB.HideWelcomeWindowInFutureVersionChanges)
    chkHideDeveloperCreditOnTooltips:SetValue(ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips)

StaticPopupDialogs["POPUP_DIALOG_CONFIRM_RESET_SETTINGS"] = {
    text = L["Dialog_ResetSettings_Message"],
    button1 = L["Dialog_Yes"],
    button2 = L["Dialog_No"],
    OnAccept = function()
        --Set default values for all settings

        --General
        ChromieTimeTrackerDB.Mode = 2;
        ChromieTimeTrackerDB.MainWindowVisibility = 1;
        ChromieTimeTrackerDB.WelcomeMessageVisibility = 1;
        ChromieTimeTrackerDB.ToastVisibility = 1;
        ChromieTimeTrackerDB.LockDragDrop = false;
        ChromieTimeTrackerDB.DefaultMiddleClickOption = "";
        ChromieTimeTrackerDB.LockMiddleClickOption = false;
        ChromieTimeTrackerDB.HideMinimapIcon = false;
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
        ChromieTimeTrackerDB.ShowLegionInvasionsOnReportWindow = true;

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

        CTT_updateChromieTime()
        CTT_showMainFrame()
        treeW:SelectByValue("S")
    treeW:SelectByValue("G")
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
  }

btnResetSettings:SetText(L["buttonResetSettings"])
btnResetSettings:SetWidth(200)
btnResetSettings:SetCallback("OnClick", function() 
    StaticPopup_Show ("POPUP_DIALOG_CONFIRM_RESET_SETTINGS")
end)
scrollFrameMainSettings:AddChild(btnResetSettings)

    dropdown:SetValue(ChromieTimeTrackerDB.Mode)
    ddlToastVisibility:SetValue(ChromieTimeTrackerDB.ToastVisibility)
    chkLockDragDrop:SetValue(ChromieTimeTrackerDB.LockDragDrop)
    ddlDefaultMiddleClickOption:SetValue(ChromieTimeTrackerDB.DefaultMiddleClickOption)
    chkLockMiddleClickOption:SetValue(ChromieTimeTrackerDB.LockMiddleClickOption)
    chkHideMinimapIcon:SetValue(ChromieTimeTrackerDB.HideMinimapIcon)
    chkWelcomeWindowShowOnlyOnce:SetValue(ChromieTimeTrackerSharedDB.WelcomeWindowShowOnlyOnce)
    chkHideWelcomeWindowInFutureVersionChanges:SetValue(ChromieTimeTrackerDB.HideWelcomeWindowInFutureVersionChanges)
    chkHideDeveloperCreditOnTooltips:SetValue(ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips)
   
end

tree = { 
    { 
        value = "S",
        text = L["Settings_Menu_About"],
        icon = "Interface\\AddOns\\ChromieTimeTracker\\Chromie.png",
    },
    { 
        value = "G",
        text = L["Settings_Menu_General"],
        icon = "Interface\\Icons\\inv_misc_gear_01",
    },
    {
        value = "Ctx",
        text = L["Settings_Menu_Context_Menu"],
        icon = "Interface\\Icons\\inv_misc_gear_01",
    },
    {
        value = "Adv",
        text = L["Settings_Menu_Advanced"],
        icon = "Interface\\Icons\\inv_misc_gear_01",
    },
    {
        value = "Alt",
        text = L["Settings_Menu_Alternate"],
        icon = "Interface\\Icons\\inv_misc_gear_01",
    },
    {
        value = "Enh",
        text = L["Settings_Menu_Enhancements"],
        icon = "Interface\\Icons\\inv_misc_gear_01",
    },
    {
        value = "Exp",
        text = L["Settings_Menu_Experience"],
        icon = "Interface\\Icons\\inv_misc_gear_01",
    },
    {
        value = "Rmx",
        text = L["Settings_Menu_Remix"],
        icon = "Interface\\Icons\\item_timemote_icon",
    },
    { 
        value = "C", 
        text = L["Settings_Menu_Credit"],
        icon = "Interface\\Icons\\inv_misc_coin_02",
    },
  }

  
  treeW:SetFullHeight(true)
  treeW:SetLayout("Flow")
  treeW:SetTree(tree)
  settingsFrame:AddChild(treeW)

  treeW:SetCallback("OnGroupSelected", function(container, _, group, ...)
    
    --elseif string.find(group, "Ctx") then

    if group == "G" then
        CTT_LoadSettings()
    elseif group == "C" then
        CTT_LoadCredits()
    elseif group == "S" then
        CTT_LoadAbout()
    elseif group == "Adv" then
        CTT_LoadAdvancedModeSettings()
    elseif group == "Alt" then
        CTT_LoadAlternateModeSettings()
    elseif group == "Ctx" then
        CTT_LoadContextMenuSettings()
    elseif group == "Cur" then
        --CTT_LoadCurrencyMenuSettings()
    elseif group == "Enh" then
        CTT_LoadReportEnhancementSettings()
    elseif group == "Exp" then
        CTT_LoadExperienceSettings()
    elseif group == "Rmx" then
        CTT_LoadRemixSettings()
    else
        print(group)
    end
end)

settingsFrame:Hide()

treeW:SelectByValue("S")

CTT_LoadAbout()

function ChromieTimeTracker:ToggleSettingsFrame()
    if not settingsFrame:IsShown() then
        settingsFrame:Show()
    else
        settingsFrame:Hide()
    end
end