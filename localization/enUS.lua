--Translator Thiago Franco
--if GetLocale() ~= "enUS" then return end
local _, mct = ...
mct.L = {}
local L = mct.L

L["AddonName"] = "Chromie Time Tracker"
L["DevelopmentTeamCredit"] = "Developed by |cFFFFFFFFThiago Franco (|cFFFF7C0ATopolino|r-Nemesis [|cFF00AA00Brazil|r]).|r"
L["LClickAction"] = "Left-click: |cFFFFFFFFToggle Timeline box.|r"
L["LClickAction_Alternate"] = "Left-Click: |cFFFFFFFFMove Alternate Mode icon.|r"
L["MClickAction"] = "Middle-Click: |cFFFFFFFFShow Follower activity summary.|r"
L["MClickAction_Warlords"] = "Middle-Click: |cFFFFFFFFShow Garrison summary.|r"
L["MClickAction_Legion"] = "Middle-Click: |cFFFFFFFFShow Order Hall summary.|r"
L["MClickAction_Missions"] = "Middle-Click: |cFFFFFFFFShow Follower Missions summary.|r"
L["MClickAction_Covenant"] = "Middle-Click: |cFFFFFFFFShow Covenant Sanctum summary.|r"
L["MClickAction_DragonIsles"] = "Middle-Click: |cFFFFFFFFShow The Dragon Isles summary.|r"
L["MClickAction_KhazAlgar"] = "Middle-Click: |cFFFFFFFFShow Khaz Algar summary.|r"
L["RClickAction"] = "Right-click: |cFFFFFFFFShortcuts and Settings.|r"
L["ChatAddonLoadedMessage"] = "Chromie Time Tracker successfully loaded! Your timeline: "
L["Timeline"] = "Timeline: "
L["Settings"] = "Settings"
L["lblModeSelect"] = "Mode Select: "
L["CompactMode"] = "Compact Mode"
L["CompactModeDescription"] = "Show the timeline in a small box without label."
L["StandardMode"] = "Standard Mode"
L["StandardModeDescription"] = "Show the timeline in a medium box with label."
L["AlternateMode"] = "Alternate Mode"
L["AlternateModeDescription"] = "Recommended using after not being able to time travel anymore (level 70+). Replace the timeline text with the related summary window name."
L["AdvancedMode"] = "Advanced Mode"
L["AdvancedModeDescription"] = "Show the timeline and a bunch of extra features."
L["HideWhenNotTimeTraveling"] = "Hide timeline window when not using Chromie Time Travel."
L["LockDragDrop"] = "Lock window."
L["AlternateMode_ShowIconOnly"] = "Show only an icon when using Alternate Mode."
L["lblDefaultMiddleClickOption"] = "Middle-click default option:"
L["MiddleClickOptionDescription"] = "\n|cFFD6AE12Choose which option will be activated as default when not time travelling.\n\n"
L["LockMiddleClickOption"] = "Lock selected middle-click option to all timlines."
L["MiddleClickOption_Warlords"] = "Garrison  - |cFFA1481DWarlords of Draenor|r"
L["MiddleClickOption_Legion"] = "Class Hall - |cFF00FF00Legion|r"
L["MiddleClickOption_Missions"] = "Follower Missions - |cFF056AC4Battle for Azeroth|r"
L["MiddleClickOption_Covenant"] = "Covenant Sanctum %s |cFF888888Shadowlands|r"
L["MiddleClickOption_DragonIsles"] = "Dragon Isles Summary - |cFFC90A67Dragonflight|r"
L["MiddleClickOption_KhazAlgar"] = "Khaz Algar Summary - |cFFFF7F27The War Within|r"
L["UndiscoveredContent"]  = "This content is not yet unlocked.\n"
L["UndiscoveredContent_Warlords"] = "|cFFA1481DWarlords of Draenor Garrison|r"
L["UndiscoveredContent_Legion"] = "|cFF00FF00Legion Class Hall|r"
L["UndiscoveredContent_Missions"] = "|cFF056AC4Battle for Azeroth Follower Missions|r"
L["UndiscoveredContent_Covenant"] = "|cFF888888Shadowlands Covenant Sanctum|r"
L["UndiscoveredContent_DragonIsles"] = "|cFFC90A67The Dragon Isles|r"
L["UndiscoveredContent_KhazAlgar"] = "|cFFFF7F27Khaz Algar|r"
L["UndiscoveredContentUnlockRequirement_Warlords"] = "\n|cFFFFC90EComplete Mission: Delegating on Draenor.|r"
L["UndiscoveredContentUnlockRequirement_Legion"] = "\n|cFFFFC90EComplete Mission: Rise, Champions.|r"
L["UndiscoveredContentUnlockRequirement_Missions"] = "\n|cFFFFC90EComplete Mission: War of Shadows.|r"
L["UndiscoveredContentUnlockRequirement_Covenant"] = "\n|cFFFFC90EComplete Mission: Choosing Your Purpose.|r"
L["UndiscoveredContentUnlockRequirement_DragonIsles"] = "\n|cFFFFC90ETravel to The Dragon Isles.|r"
L["UndiscoveredContentUnlockRequirement_KhazAlgar"] = "\n|cFFFFC90ETravel to Khaz Algar.|r"
L["ConfigurationMissing"]  = "No default window selected.\n"
L["buttonSave"] = "Save"
L["currentExpansionLabel"] = "Not Time Travelling"
L["SlashCommands"] = "Chat Command List:\n\n|cFFFFC90E/ChromieTimeTracker:|r toggle timeline wndows.\n|cFFFFC90E/ctt:|r toggle timeline windows.\n|cFFFFC90E/ctt config:|r open settings window.\n|cFFFFC90E/Ectt resetPosition:|r reset the addon position to screen center if accidentaly dragged offscreen.\n|cFFFFC90E/ctt resetSettings:|r reset the addon settings to default.\n|cFFFFC90E/ctt resetAll:|r reset the addon position to screen center and settings to default (resetSettings and ResetPosition commands).\n"
L["RunCommandMessage_ResetPosition"] = "Chromie Time Tracker  window and icon location reset."
L["RunCommandMessage_ResetSettings"] = "Chromie Time Tracker settings reset."
L["RunCommandMessage_ResetAll"] = "Chromie Time Tracker position and settings reset."
L["HideDeveloperCreditOnTooltips"] = "Hide developer info on tooltips."
L["buttonResetPosition"] = "Reset Position"
L["buttonResetSettings"] = "Reset Settings"
L["lblCreditColabList"] = "|cFFFFC90EDeveloper:|r\nThiago Franco (Topolino)\n\n|cFFFFC90ELocalization:|r\nBrazilian Portuguese (ptBR) - Thiago Franco (Topolino)\nEnglish (enUS) - Thiago Franco (Topolino)\nRussian (ruRU) - ZamestoTV (Hubbotu)"
L["About_Title"] = "Easily track your current Timewalking Campaign (Chromie Time)."
L["About_Version"] = "2.0.0"
L["About_Line1"] = "Continue using the addon, even when you can no longer enter timewalking campaigns, with the following features:"
L["About_Line2"] = "Access to summaries and reports for the following areas:\n- Khaz Algar from The War Within.\n- The Dragon Isles from Dragonflight.\n- Covenant Sanctum from Shadowlands.\n- Follower Missions from Battle for Azeroth.\n- Class Hall from Legion.\n- Garrison from Warlords of Draenor.\n\n- Remember your Shadowlands Covenant Sanctum choice."
L["About_Line3"] = "The language definition is made based on the selected World of Warcraft language, but not all languages ​​have available translations. Unavailable languages ​​use English as a backup.\n\nIf there is no translation in your language and you would like to voluntarily contribute to the project by translating it, or if you have a suggestion for improvement or correction of localization, please contact us."
L["lblSelectAdvancedModeOptions"] = "Choose which buttons are visible on advanced mode:"
L["lblSelectContextMenuOptions"] = "Choose which buttons are visible in the context menu:"
L["ContextMenuTitle"] = "Open Report"
L["ddlButtonAlignment"] = "Button Alignment"
L["ddlButtonPosition"] = "Button Position"
L["alignLeft"] = "Left"
L["alignCenter"] = "Middle"
L["alignRight"] = "Right"
L["positionAbove"] = "Above"
L["positionBelow"] = "Below"
L["EvokerHasNoClassHall"]  = "The Evoker class doesn't have a Class Hall.\n"
L["Settings_Menu_About"] = "About"
L["Settings_Menu_General"] = "General"
L["Settings_Menu_Advanced"] = "Advanced Mode"
L["Settings_Menu_Alternate"] = "Alternate Mode"
L["Settings_Menu_Currency"] = "Currency and Resources"
L["Settings_Menu_Credit"] = "Credits"
L["Dialog_Yes"] = "Yes" 
L["Dialog_No"] = "No"
L["Dialog_ResetPosition_Message"] = "Addon windows will be reset to the center of the screen. Are you sure?"
L["Dialog_ResetSettings_Message"] = "Addon settings will be reset to default. Are you sure?"
L["chkAdvShowUnlockedOnly"] = "Show only unlocked content"
L["chkAdvHideTimelineBox"] = "Hide timeline box"
L["chkShowCurrencyOnReportWindow"] = "Show resources on report window"