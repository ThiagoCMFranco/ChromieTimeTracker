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

local playerClass, englishClass = UnitClass("player")
englishFaction, localizedFaction = UnitFactionGroup("player")

local PlayerInfo = {}
PlayerInfo["Name"] = ""
PlayerInfo["Class"] = englishClass
PlayerInfo["Faction"] = englishFaction

CurrentGarrisonID = 0

local C_ClassTextures =
{
  --["DRUID"] = "Interface\\Icons\\Classicon_druid",
  --["SHAMAN"] = "Interface\\Icons\\Classicon_shaman",
  --["DEATHKNIGHT"] = "Interface\\Icons\\Classicon_deathknight",
  --["PALADIN"] = "Interface\\Icons\\Classicon_paladin",
  --["WARRIOR"] = "Interface\\Icons\\Classicon_warrior",
  --["HUNTER"] = "Interface\\Icons\\Classicon_hunter",
  --["ROGUE"] = "Interface\\Icons\\Classicon_rogue",
  --["PRIEST"] = "Interface\\Icons\\Classicon_priest",
  --["MAGE"] = "Interface\\Icons\\Classicon_mage",
  --["WARLOCK"] = "Interface\\Icons\\Classicon_warlock",
  --["MONK"] = "Interface\\Icons\\Classicon_monk",
  --["DEMONHUNTER"] = "Interface\\Icons\\Classicon_demonhunter",
  --["EVOKER"] = "Interface\\Icons\\Classicon_evoker",

  ["DRUID"] = "Interface\\Icons\\crest_druid",
  ["SHAMAN"] = "Interface\\Icons\\crest_shaman",
  ["DEATHKNIGHT"] = "Interface\\Icons\\crest_deathknight",
  ["PALADIN"] = "Interface\\Icons\\crest_paladin",
  ["WARRIOR"] = "Interface\\Icons\\crest_warrior",
  ["HUNTER"] = "Interface\\Icons\\crest_hunter",
  ["ROGUE"] = "Interface\\Icons\\crest_rogue",
  ["PRIEST"] = "Interface\\Icons\\crest_priest",
  ["MAGE"] = "Interface\\Icons\\crest_mage",
  ["WARLOCK"] = "Interface\\Icons\\crest_warlock",
  ["MONK"] = "Interface\\Icons\\crest_monk",
  ["DEMONHUNTER"] = "Interface\\Icons\\crest_demonhunter",
  ["EVOKER"] = "Interface\\Icons\\crest_evoker",
}

local C_GarrisonTextures =
{
  ["Alliance"] = "Interface\\Icons\\achievement_garrison_tier01_alliance",
  ["Horde"] = "Interface\\Icons\\achievement_garrison_tier01_horde",
}

local C_WarCampaignTextures =
{
  ["Alliance"] = "Interface\\Icons\\inv_alliancewareffort",
  ["Horde"] = "Interface\\Icons\\inv_hordewareffort",
}

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
        ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips = false;
        ChromieTimeTrackerDB.UseDiferentCoordinatesForIconAndTextBox = false;

        --Set initial value for Avanced Mode settings
        ChromieTimeTrackerDB.AdvShowGarrison = true;
        ChromieTimeTrackerDB.AdvShowClassHall = true;
        ChromieTimeTrackerDB.AdvShowWarEffort = true;
        ChromieTimeTrackerDB.AdvShowCovenant = true;
        ChromieTimeTrackerDB.AdvShowDragonIsles = true;
        ChromieTimeTrackerDB.AdvShowKhazAlgar = true;

        ChromieTimeTrackerDB.AlreadyUsed = true    
    end
end



CTT_SetupFirstAccess()

-- Criação dos frames.
--Principal
local addonRootFrame = CreateFrame("Frame", "ChromieTimeTrackerRootFrame", UIParent, "")
local mainFrame = CreateFrame("Frame", "ChromieTimeTrackerMainFrame", ChromieTimeTrackerRootFrame, "TooltipBorderedFrameTemplate")
local iconFrame = CreateFrame("Frame", "ChromieTimeTrackerMainIconFrame", ChromieTimeTrackerRootFrame, "TooltipBorderedFrameTemplate")
local garrisonIconFrame = CreateFrame("Frame", "ChromieTimeTrackerGarrisonIconFrame", ChromieTimeTrackerRootFrame, "TooltipBorderedFrameTemplate")
local classHallIconFrame = CreateFrame("Frame", "ChromieTimeTrackerClassHallIconFrame", ChromieTimeTrackerRootFrame, "TooltipBorderedFrameTemplate")
local missionsIconFrame = CreateFrame("Frame", "ChromieTimeTrackerMissionsIconFrame", ChromieTimeTrackerRootFrame, "TooltipBorderedFrameTemplate")
local covenantIconFrame = CreateFrame("Frame", "ChromieTimeTrackerCovenantIconFrame", ChromieTimeTrackerRootFrame, "TooltipBorderedFrameTemplate")
local dragonIslesIconFrame = CreateFrame("Frame", "ChromieTimeTrackerDragonIslesIconFrame", ChromieTimeTrackerRootFrame, "TooltipBorderedFrameTemplate")
local khazAlgarIconFrame = CreateFrame("Frame", "ChromieTimeTrackerKhazAlgarIconFrame", ChromieTimeTrackerRootFrame, "TooltipBorderedFrameTemplate")

--Root

local function GeneratorFunction(owner, rootDescription)
	rootDescription:CreateTitle(L["ContextMenuTitle"]);
	rootDescription:CreateButton(L["MiddleClickOption_Warlords"], function(data)
    	CTT_MouseMiddleButtonClick_2(2)
	end);
    if PlayerInfo["Class"]~= "EVOKER" then
        rootDescription:CreateButton(L["MiddleClickOption_Legion"], function(data)
            CTT_MouseMiddleButtonClick_2(3)
        end);
    else
        --Since Evoker was launched after Legion there is no class hall for them.
    end
    rootDescription:CreateButton(L["MiddleClickOption_Missions"], function(data)
    	CTT_MouseMiddleButtonClick_2(9)
	end);
    rootDescription:CreateButton(L["MiddleClickOption_Covenant"], function(data)
    	CTT_MouseMiddleButtonClick_2(111)
	end);
    rootDescription:CreateButton(L["MiddleClickOption_DragonIsles"], function(data)
    	CTT_MouseMiddleButtonClick_2("DF")
	end);
    rootDescription:CreateButton(L["MiddleClickOption_KhazAlgar"], function(data)
    	CTT_MouseMiddleButtonClick_2("TWW")
	end);
    --rootDescription:CreateDivider()
end;


--contextMenu

function CTT_setupRootFrame()

addonRootFrame:ClearAllPoints()
addonRootFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
addonRootFrame:SetSize(280, 195)
addonRootFrame:SetFrameLevel(0)
addonRootFrame:Show()

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
        if IsShiftKeyDown() then
            local contextMenu = MenuUtil.CreateContextMenu(ChromieTimeTrackerRootFrame, GeneratorFunction);
        else
        
        CTT_MouseMiddleButtonClick()

        end
    elseif btn == "RightButton" then
        PlaySound(808)
        ChromieTimeTracker:ToggleSettingsFrame()
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
        addonRootFrame:Show()
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
        --garrisonIconFrame:Show()
        --classHallIconFrame:Show()
        --missionsIconFrame:Show()
        --covenantIconFrame:Show()
        --dragonIslesIconFrame:Show()
        --khazAlgarIconFrame:Show()
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
            if(Summaries[ChromieTimeTrackerDB.DefaultMiddleClickOption] == "" or Summaries[ChromieTimeTrackerDB.DefaultMiddleClickOption] == nil) then
                mainFrame.playerTimeline:SetText(L["ConfigurationMissing"])
            else
                mainFrame.playerTimeline:SetText(Summaries[ChromieTimeTrackerDB.DefaultMiddleClickOption])
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
--iconFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

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
        if IsShiftKeyDown() then
            local contextMenu = MenuUtil.CreateContextMenu(ChromieTimeTrackerRootFrame, GeneratorFunction);
        else
            CTT_MouseMiddleButtonClick()
        end
    elseif btn == "RightButton" then
        PlaySound(808)
        ChromieTimeTracker:ToggleSettingsFrame()
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

function CTT_setupGarrisonIconFrame(_garrisonIconFrame, _garrisonID, _offsetX, _offsetY, _iconName, _TooltipText)

    _garrisonIconFrame:ClearAllPoints()
    _garrisonIconFrame:SetPoint("TOPLEFT", ChromieTimeTrackerRootFrame, "TOPLEFT", _offsetX, _offsetY)
    --iconFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    
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
            CTT_MouseMiddleButtonClick_2(_garrisonID)
        elseif btn == "RightButton" then
            PlaySound(808)
            ChromieTimeTracker:ToggleSettingsFrame()
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
            _garrisonIconFrame:SetSize(34,34)
            _garrisonIconFrame:ClearAllPoints()
            _garrisonIconFrame:SetPoint("TOPLEFT", ChromieTimeTrackerRootFrame, "TOPLEFT", _offsetX-1, _offsetY+1)
    end)
    
    _garrisonIconFrame:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        _garrisonIconFrame:SetSize(32,32)
        _garrisonIconFrame:ClearAllPoints()
        _garrisonIconFrame:SetPoint("TOPLEFT", ChromieTimeTrackerRootFrame, "TOPLEFT", _offsetX, _offsetY)
    end)
        
    _garrisonIconFrame.playerTimeline = _garrisonIconFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    _garrisonIconFrame.playerTimeline:SetPoint("CENTER", iconFrame, "CENTER", 0, 0)

    _garrisonIconFrame.playerTimeline:SetText("")
    _garrisonIconFrame.icon = _garrisonIconFrame:CreateTexture()
    _garrisonIconFrame.icon:SetAllPoints()
    _garrisonIconFrame.icon:SetTexture(_iconName, false)
    
    _garrisonIconFrame:SetSize(32,32)

    _garrisonIconFrame:Show()

    end

    function getClassTexture(_playerClass)    
        return C_ClassTextures[_playerClass]  
    end

    function getFactionTexture(_playerFaction, _context)

        if (_context == "G") then
            return C_GarrisonTextures[_playerFaction]
        else
            return C_WarCampaignTextures[_playerFaction]
        end

    end

function CTT_LoadAvancedModeIcons()

    local iconsCount = 0

    if ChromieTimeTrackerDB.AdvShowGarrison then
        iconsCount = iconsCount + 1;
    end
    if ChromieTimeTrackerDB.AdvShowClassHall then
        if PlayerInfo["Class"]~= "EVOKER" then
            iconsCount = iconsCount + 1;
        else
            --Since Evoker was launched after Legion there is no class hall for them.
        end        
    end
    if ChromieTimeTrackerDB.AdvShowWarEffort then
        iconsCount = iconsCount + 1;
    end
    if ChromieTimeTrackerDB.AdvShowCovenant then
        iconsCount = iconsCount + 1;
    end
    if ChromieTimeTrackerDB.AdvShowDragonIsles then
        iconsCount = iconsCount + 1;
    end
    if ChromieTimeTrackerDB.AdvShowKhazAlgar then
        iconsCount = iconsCount + 1;
    end

    local alignments = {}
    alignments[1] = "LEFT"
    alignments[2] = "CENTER"
    alignments[3] = "RIGHT"



    local alignment = alignments[ChromieTimeTrackerDB.AdvButtonsAlignment] or "CENTER"
    local left = 0
    local iconSize = 32
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

    local position = 0;
    
    if ChromieTimeTrackerDB.AdvShowGarrison then
        CTT_setupGarrisonIconFrame(garrisonIconFrame,2,(left + (step * position)),-35,getFactionTexture(PlayerInfo["Faction"],"G"), L["MiddleClickOption_Warlords"])
        position = position + 1;
    else
        garrisonIconFrame:Hide();
    end
    if ChromieTimeTrackerDB.AdvShowClassHall then
        if PlayerInfo["Class"]~= "EVOKER" then
            CTT_setupGarrisonIconFrame(classHallIconFrame,3,(left + (step * position)),-35,getClassTexture(PlayerInfo["Class"]),  L["MiddleClickOption_Legion"])
            position = position + 1;
        else
            --Since Evoker was launched after Legion there is no class hall for them.
            classHallIconFrame:Hide();    
        end
    else
        classHallIconFrame:Hide();
    end
    if ChromieTimeTrackerDB.AdvShowWarEffort then
        CTT_setupGarrisonIconFrame(missionsIconFrame,9,(left + (step * position)),-35,getFactionTexture(PlayerInfo["Faction"],""),  L["MiddleClickOption_Missions"])
        position = position + 1;
    else
        missionsIconFrame:Hide();
    end
    if ChromieTimeTrackerDB.AdvShowCovenant then
        CTT_setupGarrisonIconFrame(covenantIconFrame,111,(left + (step * position)),-35,"Interface\\Icons\\inv_misc_covenant_renown",  L["MiddleClickOption_Covenant"])
        position = position + 1;
    else
        covenantIconFrame:Hide();
    end
    if ChromieTimeTrackerDB.AdvShowDragonIsles then
        CTT_setupGarrisonIconFrame(dragonIslesIconFrame,"DF",(left + (step * position)),-35,"Interface\\Icons\\ability_dragonriding_diving01",  L["MiddleClickOption_DragonIsles"])
        position = position + 1;
    else
        dragonIslesIconFrame:Hide();
    end
    if ChromieTimeTrackerDB.AdvShowKhazAlgar then
        CTT_setupGarrisonIconFrame(khazAlgarIconFrame,"TWW",(left + (step * position)),-35,"Interface\\Icons\\inv_10_gearupgrade_drakesaspectenhancedcrest",  L["MiddleClickOption_KhazAlgar"]) --ability_earthen_hyperproductive
        position = position + 1;
    else
        khazAlgarIconFrame:Hide();
    end

end

    --CTT_setupGarrisonIconFrame(garrisonIconFrame,2,39,-35,getFactionTexture(englishFaction,"G"), "Guarnição") --achievement_garrison_tier01_horde
    --CTT_setupGarrisonIconFrame(classHallIconFrame,3,73,-35,getClassTexture(englishClass), "Salão de Classe")
    --CTT_setupGarrisonIconFrame(missionsIconFrame,9,107,-35,getFactionTexture(englishFaction,""), "Missões de Seguidor") --inv_hordewareffort
    --CTT_setupGarrisonIconFrame(covenantIconFrame,111,141,-35,"Interface\\Icons\\inv_misc_covenant_renown", "Santuário do Pacto")
    --CTT_setupGarrisonIconFrame(dragonIslesIconFrame,"DF",175,-35,"Interface\\Icons\\ability_dragonriding_diving01", "As Ilhas do Dragão")
    --CTT_setupGarrisonIconFrame(khazAlgarIconFrame,"TWW",209,-35,"Interface\\Icons\\inv_10_gearupgrade_drakesaspectenhancedcrest", "Khaz Algar") --ability_earthen_hyperproductive

function ChromieTimeTracker:ToggleMainFrame()
    if not addonRootFrame:IsShown() then
        addonRootFrame:Show()
    else
        addonRootFrame:Hide()
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
            else
                addonRootFrame:Show()
            end
        elseif btn == "RightButton" then
            PlaySound(808)
            ChromieTimeTracker:ToggleSettingsFrame()
        elseif btn == "MiddleButton" then

            if IsShiftKeyDown() then
                local contextMenu = MenuUtil.CreateContextMenu(ChromieTimeTrackerRootFrame, GeneratorFunction);
            else

            CTT_MouseMiddleButtonClick()
            
            end
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
        --if (ChromieTimeTrackerDB.Mode == 4) then
        --    CTT_LoadAvancedModeIcons()
        --end
        print(L["ChatAddonLoadedMessage"] .. CTT_getChromieTime() .. ".")
    end
    if event == "QUEST_LOG_UPDATE" then
        CTT_updateChromieTime()
        --if (ChromieTimeTrackerDB.Mode == 4) then
        --    CTT_LoadAvancedModeIcons()
        --end
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
    addonRootFrame:Show()
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

function CTT_MouseMiddleButtonClick_2(_garrisonID)
 --A FAZER: VALIDAR EXIBIÇÃO DE CADA EXPANSÃO E APRESENTAR QUANDO DISPONÍVEL.
 if _garrisonID == 111 then
    if C_Covenants.GetActiveCovenantID() ~= 0 and C_Covenants.GetActiveCovenantID() ~= nil then
        ShowGarrisonLandingPage(_garrisonID)
    else
        requisito = L["UndiscoveredContentUnlockRequirement_Covenant"]
        CTT_flashMessage(L["UndiscoveredContent"]  .. L["UndiscoveredContent_Covenant"] .. requisito, 5, 1.5)
    end
elseif _garrisonID == 2 or _garrisonID == 3 or _garrisonID == 9 then
 if not not (C_Garrison.GetGarrisonInfo(_garrisonID)) then
    ShowGarrisonLandingPage(_garrisonID)
 else
    local funcionalidade = ""
    if (_garrisonID == 2) then
        funcionalidade = L["UndiscoveredContent_Warlords"]
        requisito = L["UndiscoveredContentUnlockRequirement_Warlords"]
        CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
    elseif (_garrisonID == 3) then
        funcionalidade = L["UndiscoveredContent_Legion"]
        requisito = L["UndiscoveredContentUnlockRequirement_Legion"]
        CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
    elseif (_garrisonID == 9) then
        funcionalidade = L["UndiscoveredContent_Missions"]
        requisito = L["UndiscoveredContentUnlockRequirement_Missions"]
        CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
    else
        funcionalidade = ""
        CTT_flashMessage(L["ConfigurationMissing"], 5, 1.5)
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
            CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
        end
    elseif _garrisonID == "TWW" then
        local funcionalidade = ""
        if(C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(10)) then
            CTT_OpenExpansionLandingPage(_garrisonID);
        else
            funcionalidade = L["UndiscoveredContent_KhazAlgar"]
            requisito = L["UndiscoveredContentUnlockRequirement_KhazAlgar"]
            CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
        end
    else
        CTT_flashMessage(L["ConfigurationMissing"], 5, 1.5)
    end
end
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
                            if PlayerInfo["Class"]~= "EVOKER" then
                                funcionalidade = L["UndiscoveredContent_Legion"]
                                requisito = L["UndiscoveredContentUnlockRequirement_Legion"]
                                CTT_flashMessage(L["UndiscoveredContent"]  .. funcionalidade .. requisito , 5, 1.5)
                            else
                                --Since Evoker was launched after Legion there is no class hall for them.
                                CTT_flashMessage(L["EvokerHasNoClassHall"], 5, 1.5)
                            end
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

function CTT_ShowIconTooltip(tooltip, text)
    tooltip:AddLine("|cFFFFFFFF" .. text .. "|r", nil, nil, nil, nil)
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

        if (ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips) then
            tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. LClickAction .. "\n" .. MClickAction .. "\n" .. L["ShiftMClickAction"] .. "\n" .. L["RClickAction"] .."", nil, nil, nil, nil)
        else
            tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. LClickAction .. "\n" .. MClickAction .. "\n" .. L["ShiftMClickAction"] .. "\n" .. L["RClickAction"] .. "\n\n".. L["DevelopmentTeamCredit"] .."", nil, nil, nil, nil)
        end
        
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

        if (ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips) then
            tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. LClickAction .. "\n" .. L["ShiftMClickAction"] .. "\n" .. MClickAction .. "\n" .. L["RClickAction"] .. "", nil, nil, nil, nil)
        else
            tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. LClickAction .. "\n" .. L["ShiftMClickAction"] .. "\n" .. MClickAction .. "\n" .. L["RClickAction"] .. "\n\n".. L["DevelopmentTeamCredit"] .."", nil, nil, nil, nil)
        end
    else
        if (ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips) then
            tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. LClickAction .. "\n" .. L["ShiftMClickAction"] .. "\n" .. L["RClickAction"] .."", nil, nil, nil, nil)
        else
            tooltip:AddLine(L["AddonName"] .. "\n\n|cFFFFFFFF" .. CTT_getChromieTime() .. "|r.\n\n" .. LClickAction .. "\n" .. L["ShiftMClickAction"] .. "\n" .. L["RClickAction"] .. "\n\n".. L["DevelopmentTeamCredit"] .."", nil, nil, nil, nil)
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

function CTT_setupSlashCommands()
    -- Criação dos slash comands.
    
    SLASH_ChromieTimeTracker1 = "/ChromieTimeTracker"
    SLASH_ChromieTimeTracker2 = "/ctt"
    SlashCmdList["ChromieTimeTracker"] = function(arg)
        if(arg == "config") then
            ChromieTimeTracker:ToggleSettingsFrame()
            
        elseif(arg == "DF" or arg == "TWW") then
            CTT_OpenExpansionLandingPage(arg)
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
    
            addonRootFrame:Show()

            print(L["RunCommandMessage_ResetPosition"])
    
        elseif(arg == "resetSettings") then
            ChromieTimeTrackerDB.Mode = 2;
            ChromieTimeTrackerDB.HideWhenNotTimeTraveling = false;
            ChromieTimeTrackerDB.LockDragDrop = false;
            ChromieTimeTrackerDB.AlternateModeShowIconOnly = false;
            ChromieTimeTrackerDB.DefaultMiddleClickOption = "";
            ChromieTimeTrackerDB.LockMiddleClickOption = false;
            ChromieTimeTrackerDB.HideDeveloperCreditOnTooltips = false;
            ChromieTimeTrackerDB.UseDiferentCoordinatesForIconAndTextBox = false;
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
                addonRootFrame:Hide()
            else
                addonRootFrame:Show()
            end
        end
    end
    end
    
    CTT_setupSlashCommands()

    --print(L["ChatAddonLoadedMessage"] .. CTT_getChromieTime() .. ".")
