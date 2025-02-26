local name, mct = ...
local L = mct.L 

local modes = {L["CompactMode"], L["StandardMode"], L["AlternateMode"]}
local MiddleClickOptions = {L["MiddleClickOption_Warlords"], L["MiddleClickOption_Legion"],L["MiddleClickOption_Missions"],L["MiddleClickOption_Covenant"],L["MiddleClickOption_DragonIsles"],L["MiddleClickOption_KhazAlgar"]}

local AceGUI = LibStub("AceGUI-3.0")

-- Create a container frame
settingsFrame = AceGUI:Create("Frame")
settingsFrame:SetCallback("OnClose",function(widget)  end)
settingsFrame:SetTitle(L["AddonName"] .. " - " .. L["Settings"])
settingsFrame:SetStatusText(L["DevelopmentTeamCredit"])
settingsFrame:SetWidth(620)
settingsFrame:SetHeight(400)
settingsFrame:SetLayout("Flow")

local dropdown = AceGUI:Create("Dropdown")
dropdown:SetList(modes)
dropdown:SetLabel(L["lblModeSelect"])
dropdown:SetWidth(200)
dropdown:SetCallback("OnValueChanged", function(widget, event, text) textStore = text end)
settingsFrame:AddChild(dropdown)

local LabelCompactMode = AceGUI:Create("Label")
LabelCompactMode:SetText("\n|cFFD6AE12" .. L["CompactMode"] .. ":|r " .. L["CompactModeDescription"])
LabelCompactMode:SetWidth(700)
settingsFrame:AddChild(LabelCompactMode)

local LabelStandardMode = AceGUI:Create("Label")
LabelStandardMode:SetText("|cFFD6AE12" .. L["StandardMode"] .. ":|r " .. L["StandardModeDescription"])
LabelStandardMode:SetWidth(700)
settingsFrame:AddChild(LabelStandardMode)

local LabelAlternateMode = AceGUI:Create("Label")
LabelAlternateMode:SetText("|cFFD6AE12" .. L["AlternateMode"] .. ":|r " .. L["AlternateModeDescription"])
LabelAlternateMode:SetWidth(590)
settingsFrame:AddChild(LabelAlternateMode)

local CheckBox = AceGUI:Create("CheckBox")
CheckBox:SetLabel(L["HideWhenNotTimeTraveling"])
CheckBox:SetCallback("OnValueChanged", function(widget, event, text)  end)
CheckBox:SetWidth(700)
settingsFrame:AddChild(CheckBox)

local chkAlternateModeShowIconOnly = AceGUI:Create("CheckBox")
chkAlternateModeShowIconOnly:SetLabel(L["AlternateMode_ShowIconOnly"])
chkAlternateModeShowIconOnly:SetCallback("OnValueChanged", function(widget, event, text)  end)
chkAlternateModeShowIconOnly:SetWidth(700)
settingsFrame:AddChild(chkAlternateModeShowIconOnly)

local chkLockDragDrop = AceGUI:Create("CheckBox")
chkLockDragDrop:SetLabel(L["LockDragDrop"])
chkLockDragDrop:SetCallback("OnValueChanged", function(widget, event, text)  end)
chkLockDragDrop:SetWidth(700)
settingsFrame:AddChild(chkLockDragDrop)

local ddlDefaultMiddleClickOption = AceGUI:Create("Dropdown")
ddlDefaultMiddleClickOption:SetList(MiddleClickOptions)
ddlDefaultMiddleClickOption:SetLabel(L["lblDefaultMiddleClickOption"])
ddlDefaultMiddleClickOption:SetWidth(280)
ddlDefaultMiddleClickOption:SetCallback("OnValueChanged", function(widget, event, text) textStore = text end)
settingsFrame:AddChild(ddlDefaultMiddleClickOption)

local LabelMiddleClick = AceGUI:Create("Label")
LabelMiddleClick:SetText(L["MiddleClickOptionDescription"])
LabelMiddleClick:SetWidth(700)
settingsFrame:AddChild(LabelMiddleClick)

local chkLockMiddleClickOption = AceGUI:Create("CheckBox")
chkLockMiddleClickOption:SetLabel(L["LockMiddleClickOption"])
chkLockMiddleClickOption:SetCallback("OnValueChanged", function(widget, event, text)  end)
chkLockMiddleClickOption:SetWidth(700)
settingsFrame:AddChild(chkLockMiddleClickOption)

local btnSave = AceGUI:Create("Button")
btnSave:SetText(L["buttonSave"])
btnSave:SetWidth(200)
btnSave:SetCallback("OnClick", function() saveData(); end)
settingsFrame:AddChild(btnSave)

settingsFrame:Hide()

function saveData()
    ChromieTimeTrackerDB.Mode = dropdown.value;
    ChromieTimeTrackerDB.HideWhenNotTimeTraveling = CheckBox:GetValue();
    ChromieTimeTrackerDB.LockDragDrop = chkLockDragDrop:GetValue();
    ChromieTimeTrackerDB.AlternateModeShowIconOnly = chkAlternateModeShowIconOnly:GetValue();
    ChromieTimeTrackerDB.DefaultMiddleClickOption = ddlDefaultMiddleClickOption.value;
    ChromieTimeTrackerDB.LockMiddleClickOption = chkLockMiddleClickOption:GetValue();
    CTT_updateChromieTime();
    CTT_showMainFrame()
end

function loadSettings()
    dropdown:SetValue(ChromieTimeTrackerDB.Mode)
    CheckBox:SetValue(ChromieTimeTrackerDB.HideWhenNotTimeTraveling)
    chkLockDragDrop:SetValue(ChromieTimeTrackerDB.LockDragDrop)
    chkAlternateModeShowIconOnly:SetValue(ChromieTimeTrackerDB.AlternateModeShowIconOnly)
    ddlDefaultMiddleClickOption:SetValue(ChromieTimeTrackerDB.DefaultMiddleClickOption)
    chkLockMiddleClickOption:SetValue(ChromieTimeTrackerDB.LockMiddleClickOption)
end

function ChromieTimeTracker:ToggleSettingsFrame()
    if not settingsFrame:IsShown() then
        loadSettings()
        settingsFrame:Show()
    else
        settingsFrame:Hide()
    end
end
