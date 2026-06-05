local name, mct = ...
local L = mct.L 

local C_LandingPagesTextures = mct.C_LandingPagesTextures
local C_GarrisonTextures = mct.C_GarrisonTextures
local C_ClassTextures = mct.C_ClassTextures
local C_WarCampaignTextures = mct.C_WarCampaignTextures
local C_CovenantChoicesTextures = mct.C_CovenantChoicesTextures
local C_PandariaTabTextures = mct.C_PandariaTabTextures

local isUnlocked = {}

local playerClass, englishClass = UnitClass("player")
englishFaction, localizedFaction = UnitFactionGroup("player")

local PlayerInfo = {}
PlayerInfo["Name"] = ""
PlayerInfo["Class"] = englishClass
PlayerInfo["Faction"] = englishFaction
PlayerInfo["Timeline"] = ""

local _CovData = {}
        _CovData = getCovenantData()

-- 1. CONFIGURAÇÃO
local config = {
    triggerType = "CLICK", 
    radius = 50,
    hideDelay = 1.5,
    mainIcon = "Interface\\AddOns\\ChromieTimeTracker\\Chromie.png",
    buttonData = {
        { id = "MoPReport", icon = C_PandariaTabTextures[PlayerInfo["Faction"] .. "_Map"], type = "Atlas", tooltip = L["MiddleClickOption_Mists"] },
        { id = 2, icon = C_GarrisonTextures[PlayerInfo["Faction"]], type = "Atlas", tooltip = L["MiddleClickOption_Warlords"] },
        { id = 3, icon = C_ClassTextures[PlayerInfo["Class"]], type = "Atlas", tooltip = L["MiddleClickOption_Legion"] },
        { id = 9, icon = C_WarCampaignTextures[PlayerInfo["Faction"]], type = "Atlas", tooltip = L["MiddleClickOption_Missions"] },
        { id = 111, icon = C_CovenantChoicesTextures[_CovData[1]], type = "Atlas", tooltip = string.format(L["MiddleClickOption_Covenant"], _CovData[3]) },
        { id = "DF", icon = C_LandingPagesTextures["DragonIsles"], type = "Atlas", tooltip = L["MiddleClickOption_DragonIsles"] },
        { id = "TWW", icon = C_LandingPagesTextures["KhazAlgar"], type = "Atlas", tooltip = L["MiddleClickOption_KhazAlgar"] },
        { id = "MN", icon = C_LandingPagesTextures["Midnight"], type = "Atlas", tooltip = L["MiddleClickOption_Midnight"] },
    }
}

-- 2. BOTÃO PRINCIPAL (Criado sem template para usar seu visual customizado)
local MainButton = CreateFrame("Button", "CTTRadialMenu", ChromieTimeTrackerRootFrame)
MainButton:SetSize(40, 40)
MainButton:SetPoint("CENTER", 0, 0)
MainButton.childButtons = {}
MainButton.isExpanded = false
MainButton:SetMovable(true)
MainButton:RegisterForDrag("LeftButton")
MainButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")

-- 3. SUA FUNÇÃO INTEGRAL (RESTAURADA E LIMPA)
function CTT_setupGarrisonIconFrameOnDisc(_parentFrame, _garrisonIconFrame, _size, _garrisonID, _offsetX, _offsetY, _iconName, _iconType, _TooltipText)
    if not _G["C_ButtonFrames"] then _G["C_ButtonFrames"] = {} end
    _G["C_ButtonFrames"][_garrisonID] = _garrisonIconFrame

    _garrisonIconFrame:ClearAllPoints()
    _garrisonIconFrame:SetPoint("CENTER", _parentFrame, "CENTER", _offsetX, _offsetY)
    
    _garrisonIconFrame:SetFrameLevel(10)
    _garrisonIconFrame:EnableMouse(true)

    _garrisonIconFrame:SetScript("OnMouseDown", function(self, btn)
        if _garrisonID == "MAIN" then return end -- Botão central apenas abre/fecha
        if btn == 'LeftButton' then 
            local _ExpansionId
            if(_garrisonID == "DF") then _ExpansionId = 9 end
            if(_garrisonID == "TWW") then _ExpansionId = 10 end
            if(_garrisonID == "MN") then _ExpansionId = 11 end

            if(GarrisonLandingPage and GarrisonLandingPage:IsShown() and _garrisonID == GarrisonLandingPage.garrTypeID) then
                HideUIPanel(GarrisonLandingPage)
            elseif (EncounterJournal ~= nil and EncounterJournal:IsShown() and _ExpansionId == EncounterJournal.JourneysFrame.expansionFilter) then
                EncounterJournalCloseButton:Click()
            else
                if CTT_CheckExpansionContentAccess then 
                    CTT_CheckExpansionContentAccess(_garrisonID) 
                end
            end
            ToggleRing(false, true)
        end
    end)

    _garrisonIconFrame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        if CTT_ShowIconTooltip then
            CTT_ShowIconTooltip(GameTooltip, _TooltipText)
        else
            GameTooltip:SetText(_TooltipText)
        end
        GameTooltip:Show()

        if _garrisonIconFrame.iconHightLight then
            _garrisonIconFrame.iconHightLight:SetAtlas("bag-border-highlight", false)
            _garrisonIconFrame.iconHightLight:SetAlpha(1)
        end
        if hideTimer then hideTimer:Cancel() end
    end)
    
    _garrisonIconFrame:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        if _garrisonIconFrame.iconHightLight then
            _garrisonIconFrame.iconHightLight:SetAlpha(0)
        end
        --if config.triggerType == "HOVER" then StartHideTimer() end
        StartHideTimer()
    end)

    -- CAMADAS VISUAIS
    if(not _garrisonIconFrame.iconBorder) then
        _garrisonIconFrame.iconBorder = _garrisonIconFrame:CreateTexture(nil,"BACKGROUND",nil,0)
    end
    _garrisonIconFrame.iconBorder:SetAllPoints()
    _garrisonIconFrame.iconBorder:SetAtlas("Map_Faction_Ring", false)

    if(not _garrisonIconFrame.iconHightLight) then
        _garrisonIconFrame.iconHightLight = _garrisonIconFrame:CreateTexture(nil,"BACKGROUND",nil,-1)
    end
    _garrisonIconFrame.iconHightLight:SetAllPoints()
    _garrisonIconFrame.iconHightLight:SetAlpha(0)

    if(not _garrisonIconFrame.icon) then
        _garrisonIconFrame.icon = _garrisonIconFrame:CreateTexture(nil,"BACKGROUND",nil,-2)
    end
    _garrisonIconFrame.icon:SetPoint("CENTER")
    _garrisonIconFrame.icon:SetSize(_size * 0.8, _size * 0.8)

    if(not _garrisonIconFrame.iconBackGround) then
        _garrisonIconFrame.iconBackGround = _garrisonIconFrame:CreateTexture(nil,"BACKGROUND",nil,-3)
    end
    _garrisonIconFrame.iconBackGround:SetAllPoints()
    _garrisonIconFrame.iconBackGround:SetAtlas("common-radiobutton-circle", false)
            
    if _iconType == "Texture" then
        SetPortraitTextureCustom(_garrisonIconFrame.icon, _iconName)
        --_garrisonIconFrame.icon:SetTexture(_iconName)
    else
        _garrisonIconFrame.icon:SetAtlas(_iconName)
    end
    
    _garrisonIconFrame:SetSize(_size, _size)
    
    -- OCULTAR INICIALMENTE (Se não for o botão principal)
    if _garrisonID ~= "MAIN" then
        _garrisonIconFrame:Hide()
    end
end

-- 4. LÓGICA DO ANEL
local hideTimer
function StartHideTimer()
    if hideTimer then hideTimer:Cancel() end
    hideTimer = C_Timer.NewTimer(config.hideDelay, function()
        if not MainButton:IsMouseOver() then
            local anyChildMouseOver = false
            local anyChildVisible = false
            for _, btn in ipairs(MainButton.childButtons) do
                if btn:IsShown() then anyChildVisible = true end
                if btn:IsMouseOver() then anyChildMouseOver = true break end
                
            end
            if not anyChildMouseOver then if anyChildVisible then ToggleRing(false, true) end end
        end
    end)
end

function ToggleRing(show, _sound)
    if(_sound) then
        local _soundID = 808 --Click
        --local _soundID = 260038 -- Chimers
        PlaySound(_soundID)
    end
    MainButton.isExpanded = show
    --local count = #MainButton.childButtons
    --if count == 0 then return end
    
    -- 2. Exibição e Posicionamento (Apenas para botões ativos)
    -- Primeiro, vamos filtrar quantos botões estão realmente ativos para o cálculo do ângulo
    local activeButtons = {}
    for _, btn in ipairs(MainButton.childButtons) do
        if btn.isActive then
            table.insert(activeButtons, btn)
        end
    end
    
    local count = #activeButtons
    
    for i, btn in ipairs(activeButtons) do
        if show then
            local angle = (i - 1) * (2 * math.pi / count)
            local x = math.cos(angle) * config.radius
            local y = math.sin(angle) * config.radius
            
            btn:ClearAllPoints()
            btn:SetPoint("CENTER", MainButton, "CENTER", x, y)
            btn:Show()
            UIFrameFadeIn(btn, 0.15, btn:GetAlpha(), 1)
        else
            UIFrameFadeOut(btn, 0.15, btn:GetAlpha(), 0)
            btn:EnableMouse(false)
            C_Timer.After(0.15, function() btn:Hide() btn:EnableMouse(true) end)            
        end
    end
end

-- 5. INICIALIZAÇÃO
-- Central (MAIN)

local iconSize = 40

local left = 0
local top = -35
local placeholderSize = 280

local function IsExpansionUnlocked(index)
    if index == 1 then
        return C_Garrison.GetGarrisonInfo and C_Garrison.GetGarrisonInfo(2)
    elseif index == 2 then
        return C_Garrison.GetGarrisonInfo and C_Garrison.GetGarrisonInfo(3)
    elseif index == 3 then
        return C_Garrison.GetGarrisonInfo and C_Garrison.GetGarrisonInfo(9)
    elseif index == 4 then
        return C_Covenants.GetActiveCovenantID and C_Covenants.GetActiveCovenantID() ~= 0
    elseif index >= 5 and index <= 7 then
        local expId = 8 + (index - 4)
        return CheckSumaryWindowIsUnlockedForExpansion and CheckSumaryWindowIsUnlockedForExpansion(expId, C_SUMARY_UNLOCK_QUEST_IDS, ChromieTimeTrackerDB, ChromieTimeTrackerSharedDB)
    end
    return false
end

    -- Inicialize a tabela apenas uma vez (fora da função de atualização)
    MainButton.childButtons = MainButton.childButtons or {}

-- Filhos (Disco)
function CreateChildButtons()
    if(_CovData[3] == "-") then
        _CovData = getCovenantData()

        -- ATUALIZAR CONFIGURAÇÃO PARA CARREGAR PACTO DE SHADOWLANDS
        config = {
            triggerType = "CLICK", 
            radius = 50,
            hideDelay = 1.5,
            mainIcon = "Interface\\AddOns\\ChromieTimeTracker\\Chromie.png",
            buttonData = {
                { id = "MoPReport", icon = C_PandariaTabTextures[PlayerInfo["Faction"] .. "_Map"], type = "Atlas", tooltip = L["MiddleClickOption_Mists"] },
                { id = 2, icon = C_GarrisonTextures[PlayerInfo["Faction"]], type = "Atlas", tooltip = L["MiddleClickOption_Warlords"] },
                { id = 3, icon = C_ClassTextures[PlayerInfo["Class"]], type = "Atlas", tooltip = L["MiddleClickOption_Legion"] },
                { id = 9, icon = C_WarCampaignTextures[PlayerInfo["Faction"]], type = "Atlas", tooltip = L["MiddleClickOption_Missions"] },
                { id = 111, icon = C_CovenantChoicesTextures[_CovData[1]], type = "Atlas", tooltip = string.format(L["MiddleClickOption_Covenant"], _CovData[3]) },
                { id = "DF", icon = C_LandingPagesTextures["DragonIsles"], type = "Atlas", tooltip = L["MiddleClickOption_DragonIsles"] },
                { id = "TWW", icon = C_LandingPagesTextures["KhazAlgar"], type = "Atlas", tooltip = L["MiddleClickOption_KhazAlgar"] },
                { id = "MN", icon = C_LandingPagesTextures["Midnight"], type = "Atlas", tooltip = L["MiddleClickOption_Midnight"] },
            }
        }
    end

    isUnlocked = {true, true, true, true, true, true, true}
    if ChromieTimeTrackerDB.AdvShowUnlockedOnly then
        for i = 1, 7 do
            isUnlocked[i] = IsExpansionUnlocked(i) or false
        end
    end

    local showKeys = {
        "AdvShowMoPReport", "AdvShowGarrison", "AdvShowClassHall", "AdvShowWarEffort",
        "AdvShowCovenant", "AdvShowDragonIsles", "AdvShowKhazAlgar", "AdvShowMidnight"
    }
    local unlockKeys = {
        ChromieTimeTrackerDB.IntegrationMoPReport, isUnlocked[1], isUnlocked[2], isUnlocked[3],
        isUnlocked[4], isUnlocked[5], isUnlocked[6], isUnlocked[7]
    }

    -- 1. Gerenciamento e Reutilização dos Objetos
    for i, data in ipairs(config.buttonData) do
        local btn = MainButton.childButtons[i]

        -- Se o botão não existe, cria-o uma única vez
        if not btn then
            btn = CreateFrame("Button", "CTTRing_Child_" .. i, MainButton)
            MainButton.childButtons[i] = btn
        end

        -- Verifica se as condições de exibição são atendidas
        if ChromieTimeTrackerDB[showKeys[i]] and unlockKeys[i] then
            -- Atualiza os dados do botão (ícone, tipo, etc) apenas se necessário
            CTT_setupGarrisonIconFrameOnDisc(MainButton, btn, 40, data.id, 0, 0, data.icon, data.type, data.tooltip)
            btn.isActive = true
        else
            btn.isActive = false
            btn:Hide() -- Garante que botões inativos fiquem ocultos
        end
    end
end

-- 6. GATILHOS (Corrigidos para não deletar o Tooltip)
MainButton:SetScript("OnClick", function(self, btn)
    if btn == "LeftButton" then
        ToggleRing(not self.isExpanded, true)
    elseif btn == "RightButton" then
        local contextMenu = MenuUtil.CreateContextMenu(ChromieTimeTrackerRootFrame, GeneratorFunction);
    end
end)

-- Hooking: Vamos adicionar a lógica de expansão sem remover o Tooltip definido no Setup
MainButton:HookScript("OnEnter", function(self)
    if config.triggerType == "HOVER" then ToggleRing(true, true) end
    if hideTimer then hideTimer:Cancel() end
end)

MainButton:HookScript("OnLeave", function(self)
    if self.isExpanded then StartHideTimer() end
end)

    MainButton:SetScript("OnDragStart", function(self)
        if(not ChromieTimeTrackerDB.LockDragDrop)then
            ChromieTimeTrackerRootFrame:StartMoving()
    
            GameTooltip:Hide()
        end
        
    end)

    MainButton:SetScript("OnDragStop", function(self)
        ChromieTimeTrackerRootFrame:StopMovingOrSizing()
        
        GameTooltip:Show()
    
        ChromieTimeTrackerDB.PointIcon = {ChromieTimeTrackerRootFrame:GetPoint()}
        
        ChromieTimeTrackerDB.BasePoint = ChromieTimeTrackerDB.PointIcon[1]
        ChromieTimeTrackerDB.RelativePoint = ChromieTimeTrackerDB.PointIcon[3]
        ChromieTimeTrackerDB.OffsetX = ChromieTimeTrackerDB.PointIcon[4]
        ChromieTimeTrackerDB.OffsetY = ChromieTimeTrackerDB.PointIcon[5]
    
    end)

    function UpdateRingMenu(_position, _alignment, _visibility)
if (_position == "BELOW") then
    top = -iconSize + 14
end

if (_position == "ABOVE") then
    -- Ajuste para ficar logo acima do frame principal
    top = iconSize + 17 
end

    left = 0
    if(_alignment == "CENTER") then
        left = (placeholderSize/2 - (iconSize/2))
    end
    if(_alignment == "RIGHT") then
        left = (placeholderSize - (iconSize))
    end

if(_visibility) then
    MainButton:Show()
    CreateChildButtons()
    CTT_setupGarrisonIconFrameOnDisc(ChromieTimeTrackerRootFrame, MainButton, 46, "MAIN", left - 120, top, config.mainIcon, "Texture", L["AddonName"] .. " - " .. CTT_getChromieTime())
else
    MainButton:Hide()
end

end
    
    C_Timer.After(1,function()
        CreateChildButtons()
    end)