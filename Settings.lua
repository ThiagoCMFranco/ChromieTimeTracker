local name, mct = ...
local L = mct.L 

local C_LanguageContributors = {}

local modes = {L["CompactMode"], L["StandardMode"], L["AlternateMode"], L["AdvancedMode"]}
local buttonAlignments = {L["alignLeft"],L["alignCenter"],L["alignRight"]}
local MiddleClickOptions = {L["MiddleClickOption_Warlords"], L["MiddleClickOption_Legion"],L["MiddleClickOption_Missions"],L["MiddleClickOption_Covenant"],L["MiddleClickOption_DragonIsles"],L["MiddleClickOption_KhazAlgar"]}

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
    local LabelCredits = AceGUI:Create("Label")
    LabelCredits:SetText(L["lblCreditColabList"])
    --LabelCredits:SetFont(font, 13, style)
    CTT_setACE3WidgetFontSide(LabelCredits, 13)
    LabelCredits:SetWidth(580)
    treeW:AddChild(LabelCredits)

end

function CTT_LoadAbout()
    treeW:ReleaseChildren()

    local LabelAbout_Title = AceGUI:Create("Label")
    LabelAbout_Title:SetText("|cFFFFC90E" .. L["AddonName"] .. "|r")
    --LabelAbout_Title:SetFont(font, 20, style)
    CTT_setACE3WidgetFontSide(LabelAbout_Title, 20)
    LabelAbout_Title:SetWidth(580)
    treeW:AddChild(LabelAbout_Title)

    local LabelAbout = AceGUI:Create("Label")
    LabelAbout:SetText("|cFFFFC90E" .. L["About_Version"] .. "|r\n\n" .. L["About_Title"] .. "\n\n" .. L["About_Line1"] .. "\n\n" .. L["About_Line2"] .. "\n\n" .. L["About_Line3"])
    --LabelAbout:SetFont(font, 13, style)
    CTT_setACE3WidgetFontSide(LabelAbout, 13)
    LabelAbout:SetWidth(560)
    treeW:AddChild(LabelAbout)
    
    local headingAbout1 = AceGUI:Create("Heading")
    headingAbout1:SetRelativeWidth(1)
    treeW:AddChild(headingAbout1)
end

function CTT_LoadAdvancedModeSettings()
    treeW:ReleaseChildren()

--Advanced Mode Options
local ddlButtonAlignment = AceGUI:Create("Dropdown")
local lblSelectAdvancedModeOptions = AceGUI:Create("Label")
local chkAdvShowGarrison = AceGUI:Create("CheckBox")
local chkAdvShowClassHall = AceGUI:Create("CheckBox")
local chkAdvShowWarEffort = AceGUI:Create("CheckBox")
local chkAdvShowCovenant = AceGUI:Create("CheckBox")
local chkAdvShowDragonIsles = AceGUI:Create("CheckBox")
local chkAdvShowKhazAlgar = AceGUI:Create("CheckBox")
local chkAdvShowUnlockedOnly = AceGUI:Create("CheckBox")
local heading5 = AceGUI:Create("Heading")

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
treeW:AddChild(ddlButtonAlignment)

lblSelectAdvancedModeOptions:SetText("\n" .. L["lblSelectAdvancedModeOptions"])
CTT_setACE3WidgetFontSide(lblSelectAdvancedModeOptions, 12)
lblSelectAdvancedModeOptions:SetWidth(580)
treeW:AddChild(lblSelectAdvancedModeOptions)
    
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
    treeW:AddChild(chkAdvShowGarrison)

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
    treeW:AddChild(chkAdvShowClassHall)

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
    treeW:AddChild(chkAdvShowWarEffort)

    chkAdvShowCovenant:SetLabel(L["MiddleClickOption_Covenant"])
    chkAdvShowCovenant:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.AdvShowCovenant = chkAdvShowCovenant:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkAdvShowCovenant:SetWidth(700)
    treeW:AddChild(chkAdvShowCovenant)

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
    treeW:AddChild(chkAdvShowDragonIsles)

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
    treeW:AddChild(chkAdvShowKhazAlgar)

    heading5:SetRelativeWidth(1)
    treeW:AddChild(heading5)

    chkAdvShowUnlockedOnly:SetLabel("Exibir somente ícones de áreas desbloqueadas")
    chkAdvShowUnlockedOnly:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.AdvShowUnlockedOnly = chkAdvShowUnlockedOnly:GetValue()
        CTT_updateChromieTime()
        CTT_showMainFrame()
        if (ChromieTimeTrackerDB.Mode == 4) then
            CTT_LoadAvancedModeIcons()
        end
    end)
    chkAdvShowUnlockedOnly:SetWidth(700)
    treeW:AddChild(chkAdvShowUnlockedOnly)

    ddlButtonAlignment:SetValue(ChromieTimeTrackerDB.AdvButtonsAlignment)
    chkAdvShowGarrison:SetValue(ChromieTimeTrackerDB.AdvShowGarrison)
    chkAdvShowClassHall:SetValue(ChromieTimeTrackerDB.AdvShowClassHall)
    chkAdvShowWarEffort:SetValue(ChromieTimeTrackerDB.AdvShowWarEffort)
    chkAdvShowCovenant:SetValue(ChromieTimeTrackerDB.AdvShowCovenant)
    chkAdvShowDragonIsles:SetValue(ChromieTimeTrackerDB.AdvShowDragonIsles)
    chkAdvShowKhazAlgar:SetValue(ChromieTimeTrackerDB.AdvShowKhazAlgar)
    chkAdvShowUnlockedOnly:SetValue(ChromieTimeTrackerDB.AdvShowUnlockedOnly)
end

function CTT_LoadSettings()

treeW:ReleaseChildren()

--Geral
local dropdown = AceGUI:Create("Dropdown")
local LabelCompactMode = AceGUI:Create("Label")
local LabelStandardMode = AceGUI:Create("Label")
local LabelAlternateMode = AceGUI:Create("Label")
local LabelAdvancedMode = AceGUI:Create("Label")
local CheckBox = AceGUI:Create("CheckBox")
local chkAlternateModeShowIconOnly = AceGUI:Create("CheckBox")
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
treeW:AddChild(dropdown)

LabelCompactMode:SetText("\n|cFFD6AE12" .. L["CompactMode"] .. ":|r " .. L["CompactModeDescription"])
LabelCompactMode:SetWidth(700)
treeW:AddChild(LabelCompactMode)

LabelStandardMode:SetText("|cFFD6AE12" .. L["StandardMode"] .. ":|r " .. L["StandardModeDescription"])
LabelStandardMode:SetWidth(700)
treeW:AddChild(LabelStandardMode)


LabelAlternateMode:SetText("|cFFD6AE12" .. L["AlternateMode"] .. ":|r " .. L["AlternateModeDescription"])
LabelAlternateMode:SetWidth(590)
treeW:AddChild(LabelAlternateMode)

LabelAdvancedMode:SetText("|cFFD6AE12" .. L["AdvancedMode"] .. ":|r " .. L["AdvancedModeDescription"])
LabelAdvancedMode:SetWidth(590)
treeW:AddChild(LabelAdvancedMode)


heading1:SetRelativeWidth(1)
treeW:AddChild(heading1)


CheckBox:SetLabel(L["HideWhenNotTimeTraveling"])
CheckBox:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.HideWhenNotTimeTraveling = CheckBox:GetValue()
    CTT_updateChromieTime()
    CTT_showMainFrame()
end)
CheckBox:SetWidth(700)
treeW:AddChild(CheckBox)


chkAlternateModeShowIconOnly:SetLabel(L["AlternateMode_ShowIconOnly"])
chkAlternateModeShowIconOnly:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.AlternateModeShowIconOnly = chkAlternateModeShowIconOnly:GetValue()
    CTT_updateChromieTime()
    CTT_showMainFrame()
end)
chkAlternateModeShowIconOnly:SetWidth(700)
treeW:AddChild(chkAlternateModeShowIconOnly)


chkLockDragDrop:SetLabel(L["LockDragDrop"])
chkLockDragDrop:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.LockDragDrop = chkLockDragDrop:GetValue()
    CTT_updateChromieTime()
    CTT_showMainFrame()
end)
chkLockDragDrop:SetWidth(700)
treeW:AddChild(chkLockDragDrop)

heading2:SetRelativeWidth(1)
treeW:AddChild(heading2)

ddlDefaultMiddleClickOption:SetList(MiddleClickOptions)
ddlDefaultMiddleClickOption:SetLabel(L["lblDefaultMiddleClickOption"])
ddlDefaultMiddleClickOption:SetWidth(280)
ddlDefaultMiddleClickOption:SetCallback("OnValueChanged", function(widget, event, text)
    textStore = text 
    ChromieTimeTrackerDB.DefaultMiddleClickOption = ddlDefaultMiddleClickOption.value
    CTT_updateChromieTime()
    CTT_showMainFrame()
end)
treeW:AddChild(ddlDefaultMiddleClickOption)


LabelMiddleClick:SetText(L["MiddleClickOptionDescription"])
LabelMiddleClick:SetWidth(700)
treeW:AddChild(LabelMiddleClick)


chkLockMiddleClickOption:SetLabel(L["LockMiddleClickOption"])
chkLockMiddleClickOption:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.LockMiddleClickOption = chkLockMiddleClickOption:GetValue()
    CTT_updateChromieTime()
    CTT_showMainFrame()
end)
chkLockMiddleClickOption:SetWidth(700)
treeW:AddChild(chkLockMiddleClickOption)

heading3:SetRelativeWidth(1)
treeW:AddChild(heading3)

chkHideDeveloperCreditOnTooltips:SetLabel(L["HideDeveloperCreditOnTooltips"])
chkHideDeveloperCreditOnTooltips:SetCallback("OnValueChanged", function(widget, event, text) 
    ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips = chkHideDeveloperCreditOnTooltips:GetValue()
    CTT_updateChromieTime()
    CTT_showMainFrame()
 end)
chkHideDeveloperCreditOnTooltips:SetWidth(700)
treeW:AddChild(chkHideDeveloperCreditOnTooltips)

--
--btnSave:SetText(L["buttonSave"])
--btnSave:SetWidth(100)
--btnSave:SetCallback("OnClick", function() 
--    
--    ChromieTimeTrackerDB.Mode = dropdown.value;
--    ChromieTimeTrackerDB.HideWhenNotTimeTraveling = CheckBox:GetValue();
--    ChromieTimeTrackerDB.LockDragDrop = chkLockDragDrop:GetValue();
--    ChromieTimeTrackerDB.AlternateModeShowIconOnly = chkAlternateModeShowIconOnly:GetValue();
--    ChromieTimeTrackerDB.DefaultMiddleClickOption = ddlDefaultMiddleClickOption.value;
--    ChromieTimeTrackerDB.LockMiddleClickOption = chkLockMiddleClickOption:GetValue();
--    ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips = chkHideDeveloperCreditOnTooltips:GetValue();
--    CTT_updateChromieTime();
--    CTT_showMainFrame()
--    
--    ; end)
--treeW:AddChild(btnSave)

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
treeW:AddChild(btnResetPosition)

    dropdown:SetValue(ChromieTimeTrackerDB.Mode)
    CheckBox:SetValue(ChromieTimeTrackerDB.HideWhenNotTimeTraveling)
    chkLockDragDrop:SetValue(ChromieTimeTrackerDB.LockDragDrop)
    chkAlternateModeShowIconOnly:SetValue(ChromieTimeTrackerDB.AlternateModeShowIconOnly)
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
        --ChromieTimeTrackerDB.UseDiferentCoordinatesForIconAndTextBox = false;
        ChromieTimeTrackerDB.AdvShowGarrison = true;
        ChromieTimeTrackerDB.AdvShowClassHall = true;
        ChromieTimeTrackerDB.AdvShowWarEffort = true;
        ChromieTimeTrackerDB.AdvShowCovenant = true;
        ChromieTimeTrackerDB.AdvShowDragonIsles = true;
        ChromieTimeTrackerDB.AdvShowKhazAlgar = true;
        ChromieTimeTrackerDB.AdvShowUnlockedOnly = false;
        ChromieTimeTrackerDB.AdvButtonsAlignment = "CENTER";
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
treeW:AddChild(btnResetSettings)

    dropdown:SetValue(ChromieTimeTrackerDB.Mode)
    CheckBox:SetValue(ChromieTimeTrackerDB.HideWhenNotTimeTraveling)
    chkLockDragDrop:SetValue(ChromieTimeTrackerDB.LockDragDrop)
    chkAlternateModeShowIconOnly:SetValue(ChromieTimeTrackerDB.AlternateModeShowIconOnly)
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
      children = {
        {
        value = "Adv",
        text = L["Settings_Menu_General_Advanced"],
        --icon = "Interface\\Icons\\inv_misc_gear_01",
        }
      },
    },
    --{ 
    --    value = "Controls",
    --    text = "Controles",
    --    icon = "Interface\\Icons\\inv_misc_gear_01",
    --},
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
    
    if group == "G" then
        CTT_LoadSettings()
    elseif group == "C" then
        CTT_LoadCredits()
    elseif group == "S" then
        CTT_LoadAbout()
    elseif string.find(group, "Adv") then
        CTT_LoadAdvancedModeSettings()
    else
        print(group)
    end
end)

settingsFrame:Hide()

treeW:SelectByValue("S")

CTT_LoadAbout()

function saveData()
    --ChromieTimeTrackerDB.Mode = dropdown.value;
    --ChromieTimeTrackerDB.HideWhenNotTimeTraveling = CheckBox:GetValue();
    --ChromieTimeTrackerDB.LockDragDrop = chkLockDragDrop:GetValue();
    --ChromieTimeTrackerDB.AlternateModeShowIconOnly = chkAlternateModeShowIconOnly:GetValue();
    --ChromieTimeTrackerDB.DefaultMiddleClickOption = ddlDefaultMiddleClickOption.value;
    --ChromieTimeTrackerDB.LockMiddleClickOption = chkLockMiddleClickOption:GetValue();
    --ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips = chkHideDeveloperCreditOnTooltips:GetValue();    
    --CTT_updateChromieTime();
    --CTT_showMainFrame()
end

function loadSettings()
    dropdown:SetValue(ChromieTimeTrackerDB.Mode)
    CheckBox:SetValue(ChromieTimeTrackerDB.HideWhenNotTimeTraveling)
    chkLockDragDrop:SetValue(ChromieTimeTrackerDB.LockDragDrop)
    chkAlternateModeShowIconOnly:SetValue(ChromieTimeTrackerDB.AlternateModeShowIconOnly)
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