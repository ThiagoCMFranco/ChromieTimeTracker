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

--Load constants from Data.lua
local C_ExpansionColors = mct.C_ExpansionColors
local C_ExpansionGarrisonID = mct.C_ExpansionGarrisonID
local C_ExpansionGarrisonMiddleClickOptions = mct.C_ExpansionGarrisonMiddleClickOptions
local C_ExpansionSummaries = mct.C_ExpansionSummaries
local C_ClassTextures = mct.C_ClassTextures
local C_GarrisonTextures = mct.C_GarrisonTextures
local C_WarCampaignTextures = mct.C_WarCampaignTextures
local C_CovenantChoicesTextures = mct.C_CovenantChoicesTextures
local C_LandingPagesTextures = mct.C_LandingPagesTextures
local C_ClassTabTextures = mct.C_ClassTabTextures
local C_GarrisonTabTextures = mct.C_GarrisonTabTextures
local C_WarCampaignTabTextures = mct.C_WarCampaignTabTextures
local C_CovenantChoicesTabTextures = mct.C_CovenantChoicesTabTextures
local C_ButtonFrames = mct.C_ButtonFrames
local C_CurrencyId = mct.C_CurrencyId


local playerClass, englishClass = UnitClass("player")
englishFaction, localizedFaction = UnitFactionGroup("player")

local PlayerInfo = {}
PlayerInfo["Name"] = ""
PlayerInfo["Class"] = englishClass
PlayerInfo["Faction"] = englishFaction
PlayerInfo["Timeline"] = ""

CurrentGarrisonID = 0

local isGarrisonUIFirstLoad = true

local isUnlocked = {}

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

        --Set initial values for all settings
        ChromieTimeTrackerDB.Mode = 2;
        ChromieTimeTrackerDB.HideWhenNotTimeTraveling = false;
        ChromieTimeTrackerDB.LockDragDrop = false;
        ChromieTimeTrackerDB.ToastVisibility = 1;
        ChromieTimeTrackerDB.AlternateModeShowIconOnly = false;
        ChromieTimeTrackerDB.DefaultMiddleClickOption = "";
        ChromieTimeTrackerDB.LockMiddleClickOption = false;
        ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips = false;
        ChromieTimeTrackerDB.UseDiferentCoordinatesForIconAndTextBox = false;

        --Set initial values for Avanced Mode settings
        ChromieTimeTrackerDB.AdvShowGarrison = true;
        ChromieTimeTrackerDB.AdvShowClassHall = true;
        ChromieTimeTrackerDB.AdvShowWarEffort = true;
        ChromieTimeTrackerDB.AdvShowCovenant = true;
        ChromieTimeTrackerDB.AdvShowDragonIsles = true;
        ChromieTimeTrackerDB.AdvShowKhazAlgar = true;

        --Set initial values for Context Menu settings
        ChromieTimeTrackerDB.ContextMenuShowGarrison = true;
        ChromieTimeTrackerDB.ContextMenuShowClassHall = true;
        ChromieTimeTrackerDB.ContextMenuShowWarEffort = true;
        ChromieTimeTrackerDB.ContextMenuShowCovenant = true;
        ChromieTimeTrackerDB.ContextMenuShowDragonIsles = true;
        ChromieTimeTrackerDB.ContextMenuShowKhazAlgar = true;
        ChromieTimeTrackerDB.ContextMenuShowUnlockedOnly = false;

        --Set initial values for Currency settings
        ChromieTimeTrackerDB.ShowCurrencyOnReportWindow = true;
        ChromieTimeTrackerDB.ShowCurrencyOnTooltips = true;

        --Set initial values for Enhancement settings
        ChromieTimeTrackerDB.ShowReportTabsOnReportWindow = true;
        ChromieTimeTrackerDB.ShowMissionExpirationTimeOnReportWindow = true;

        ChromieTimeTrackerDB.AlreadyUsed = true
    end
end



CTT_SetupFirstAccess()

-- Criação dos frames.
--Principal
local addonRootFrame = CreateFrame("Frame", "ChromieTimeTrackerRootFrame", UIParent, "")
local mainFrame = CreateFrame("Frame", "ChromieTimeTrackerMainFrame", ChromieTimeTrackerRootFrame, "TooltipBorderedFrameTemplate")
local iconFrame = CreateFrame("Frame", "ChromieTimeTrackerMainIconFrame", ChromieTimeTrackerRootFrame, "TooltipBorderedFrameTemplate")
local garrisonIconFrame = CreateFrame("Frame", "ChromieTimeTrackerGarrisonIconFrame", ChromieTimeTrackerRootFrame, "")
local classHallIconFrame = CreateFrame("Frame", "ChromieTimeTrackerClassHallIconFrame", ChromieTimeTrackerRootFrame, "")
local missionsIconFrame = CreateFrame("Frame", "ChromieTimeTrackerMissionsIconFrame", ChromieTimeTrackerRootFrame, "")
local covenantIconFrame = CreateFrame("Frame", "ChromieTimeTrackerCovenantIconFrame", ChromieTimeTrackerRootFrame, "")
local dragonIslesIconFrame = CreateFrame("Frame", "ChromieTimeTrackerDragonIslesIconFrame", ChromieTimeTrackerRootFrame, "")
local khazAlgarIconFrame = CreateFrame("Frame", "ChromieTimeTrackerKhazAlgarIconFrame", ChromieTimeTrackerRootFrame, "")


--contextMenu

local function GeneratorFunction(owner, rootDescription)

    isUnlocked = {true, true, true, true, true, true}

    local hideSeparator = true

    if(ChromieTimeTrackerDB.ContextMenuShowUnlockedOnly) then
        
        if not not (C_Garrison.GetGarrisonInfo(2)) then
            isUnlocked[1] = true
        else
            isUnlocked[1] = false
        end
    
        if not not (C_Garrison.GetGarrisonInfo(3)) then
            isUnlocked[2] = true
        else
            isUnlocked[2] = false
        end
    
        if not not (C_Garrison.GetGarrisonInfo(9)) then
            isUnlocked[3] = true
        else
            isUnlocked[3] = false
        end
    
        if C_Covenants.GetActiveCovenantID() ~= 0 and C_Covenants.GetActiveCovenantID() ~= nil then
            isUnlocked[4] = true
        else
            isUnlocked[4] = false
        end
    
        if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(9)) then
            isUnlocked[5] = true
        else
            isUnlocked[5] = false
        end
    
        if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(10)) then
            isUnlocked[6] = true
        else
            isUnlocked[6] = false
        end
    end
    
    if ChromieTimeTrackerDB.ContextMenuShowGarrison and (isUnlocked[1]) then
        rootDescription:CreateTitle(L["ContextMenuTitle"]);
        rootDescription:CreateButton(L["MiddleClickOption_Warlords"], function(data)
            
            if(GarrisonLandingPage and GarrisonLandingPage:IsShown() and 2 == GarrisonLandingPage.garrTypeID) then
                HideUIPanel(GarrisonLandingPage);
            else
                CTT_CheckExpansionContentAccess(2)
            end
        end);
        hideSeparator = false
    end
    if ChromieTimeTrackerDB.ContextMenuShowClassHall and (isUnlocked[2]) then
        if PlayerInfo["Class"]~= "EVOKER" then
            rootDescription:CreateButton(L["MiddleClickOption_Legion"], function(data)
                if(GarrisonLandingPage and GarrisonLandingPage:IsShown() and 3 == GarrisonLandingPage.garrTypeID) then
                    HideUIPanel(GarrisonLandingPage);
                else
                    CTT_CheckExpansionContentAccess(3)
                end
            end);
            hideSeparator = false
        else
            --Since Evoker was launched after Legion there is no class hall for them.
        end

    end
    if ChromieTimeTrackerDB.ContextMenuShowWarEffort and (isUnlocked[3]) then

        rootDescription:CreateButton(L["MiddleClickOption_Missions"], function(data)
            if(GarrisonLandingPage and GarrisonLandingPage:IsShown() and 9 == GarrisonLandingPage.garrTypeID) then
                HideUIPanel(GarrisonLandingPage);
            else
                CTT_CheckExpansionContentAccess(9)
            end
        end);
        hideSeparator = false
    end
    if ChromieTimeTrackerDB.ContextMenuShowCovenant and (isUnlocked[4]) then

        local _CovData = {}
        _CovData = getCovenantData()
        
        rootDescription:CreateButton(string.format(L["MiddleClickOption_Covenant"], _CovData[3]), function(data)
            if(GarrisonLandingPage and GarrisonLandingPage:IsShown() and 111 == GarrisonLandingPage.garrTypeID) then
                HideUIPanel(GarrisonLandingPage);
            else
                CTT_CheckExpansionContentAccess(111)
            end
        end);
        hideSeparator = false
    end
    if ChromieTimeTrackerDB.ContextMenuShowDragonIsles and (isUnlocked[5]) then

        rootDescription:CreateButton(L["MiddleClickOption_DragonIsles"], function(data)
            CTT_CheckExpansionContentAccess("DF")
        end);
        hideSeparator = false
    end
    if ChromieTimeTrackerDB.ContextMenuShowKhazAlgar and (isUnlocked[6]) then

        rootDescription:CreateButton(L["MiddleClickOption_KhazAlgar"], function(data)
            CTT_CheckExpansionContentAccess("TWW")
        end);
        hideSeparator = false
    end


    if not hideSeparator then
        rootDescription:CreateDivider()
    end

    rootDescription:CreateButton(L["Settings"], function(data)
    	PlaySound(808)
            ChromieTimeTracker:ToggleSettingsFrame()
	end);


end;

--Root

function CTT_setupRootFrame()

addonRootFrame:ClearAllPoints()
addonRootFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
addonRootFrame:SetSize(280, 195)
addonRootFrame:SetFrameLevel(0)

if (not ChromieTimeTrackerDB.HideMainWindow or ChromieTimeTrackerDB.HideMainWindow == nil) then
    addonRootFrame:Show()
else
    addonRootFrame:Hide()
end

addonRootFrame:EnableMouse(true)
addonRootFrame:SetMovable(true)
addonRootFrame:RegisterForDrag("LeftButton")
addonRootFrame:SetScript("OnDragStart", function(self)
    if(not ChromieTimeTrackerDB.LockDragDrop)then
        self:StartMoving()
    end
	
end)
addonRootFrame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()

    ChromieTimeTrackerDB.Point = {addonRootFrame:GetPoint()}
    
    ChromieTimeTrackerDB.BasePoint = ChromieTimeTrackerDB.Point[1]
    ChromieTimeTrackerDB.RelativePoint = ChromieTimeTrackerDB.Point[3]
    ChromieTimeTrackerDB.OffsetX = ChromieTimeTrackerDB.Point[4]
    ChromieTimeTrackerDB.OffsetY = ChromieTimeTrackerDB.Point[5]
end)

addonRootFrame:SetScript("OnShow", function()
    PlaySound(808)
end)

addonRootFrame:SetScript("OnHide", function()
        PlaySound(808)
end)

end

CTT_setupRootFrame()


function CTT_setupMainFrame()

mainFrame:ClearAllPoints()
mainFrame:SetPoint("TOPLEFT", ChromieTimeTrackerRootFrame, "TOPLEFT", 0, 0)

mainFrame:EnableMouse(true)
mainFrame:SetMovable(true)
mainFrame:RegisterForDrag("LeftButton")
mainFrame:SetScript("OnDragStart", function(self)
    if(not ChromieTimeTrackerDB.LockDragDrop)then
        addonRootFrame:StartMoving()
    end
    
end)
mainFrame:SetScript("OnMouseDown", function(self, btn)
    if btn == 'MiddleButton' then 
        CTT_MouseMiddleButtonClick()
    elseif btn == "RightButton" then
        local contextMenu = MenuUtil.CreateContextMenu(ChromieTimeTrackerRootFrame, GeneratorFunction);
    end
end)


mainFrame:SetScript("OnDragStop", function(self)
	addonRootFrame:StopMovingOrSizing()
    
    ChromieTimeTrackerDB.Point = {addonRootFrame:GetPoint()}
    
    ChromieTimeTrackerDB.BasePoint = ChromieTimeTrackerDB.Point[1]
    ChromieTimeTrackerDB.RelativePoint = ChromieTimeTrackerDB.Point[3]
    ChromieTimeTrackerDB.OffsetX = ChromieTimeTrackerDB.Point[4]
    ChromieTimeTrackerDB.OffsetY = ChromieTimeTrackerDB.Point[5]

end)

mainFrame:SetScript("OnShow", function()
--    PlaySound(808)
    CTT_updateChromieTime()
end)

mainFrame:SetScript("OnHide", function()
--        PlaySound(808)
end)

mainFrame:SetFrameLevel(1)

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
                currentExpansionName = "|c" .. C_ExpansionColors[ChromieTimeItem.sortPriority] .. ChromieTimeItem.name .. "|r"
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
        mainFrame:Show()
        addonRootFrame:SetSize(180, 24)
        iconFrame:Hide()
        garrisonIconFrame:Hide()
        classHallIconFrame:Hide()
        missionsIconFrame:Hide()
        covenantIconFrame:Hide()
        dragonIslesIconFrame:Hide()
        khazAlgarIconFrame:Hide()
    elseif ChromieTimeTrackerDB.Mode == 2 then
        mainFrame:SetSize(280, 35)
        mainFrame:Show()
        addonRootFrame:SetSize(280, 35)
        iconFrame:Hide()
        garrisonIconFrame:Hide()
        classHallIconFrame:Hide()
        missionsIconFrame:Hide()
        covenantIconFrame:Hide()
        dragonIslesIconFrame:Hide()
        khazAlgarIconFrame:Hide()
    elseif ChromieTimeTrackerDB.Mode == 3 then
        if ChromieTimeTrackerDB.AlternateModeShowIconOnly then
        iconFrame:SetSize(32,32)
        iconFrame:Show()
        if (not ChromieTimeTrackerDB.HideMainWindow or ChromieTimeTrackerDB.HideMainWindow == nil) then
            addonRootFrame:Show()
        else
            addonRootFrame:Hide()
        end
        mainFrame:Hide()
        addonRootFrame:SetSize(32, 32)
        garrisonIconFrame:Hide()
        classHallIconFrame:Hide()
        missionsIconFrame:Hide()
        covenantIconFrame:Hide()
        dragonIslesIconFrame:Hide()
        khazAlgarIconFrame:Hide()
        else 
        mainFrame:SetSize(280, 35)
        addonRootFrame:SetSize(280, 35)
        iconFrame:Hide()
        mainFrame:Show()
        garrisonIconFrame:Hide()
        classHallIconFrame:Hide()
        missionsIconFrame:Hide()
        covenantIconFrame:Hide()
        dragonIslesIconFrame:Hide()
        khazAlgarIconFrame:Hide()
        end
    elseif ChromieTimeTrackerDB.Mode == 4 then
        mainFrame:SetSize(280, 35)
        mainFrame:Show()
        addonRootFrame:SetSize(280, 67)
        iconFrame:Hide()
        if ChromieTimeTrackerDB.AdvHideTimelineBox then
            mainFrame:Hide()
        else
            mainFrame:Show()
        end
        CTT_LoadAvancedModeIcons()
    else
        mainFrame:SetSize(280, 35)
        addonRootFrame:SetSize(280, 35)
        iconFrame:Hide()
        mainFrame:Show()
    end

    if ChromieTimeTrackerDB.Mode == 1 then
        mainFrame.playerTimeline:SetText(currentExpansionName)
    elseif ChromieTimeTrackerDB.Mode == 3 then
        if ChromieTimeTrackerDB.AlternateModeShowIconOnly then
            iconFrame.playerTimeline:SetText("")
            iconFrame.icon = iconFrame:CreateTexture()
            iconFrame.icon:SetAllPoints()
            iconFrame.icon:SetTexture("Interface\\Icons\\Inv_dragonwhelp3_bronze", false)
        else 
            if(C_ExpansionSummaries[ChromieTimeTrackerDB.DefaultMiddleClickOption] == "" or C_ExpansionSummaries[ChromieTimeTrackerDB.DefaultMiddleClickOption] == nil) then
                mainFrame.playerTimeline:SetText(L["ConfigurationMissing"])
            else
                mainFrame.playerTimeline:SetText(C_ExpansionSummaries[ChromieTimeTrackerDB.DefaultMiddleClickOption])
            end
        end
    else
        mainFrame.playerTimeline:SetText(L["Timeline"] .. currentExpansionName ..".")
    end

    if ChromieTimeTrackerDB.HideWhenNotTimeTraveling and currentExpansionName == L["currentExpansionLabel"] and ChromieTimeTrackerDB.Mode ~= 3 then
        mainFrame:Hide()
    end

    mainFrame:ClearAllPoints()
    iconFrame:ClearAllPoints()
    addonRootFrame:ClearAllPoints()

    mainFrame:SetPoint("TOPLEFT", ChromieTimeTrackerRootFrame, "TOPLEFT", 0, 0)
    iconFrame:SetPoint("TOPLEFT", ChromieTimeTrackerRootFrame, "TOPLEFT", 0, 0)
    addonRootFrame:SetPoint(ChromieTimeTrackerDB.BasePoint or "CENTER", UIParent, ChromieTimeTrackerDB.RelativePoint or "CENTER", ChromieTimeTrackerDB.OffsetX or 0, ChromieTimeTrackerDB.OffsetY or 0)    
        
end

--Icon

function CTT_setupIconFrame()

iconFrame:ClearAllPoints()
iconFrame:SetPoint("TOPLEFT", ChromieTimeTrackerRootFrame, "TOPLEFT", 0, 0)

iconFrame:SetFrameLevel(2)
iconFrame:EnableMouse(true)
iconFrame:SetMovable(true)
iconFrame:RegisterForDrag("LeftButton")
iconFrame:SetScript("OnDragStart", function(self)
    if(not ChromieTimeTrackerDB.LockDragDrop)then
        addonRootFrame:StartMoving()

        GameTooltip:Hide()
    end
    
end)
iconFrame:SetScript("OnMouseDown", function(self, btn)
    if btn == 'MiddleButton' then 
            CTT_MouseMiddleButtonClick()
    elseif btn == "RightButton" then
        local contextMenu = MenuUtil.CreateContextMenu(ChromieTimeTrackerRootFrame, GeneratorFunction);
    end
end)

iconFrame:SetScript("OnDragStop", function(self)
	addonRootFrame:StopMovingOrSizing()
    
    GameTooltip:Show()

    ChromieTimeTrackerDB.PointIcon = {addonRootFrame:GetPoint()}
    
    ChromieTimeTrackerDB.BasePoint = ChromieTimeTrackerDB.PointIcon[1]
    ChromieTimeTrackerDB.RelativePoint = ChromieTimeTrackerDB.PointIcon[3]
    ChromieTimeTrackerDB.OffsetX = ChromieTimeTrackerDB.PointIcon[4]
    ChromieTimeTrackerDB.OffsetY = ChromieTimeTrackerDB.PointIcon[5]

end)

iconFrame:SetScript("OnEnter", function(self)

    local _ttpPoint = {addonRootFrame:GetPoint()}

    if(_ttpPoint[1] == "TOPLEFT") then
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    elseif(_ttpPoint[1] == "TOPRIGHT") then
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
    elseif(_ttpPoint[1] == "BOTTOMLEFT") then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    elseif(_ttpPoint[1] == "BOTTOMRIGHT") then
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
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

function CTT_setupGarrisonIconFrame(_garrisonIconFrame, _size, _garrisonID, _offsetX, _offsetY, _iconName, _iconType, _TooltipText)

    _garrisonIconFrame:ClearAllPoints()
    _garrisonIconFrame:SetPoint("TOPLEFT", ChromieTimeTrackerRootFrame, "TOPLEFT", _offsetX, _offsetY)
    
    _garrisonIconFrame:SetFrameLevel(2)
    _garrisonIconFrame:EnableMouse(true)
    _garrisonIconFrame:SetMovable(true)
    _garrisonIconFrame:RegisterForDrag("LeftButton")
    _garrisonIconFrame:SetScript("OnDragStart", function(self)
        if(not ChromieTimeTrackerDB.LockDragDrop)then
            addonRootFrame:StartMoving()
    
            GameTooltip:Hide()
        end
        
    end)
    _garrisonIconFrame:SetScript("OnMouseDown", function(self, btn)
        if btn == 'LeftButton' then 
            if(GarrisonLandingPage and GarrisonLandingPage:IsShown() and _garrisonID == GarrisonLandingPage.garrTypeID) then
                HideUIPanel(GarrisonLandingPage);
            else
                CTT_CheckExpansionContentAccess(_garrisonID)
            end
        elseif btn == "RightButton" then
            local contextMenu = MenuUtil.CreateContextMenu(ChromieTimeTrackerRootFrame, GeneratorFunction);
        end
    end)
    
    _garrisonIconFrame:SetScript("OnDragStop", function(self)
        addonRootFrame:StopMovingOrSizing()
        
        GameTooltip:Show()
    
        ChromieTimeTrackerDB.PointIcon = {addonRootFrame:GetPoint()}
        
        ChromieTimeTrackerDB.BasePoint = ChromieTimeTrackerDB.PointIcon[1]
        ChromieTimeTrackerDB.RelativePoint = ChromieTimeTrackerDB.PointIcon[3]
        ChromieTimeTrackerDB.OffsetX = ChromieTimeTrackerDB.PointIcon[4]
        ChromieTimeTrackerDB.OffsetY = ChromieTimeTrackerDB.PointIcon[5]
    
    end)
    
    _garrisonIconFrame:SetScript("OnEnter", function(self)
    
        local _ttpPoint = {addonRootFrame:GetPoint()}
    
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
    
            CTT_ShowIconTooltip(GameTooltip, _TooltipText)
            GameTooltip:Show()
            _garrisonIconFrame.iconHightLight:SetAtlas("bag-border-highlight", false)
            _garrisonIconFrame.iconHightLight:ClearAllPoints()
            _garrisonIconFrame.iconHightLight:SetPoint("TOPLEFT", C_ButtonFrames[_garrisonID], "TOPLEFT", 1, -1)
            _garrisonIconFrame.iconHightLight:SetWidth(_size)
            _garrisonIconFrame.iconHightLight:SetHeight(_size)
            
    end)
    
    _garrisonIconFrame:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        _garrisonIconFrame.iconHightLight:ClearAllPoints()
        _garrisonIconFrame.iconHightLight:SetTexture(nil,"ARTWORK")
    end)

    _garrisonIconFrame.iconBorder = _garrisonIconFrame:CreateTexture(nil,"BACKGROUND",nil,0)
    _garrisonIconFrame.iconBorder:SetPoint("TOPLEFT", C_ButtonFrames[_garrisonID], "TOPLEFT", 1, -1)
    _garrisonIconFrame.iconBorder:SetWidth(_size)
    _garrisonIconFrame.iconBorder:SetHeight(_size)
    _garrisonIconFrame.iconBorder:SetAtlas("Map_Faction_Ring", false)

    _garrisonIconFrame.iconHightLight = _garrisonIconFrame:CreateTexture(nil,"BACKGROUND",nil,-1)
    _garrisonIconFrame.iconHightLight:SetPoint("TOPLEFT", C_ButtonFrames[_garrisonID], "TOPLEFT", 1, -1)
    _garrisonIconFrame.iconHightLight:SetWidth(_size)
    _garrisonIconFrame.iconHightLight:SetHeight(_size)

    _garrisonIconFrame.icon = _garrisonIconFrame:CreateTexture(nil,"BACKGROUND",nil,-2)
    _garrisonIconFrame.icon:SetPoint("TOPLEFT", C_ButtonFrames[_garrisonID], "TOPLEFT", 0, 0)
    _garrisonIconFrame.icon:SetWidth(_size)
    _garrisonIconFrame.icon:SetHeight(_size)

    _garrisonIconFrame.iconBackGround = _garrisonIconFrame:CreateTexture(nil,"BACKGROUND",nil,-3)
    _garrisonIconFrame.iconBackGround:ClearAllPoints()
    _garrisonIconFrame.iconBackGround:SetPoint("TOPLEFT", C_ButtonFrames[_garrisonID], "TOPLEFT", 0, 0)
    _garrisonIconFrame.iconBackGround:SetWidth(_size)
    _garrisonIconFrame.iconBackGround:SetHeight(_size)

    _garrisonIconFrame.iconBackGround:SetAtlas("common-radiobutton-circle", false)
            
    if _iconType == "Texture" then
    _garrisonIconFrame.icon:SetTexture(_iconName, false)
    else --"Atlas"
    _garrisonIconFrame.icon:SetAtlas(_iconName, false)
    end
    
    _garrisonIconFrame:SetSize(_size,_size)

    _garrisonIconFrame:Show()

    end

function CTT_LoadAvancedModeIcons()

    local iconsCount = 0

    isUnlocked = {true, true, true, true, true, true}

    if(ChromieTimeTrackerDB.AdvShowUnlockedOnly) then
        
            if not not (C_Garrison.GetGarrisonInfo(2)) then
                isUnlocked[1] = true
            else
                isUnlocked[1] = false
            end

            if not not (C_Garrison.GetGarrisonInfo(3)) then
                isUnlocked[2] = true
            else
                isUnlocked[2] = false
            end

            if not not (C_Garrison.GetGarrisonInfo(9)) then
                isUnlocked[3] = true
            else
                isUnlocked[3] = false
            end

            if C_Covenants.GetActiveCovenantID() ~= 0 and C_Covenants.GetActiveCovenantID() ~= nil then
                isUnlocked[4] = true
            else
                isUnlocked[4] = false
            end

            if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(9)) then
                isUnlocked[5] = true
            else
                isUnlocked[5] = false
            end

            if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(10)) then
                isUnlocked[6] = true
            else
                isUnlocked[6] = false
            end
    end

    if ChromieTimeTrackerDB.AdvShowGarrison and (isUnlocked[1]) then
        iconsCount = iconsCount + 1;
    end
    if ChromieTimeTrackerDB.AdvShowClassHall and (isUnlocked[2]) then
        if PlayerInfo["Class"]~= "EVOKER" then
            iconsCount = iconsCount + 1;
        else
            --Since Evoker was launched after Legion there is no class hall for them.
        end        
    end
    if ChromieTimeTrackerDB.AdvShowWarEffort and (isUnlocked[3]) then
        iconsCount = iconsCount + 1;
    end
    if ChromieTimeTrackerDB.AdvShowCovenant and (isUnlocked[4]) then
        iconsCount = iconsCount + 1;
    end
    if ChromieTimeTrackerDB.AdvShowDragonIsles and (isUnlocked[5]) then
        iconsCount = iconsCount + 1;
    end
    if ChromieTimeTrackerDB.AdvShowKhazAlgar and (isUnlocked[6]) then
        iconsCount = iconsCount + 1;
    end

    local alignments = {}
    alignments[1] = "LEFT"
    alignments[2] = "CENTER"
    alignments[3] = "RIGHT"

    local positions = {}
    positions[1] = "ABOVE"
    positions[2] = "BELOW"

    local alignment = alignments[ChromieTimeTrackerDB.AdvButtonsAlignment] or "CENTER"
    local position = positions[ChromieTimeTrackerDB.AdvButtonsPosition] or "BELOW"
    local top = -35
    local left = 0
    local iconSize = 36
    local iconSpace = 1
    local placeholderSize = 280
    local mid = (placeholderSize/2)    
    local step = (iconSize + (2*iconSpace))
    if(alignment == "CENTER") then
        left = (placeholderSize/2 - (iconSize + (2*iconSpace))*iconsCount/2) 
    end
    if(alignment == "RIGHT") then
        left = (placeholderSize - (iconSize + (2*iconSpace))*iconsCount) 
    end

    if(position == "BELOW") then
        top = -iconSize
    end
    if(position == "ABOVE") then
        top = iconSize + 2
    end

    local position = 0;
    
    if ChromieTimeTrackerDB.AdvShowGarrison and (isUnlocked[1]) then
        CTT_setupGarrisonIconFrame(garrisonIconFrame,iconSize,2,(left + (step * position)),top,C_GarrisonTextures[PlayerInfo["Faction"]], "Atlas", L["MiddleClickOption_Warlords"])
        position = position + 1;
    else
        garrisonIconFrame:Hide();
    end
    if ChromieTimeTrackerDB.AdvShowClassHall and (isUnlocked[2]) then
        if PlayerInfo["Class"]~= "EVOKER" then
            CTT_setupGarrisonIconFrame(classHallIconFrame,iconSize,3,(left + (step * position)),top,C_ClassTextures[PlayerInfo["Class"]], "Atlas", L["MiddleClickOption_Legion"])
            position = position + 1;
        else
            --Since Evoker was launched after Legion there is no class hall for them.
            classHallIconFrame:Hide();    
        end
    else
        classHallIconFrame:Hide();
    end
    if ChromieTimeTrackerDB.AdvShowWarEffort and (isUnlocked[3]) then
        CTT_setupGarrisonIconFrame(missionsIconFrame,iconSize,9,(left + (step * position)),top,C_WarCampaignTextures[PlayerInfo["Faction"]], "Atlas", L["MiddleClickOption_Missions"])
        position = position + 1;
    else
        missionsIconFrame:Hide();
    end

    if ChromieTimeTrackerDB.AdvShowCovenant and (isUnlocked[4]) then

        local _CovData = {}
        _CovData = getCovenantData()

        CTT_setupGarrisonIconFrame(covenantIconFrame,iconSize,111,(left + (step * position)),top,C_CovenantChoicesTextures[_CovData[1]], "Atlas", string.format(L["MiddleClickOption_Covenant"], _CovData[3]))
        position = position + 1;
    else
        covenantIconFrame:Hide();
    end
    if ChromieTimeTrackerDB.AdvShowDragonIsles and (isUnlocked[5]) then
        CTT_setupGarrisonIconFrame(dragonIslesIconFrame,iconSize,"DF",(left + (step * position)),top,C_LandingPagesTextures["DragonIsles"], "Atlas", L["MiddleClickOption_DragonIsles"])
        position = position + 1;
    else
        dragonIslesIconFrame:Hide();
    end
    if ChromieTimeTrackerDB.AdvShowKhazAlgar and (isUnlocked[6]) then
        CTT_setupGarrisonIconFrame(khazAlgarIconFrame,iconSize,"TWW",(left + (step * position)),top,C_LandingPagesTextures["KhazAlgar"], "Atlas", L["MiddleClickOption_KhazAlgar"])
        position = position + 1;
    else
        khazAlgarIconFrame:Hide();
    end

end

function ChromieTimeTracker:ToggleMainFrame()
    if not addonRootFrame:IsShown() then
        addonRootFrame:Show()
        ChromieTimeTrackerDB.HideMainWindow = false
    else
        addonRootFrame:Hide()
        ChromieTimeTrackerDB.HideMainWindow = true
    end
end



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
            if addonRootFrame:IsShown() then
                addonRootFrame:Hide()
                ChromieTimeTrackerDB.HideMainWindow = true
            else
                addonRootFrame:Show()
                ChromieTimeTrackerDB.HideMainWindow = false
            end
        elseif btn == "RightButton" then
            local contextMenu = MenuUtil.CreateContextMenu(UIParent, GeneratorFunction);
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
        if(not ChromieTimeTrackerDB.HideChatWelcomeMessage) then
            print(L["ChatAddonLoadedMessage"] .. CTT_getChromieTime() .. ".")
        end
        if (not ChromieTimeTrackerDB.HideMainWindow or ChromieTimeTrackerDB.HideMainWindow == nil) then
            addonRootFrame:Show()
        else
            addonRootFrame:Hide()
        end
        if(not ChromieTimeTrackerDB.HideToastWindow) then
            if((ChromieTimeTrackerDB.ToastVisibility == 1) or (ChromieTimeTrackerDB.ToastVisibility == 2 and currentExpansionName ~= L['currentExpansionLabel']) or (ChromieTimeTrackerDB.ToastVisibility == nil)) then
                ChromieTimeTrackerUtil:ShowToast(string.gsub(L["Timeline"], ":", ""),currentExpansionName,1)
            end
        end
    end
    if event == "QUEST_LOG_UPDATE" then
        CTT_updateChromieTime()

        if((ChromieTimeTrackerDB.ToastVisibility == 1) or (ChromieTimeTrackerDB.ToastVisibility == 2 and currentExpansionName ~= L['currentExpansionLabel']) or (ChromieTimeTrackerDB.ToastVisibility == nil)) then
        --Limit alert to trigger only when there is a timeline change
            if(PlayerInfo["Timeline"] ~= currentExpansionName) then

                --Get player position to trigger validation only when near Chromie
                _zone = C_Map.GetBestMapForUnit("player");

                --Check if player zone id is a valid number
                if type(_zone) ~= "number" then
                    _zone = 0
                end

                if(_zone ~= 0) then

                    playerPosition = C_Map.GetPlayerMapPosition(_zone,"player");
                    
                    if playerPosition == nil then
                        --Invalid map position (Inside instance)
                    else
                        x = math.ceil(playerPosition.x*10000)/100
                        y = math.ceil(playerPosition.y*10000)/100

                        --Check for Alliance (Stormwind Chromie)
                        if (_zone == 84) then
                            if (x > 55.95 and x < 56.50 and y > 16.95 and y < 17.65) then
                                --print(C_Map.GetMapInfo(z).name, math.ceil(pos.x*10000)/100, math.ceil(pos.y*10000)/100)
                                ChromieTimeTrackerUtil:ShowToast(string.gsub(L["Timeline"], ":", ""),currentExpansionName,0)
                                PlayerInfo["Timeline"] = currentExpansionName
                            end
                        end

                        --Check for Horde (Orgrimmar Chromie)
                        if (_zone == 85) then
                            if (x > 40.53 and x < 41.15 and y > 79.80 and y < 80.65) then
                                --print(C_Map.GetMapInfo(z).name, math.ceil(pos.x*10000)/100, math.ceil(pos.y*10000)/100)
                                ChromieTimeTrackerUtil:ShowToast(string.gsub(L["Timeline"], ":", ""),currentExpansionName,0)
                                PlayerInfo["Timeline"] = currentExpansionName
                            end
                        end
                    end
                end
            end
        end
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
    if (not ChromieTimeTrackerDB.HideMainWindow or ChromieTimeTrackerDB.HideMainWindow == nil) then
        addonRootFrame:Show()
    else
        addonRootFrame:Hide()
    end
end

function updateGarrisonReportDisplayedCurrency(_garrisonID)
    if(ChromieTimeTrackerDB.ShowCurrencyOnReportWindow) then
        garrisonUIResourcesFrame:Show()
    else
        garrisonUIResourcesFrame:Hide()
    end
    if _garrisonID == 2 then
        garrisonUIResourcesFrame.garrisonCurrency:SetText(getCurrencyById(C_CurrencyId["Garrison_Resources"], true) .. "    " .. getCurrencyById(C_CurrencyId["Garrison_Oil"], true))
    end
    if _garrisonID == 3 then
        garrisonUIResourcesFrame.garrisonCurrency:SetText(getCurrencyById(C_CurrencyId["Order_Resources"], true))
    end
    if _garrisonID == 9 then
        garrisonUIResourcesFrame.garrisonCurrency:SetText(getCurrencyById(C_CurrencyId["War_Resources"], true))
    end
    if _garrisonID == 111 then
        garrisonUIResourcesFrame.garrisonCurrency:SetText(getCurrencyById(C_CurrencyId["Reservoir_Anima"], true))
    end
end

local function GenericFunction(_function, ...)
	return _function(...)
end

local function RegisterCallback_OnInitializedFrame(_frame, _function)
	_frame:RegisterCallback("OnInitializedFrame", GenericFunction, _function)
	if _frame:IsVisible() then
		_frame:ForEachFrame(_function)
	end
end

local function CTT_ShowReportMissionExpirationTime(b, item)
    if ChromieTimeTrackerDB.ShowMissionExpirationTimeOnReportWindow then
        if b and item and item.offerTimeRemaining and item.offerEndTime then
            local _color = "|cffa0a0a0"
            if (item.offerEndTime - GetTime()) /60 < 360 then
                _color = "|cFFFF7F27"
            end
            if (item.offerEndTime - GetTime()) /60 < 120 then
                _color = "|cffff3333"
            end

            if item.offerEndTime - 8640000 <= GetTime() then
                b.MissionType:SetFormattedText("%s |cffa0a0a0(%s %s%s|r)|r",
                    item.durationSeconds >= GARRISON_LONG_MISSION_TIME and (GARRISON_LONG_MISSION_TIME_FORMAT):format(item.duration) or item.duration,
                    L["Expires_in"], _color, item.offerTimeRemaining)
            end
        end
    end
end

function drawGarrisonReportCurrencyWidget(_garrisonID)
    if(isGarrisonUIFirstLoad) then
        isGarrisonUIFirstLoad = false

            garrisonUIResourcesFrame = CreateFrame("Frame", "ChromieTimeTrackerGarrisonUIResourcesFrame", GarrisonLandingPageReport, "")

            garrisonUIResourcesFrame:ClearAllPoints()
            garrisonUIResourcesFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "TOPLEFT", 40, -12)
            garrisonUIResourcesFrame:SetSize(320, 28)
            garrisonUIResourcesFrame:SetFrameLevel(5)

            garrisonUIResourcesFrame.garrisonCurrency = garrisonUIResourcesFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            garrisonUIResourcesFrame.garrisonCurrency:SetPoint("LEFT", garrisonUIResourcesFrame, "LEFT", 0, 0)
            garrisonUIResourcesFrame.garrisonCurrency:SetText("[Currency]")

            --Disabling native Garrison Fleet tab OnEnter and Onleave events resulting in nil reference error - Begin
            GarrisonLandingPageTab_OnEnter = function(...) end
            GarrisonLandingPageTab_OnLeave = function(...) end
            GarrisonShipFollowerListButton_OnClick = function(...) end
            --Disabling native garrison fleet tab OnEnter and Onleave events resulting in nil reference error - End
            
            garrisonUIResourcesFrame:Show()

            RegisterCallback_OnInitializedFrame(GarrisonLandingPageReportList.ScrollBox, CTT_ShowReportMissionExpirationTime)

    end
    updateGarrisonReportDisplayedCurrency(_garrisonID)
end


function CTT_CheckExpansionContentAccess(_garrisonID)
    
 if _garrisonID == 111 then
    if C_Covenants.GetActiveCovenantID() ~= 0 and C_Covenants.GetActiveCovenantID() ~= nil then
        HideUIPanel(GarrisonLandingPage);
        ShowGarrisonLandingPage(_garrisonID)
        drawGarrisonReportCurrencyWidget(_garrisonID)
    else
        requisito = L["UndiscoveredContentUnlockRequirement_Covenant"]
        ChromieTimeTrackerUtil:FlashMessage(L["UndiscoveredContent"]  .. L["UndiscoveredContent_Covenant"] .. requisito, 5, 1.5)
    end
elseif _garrisonID == 2 or _garrisonID == 3 or _garrisonID == 9 then
 if not not (C_Garrison.GetGarrisonInfo(_garrisonID)) then
    HideUIPanel(GarrisonLandingPage);
    ShowGarrisonLandingPage(_garrisonID)
    drawGarrisonReportCurrencyWidget(_garrisonID)
 else
    local funcionalidade = ""
    if (_garrisonID == 2) then
        funcionalidade = L["UndiscoveredContent_Warlords"]
        requisito = L["UndiscoveredContentUnlockRequirement_Warlords"]
        ChromieTimeTrackerUtil:FlashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
    elseif (_garrisonID == 3) then
        if PlayerInfo["Class"]~= "EVOKER" then
            funcionalidade = L["UndiscoveredContent_Legion"]
            requisito = L["UndiscoveredContentUnlockRequirement_Legion"]
            ChromieTimeTrackerUtil:FlashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
        else
            --Since Evoker was launched after Legion there is no class hall for them.
            ChromieTimeTrackerUtil:FlashMessage(L["EvokerHasNoClassHall"], 5, 1.5)
        end
    elseif (_garrisonID == 9) then
        funcionalidade = L["UndiscoveredContent_Missions"]
        requisito = L["UndiscoveredContentUnlockRequirement_Missions"]
        ChromieTimeTrackerUtil:FlashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
    else
        funcionalidade = ""
        ChromieTimeTrackerUtil:FlashMessage(L["ConfigurationMissing"], 5, 1.5)
    end
end
else
    if _garrisonID == "DF" then
        local funcionalidade = ""
        if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(9)) then
            CTT_OpenExpansionLandingPage(_garrisonID);
        else
            funcionalidade = L["UndiscoveredContent_DragonIsles"]
            requisito = L["UndiscoveredContentUnlockRequirement_DragonIsles"]
            ChromieTimeTrackerUtil:FlashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
        end
    elseif _garrisonID == "TWW" then
        local funcionalidade = ""
        if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(10)) then
            CTT_OpenExpansionLandingPage(_garrisonID);
        else
            funcionalidade = L["UndiscoveredContent_KhazAlgar"]
            requisito = L["UndiscoveredContentUnlockRequirement_KhazAlgar"]
            ChromieTimeTrackerUtil:FlashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
        end
    else
        ChromieTimeTrackerUtil:FlashMessage(L["ConfigurationMissing"], 5, 1.5)
    end
end
end

function CTT_MouseMiddleButtonClick()

    local selected = 0

    if ChromieTimeTrackerDB.LockMiddleClickOption or currentExpansionName == L["currentExpansionLabel"] then
        selected = C_ExpansionGarrisonID[C_ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]]
    else
        if not (C_ExpansionGarrisonID[CurrentGarrisonID] == 0) then
            selected = C_ExpansionGarrisonID[CurrentGarrisonID]
        end
    end
    if(GarrisonLandingPage and GarrisonLandingPage:IsShown() and selected == GarrisonLandingPage.garrTypeID) then
        HideUIPanel(GarrisonLandingPage);
    else
        CTT_CheckExpansionContentAccess(selected)
    end

end

function CTT_ShowIconTooltip(tooltip, text)
    tooltip:AddLine("|cFFFFFFFF" .. text .. "|r", nil, nil, nil, nil)
end

function CTT_SetupTooltip(_tooltip, _LClickAction, _MClickAction, _TimelineCurrency)
    if (ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips) then
        if (ChromieTimeTrackerDB.ShowCurrencyOnTooltips) then
            _tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r." .. _TimelineCurrency .. "\n\n" .. _LClickAction .. "\n" .. _MClickAction .. "\n" .. L["RClickAction"] .. "", nil, nil, nil, nil)
        else
            _tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. _LClickAction .. "\n" .. _MClickAction .. "\n" .. L["RClickAction"] .. "", nil, nil, nil, nil)
        end
    else
        if (ChromieTimeTrackerDB.ShowCurrencyOnTooltips) then
            _tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r." .. _TimelineCurrency .. "\n\n" .. _LClickAction .. "\n" .. _MClickAction .. "\n" .. L["RClickAction"] .. "\n\n".. L["DevelopmentTeamCredit"] .."", nil, nil, nil, nil)
        else
            _tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. _LClickAction .. "\n" .. _MClickAction .. "\n" .. L["RClickAction"] .. "\n\n".. L["DevelopmentTeamCredit"] .."", nil, nil, nil, nil)
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

    local TimelineCurrency = ""
    if not (C_ExpansionGarrisonID[CurrentGarrisonID] == 0) then
        if C_ExpansionGarrisonID[CurrentGarrisonID] == 2 then
            TimelineCurrency = "\n\n" .. getCurrencyById(C_CurrencyId["Garrison_Resources"], true) .. "\n" .. getCurrencyById(C_CurrencyId["Garrison_Oil"], true)
        elseif C_ExpansionGarrisonID[CurrentGarrisonID] == 3 then
            TimelineCurrency = "\n\n" .. getCurrencyById(C_CurrencyId["Order_Resources"], true)
        elseif C_ExpansionGarrisonID[CurrentGarrisonID] == 9 then
            TimelineCurrency = "\n\n" .. getCurrencyById(C_CurrencyId["War_Resources"], true)
        elseif C_ExpansionGarrisonID[CurrentGarrisonID] == 111 then
            TimelineCurrency = "\n\n" .. getCurrencyById(C_CurrencyId["Reservoir_Anima"], true)
        end
    else
        --Adicionar funcionalidade de exibir recursos específicos quando não estiver em nenhuma linha temporal.
    end

    if ChromieTimeTrackerDB.LockMiddleClickOption or currentExpansionName == L["currentExpansionLabel"] then
        
        if C_ExpansionGarrisonID[C_ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]] == 2 then
            MClickAction = L["MClickAction_Warlords"]      
        elseif C_ExpansionGarrisonID[C_ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]] == 3 then
            MClickAction = L["MClickAction_Legion"]            
        elseif C_ExpansionGarrisonID[C_ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]] == 9 then
            MClickAction = L["MClickAction_Missions"]            
        elseif C_ExpansionGarrisonID[C_ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]] == 111 then
            MClickAction = L["MClickAction_Covenant"]            
        elseif C_ExpansionGarrisonID[C_ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]] == "DF" then
            MClickAction = L["MClickAction_DragonIsles"]
        elseif C_ExpansionGarrisonID[C_ExpansionGarrisonMiddleClickOptions[ChromieTimeTrackerDB.DefaultMiddleClickOption]] == "TWW" then
            MClickAction = L["MClickAction_KhazAlgar"]
        else
            MClickAction = L["MClickAction"]
        end

        CTT_SetupTooltip(tooltip, LClickAction, MClickAction, TimelineCurrency)

        
else
    if not (C_ExpansionGarrisonID[CurrentGarrisonID] == 0) then

        if C_ExpansionGarrisonID[CurrentGarrisonID] == 2 then
            MClickAction = L["MClickAction_Warlords"]
        elseif C_ExpansionGarrisonID[CurrentGarrisonID] == 3 then
            MClickAction = L["MClickAction_Legion"]
        elseif C_ExpansionGarrisonID[CurrentGarrisonID] == 9 then
            MClickAction = L["MClickAction_Missions"]
        elseif C_ExpansionGarrisonID[CurrentGarrisonID] == 111 then
            MClickAction = L["MClickAction_Covenant"]
        elseif C_ExpansionGarrisonID[CurrentGarrisonID] == "DF" then
            MClickAction = L["MClickAction_DragonIsles"]
        elseif C_ExpansionGarrisonID[CurrentGarrisonID] == "TWW" then
            MClickAction = L["MClickAction_KhazAlgar"]
        else
            MClickAction = L["MClickAction"]
        end

        CTT_SetupTooltip(tooltip, LClickAction, MClickAction, TimelineCurrency)

    else
        if (ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips) then
            tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. LClickAction .. "\n" .. L["RClickAction"] .."", nil, nil, nil, nil)
        else
            tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. LClickAction .. "\n" .. L["RClickAction"] .. "\n\n".. L["DevelopmentTeamCredit"] .."", nil, nil, nil, nil)
        end      
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

--Add garrison buttons to GarrisonLandingPage - Início

garrisonTabs = {}
garrisonTabsHover = {}
local function SelectGarrison(self)
    CTT_CheckExpansionContentAccess(self.pageID)
end

local E = CreateFrame('Frame')
E:RegisterEvent('ADDON_LOADED')
E:SetScript('OnEvent', function(self, event, addon)
    if(addon == 'Blizzard_GarrisonUI') then

        local _CovData = {}
        _CovData = getCovenantData()
        
        for _, _garrisonTab in next, {
            {2, GARRISON_LANDING_PAGE_TITLE, C_GarrisonTabTextures[PlayerInfo["Faction"]]},
            {3, ORDER_HALL_LANDING_PAGE_TITLE, C_ClassTabTextures[PlayerInfo["Class"]]},
            {9, GARRISON_TYPE_8_0_LANDING_PAGE_TITLE, C_WarCampaignTabTextures[PlayerInfo["Faction"]]},
			{111, GARRISON_TYPE_9_0_LANDING_PAGE_TITLE, C_CovenantChoicesTabTextures[_CovData[1]]},
        } do
            garrisonTabFrame = CreateFrame('CheckButton', nil, GarrisonLandingPage, 'UIButtonTemplate')
            garrisonTabFrame:SetPoint('TOPRIGHT', 25, -(40 * (#garrisonTabs + 1)))
            garrisonTabFrame:SetSize(30,30)
            garrisonTabFrame:SetNormalTexture(_garrisonTab[3])
            garrisonTabFrame:SetScript('OnClick', SelectGarrison)
            garrisonTabFrame:Show()
            garrisonTabFrame.tabIndex = #garrisonTabs + 1
            garrisonTabFrame.pageID = _garrisonTab[1]
            garrisonTabFrame.tooltip = _garrisonTab[2]

            garrisonTabFrameHover = CreateFrame('CheckButton', garrisonTabFrame, GarrisonLandingPage, '')
            garrisonTabFrameHover:SetPoint('TOPRIGHT', 25, -(40 * (#garrisonTabs + 1)))
            garrisonTabFrameHover:SetSize(30,30)
            garrisonTabFrameHover:SetNormalTexture('bags-glow-artifact')
            garrisonTabFrameHover:SetScript('OnClick', SelectGarrison)
            garrisonTabFrameHover:SetFrameLevel(10)
            garrisonTabFrameHover.pageID = _garrisonTab[1]
            garrisonTabFrameHover.tooltip = _garrisonTab[2]
            
            table.insert(garrisonTabs, garrisonTabFrame)
            table.insert(garrisonTabsHover, garrisonTabFrameHover)
        end     
        
        for _, _garTab in pairs(garrisonTabs) do
            if ChromieTimeTrackerDB.ShowReportTabsOnReportWindow then
                _garTab:SetScript("OnEnter", function(self)
                    garrisonTabsHover[_garTab.tabIndex]:Show()
                end)
                _garTab:Show();
            else
                _garTab:Hide();
            end
        end

        for _, _garTabHover in pairs(garrisonTabsHover) do

            if ChromieTimeTrackerDB.ShowReportTabsOnReportWindow then
                _garTabHover:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
                    CTT_ShowIconTooltip(GameTooltip, _garTabHover.tooltip)
                    GameTooltip:Show()
                end)

                _garTabHover:SetScript("OnLeave", function(self)
                    GameTooltip:Hide()
                    _garTabHover:Hide()
                end)
                _garTabHover:Show();
            else
                _garTabHover:Hide();
            end
        end

        for _, _garTabHover in pairs(garrisonTabsHover) do
            _garTabHover:Hide()
        end

        self:UnregisterEvent(event)
    
end
end)

--Add garrison buttons to GarrisonLandingPage - Fim

function CTT_setupSlashCommands()
    -- Criação dos slash comands.
    
    SLASH_ChromieTimeTracker1 = "/ChromieTimeTracker"
    SLASH_ChromieTimeTracker2 = "/ctt"
    SlashCmdList["ChromieTimeTracker"] = function(arg)
        if(arg == "config") then
            ChromieTimeTracker:ToggleSettingsFrame()
            
        elseif(arg == "DF" or arg == "TWW") then
            CTT_OpenExpansionLandingPage(arg)
        elseif(arg == "2" or arg == "3" or arg == "9" or arg == "111") then
            HideUIPanel(GarrisonLandingPage);
            ShowGarrisonLandingPage(tonumber(arg))
            drawGarrisonReportCurrencyWidget(tonumber(arg))
        elseif(arg == "commands") then
            print(L["SlashCommands"])
        elseif(arg == "resetPosition") then
            mainFrame:ClearAllPoints()
            mainFrame:SetPoint("TOPLEFT", ChromieTimeTrackerRootFrame, "TOPLEFT", 0, 0)
    
            iconFrame:ClearAllPoints()
            iconFrame:SetPoint("TOPLEFT", ChromieTimeTrackerRootFrame, "TOPLEFT", 0, 0)
    
            ChromieTimeTrackerDB.PointIcon = {iconFrame:GetPoint()}

            addonRootFrame:ClearAllPoints()
            addonRootFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

            ChromieTimeTrackerDB.Point = {addonRootFrame:GetPoint()}
        
            ChromieTimeTrackerDB.BasePoint = ChromieTimeTrackerDB.Point[1]
            ChromieTimeTrackerDB.RelativePoint = ChromieTimeTrackerDB.Point[3]
            ChromieTimeTrackerDB.OffsetX = ChromieTimeTrackerDB.Point[4]
            ChromieTimeTrackerDB.OffsetY = ChromieTimeTrackerDB.Point[5]
    
            CTT_updateChromieTime();
    
            ChromieTimeTrackerDB.HideMainWindow = false

            if (not ChromieTimeTrackerDB.HideMainWindow or ChromieTimeTrackerDB.HideMainWindow == nil) then
                addonRootFrame:Show()
            end

            print(L["RunCommandMessage_ResetPosition"])
    
        elseif(arg == "resetSettings") then
            ChromieTimeTrackerDB.Mode = 2;
            ChromieTimeTrackerDB.HideWhenNotTimeTraveling = false;
            ChromieTimeTrackerDB.LockDragDrop = false;
            ChromieTimeTrackerDB.ToastVisibility = 1;
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

            ChromieTimeTrackerDB.ShowCurrencyOnReportWindow = true;
            ChromieTimeTrackerDB.ShowCurrencyOnTooltips = true;

            ChromieTimeTrackerDB.ShowReportTabsOnReportWindow = true;
            ChromieTimeTrackerDB.ShowMissionExpirationTimeOnReportWindow = true;
            
            CTT_updateChromieTime();
            CTT_LoadAvancedModeIcons();

            print(L["RunCommandMessage_ResetSettings"])

        elseif(arg == "resetAll") then
            CTT_SetupFirstAccess("resetAll")
            CTT_updateChromieTime()
            CTT_LoadAvancedModeIcons()

            print(L["RunCommandMessage_ResetAll"])
        else
            if addonRootFrame:IsShown() then
                ChromieTimeTrackerDB.HideMainWindow = true
                addonRootFrame:Hide()
            else
                ChromieTimeTrackerDB.HideMainWindow = false
                addonRootFrame:Show()
            end
        end
    end
    end
    
    CTT_setupSlashCommands()

    