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
local buttonAlignments = {L["alignLeft"],L["alignCenter"],L["alignRight"]}
local buttonPositions = {L["positionAbove"], L["positionBelow"]}
local MiddleClickOptions = {L["MiddleClickOption_Warlords"], L["MiddleClickOption_Legion"],L["MiddleClickOption_Missions"],string.format(L["MiddleClickOption_Covenant"], "-"),L["MiddleClickOption_DragonIsles"],L["MiddleClickOption_KhazAlgar"]}

local AceGUI = LibStub("AceGUI-3.0")

-- Create a container frame
settingsFrame = AceGUI:Create("Frame")
settingsFrame:SetCallback("OnClose",function(widget)  end)
settingsFrame:SetTitle(L["AddonName"] .. " - " .. L["Settings"])
settingsFrame:SetStatusText(L["DevelopmentTeamCredit"])
settingsFrame:SetWidth(800)
settingsFrame:SetHeight(510)
settingsFrame:SetLayout("Flow")


--"Gambiarra da Braba - Início" - 01/03/2025
--This next lines were the only way found to resize texts on ACE3 widgets since it's a poorly documented lib that get almost no feature update in a long time.
--If someone knows a diferent way to do this or by the time you read this there are any changes in ACE3 label widget concerning font sizing ou allowing to get
--current font style, feel free to try and push a commit on GitHub project page.
local auxFontScaleFrame = CreateFrame("Frame", "auxFontScaleFrame", UIParent, "BasicFrameTemplateWithInset")
auxFontScaleFrame.dummyTextLabel = auxFontScaleFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
local font, size, style = auxFontScaleFrame.dummyTextLabel:GetFont() --Essas 3 variáveis são utilizadas para ajustar a escala de textos dentro dos widgets do ACE3.
auxFontScaleFrame:Hide()

function CTT_setACE3WidgetFontSide(_widget, _size)
    _widget:SetFont(font, _size, style)
end
--"Gambiarra da Braba - Fim"

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
    --LabelCredits:SetFont(font, 13, style)
    CTT_setACE3WidgetFontSide(LabelCredits, 13)
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
    --LabelAbout_Title:SetFont(font, 20, style)
    CTT_setACE3WidgetFontSide(LabelAbout_Title, 20)
    LabelAbout_Title:SetWidth(580)
    scrollFrameAbout:AddChild(LabelAbout_Title)

    local LabelAbout = AceGUI:Create("Label")
    LabelAbout:SetText("|cFFFFC90E" .. L["About_Version"] .. "|r\n\n" .. L["About_Title"] .. "\n\n" .. L["About_Line1"] .. "\n\n" .. L["About_Line2"] .. "\n\n")
    --LabelAbout:SetFont(font, 13, style)
    CTT_setACE3WidgetFontSide(LabelAbout, 13)
    LabelAbout:SetWidth(560)
    scrollFrameAbout:AddChild(LabelAbout)
    
    local headingAbout1 = AceGUI:Create("Heading")
    headingAbout1:SetRelativeWidth(1)
    scrollFrameAbout:AddChild(headingAbout1)

    local LabelAboutLocalizationDisclaimer = AceGUI:Create("Label")
    LabelAboutLocalizationDisclaimer:SetText(L["About_Line3"])
    --LabelAbout:SetFont(font, 13, style)
    CTT_setACE3WidgetFontSide(LabelAboutLocalizationDisclaimer, 13)
    LabelAboutLocalizationDisclaimer:SetWidth(560)
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

function CTT_LoadCurrencyMenuSettings()
    treeW:ReleaseChildren()

    scrollContainerCurrencySettings = AceGUI:Create("SimpleGroup")
    scrollContainerCurrencySettings:SetFullWidth(true)
    scrollContainerCurrencySettings:SetFullHeight(true)
    scrollContainerCurrencySettings:SetLayout("Fill")
    
    treeW:AddChild(scrollContainerCurrencySettings)
    
    scrollFrameCurrencySettings = AceGUI:Create("ScrollFrame")
    scrollFrameCurrencySettings:SetLayout("Flow")
    scrollContainerCurrencySettings:AddChild(scrollFrameCurrencySettings)

    local chkShowCurrencyOnReportWindow = AceGUI:Create("CheckBox")
    chkShowCurrencyOnReportWindow:SetLabel(L["chkShowCurrencyOnReportWindow"])
    chkShowCurrencyOnReportWindow:SetCallback("OnValueChanged", function(widget, event, text) 
        ChromieTimeTrackerDB.ShowCurrencyOnReportWindow = chkShowCurrencyOnReportWindow:GetValue()
        if(ChromieTimeTrackerDB.ShowCurrencyOnReportWindow) then
            garrisonUIResourcesFrame:Show()
        else
            garrisonUIResourcesFrame:Hide()
        end
    end)
    chkShowCurrencyOnReportWindow:SetWidth(700)
    scrollFrameCurrencySettings:AddChild(chkShowCurrencyOnReportWindow)

    chkShowCurrencyOnReportWindow:SetValue(ChromieTimeTrackerDB.ShowCurrencyOnReportWindow)
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
CTT_setACE3WidgetFontSide(lblSelectAdvancedModeOptions, 12)
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

lblSelectContextMenuOptions:SetText("\n" .. L["lblSelectContextMenuOptions"])
CTT_setACE3WidgetFontSide(lblSelectContextMenuOptions, 12)
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

    chkContextMenuShowGarrison:SetValue(ChromieTimeTrackerDB.ContextMenuShowGarrison)
    chkContextMenuShowClassHall:SetValue(ChromieTimeTrackerDB.ContextMenuShowClassHall)
    chkContextMenuShowWarEffort:SetValue(ChromieTimeTrackerDB.ContextMenuShowWarEffort)
    chkContextMenuShowCovenant:SetValue(ChromieTimeTrackerDB.ContextMenuShowCovenant)
    chkContextMenuShowDragonIsles:SetValue(ChromieTimeTrackerDB.ContextMenuShowDragonIsles)
    chkContextMenuShowKhazAlgar:SetValue(ChromieTimeTrackerDB.ContextMenuShowKhazAlgar)
    chkContextMenuShowUnlockedOnly:SetValue(ChromieTimeTrackerDB.ContextMenuShowUnlockedOnly)
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
local LabelCompactMode = AceGUI:Create("Label")
local LabelStandardMode = AceGUI:Create("Label")
local LabelAlternateMode = AceGUI:Create("Label")
local LabelAdvancedMode = AceGUI:Create("Label")
local CheckBox = AceGUI:Create("CheckBox")
local chkLockDragDrop = AceGUI:Create("CheckBox")
local ddlDefaultMiddleClickOption = AceGUI:Create("Dropdown")
local LabelMiddleClick = AceGUI:Create("Label")
local chkLockMiddleClickOption = AceGUI:Create("CheckBox")
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

LabelCompactMode:SetText("\n|cFFD6AE12" .. L["CompactMode"] .. ":|r " .. L["CompactModeDescription"])
LabelCompactMode:SetWidth(700)
scrollFrameMainSettings:AddChild(LabelCompactMode)

LabelStandardMode:SetText("|cFFD6AE12" .. L["StandardMode"] .. ":|r " .. L["StandardModeDescription"])
LabelStandardMode:SetWidth(700)
scrollFrameMainSettings:AddChild(LabelStandardMode)


LabelAlternateMode:SetText("|cFFD6AE12" .. L["AlternateMode"] .. ":|r " .. L["AlternateModeDescription"])
LabelAlternateMode:SetWidth(590)
scrollFrameMainSettings:AddChild(LabelAlternateMode)

LabelAdvancedMode:SetText("|cFFD6AE12" .. L["AdvancedMode"] .. ":|r " .. L["AdvancedModeDescription"])
LabelAdvancedMode:SetWidth(590)
scrollFrameMainSettings:AddChild(LabelAdvancedMode)


heading1:SetRelativeWidth(1)
scrollFrameMainSettings:AddChild(heading1)


CheckBox:SetLabel(L["HideWhenNotTimeTraveling"])
CheckBox:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.HideWhenNotTimeTraveling = CheckBox:GetValue()
    CTT_updateChromieTime()
    CTT_showMainFrame()
end)
CheckBox:SetWidth(700)
scrollFrameMainSettings:AddChild(CheckBox)


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


LabelMiddleClick:SetText(L["MiddleClickOptionDescription"])
LabelMiddleClick:SetWidth(700)
scrollFrameMainSettings:AddChild(LabelMiddleClick)


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
    CheckBox:SetValue(ChromieTimeTrackerDB.HideWhenNotTimeTraveling)
    chkLockDragDrop:SetValue(ChromieTimeTrackerDB.LockDragDrop)
    --chkAlternateModeShowIconOnly:SetValue(ChromieTimeTrackerDB.AlternateModeShowIconOnly)
    ddlDefaultMiddleClickOption:SetValue(ChromieTimeTrackerDB.DefaultMiddleClickOption)
    chkLockMiddleClickOption:SetValue(ChromieTimeTrackerDB.LockMiddleClickOption)
    chkHideDeveloperCreditOnTooltips:SetValue(ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips)

StaticPopupDialogs["POPUP_DIALOG_CONFIRM_RESET_SETTINGS"] = {
    text = L["Dialog_ResetSettings_Message"],
    button1 = L["Dialog_Yes"],
    button2 = L["Dialog_No"],
    OnAccept = function()
        ChromieTimeTrackerDB.Mode = 2;
        ChromieTimeTrackerDB.HideWhenNotTimeTraveling = false;
        ChromieTimeTrackerDB.LockDragDrop = false;
        ChromieTimeTrackerDB.AlternateModeShowIconOnly = false;
        ChromieTimeTrackerDB.DefaultMiddleClickOption = "";
        ChromieTimeTrackerDB.LockMiddleClickOption = false;
        ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips = false;
        
        ChromieTimeTrackerDB.AdvShowGarrison = true;
        ChromieTimeTrackerDB.AdvShowClassHall = true;
        ChromieTimeTrackerDB.AdvShowWarEffort = true;
        ChromieTimeTrackerDB.AdvShowCovenant = true;
        ChromieTimeTrackerDB.AdvShowDragonIsles = true;
        ChromieTimeTrackerDB.AdvShowKhazAlgar = true;
        ChromieTimeTrackerDB.AdvShowUnlockedOnly = false;
        ChromieTimeTrackerDB.AdvButtonsAlignment = "CENTER";

        ChromieTimeTrackerDB.ContextMenuShowGarrison = true;
        ChromieTimeTrackerDB.ContextMenuShowClassHall = true;
        ChromieTimeTrackerDB.ContextMenuShowWarEffort = true;
        ChromieTimeTrackerDB.ContextMenuShowCovenant = true;
        ChromieTimeTrackerDB.ContextMenuShowDragonIsles = true;
        ChromieTimeTrackerDB.ContextMenuShowKhazAlgar = true;
        ChromieTimeTrackerDB.ContextMenuShowUnlockedOnly = false;

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
    CheckBox:SetValue(ChromieTimeTrackerDB.HideWhenNotTimeTraveling)
    chkLockDragDrop:SetValue(ChromieTimeTrackerDB.LockDragDrop)
    --chkAlternateModeShowIconOnly:SetValue(ChromieTimeTrackerDB.AlternateModeShowIconOnly)
    ddlDefaultMiddleClickOption:SetValue(ChromieTimeTrackerDB.DefaultMiddleClickOption)
    chkLockMiddleClickOption:SetValue(ChromieTimeTrackerDB.LockMiddleClickOption)
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
        text = "Menu de Contexto",
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
        value = "Cur",
        text = L["Settings_Menu_Currency"],
        icon = "Interface\\Icons\\inv_misc_gear_01",
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
        CTT_LoadCurrencyMenuSettings()
    else
        print(group)
    end
end)

settingsFrame:Hide()

treeW:SelectByValue("S")

CTT_LoadAbout()

function loadSettings()
    dropdown:SetValue(ChromieTimeTrackerDB.Mode)
    CheckBox:SetValue(ChromieTimeTrackerDB.HideWhenNotTimeTraveling)
    chkLockDragDrop:SetValue(ChromieTimeTrackerDB.LockDragDrop)
    --chkAlternateModeShowIconOnly:SetValue(ChromieTimeTrackerDB.AlternateModeShowIconOnly)
    ddlDefaultMiddleClickOption:SetValue(ChromieTimeTrackerDB.DefaultMiddleClickOption)
    chkLockMiddleClickOption:SetValue(ChromieTimeTrackerDB.LockMiddleClickOption)
    chkHideDeveloperCreditOnTooltips:SetValue(ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips)
end

function ChromieTimeTracker:ToggleSettingsFrame()
    if not settingsFrame:IsShown() then
        --loadSettings()
        settingsFrame:Show()
    else
        settingsFrame:Hide()
    end
end