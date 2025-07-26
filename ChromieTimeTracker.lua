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

if not ChromieTimeTrackerSharedDB then
    ChromieTimeTrackerSharedDB = {minimap = {hide = false}}
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
local C_LandingPagesTabTextures = mct.C_LandingPagesTabTextures
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


local isGarrisonUIFirstLoad_ResourcesWidget = true
local isGarrisonUIFirstLoad_EmissaryMissionsWidget = true

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


C_Timer.After(5, function()
    CTT_SetupFirstAccess()
end)

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
ChromieTimeTrackerMinimapButton = LibStub("LibDBIcon-1.0", true)

local CTT_miniButton = LibStub("LibDataBroker-1.1"):NewDataObject("ChromieTimeTracker", {
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

ChromieTimeTrackerMinimapButton:Show("ChromieTimeTracker")

--Monitor de eventos
local eventListenerFrame = CreateFrame("Frame", "ChromieTimeTrackerEventListenerFrame", UIParent)

eventListenerFrame:RegisterEvent("PLAYER_LOGIN")
eventListenerFrame:RegisterEvent("QUEST_LOG_UPDATE")
eventListenerFrame:RegisterEvent("ADDON_LOADED")

eventListenerFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...
        local addonName = "ChromieTimeTracker"
        if name == addonName then
            ChromieTimeTrackerMinimapButton:Register("ChromieTimeTracker", CTT_miniButton, ChromieTimeTrackerSharedDB.minimap)
        end
    elseif event == "PLAYER_LOGIN" then
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
    if(isGarrisonUIFirstLoad_ResourcesWidget) then
        isGarrisonUIFirstLoad_ResourcesWidget = false

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
        drawGarrisonReportEmissaryMissionsWidget(_garrisonID)
    else
        requisito = L["UndiscoveredContentUnlockRequirement_Covenant"]
        ChromieTimeTrackerUtil:FlashMessage(L["UndiscoveredContent"]  .. L["UndiscoveredContent_Covenant"] .. requisito, 5, 1.5)
    end
elseif _garrisonID == 2 or _garrisonID == 3 or _garrisonID == 9 then
 if not not (C_Garrison.GetGarrisonInfo(_garrisonID)) then
    HideUIPanel(GarrisonLandingPage);
    ShowGarrisonLandingPage(_garrisonID)
    drawGarrisonReportCurrencyWidget(_garrisonID)
    drawGarrisonReportEmissaryMissionsWidget(_garrisonID)
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
            if(ExpansionLandingPage.Overlay.WarWithinLandingOverlay) then
                ExpansionLandingPage.Overlay.WarWithinLandingOverlay.CloseButton:Click()
            end
            CTT_OpenExpansionLandingPage(_garrisonID);
        else
            funcionalidade = L["UndiscoveredContent_DragonIsles"]
            requisito = L["UndiscoveredContentUnlockRequirement_DragonIsles"]
            ChromieTimeTrackerUtil:FlashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
        end
    elseif _garrisonID == "TWW" then
        local funcionalidade = ""
        if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(10)) then
            if(ExpansionLandingPage.Overlay.DragonflightLandingOverlay) then
                ExpansionLandingPage.Overlay.DragonflightLandingOverlay.CloseButton:Click()
            end
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
    if(self.pageID == 2 or self.pageID == 3 or self.pageID == 9 or self.pageID == 111) then
        if ExpansionLandingPage.overlayFrame and ExpansionLandingPage.overlayFrame:IsShown() then
            if(ExpansionLandingPage.Overlay.WarWithinLandingOverlay) then
                ExpansionLandingPage.Overlay.WarWithinLandingOverlay.CloseButton:Click()
            end
            if(ExpansionLandingPage.Overlay.DragonflightLandingOverlay) then
                ExpansionLandingPage.Overlay.DragonflightLandingOverlay.CloseButton:Click()
            end
        end
    end
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
            {"DF", DRAGONFLIGHT_LANDING_PAGE_TITLE, C_LandingPagesTabTextures["DragonIsles"]},
	        {"TWW", WAR_WITHIN_LANDING_PAGE_TITLE, C_LandingPagesTabTextures["KhazAlgar"]},
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

--Add garrison and expansions buttons to GarrisonLandingPage and Expansiob Landing Pages - Início

expansionTabs = {}
expansionTabsHover = {}

local E = CreateFrame('Frame')
E:RegisterEvent('ADDON_LOADED')
E:SetScript('OnEvent', function(self, event, addon)

    --Delay feature loading for 5 seconds to make sure garrison information and images were fully loaded on Blizzard variables.
    C_Timer.After(5,function()

        local l_Covenant = "Not_Selected"
        local _CovData = {}
        _CovData = getCovenantData()

        for _, _garrisonTab in next, {
            {2, GARRISON_LANDING_PAGE_TITLE, C_GarrisonTabTextures[PlayerInfo["Faction"]]},
            {3, ORDER_HALL_LANDING_PAGE_TITLE, C_ClassTabTextures[PlayerInfo["Class"]]},
            {9, GARRISON_TYPE_8_0_LANDING_PAGE_TITLE, C_WarCampaignTabTextures[PlayerInfo["Faction"]]},
	        {111, GARRISON_TYPE_9_0_LANDING_PAGE_TITLE, C_CovenantChoicesTabTextures[_CovData[1]]},
 	        {"DF", DRAGONFLIGHT_LANDING_PAGE_TITLE, C_LandingPagesTabTextures["DragonIsles"]},
	        {"TWW", WAR_WITHIN_LANDING_PAGE_TITLE, C_LandingPagesTabTextures["KhazAlgar"]},
        } do
            garrisonTabFrame = CreateFrame('CheckButton', nil, ExpansionLandingPage, 'UIButtonTemplate')
            garrisonTabFrame:SetPoint('TOPRIGHT', 38, -(40 * (#expansionTabs + 1)))
            garrisonTabFrame:SetSize(30,30)
            garrisonTabFrame:SetNormalTexture(_garrisonTab[3])
            garrisonTabFrame:SetScript('OnClick', SelectGarrison)
            garrisonTabFrame:Show()
            garrisonTabFrame.tabIndex = #expansionTabs + 1
            garrisonTabFrame.pageID = _garrisonTab[1]
            garrisonTabFrame.tooltip = _garrisonTab[2]

            garrisonTabFrameHover = CreateFrame('CheckButton', garrisonTabFrame, ExpansionLandingPage, '')
            garrisonTabFrameHover:SetPoint('TOPRIGHT', 38, -(40 * (#expansionTabs + 1)))
            garrisonTabFrameHover:SetSize(30,30)
            garrisonTabFrameHover:SetNormalTexture('bags-glow-artifact')
            garrisonTabFrameHover:SetScript('OnClick', SelectGarrison)
            garrisonTabFrameHover:SetFrameLevel(10)
            --garrisonTabFrameHover:Hide()
            garrisonTabFrameHover.pageID = _garrisonTab[1]
            garrisonTabFrameHover.tooltip = _garrisonTab[2]
            
            table.insert(expansionTabs, garrisonTabFrame)
            table.insert(expansionTabsHover, garrisonTabFrameHover)
        end     
        
        for _, _garTab in pairs(expansionTabs) do
            if ChromieTimeTrackerDB.ShowReportTabsOnReportWindow then
                _garTab:SetScript("OnEnter", function(self)
                    expansionTabsHover[_garTab.tabIndex]:Show()
                end)
                _garTab:Show();
            else
                _garTab:Hide();
            end
        end

        for _, _garTabHover in pairs(expansionTabsHover) do

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

        for _, _garTabHover in pairs(expansionTabsHover) do
            _garTabHover:Hide()
        end

        end)

        self:UnregisterEvent(event)
    
end)

hooksecurefunc("CTT_OpenExpansionLandingPage", function(_LandingPageId)
        if(_LandingPageId == "TWW") then
            for _index, _garTab in pairs(expansionTabs) do
                _garTab:SetPoint('TOPRIGHT', -10, - 30 -(40 * (_index)))
            end
            
            for _index, _garTabHover in pairs(expansionTabsHover) do
                _garTabHover:SetPoint('TOPRIGHT', -10, - 30 - (40 * (_index)))
            end
        end

        if(_LandingPageId == "DF") then
            for _index, _garTab in pairs(expansionTabs) do
                _garTab:SetPoint('TOPRIGHT', 38, -(40 * (_index)))
            end

            for _index, _garTabHover in pairs(expansionTabsHover) do
                _garTabHover:SetPoint('TOPRIGHT', 38, -(40 * (_index)))
            end
        end

        if(GarrisonLandingPage and GarrisonLandingPage:IsShown()) then
            GarrisonLandingPage_Toggle()
        end

    end)

--Add garrison and expansions buttons to GarrisonLandingPage and Expansiob Landing Pages - Fim
--Add Emissary Missions to GarrisonLandingPage - Início

local function OpenWorldMap(mapId)

    --627 - Legion - Dalaran
    --1161 - BFA - Estreito Tiragarde
    --862 - BFA - Zuldazar

    if(mapId == 627) then --Legion
        mId = 619
    end

    if(mapId == 1161) then --Alliance Battle for Azeroth
        mId = 876
    end

    if(mapId == 862) then --Horde Battle for Azeroth
        mId = 875
    end

    C_Map.OpenWorldMap(mId)
end

function getFormatedEmissaryQuestsByMapId(mapID)
    local bounties = C_QuestLog.GetBountiesForMapID(mapID)

    local info = {}
    local ret = ""


    if bounties then
        for _, bounty in ipairs(bounties) do
            if not C_QuestLog.IsComplete(bounty.questID) then
                info.text =  C_QuestLog.GetTitleForQuestID(bounty.questID)
                info.icon = bounty.icon
                info.value = bounty.questID
                info.checked = info.value == value

                --ret = ret .. "\n" .. CreateInlineIcon(info.icon) .. info.text
                ret = ret .. "\n" .. info.text
            end
        end
    end
    return ret
end

function addDummyEmissaryQuest(_text, _objective, _time)
    local info = {}
                info.text =  _text -- "Missão indisponível"
                info.objective = _objective -- "Retorne amanhã para uma nova missão."
                info.complete = false
                info.icon = ""
                info.value = ""
                info.checked = "false"
                info.remainingTimeMinutes = _time -- "0"
                info.rewardName = ""
                info.rewardTexture = ""
                info.rewardNumItems = ""
                return info
end

local emissaryMissionRewardLoadedOk = false

function drawGarrisonReportEmissaryMissionsWidget(_garrisonID)
    if(isGarrisonUIFirstLoad_EmissaryMissionsWidget) then
        isGarrisonUIFirstLoad_EmissaryMissionsWidget = false

            garrisonUIEmissaryMissionsFrame = CreateFrame("Frame", "ChromieTimeTrackerGarrisonUIEmissaryMissionsFrame", GarrisonLandingPageReport, "")
            garrisonUIEmissaryMissionsFrameDisabled = CreateFrame("Frame", "ChromieTimeTrackerGarrisonUIEmissaryMissionsFrameDisabled", GarrisonLandingPageReport, "")

            garrisonUIEmissaryMissionsFrame:ClearAllPoints()
            garrisonUIEmissaryMissionsFrame:SetPoint("TOPLEFT", GarrisonLandingPageReport, "BOTTOMLEFT", 40, 120)
            garrisonUIEmissaryMissionsFrame:SetSize(290, 80)
            garrisonUIEmissaryMissionsFrame:SetFrameLevel(5)

            garrisonUIEmissaryMissionsFrame.texture = garrisonUIEmissaryMissionsFrame:CreateTexture(nil,"BACKGROUND")
            garrisonUIEmissaryMissionsFrame.texture:SetPoint("TOPLEFT",garrisonUIEmissaryMissionsFrame,"TOPLEFT",0,10)
            garrisonUIEmissaryMissionsFrame.texture:SetPoint("BOTTOMRIGHT",garrisonUIEmissaryMissionsFrame,"BOTTOMRIGHT",10,50)
            garrisonUIEmissaryMissionsFrame.texture:SetTexture("interface/questframe/worldquest")
            garrisonUIEmissaryMissionsFrame.texture:SetTexCoord(0.001953125,0.544921875,0.435546875,0.51421875)

            garrisonUIEmissaryMissionsFrame.title = garrisonUIEmissaryMissionsFrame:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
            garrisonUIEmissaryMissionsFrame.title:SetPoint("TOPLEFT",garrisonUIEmissaryMissionsFrame,"TOPLEFT",-2,-2)
            garrisonUIEmissaryMissionsFrame.title:SetWidth(302)
            garrisonUIEmissaryMissionsFrame.title:SetHeight(12)
            garrisonUIEmissaryMissionsFrame.title:SetJustifyV("MIDDLE")
            garrisonUIEmissaryMissionsFrame.title:SetJustifyH("CENTER")
            garrisonUIEmissaryMissionsFrame.title:SetText("|cFFFFFFFF" .. L["EmissaryMissions_Title"] .. "|r")

            garrisonUIEmissaryMissionsFrameDisabled:ClearAllPoints()
            garrisonUIEmissaryMissionsFrameDisabled:SetPoint("TOPLEFT", GarrisonLandingPageReport, "BOTTOMLEFT", 40, 120)
            garrisonUIEmissaryMissionsFrameDisabled:SetSize(290, 80)
            garrisonUIEmissaryMissionsFrameDisabled:SetFrameLevel(5)

            garrisonUIEmissaryMissionsFrameDisabled.message = garrisonUIEmissaryMissionsFrameDisabled:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
            garrisonUIEmissaryMissionsFrameDisabled.message:SetPoint("TOPLEFT",garrisonUIEmissaryMissionsFrameDisabled,"TOPLEFT",-2,-2)
            garrisonUIEmissaryMissionsFrameDisabled.message:SetWidth(302)
            garrisonUIEmissaryMissionsFrameDisabled.message:SetHeight(40)
            garrisonUIEmissaryMissionsFrameDisabled.message:SetJustifyV("MIDDLE")
            garrisonUIEmissaryMissionsFrameDisabled.message:SetJustifyH("CENTER")
            garrisonUIEmissaryMissionsFrameDisabled.message:SetText("|cFFFFFFFF" .. L["EmissaryMissions_Locked"] .. "|r")

            emissaryMissionBorderFrame_1 = CreateFrame('CheckButton', nil, garrisonUIEmissaryMissionsFrame, 'UIButtonTemplate')
            emissaryMissionBorderFrame_1:SetPoint('TOPLEFT', 58 * 1 - 2, -28)
            emissaryMissionBorderFrame_1:SetSize(58,58)
            emissaryMissionBorderFrame_1:SetFrameLevel(10)
            emissaryMissionBorderFrame_1:SetNormalTexture('Artifacts-PerkRing-Final')

            emissaryMissionBorderFrame_2 = CreateFrame('CheckButton', nil, garrisonUIEmissaryMissionsFrame, 'UIButtonTemplate')
            emissaryMissionBorderFrame_2:SetPoint('TOPLEFT', 58 * 2 , -28)
            emissaryMissionBorderFrame_2:SetSize(58,58)
            emissaryMissionBorderFrame_2:SetFrameLevel(10)
            emissaryMissionBorderFrame_2:SetNormalTexture('Artifacts-PerkRing-Final')

            emissaryMissionBorderFrame_3 = CreateFrame('CheckButton', nil, garrisonUIEmissaryMissionsFrame, 'UIButtonTemplate')
            emissaryMissionBorderFrame_3:SetPoint('TOPLEFT', 58 * 3 + 2, -28)
            emissaryMissionBorderFrame_3:SetSize(58,58)
            emissaryMissionBorderFrame_3:SetFrameLevel(10)
            emissaryMissionBorderFrame_3:SetNormalTexture('Artifacts-PerkRing-Final')

            emissaryMissionCpmpletedFrame_1 = CreateFrame('CheckButton', nil, garrisonUIEmissaryMissionsFrame, 'UIButtonTemplate')
            emissaryMissionCpmpletedFrame_1:SetPoint('TOPLEFT', 64 * 1 - 0, -38)
            emissaryMissionCpmpletedFrame_1:SetSize(40,40)
            emissaryMissionCpmpletedFrame_1:SetFrameLevel(8)
            emissaryMissionCpmpletedFrame_1:SetNormalTexture('worldquest-tracker-checkmark')

            emissaryMissionCpmpletedFrame_2 = CreateFrame('CheckButton', nil, garrisonUIEmissaryMissionsFrame, 'UIButtonTemplate')
            emissaryMissionCpmpletedFrame_2:SetPoint('TOPLEFT', 64 * 2 - 6, -38)
            emissaryMissionCpmpletedFrame_2:SetSize(40,40)
            emissaryMissionCpmpletedFrame_2:SetFrameLevel(8)
            emissaryMissionCpmpletedFrame_2:SetNormalTexture('worldquest-tracker-checkmark')

            emissaryMissionCpmpletedFrame_3 = CreateFrame('CheckButton', nil, garrisonUIEmissaryMissionsFrame, 'UIButtonTemplate')
            emissaryMissionCpmpletedFrame_3:SetPoint('TOPLEFT', 64 * 3 - 10, -38)
            emissaryMissionCpmpletedFrame_3:SetSize(40,40)
            emissaryMissionCpmpletedFrame_3:SetFrameLevel(9)
            emissaryMissionCpmpletedFrame_3:SetNormalTexture('worldquest-tracker-checkmark')

            -- Sinalização de missão de emissário expirando (emissaryMissionExpiringFrame) só é necessário para a primeira janela pois nunca deve existir duas missões com
            -- o mesmo dia para encerramento para um mesmo contexto.
            emissaryMissionExpiringFrame = CreateFrame('CheckButton', nil, garrisonUIEmissaryMissionsFrame, 'UIButtonTemplate')
            emissaryMissionExpiringFrame:SetPoint('TOPLEFT', 75 * 1 - 0, -58)
            emissaryMissionExpiringFrame:SetSize(20,20)
            emissaryMissionExpiringFrame:SetFrameLevel(9)
            emissaryMissionExpiringFrame:SetNormalTexture('questlog-questtypeicon-clockorange')

            emissaryMissionIconFrame_1 = CreateFrame('CheckButton', nil, garrisonUIEmissaryMissionsFrame, 'UIButtonTemplate')
            emissaryMissionIconFrame_1:SetPoint('TOPLEFT', 60 * 1, -30)
            emissaryMissionIconFrame_1:SetSize(50,50)
            emissaryMissionIconFrame_1.texture_1 = emissaryMissionIconFrame_1:CreateTexture()
            emissaryMissionIconFrame_1.texture_1:SetAllPoints(emissaryMissionIconFrame_1)

            emissaryMissionIconFrame_2 = CreateFrame('CheckButton', nil, garrisonUIEmissaryMissionsFrame, 'UIButtonTemplate')
            emissaryMissionIconFrame_2:SetPoint('TOPLEFT', 60 * 2, -30)
            emissaryMissionIconFrame_2:SetSize(50,50)
            emissaryMissionIconFrame_2.texture_2 = emissaryMissionIconFrame_2:CreateTexture()
            emissaryMissionIconFrame_2.texture_2:SetAllPoints(emissaryMissionIconFrame_2)

            emissaryMissionIconFrame_3 = CreateFrame('CheckButton', nil, garrisonUIEmissaryMissionsFrame, 'UIButtonTemplate')
            emissaryMissionIconFrame_3:SetPoint('TOPLEFT', 60 * 3, -30)
            emissaryMissionIconFrame_3:SetSize(50,50)
            emissaryMissionIconFrame_3.texture_3 = emissaryMissionIconFrame_3:CreateTexture()
            emissaryMissionIconFrame_3.texture_3:SetAllPoints(emissaryMissionIconFrame_3)

            emissaryMissionIconFrameHover_1 = CreateFrame('CheckButton', emissaryMissionIconFrame, garrisonUIEmissaryMissionsFrame, '')
            emissaryMissionIconFrameHover_1:SetPoint('TOPLEFT', 60 * 1 -4, -28)
            emissaryMissionIconFrameHover_1:SetSize(58,58)
            emissaryMissionIconFrameHover_1:SetFrameLevel(12)

            emissaryMissionIconFrameHover_2 = CreateFrame('CheckButton', emissaryMissionIconFrame, garrisonUIEmissaryMissionsFrame, '')
            emissaryMissionIconFrameHover_2:SetPoint('TOPLEFT', 60 * 2 -4, -28)
            emissaryMissionIconFrameHover_2:SetSize(58,58)
            emissaryMissionIconFrameHover_2:SetFrameLevel(12)

            emissaryMissionIconFrameHover_3 = CreateFrame('CheckButton', emissaryMissionIconFrame, garrisonUIEmissaryMissionsFrame, '')
            emissaryMissionIconFrameHover_3:SetPoint('TOPLEFT', 60 * 3 -4, -28)
            emissaryMissionIconFrameHover_3:SetSize(58,58)
            emissaryMissionIconFrameHover_3:SetFrameLevel(12)           
    end

    garrisonUIEmissaryMissionsFrame:Hide()

    local mapID = 0

    if(_garrisonID == 3) then
        --627 - Legion - Dalaran
        mapID = 627
    end
    if(_garrisonID == 9) then
        if(PlayerInfo["Faction"] == "Alliance") then
            --1161 - BFA - Estreito Tiragarde
            mapID = 1161
        end
        if(PlayerInfo["Faction"] == "Horde") then
            --862 - BFA - Zuldazar
            mapID = 862
        end
    end

    if mapID ~= 0 then

        garrisonUIEmissaryMissionsFrame:Show()

        local emissaryMission = {}
        local emissaryMissionHover = {}
        local emissaryMissionBorder = {}
        local bountyList = C_QuestLog.GetBountiesForMapID(mapID)
        local _bountyList = {}

        if bountyList then
            for _, bounty in ipairs(bountyList) do
                local info = {}
                local obj = C_QuestLog.GetQuestObjectives(bounty.questID)
                
                info.text =  C_QuestLog.GetTitleForQuestID(bounty.questID)
                info.objective = obj[1].text
                info.complete = C_QuestLog.IsComplete(bounty.questID)
                info.icon = bounty.icon
                info.value = bounty.questID
                info.checked = info.value == value
                info.remainingTimeMinutes = C_TaskQuest.GetQuestTimeLeftMinutes(bounty.questID)
                local numQuestRewards = GetNumQuestLogRewards(bounty.questID)
                local name, texture, numItems, currencyID
                local hasCurrencyReward = false
                local hasMoneyReward = false

                local money = GetQuestLogRewardMoney(bounty.questID)
                
                if ( money > 0 ) then
                        local gold = floor(money / (10000))
                        info.rewardTexture = "Coin-Gold"
                        info.rewardName = ""
                        info.rewardNumItems = gold
                        hasMoneyReward = true  
                end

                if not ( money > 0 ) then
                for _, currencyInfo in ipairs(C_QuestLog.GetQuestRewardCurrencies(bounty.questID)) do
                        info.rewardName = currencyInfo.name
                        info.rewardTexture = currencyInfo.texture
                        info.rewardNumItems = currencyInfo.totalRewardAmount    
                        info.currencyID = currencyInfo.currencyID
                        hasCurrencyReward = true              
                end
                end
                
                if numQuestRewards > 0 then
                    info.rewardName, info.rewardTexture, info.rewardNumItems, info.rewardQuality, info.rewardIsUsable, info.rewardItemID = GetQuestLogRewardInfo(1, bounty.questID);
                elseif hasMoneyReward then
                    --already loaded, do not overwrite
                elseif hasCurrencyReward then
                    --already loaded, do not overwrite
                else
                    info.rewardName = ""
                    info.rewardTexture = ""
                    info.rewardNumItems = ""
                    emissaryMissionRewardLoadedOk = false
                end
                table.insert(_bountyList,info)
            end

            if (table.getn(_bountyList) == 2) then
                table.insert(_bountyList,addDummyEmissaryQuest(L["EmissaryMissions_Inactive"], L["EmissaryMissions_RespawnTime_1_Day"], 0))
            elseif (table.getn(_bountyList) == 1) then
                table.insert(_bountyList,addDummyEmissaryQuest(L["EmissaryMissions_Inactive"], L["EmissaryMissions_RespawnTime_1_Day"], 0))
                table.insert(_bountyList,addDummyEmissaryQuest(L["EmissaryMissions_Inactive"], L["EmissaryMissions_RespawnTime_2_Day"], 0))
            elseif (table.getn(_bountyList) == 0) then
                table.insert(_bountyList,addDummyEmissaryQuest(L["EmissaryMissions_Inactive"], L["EmissaryMissions_RespawnTime_1_Day"], 0)) -- "Missão indisponível", "Retorne amanhã para uma nova missão"
                table.insert(_bountyList,addDummyEmissaryQuest(L["EmissaryMissions_Inactive"], L["EmissaryMissions_RespawnTime_2_Day"], 0)) -- "Missão indisponível", "Retorne em dois dias para uma nova missão"
                table.insert(_bountyList,addDummyEmissaryQuest(L["EmissaryMissions_Inactive"], L["EmissaryMissions_RespawnTime_3_Day"], 0)) -- "Missão indisponível", "Retorne em três dias para uma nova missão"
            end

        end

            for _id, _emissaryMission in pairs(_bountyList) do 
                if _id == 1 then          
                emissaryMissionIconFrame_1.texture_1:SetTexture(_emissaryMission.icon)
                emissaryMissionIconFrame_1:Show()
                emissaryMissionIconFrame_1.tabIndex = #emissaryMission + 1
                emissaryMissionBorderFrame_1.tooltip = _emissaryMission.text
                emissaryMissionBorderFrame_1.tabIndex = #emissaryMissionBorder + 1
                
                if(_emissaryMission.complete) then
                    emissaryMissionCpmpletedFrame_1:Show()
                else
                    emissaryMissionCpmpletedFrame_1:Hide()
                end

                if(_emissaryMission.complete or _emissaryMission.text == L["EmissaryMissions_Inactive"]) then
                    emissaryMissionExpiringFrame:Hide()
                else
                    if(_emissaryMission.remainingTimeMinutes < 360) then
                        emissaryMissionExpiringFrame:Show()
                    else
                        emissaryMissionExpiringFrame:Hide()
                    end
                end

                

                emissaryMissionIconFrameHover_1:SetScript('OnClick',function(self)
                    if (_emissaryMission.text ~= L["EmissaryMissions_Inactive"]) then
                        OpenWorldMap(mapID)
                    end
                end)

                SetPortraitToTexture(emissaryMissionIconFrame_1.texture_1, _emissaryMission.icon)

                local hours = math.floor(_emissaryMission.remainingTimeMinutes / 60)
                local days =  math.floor(hours / 24)
                if(days > 0) then
                    hours = math.fmod(hours,24)
                end
                local minutes = math.fmod(_emissaryMission.remainingTimeMinutes,60)

                local daysText = L["EmissaryMissions_RemainingTime_Days_P"]
                local hoursText = L["EmissaryMissions_RemainingTime_Hours_P"]
                local minutesText = L["EmissaryMissions_RemainingTime_Minutes_P"]

                if(days == 1) then
                    daysText = L["EmissaryMissions_RemainingTime_Days_S"]
                end

                if(hours == 1) then
                    hoursText = L["EmissaryMissions_RemainingTime_Hours_S"]
                end

                if(minutes == 1) then
                    minutesText = L["EmissaryMissions_RemainingTime_Minutes_S"]
                end

                emissaryMissionIconFrameHover_1:SetNormalTexture('dragonflight-landingbutton-circleglow')
                
                if(_emissaryMission.text ~= nil and _emissaryMission.objective ~= nil and _emissaryMission.rewardName ~= nil and _emissaryMission.rewardNumItems ~= nil and _emissaryMission.rewardTexture ~= nil and _emissaryMission.remainingTimeMinutes ~= nil) then
                    if(days == 0) then
                        emissaryMissionIconFrameHover_1.tooltip = _emissaryMission.text .. "\n|cFFFFC90E" .. L["EmissaryMissions_Objective"] .. "|r " .. _emissaryMission.objective .. ".\n|cFFFFC90E" .. L["EmissaryMissions_RemainingTime"] .. "|r " .. hours .. hoursText .. minutes .. minutesText .. "\n|cFFFFC90E" .. L["EmissaryMissions_Reward"] .. "|r" .. CreateInlineIcon(_emissaryMission.rewardTexture) .. _emissaryMission.rewardNumItems .. " " .. _emissaryMission.rewardName
                    else
                        emissaryMissionIconFrameHover_1.tooltip = _emissaryMission.text .. "\n|cFFFFC90E" .. L["EmissaryMissions_Objective"] .. "|r " .. _emissaryMission.objective .. ".\n|cFFFFC90E" .. L["EmissaryMissions_RemainingTime"] .. "|r " .. days .. daysText .. hours .. hoursText .. minutes .. minutesText .. "\n|cFFFFC90E" .. L["EmissaryMissions_Reward"] .. "|r" .. CreateInlineIcon(_emissaryMission.rewardTexture) .. _emissaryMission.rewardNumItems .. " " .. _emissaryMission.rewardName
                    end
                end

                if(_emissaryMission.remainingTimeMinutes == 0) then
                    emissaryMissionIconFrameHover_1.tooltip = _emissaryMission.text .. "\n" .. _emissaryMission.objective
                end

                table.insert(emissaryMission, emissaryMissionIconFrame_1)
                table.insert(emissaryMissionHover, emissaryMissionIconFrameHover_1)
                table.insert(emissaryMissionBorder, emissaryMissionBorderFrame_1)
                end

                if _id == 2 then          
                emissaryMissionIconFrame_2.texture_2:SetTexture(_emissaryMission.icon)
                emissaryMissionIconFrame_2:Show()
                emissaryMissionIconFrame_2.tabIndex = #emissaryMission + 1
                emissaryMissionBorderFrame_2.tooltip = _emissaryMission.text
                emissaryMissionBorderFrame_2.tabIndex = #emissaryMissionBorder + 1

                if(_emissaryMission.complete) then
                    emissaryMissionCpmpletedFrame_2:Show()
                else
                    emissaryMissionCpmpletedFrame_2:Hide()
                end

                emissaryMissionIconFrameHover_2:SetScript('OnClick',function(self)
                    if (_emissaryMission.text ~= L["EmissaryMissions_Inactive"]) then
                        OpenWorldMap(mapID)
                    end
                    end)

                SetPortraitToTexture(emissaryMissionIconFrame_2.texture_2, _emissaryMission.icon)

                local hours = math.floor(_emissaryMission.remainingTimeMinutes / 60)
                local days =  math.floor(hours / 24)
                if(days > 0) then
                    hours = math.fmod(hours,24)
                end
                local minutes = math.fmod(_emissaryMission.remainingTimeMinutes,60)

                local daysText = L["EmissaryMissions_RemainingTime_Days_P"]
                local hoursText = L["EmissaryMissions_RemainingTime_Hours_P"]
                local minutesText = L["EmissaryMissions_RemainingTime_Minutes_P"]

                if(days == 1) then
                    daysText = L["EmissaryMissions_RemainingTime_Days_S"]
                end

                if(hours == 1) then
                    hoursText = L["EmissaryMissions_RemainingTime_Hours_S"]
                end

                if(minutes == 1) then
                    minutesText = L["EmissaryMissions_RemainingTime_Minutes_S"]
                end

                emissaryMissionIconFrameHover_2:SetNormalTexture('dragonflight-landingbutton-circleglow')
                
                if(_emissaryMission.text ~= nil and _emissaryMission.objective ~= nil and _emissaryMission.rewardName ~= nil and _emissaryMission.rewardNumItems ~= nil and _emissaryMission.rewardTexture ~= nil and _emissaryMission.remainingTimeMinutes ~= nil) then
                    if(days == 0) then
                        emissaryMissionIconFrameHover_2.tooltip = _emissaryMission.text .. "\n|cFFFFC90E" .. L["EmissaryMissions_Objective"] .. "|r " .. _emissaryMission.objective .. ".\n|cFFFFC90E" .. L["EmissaryMissions_RemainingTime"] .. "|r " .. hours .. hoursText .. minutes .. minutesText .. "\n|cFFFFC90E" .. L["EmissaryMissions_Reward"] .. "|r" .. CreateInlineIcon(_emissaryMission.rewardTexture) .. _emissaryMission.rewardNumItems .. " " .. _emissaryMission.rewardName
                    else
                        emissaryMissionIconFrameHover_2.tooltip = _emissaryMission.text .. "\n|cFFFFC90E" .. L["EmissaryMissions_Objective"] .. "|r " .. _emissaryMission.objective .. ".\n|cFFFFC90E" .. L["EmissaryMissions_RemainingTime"] .. "|r " .. days .. daysText .. hours .. hoursText .. minutes .. minutesText .. "\n|cFFFFC90E" .. L["EmissaryMissions_Reward"] .. "|r" .. CreateInlineIcon(_emissaryMission.rewardTexture) .. _emissaryMission.rewardNumItems .. " " .. _emissaryMission.rewardName
                    end
                end

                if(_emissaryMission.remainingTimeMinutes == 0) then
                    emissaryMissionIconFrameHover_2.tooltip = _emissaryMission.text .. "\n" .. _emissaryMission.objective
                end

                table.insert(emissaryMission, emissaryMissionIconFrame_2)
                table.insert(emissaryMissionHover, emissaryMissionIconFrameHover_2)
                table.insert(emissaryMissionBorder, emissaryMissionBorderFrame_2)
                end

                if _id == 3 then          
                emissaryMissionIconFrame_3.texture_3:SetTexture(_emissaryMission.icon)           
                emissaryMissionIconFrame_3:Show()
                emissaryMissionIconFrame_3.tabIndex = #emissaryMission + 1

                emissaryMissionBorderFrame_3.tooltip = _emissaryMission.text
                emissaryMissionBorderFrame_3.tabIndex = #emissaryMissionBorder + 1

                if(_emissaryMission.complete) then
                    emissaryMissionCpmpletedFrame_3:Show()
                else
                    emissaryMissionCpmpletedFrame_3:Hide()
                end

                emissaryMissionIconFrameHover_3:SetScript('OnClick',function(self)
                    if (_emissaryMission.text ~= L["EmissaryMissions_Inactive"]) then
                        OpenWorldMap(mapID)
                    end
                end)

                SetPortraitToTexture(emissaryMissionIconFrame_3.texture_3, _emissaryMission.icon)

                local hours = math.floor(_emissaryMission.remainingTimeMinutes / 60)
                local days =  math.floor(hours / 24)
                if(days > 0) then
                    hours = math.fmod(hours,24)
                end
                local minutes = math.fmod(_emissaryMission.remainingTimeMinutes,60)

                local daysText = L["EmissaryMissions_RemainingTime_Days_P"]
                local hoursText = L["EmissaryMissions_RemainingTime_Hours_P"]
                local minutesText = L["EmissaryMissions_RemainingTime_Minutes_P"]

                if(days == 1) then
                    daysText = L["EmissaryMissions_RemainingTime_Days_S"]
                end

                if(hours == 1) then
                    hoursText = L["EmissaryMissions_RemainingTime_Hours_S"]
                end

                if(minutes == 1) then
                    minutesText = L["EmissaryMissions_RemainingTime_Minutes_S"]
                end

                emissaryMissionIconFrameHover_3:SetNormalTexture('dragonflight-landingbutton-circleglow')

                if(_emissaryMission.text ~= nil and _emissaryMission.objective ~= nil and _emissaryMission.rewardName ~= nil and _emissaryMission.rewardNumItems ~= nil and _emissaryMission.rewardTexture ~= nil and _emissaryMission.remainingTimeMinutes ~= nil) then
                    if(days == 0) then
                        emissaryMissionIconFrameHover_3.tooltip = _emissaryMission.text .. "\n|cFFFFC90E" .. L["EmissaryMissions_Objective"] .. "|r " .. _emissaryMission.objective .. ".\n|cFFFFC90E" .. L["EmissaryMissions_RemainingTime"] .. "|r " .. hours .. hoursText .. minutes .. minutesText .. "\n|cFFFFC90E" .. L["EmissaryMissions_Reward"] .. "|r" .. CreateInlineIcon(_emissaryMission.rewardTexture) .. _emissaryMission.rewardNumItems .. " " .. _emissaryMission.rewardName
                    else
                        emissaryMissionIconFrameHover_3.tooltip = _emissaryMission.text .. "\n|cFFFFC90E" .. L["EmissaryMissions_Objective"] .. "|r " .. _emissaryMission.objective .. ".\n|cFFFFC90E" .. L["EmissaryMissions_RemainingTime"] .. "|r " .. days .. daysText .. hours .. hoursText .. minutes .. minutesText .. "\n|cFFFFC90E" .. L["EmissaryMissions_Reward"] .. "|r" .. CreateInlineIcon(_emissaryMission.rewardTexture) .. _emissaryMission.rewardNumItems .. " " .. _emissaryMission.rewardName
                    end
                end

                if(_emissaryMission.remainingTimeMinutes == 0) then
                    emissaryMissionIconFrameHover_3.tooltip = _emissaryMission.text .. "\n" .. _emissaryMission.objective
                end

                table.insert(emissaryMission, emissaryMissionIconFrame_3)
                table.insert(emissaryMissionHover, emissaryMissionIconFrameHover_3)
                table.insert(emissaryMissionBorder, emissaryMissionBorderFrame_3)
                end
            end  

            for _, _garBorder in pairs(emissaryMissionBorder) do
                    _garBorder:SetScript("OnEnter", function(self)
                        emissaryMissionHover[_garBorder.tabIndex]:Show()
                    end)
            end

            for _, _garTabHover in pairs(emissaryMissionHover) do
                    _garTabHover:SetScript("OnEnter", function(self)
                        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")

                        --Reload widget to fix mission rewards not loaded.
                        if(not emissaryMissionRewardLoadedOk) then
                            emissaryMissionRewardLoadedOk = true
                            drawGarrisonReportEmissaryMissionsWidget(_garrisonID)
                        end

                        CTT_ShowIconTooltip(GameTooltip, _garTabHover.tooltip)
                        GameTooltip:Show()
                    end)

                    _garTabHover:SetScript("OnLeave", function(self)
                        GameTooltip:Hide()
                        _garTabHover:Hide()
                    end)
            end

            for _, _garTabHover in pairs(emissaryMissionHover) do
                _garTabHover:Hide()
            end

        if(_garrisonID == 3 or _garrisonID == 9) then
            if(ChromieTimeTrackerDB.ShowEmissaryMissionsOnReportWindow or ChromieTimeTrackerDB.ShowEmissaryMissionsOnReportWindow == nil) then
                if bountyList ~= nil then
                    garrisonUIEmissaryMissionsFrame:Show()
                    garrisonUIEmissaryMissionsFrameDisabled:Hide()
                else
                    garrisonUIEmissaryMissionsFrame:Hide()
                    garrisonUIEmissaryMissionsFrameDisabled:Show()
                end
            else
                garrisonUIEmissaryMissionsFrame:Hide()
                garrisonUIEmissaryMissionsFrameDisabled:Hide()
            end
        else
            garrisonUIEmissaryMissionsFrame:Hide()
            garrisonUIEmissaryMissionsFrameDisabled:Hide()
        end

    else
        garrisonUIEmissaryMissionsFrame:Hide()
        garrisonUIEmissaryMissionsFrameDisabled:Hide()
    end

end

--Add Emissary Missions to GarrisonLandingPage - Fim

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

--Correção de problemas da interface nativa da Blizzard. Correção baseada em códigos de outros addons que enfrentaram os mesmos problemas. - Início
if (GARRISON_LANDING_COVIEW_PATCH_VERSION or 0) < 3 then
	GARRISON_LANDING_COVIEW_PATCH_VERSION = 3
	hooksecurefunc("ShowGarrisonLandingPage", function(_LandingPageId)
		if GARRISON_LANDING_COVIEW_PATCH_VERSION ~= 3 then
			return
		end
		_LandingPageId = (_LandingPageId or C_Garrison.GetLandingPageGarrisonType() or 0)
		if _LandingPageId ~= 111 and GarrisonLandingPage.SoulbindPanel then
			GarrisonLandingPage.FollowerTab.autoSpellPool:ReleaseAll()
			GarrisonLandingPage.FollowerTab.autoCombatStatsPool:ReleaseAll()
			GarrisonLandingPage.FollowerTab.AbilitiesFrame:Layout()
			GarrisonLandingPage.FollowerTab.CovenantFollowerPortraitFrame:Hide()
		end
		if _LandingPageId > 2 and GarrisonThreatCountersFrame then
			GarrisonThreatCountersFrame:Hide()
		end
		if _LandingPageId > 3 then
			GarrisonLandingPage.FollowerTab.NumFollowers:SetText("")
		end
		if GarrisonLandingPageReport.Sections then
			GarrisonLandingPageReport.Sections:SetShown(_LandingPageId == 111)
		end
	end)
end
--Correção de problemas da interface nativa da Blizzard. Correção baseada em códigos de outros addons que enfrentaram os mesmos problemas. - Fim
